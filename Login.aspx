<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_204411R_PracAssignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script src="https://www.google.com/recaptcha/api.js?render=6LcIr08eAAAAAPIntOGK_J-RAj5N68vKzDKaKwmL"></script>
    <script type="text/javascript" >

        function validatePassword() {
            var str = document.getElementById('<%=tb_password.ClientID %>').value;

            // Length
            if (str.length < 12) {
                document.getElementById("lbl_password").innerHTML = "Password length must be at least 12 characters";
                document.getElementById("lbl_password").style.color = "Red";
                return ("too_short");
            }
            else {
                document.getElementById("lbl_password").innerHTML = "Great";
                document.getElementById("lbl_password").style.color = "Green";
            }  
        }

        function validateEmail() {
            var email = document.getElementById('<%=tb_email.ClientID%>').value;

            if (email.search(/[@]/) == -1) {
                document.getElementById("lbl_email").innerHTML = "Please enter a valid email address";
                document.getElementById("lbl_email").style.color = "Red";

            }
            else {
                document.getElementById("lbl_email").innerHTML = "Great";
                document.getElementById("lbl_email").style.color = "Green";
            }
        }
    </script>
</head>

<body>
    <br />
    
    <div class="container">  
        <h2 class="m-3">Login</h2>

        <div>  
            <form id="loginForm" runat="server">
                <div class="row m-2">  
                    <div> 
                        <label  for="email">Email</label>
                        <asp:TextBox ID="tb_email"  runat="server" Width="209px" onkeyup="javascript:validateEmail()"></asp:TextBox>
                        <asp:Label ID="lbl_email" runat="server" Text=""></asp:Label>
                    </div>  
                </div>  
 
                <div class="row m-2">
                    <div>
                        <label for="password">Password</label>
                        <asp:TextBox ID="tb_password" runat="server" Width="209px" onkeyup="javascript:validatePassword()"></asp:TextBox>
                        <asp:Label ID="lbl_password" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <br />

                <div>
                    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                </div>

                <br />
                <div class="row m-2">  
                    <div class="mb-3">  
                         <asp:Button ID="btn_login" runat="server" Text="Login" CssClass="btn btn-success"  OnClick="btn_login_Click" />   
                    </div>  
                    <div>
                        <p><a href="Registration.aspx" cssclass="btn btn-success">Create an account</a></p>
                    </div>
                </div>  
                <br />
                <br />
                <div>
                    <asp:Label ID="lbl_msg" runat="server" EnableViewState="False">Error message here (lblMessage)</asp:Label>
                </div>
            </form>
        </div>
    </div>

    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LcIr08eAAAAAPIntOGK_J-RAj5N68vKzDKaKwmL', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
