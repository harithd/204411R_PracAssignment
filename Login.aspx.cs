using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions; // for Regular expression
using System.Drawing; // for change of color
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;


namespace _204411R_PracAssignment
{
    public partial class Login : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string pwd = HttpUtility.HtmlEncode(tb_password.Text.Trim());
            string email = HttpUtility.HtmlEncode(tb_email.Text.Trim());

            SHA512Managed hashing = new SHA512Managed();
            string dbHash = getDBHash(email);
            string dbSalt = getDBSalt(email);

            try
            {
                if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                {
                    string pwdWithSalt = pwd + dbSalt;
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                    string userHash = Convert.ToBase64String(hashWithSalt);
                    if (userHash.Equals(dbHash))
                    {
                        Response.Redirect("Success.aspx", false);
                    }


                    else
                    {
                        lbl_msg.Text = "Email or password is not valid. Please try again.";
                        Response.Redirect("Login.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            

            if (ValidateCaptcha())
            {
                SqlConnection connection = new SqlConnection(MYDBConnectionString);
                string sql = "SELECT * FROM Account WHERE Email=@Email";
                SqlCommand command = new SqlCommand(sql, connection);
                connection.Open();
                command.Parameters.AddWithValue("@Email", email);
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {

                }

                // Check for username and password
                if (tb_email.Text.Trim().Equals("u") && tb_password.Text.Trim().Equals("p"))
                {
                    Session["LoggedIn"] = tb_email.Text.Trim();

                    // create a new GUID and save to session
                    string guid = Guid.NewGuid().ToString();
                    Session["AuthToken"] = guid;

                    // now create a new cookie with this guid value
                    Response.Cookies.Add(new HttpCookie("AuthToken", guid));

                    Response.Redirect("Index.aspx", false);
                }
                else
                {
                    lbl_msg.Text = "Wrong email or password";
                }
            }


        }


        private bool checkInput()
        {
            // check email address
            if (String.IsNullOrEmpty(tb_email.Text))
            {
                lbl_email.Text = "Please enter an email address";
                lbl_email.ForeColor = Color.Red;
                lbl_email.Visible = true;
            }
            else if (Regex.IsMatch(tb_email.Text, "@"))
            {
                lbl_email.Text = "Excellent";
                lbl_email.ForeColor = Color.Green;
            }
            else
            {
                lbl_email.Text = "Please enter a valid email address";
                lbl_email.ForeColor = Color.Red;
            }

            if (String.IsNullOrEmpty(tb_password.Text))
            {
                lbl_password.Text = "Please enter your password";
                lbl_password.ForeColor = Color.Red;
            }
            else
            {
                lbl_password.Text = "Excellent";
                lbl_password.ForeColor = Color.Green;
            }

            return true;
        }

        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            string captchaResponse = Request.Form["g-recaptcha-response"];

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
                ("https://www.google.com/recaptcha/api/siteverify?secret=6LcIr08eAAAAAHEIXpvo5kerfqx29Un4NcOO07di &response=" + captchaResponse);

            try
            {

                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {

                        string jsonResponse = readStream.ReadToEnd();

                        //lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        result = Convert.ToBoolean(jsonObject.success);
                    }
                }

                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }

        protected string getDBHash(string email)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select PasswordHash FROM Account WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["PasswordHash"] != null)
                        {
                            if (reader["PasswordHash"] != DBNull.Value)
                            {
                                h = reader["PasswordHash"].ToString();
                            }
                        }
                    }

                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }

        protected string getDBSalt(string email)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select PASSWORDSALT FROM ACCOUNT WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Email", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0,
               plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }


    }
}