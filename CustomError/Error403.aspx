<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error403.aspx.cs" Inherits="_204411R_PracAssignment.CustomError.Error403" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <br />
    
    <div class="container">  
        <div class="row m-2">
            <div>
                <h1>403 Forbidden</h1>
                <h4>We are sorry, but you do not have access to this page.</h4>
                <%--<asp:Button ID="btn_back" runat="server" Text="Home" CssClass="btn btn-success"  OnClick="btn_back_Click" />--%>

                <div>
                    <p><a href="../Index.aspx" cssclass="btn btn-secondary">Click here to return</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
