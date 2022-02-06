<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="_204411R_PracAssignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script src="https://www.google.com/recaptcha/api.js?render=6LcIr08eAAAAAPIntOGK_J-RAj5N68vKzDKaKwmL"></script>
    <script type="text/javascript">
        function validateFirstName() {
            var firstName = document.getElementById('<%=tb_firstName.ClientID%>').value;

            if (firstName.length < 1) {
                document.getElementById("lbl_firstName").innerHTML = "Please enter a valid first name";
                document.getElementById("lbl_firstName").style.color = "Red";
                return ("too_short");
            }

            else if (firstName.search(/[^a-zA-Z]/) != -1) {
                document.getElementById("lbl_firstName").innerHTML = "Please enter a valid first name";
                document.getElementById("lbl_firstName").style.color = "Red";
                return ("no_specialChar");
            }

            else {
                document.getElementById("lbl_firstName").innerHTML = "Excellent";
                document.getElementById("lbl_firstName").style.color = "Green";
            }
        }

        function validateLastName() {
            var lastName = document.getElementById('<%=tb_lastName.ClientID%>').value;

            if (lastName.length < 1) {
                document.getElementById("lbl_lastName").innerHTML = "Please enter a valid last name";
                document.getElementById("lbl_lastName").style.color = "Red";
                return ("too_short");
            }

            else if (lastName.search(/[^a-zA-Z]/) != -1) {
                document.getElementById("lbl_lastName").innerHTML = "Please enter a valid last name";
                document.getElementById("lbl_lastName").style.color = "Red";
                return ("no_specialChar");
            }

            else {
                document.getElementById("lbl_lastName").innerHTML = "Excellent";
                document.getElementById("lbl_lastName").style.color = "Green";
            }
        }

        function validateCardNumber() {
            var cardNumber = document.getElementById('<%=tb_cardNumber.ClientID%>').value;

            if (cardNumber.length <= 0) {
                document.getElementById("lbl_cardNumber").innerHTML = "Please enter a valid credit card number";
                document.getElementById("lbl_cardNumber").style.color = "Red";
                return ("too_short");
            }

            else if (cardNumber.length != 16) {
                document.getElementById("lbl_cardNumber").innerHTML = "Please enter a valid credit card number";
                document.getElementById("lbl_cardNumber").style.color = "Red";
                return ("not_16_digits");
            }
           
            else if (cardNumber.search(/[A-Z]/) != -1) {
                document.getElementById("lbl_cardNumber").innerHTML = "Please enter a valid credit card number";
                document.getElementById("lbl_cardNumber").style.color = "Red";
                return ("got_uppercase");
            }

            else if (cardNumber.search(/[a-z]/) != -1) {
                document.getElementById("lbl_cardNumber").innerHTML = "Please enter a valid credit card number";
                document.getElementById("lbl_cardNumber").style.color = "Red";
                return ("got_lowercase");
            }

            else if (cardNumber.search(/[^a-zA-Z0-9]/) != -1) {
                document.getElementById("lbl_cardNumber").innerHTML = "Please enter a valid credit card number";
                document.getElementById("lbl_cardNumber").style.color = "Red";
                return ("got_specialChar");
            }

            else {
                document.getElementById("lbl_cardNumber").innerHTML = "Excellent";
                document.getElementById("lbl_cardNumber").style.color = "Green";
            }
        }

        <%--function validateCardExpiry() {
            var cardExpiry = document.getElementById('<%=tb_cardExpiry.ClientID%>').value;

            if (cardExpiry.length <= 0) {
                document.getElementById("lbl_cardExpiry").innerHTML = "Please enter a valid expiry date";
                document.getElementById("lbl_cardExpiry").style.color = "Red";
                return ("too_short");
            }

            else {
                document.getElementById("lbl_cardExpiry").innerHTML = "Excellent";
                document.getElementById("lbl_cardExpiry").style.color = "Green";
            }
        }--%>

        function validateCVV() {
            var cvv = document.getElementById('<%=tb_CVV.ClientID%>').value;

            if (cvv.length <= 0) {
                document.getElementById("lbl_CVV").innerHTML = "Please enter a valid (3-digit) CVV number";
                document.getElementById("lbl_CVV").style.color = "Red";
                return ("too_short");
            }

            else if (cvv.length != 3) {
                document.getElementById("lbl_CVV").innerHTML = "Please enter a valid (3-digit) CVV number";
                document.getElementById("lbl_CVV").style.color = "Red";
                return ("not_16_digits");
            }

            else if (cvv.search(/[A-Z]/) != -1) {
                document.getElementById("lbl_CVV").innerHTML = "Please enter a valid (3-digit) CVV number";
                document.getElementById("lbl_CVV").style.color = "Red";
                return ("got_uppercase");
            }

            else if (cvv.search(/[a-z]/) != -1) {
                document.getElementById("lbl_CVV").innerHTML = "Please enter a valid (3-digit) CVV number";
                document.getElementById("lbl_CVV").style.color = "Red";
                return ("got_lowercase");
            }

            else if (cvv.search(/[^a-zA-Z0-9]/) != -1) {
                document.getElementById("lbl_CVV").innerHTML = "Please enter a valid (3-digit) CVV number";
                document.getElementById("lbl_CVV").style.color = "Red";
                return ("got_specialChar");
            }

            else {
                document.getElementById("lbl_CVV").innerHTML = "Excellent";
                document.getElementById("lbl_CVV").style.color = "Green";
            }
        }

        function validateEmail() {
            var email = document.getElementById('<%=tb_email.ClientID%>').value;

            if (email.search(/[@]/) == -1) {
                document.getElementById("lbl_email").innerHTML = "Please enter a valid email address";
                document.getElementById("lbl_email").style.color = "Red";
                return ("no_at");
            }
            else {
                document.getElementById("lbl_email").innerHTML = "Excellent";
                document.getElementById("lbl_email").style.color = "Green";
            }
        }

        function validatePassword() {
            var password = document.getElementById('<%=tb_password.ClientID %>').value;

            // Length
            if (password.length < 12) {
                document.getElementById("lbl_pwChecker").innerHTML = "Password length must be at least 12 characters";
                document.getElementById("lbl_pwChecker").style.color = "Red";
                return ("too_short");
            }

            // At least 1 numeral
            else if (password.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwChecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwChecker").style.color = "Red";
                return ("no_number");
            }

            // At least 1 uppercase letter
            else if (password.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwChecker").innerHTML = "Password require at least 1 uppercase letter";
                document.getElementById("lbl_pwChecker").style.color = "Red";
                return ("no_uppercase");
            }

            // At least 1 lowercase letter
            else if (password.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwChecker").innerHTML = "Password require at least 1 lowercase letter";
                document.getElementById("lbl_pwChecker").style.color = "Red";
                return ("no_lowercase");
            }

            // At least 1 special character
            else if (password.search(/[^a-zA-Z0-9]/) == -1) {
                document.getElementById("lbl_pwChecker").innerHTML = "Password require at least 1 special character";
                document.getElementById("lbl_pwChecker").style.color = "Red";
                return ("no_specialChar");
            }

            document.getElementById("lbl_pwChecker").innerHTML = "Password: Strong";
            document.getElementById("lbl_pwChecker").style.color = "Blue";
        }

        <%--function validateDOB() {
            var dob = document.getElementById('<%=tb_dob.ClientID%>').value;

            if (dob.length <= 0) {
                document.getElementById("lbl_dob").innerHTML = "Please enter a valid date";
                document.getElementById("lbl_dob").style.color = "Red";
                return ("too_short");
            }

            else {
                document.getElementById("lbl_dob").innerHTML = "Excellent";
                document.getElementById("lbl_dob").style.color = "Green";
            }
        }--%>
        
    </script>

</head>

<body>
    <br />
    <div class="container">  
        <h2 class="m-3">Registration</h2>
            <div>  
                <form id="registrationForm" runat="server">  

                    <%--First Name--%>
                   <div class="row m-2">  
                        <div class="mb-2">
                            First Name 
                            <asp:TextBox ID="tb_firstName" runat="server" Width="209px" onkeyup="validateFirstName()"></asp:TextBox>
                            <asp:Label ID="lbl_firstName" runat="server" Text=""></asp:Label>
                        </div>  
                    
                       <%--Last Name--%>
                       <div>
                           Last Name
                           <asp:TextBox ID="tb_lastName" runat="server" Width="209px" onkeyup="validateLastName()"></asp:TextBox>  
                           <asp:Label ID="lbl_lastName" runat="server" Text=""></asp:Label>
                       </div>
                   </div>  

                    <%--Credit Card Number--%>
                    <div class="row m-2">
                        <div>
                            Credit Card Number
                            <asp:TextBox ID="tb_cardNumber" runat="server" Width="209px" onkeyup="javascript:validateCardNumber()"></asp:TextBox>
                            <asp:Label ID="lbl_cardNumber" runat="server" Text=""></asp:Label>
                        </div>
                    </div>

                    <%--Credit Card Expiry & CVV--%>
                    <div class="row m-2">
                        <div>
                            Credit Card Expiry
                            <asp:TextBox ID="tb_cardExpiry" runat="server" Width="209px" type="month" onkeyup="javascript:validateCardExpiry()"></asp:TextBox>
                            <asp:Label ID="lbl_cardExpiry" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            CVV
                            <asp:TextBox ID="tb_CVV" runat="server" Width="70px" onkeyup="javascript:validateCVV()"></asp:TextBox>
                            <asp:Label ID="lbl_CVV" runat="server" Text=""></asp:Label>
                        </div>
                    </div>

                    <%--Email--%>
                    <div class="row m-2">  
                        <div>
                            Email 
                            <asp:TextBox ID="tb_email" runat="server" Width="209px" type="email" onkeyup="javascript:validateEmail()"></asp:TextBox>
                            <asp:Label ID="lbl_email" runat="server" Text=""></asp:Label>
                        </div>  
                    </div> 

                    <%--Password--%>
                    <div class="row m-2">  
                        <div>
                            Password
                            <asp:TextBox ID="tb_password" runat="server" Width="209px" TextMode="Password" onkeyup="javascript:validatePassword()"></asp:TextBox>
                            <asp:Label ID="lbl_pwChecker" runat="server" Text=""></asp:Label>
                        </div>  
                    </div>  

                    <%--<div class="row m-2">  
                        <div>
                            Confirm Password
                            <asp:TextBox ID="tb_password2" runat="server" TextMode="Password"></asp:TextBox>  
                        </div>   
                    </div> --%> 
              
                    <%--Date of Birth--%>
                    <div class="row m-2">  
                        <div>
                            Date of Birth
                            <asp:TextBox ID="tb_dob" runat="server" type="date" onkeyup="javascript:validateDOB()"></asp:TextBox> 
                            <asp:Label ID="lbl_dob" runat="server" Text=""></asp:Label>
                        </div> 
                    </div>  

                    <%--Photo Upload--%>
                    <div class="row m-2">
                        <div>
                            Photo
                            <asp:FileUpload ID="photoUpload" runat="server" Width="250px"/>
                            <%--<asp:Label ID="lbl_photo" runat="server" Text=""></asp:Label>--%>                 
                            <asp:Button ID="btn_photo" runat="server" Text="Upload Photo" OnClick="btn_photo_Click"/>   
                        </div>  
                    </div>
                 
                    <br />
                        <div>
                            <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                        </div>
                    <br />

                    <%--Button--%>
                    <div class="row m-2">  
                        <div>
                            
                            <asp:Button ID="btn_register" runat="server" Text="Register" CssClass="btn btn-success" OnClick="btn_register_Click" />  
                            <asp:Label ID="errormsg" runat="server" Text=""></asp:Label>
                        </div>  
                    </div>  
                 </form> 
            </div>  
    </div>  
     
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LcIr08eAAAAAPIntOGK_J-RAj5N68vKzDKaKwmL', { action: 'Registration' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
