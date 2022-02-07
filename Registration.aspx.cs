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
using System.Diagnostics;
using System.Configuration;


namespace _204411R_PracAssignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString = ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        byte[] image2;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            // Extract data from textbox
            int scores = checkPassword(HttpUtility.HtmlEncode(tb_password.Text));
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;

                case 2:
                    status = "Weak";
                    break;

                case 3:
                    status = "Medium";
                    break;

                case 4:
                    status = "Strong";
                    break;

                case 5:
                    status = "";
                    break;

                default:
                    break;
            }

            lbl_pwChecker.Text = "Status: " + status;
            if (scores < 4)
            {
                lbl_pwChecker.ForeColor = Color.Red;
                return;
            }
            
            lbl_pwChecker.ForeColor = Color.Green;

            // string pwd = get value from textbox
            string pwd = HttpUtility.HtmlEncode(tb_password.Text.ToString().Trim()); ;

            //Generate random salt
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];

            // Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            SHA512Managed hashing = new SHA512Managed();

            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

            finalHash = Convert.ToBase64String(hashWithSalt);

            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            int imgFile = photoUpload.PostedFile.ContentLength;
            image2 = new byte[imgFile];


            // validate input
            // check first name
            if (tb_firstName.Text == "")
            {
                lbl_firstName.Text = "First name cannot be empty";
                lbl_firstName.ForeColor = Color.Red;

            }
            else if (Regex.IsMatch(tb_firstName.Text, "[^a-zA-Z]"))
            {
                lbl_firstName.Text = "Please enter valid first name";
                lbl_firstName.ForeColor = Color.Red;

            }

            // check last name
            else if (tb_lastName.Text == "")
            {
                lbl_lastName.Text = "Last name cannot be empty";
                lbl_lastName.ForeColor = Color.Red;

            }
            else if (Regex.IsMatch(tb_lastName.Text, "[^a-zA-Z]"))
            {
                lbl_lastName.Text = "Please enter valid last name";
                lbl_lastName.ForeColor = Color.Red;

            }

            // check card number
            else if (tb_cardNumber.Text == "")
            {
                lbl_cardNumber.Text = "Please enter a credit card number";
                lbl_cardNumber.ForeColor = Color.Red;
            }
            else if (!Regex.IsMatch(tb_cardNumber.Text, "^[0-9]*$"))
            {
                lbl_cardNumber.Text = "Please enter a valid credit card number";
                lbl_cardNumber.ForeColor = Color.Red;
            }
            else if (tb_cardNumber.Text.Length != 16)
            {
                lbl_cardNumber.Text = "Please enter a valid credit card number";
                lbl_cardNumber.ForeColor = Color.Red;
            }

            // check card expiry date
            else if (tb_cardExpiry.Text == "")
            {
                lbl_cardExpiry.Text = "Please select card expiry date";
                lbl_cardExpiry.ForeColor = Color.Red;
            }

            // check CVV
            else if (tb_CVV.Text == "")
            {
                lbl_CVV.Text = "CVV number cannot be empty";
                lbl_CVV.ForeColor = Color.Red;
            }
            else if (!Regex.IsMatch(tb_CVV.Text, "^[0-9]*$"))
            {
                lbl_CVV.Text = "Please enter a valid (3-digit) CVV number";
                lbl_CVV.ForeColor = Color.Red;
            }

            else if (tb_CVV.Text.Length != 3)
            {
                lbl_CVV.Text = "Please enter a valid (3-digit) CVV number";
                lbl_CVV.ForeColor = Color.Red;
            }

            // check email address
            else if (tb_email.Text == "")
            {
                lbl_email.Text = "Please enter an email address";
                lbl_email.ForeColor = Color.Red;
            }

            // check date of birth
            else if (tb_dob.Text == "")
            {
                lbl_dob.Text = "Please select date of birth";
                lbl_dob.ForeColor = Color.Red;
            }

            else
            {
                Debug.WriteLine("creating account now...");
                createAccount();
            }

            //Response.Redirect("Login.aspx", false);

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
                ("https://www.google.com/recaptcha/api/siteverify?secret=SECRETKEY &response=" + captchaResponse);

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

        protected void createAccount()
        {
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "SELECT Email FROM Account WHERE Email=@Email";
            SqlCommand command = new SqlCommand(sql, connection);

            bool checkEmail = false;
            var email = HttpUtility.HtmlEncode(tb_email.Text.Trim());
            try
            {
                Debug.WriteLine("opning db to check email..");
                command.Parameters.AddWithValue("@Email", email);
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["Email"] != null)
                        {
                            Debug.WriteLine("email is not null");
                            if (reader["Email"] != DBNull.Value)
                            {
                                Debug.WriteLine("email is not DBnull. checkemail is true");
                                checkEmail = true;
                            }
                            else
                            {
                                Debug.WriteLine("email is false");
                                checkEmail = false;
                            }
                        }
                        else
                        {
                            Debug.WriteLine("email is false 2");
                            checkEmail = false;
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }

            if (checkEmail == false)
            {
                Debug.WriteLine("if checkEmail is false, so creating account");
                try
                {
                    using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                    {
                       

                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES (@FirstName, @LastName, @CreditCardNumber, @CreditCardExpiry, @CVV, @Email, @PasswordHash, @PasswordSalt, @DateOfBirth, @Image, @IV, @Key)"))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter())
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.AddWithValue("@FirstName", HttpUtility.HtmlEncode(tb_firstName.Text.Trim()));
                                cmd.Parameters.AddWithValue("@LastName", HttpUtility.HtmlEncode(tb_lastName.Text.Trim()));
                                cmd.Parameters.AddWithValue("@CreditCardNumber", Convert.ToBase64String(encryptData(tb_cardNumber.Text.Trim())));
                                cmd.Parameters.AddWithValue("@CreditCardExpiry", tb_cardExpiry.Text.Trim());
                                cmd.Parameters.AddWithValue("@CVV", HttpUtility.HtmlEncode(tb_CVV.Text.Trim()));
                                cmd.Parameters.AddWithValue("@Email", HttpUtility.HtmlEncode(tb_email.Text.Trim()));
                                cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                                cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                                cmd.Parameters.AddWithValue("@DateOfBirth", HttpUtility.HtmlEncode(tb_dob.Text.Trim()));
                                cmd.Parameters.AddWithValue("@Image", image2);

                                cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                                cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));

                                cmd.Connection = con;
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    throw new Exception(ex.ToString());
                }
                Response.Redirect("Login.aspx");
            }
            else
            {
                Debug.WriteLine("Email exists!");
                lbl_email.Text = "An account with this email address already exists!";
                lbl_email.ForeColor = Color.Red;
            }
        }

        // validate password
        private int checkPassword(string password)
        {
            int score = 0;

            // check password strength here

            if (password.Length < 12)
            {
                // Very weak
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(password, "[a-z]"))
            {
                // 2 - Weak
                score++;
            }

            if (Regex.IsMatch(password, "[A-Z]"))
            {
                // 3 - Medium
                score++;
            }
            if (Regex.IsMatch(password, "[0-9]"))
            {
                //4 - Strong
                score++;
            }
            if (Regex.IsMatch(password, "[<,>,@,!,#,$,%,^,&,*,(,),_,+,\\[,\\],{,},?,:,;,|,',\\,.,/,~,`,-,=]"))
            {
                //5 - Very strong
                score++;
            }
            return score;
        }

        // Encrypt data
        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
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
