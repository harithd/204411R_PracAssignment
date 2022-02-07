<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="_204411R_PracAssignment.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Homepage</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <br />
    <div class="container">  
        <h2 class="m-3">Homepage</h2>
        <div>
            <form id="homepageForm" runat="server">
                <div class="row m-2">
                    <div>
                        <asp:Label ID="lbl_msg" runat="server" EnableViewState="False"></asp:Label>
                    </div>
                </div>
                <br />
                <br />
                <div class="row m-2">
                    <div>
                        First Name: 
                        <asp:Label ID="lbl_firstName" runat="server" EnableViewState="False"></asp:Label>
                    </div>
                </div>
                <div class="row m-2">
                    <div>
                        Last Name:  
                        <asp:Label ID="lbl_lastName" runat="server" EnableViewState="False"></asp:Label>
                    </div>
                </div>
                <div class="row m-2">
                    <div>
                        Credit Card Number:
                        <asp:Label ID="lbl_creditCard" runat="server" EnableViewState="False"></asp:Label>
                    </div>
                </div>
                <div class="row m-2">
                    <div>
                        Email:
                        <asp:Label ID="lbl_email" runat="server" EnableViewState="False"></asp:Label>
                    </div>
                </div>
                <br />
                <br />
                <div class="row m-2">  
                    <div>  
                         <asp:Button ID="btn_logout" runat="server" Text="Logout" CssClass="btn btn-success" OnClick="btn_logout_Click"/>  
                    </div>  
                </div>         
            </form>
        </div>
    </div>
</body>
</html>
