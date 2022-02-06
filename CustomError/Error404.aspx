<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="_204411R_PracAssignment.CustomError.Error404" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <br />
    
    <div class="container">  
        <div class="row m-2">
            <div>
                <h1>404</h1>
                <h4>The page you're looking for does not exist.</h4>
                <%--<asp:Button ID="btn_back" runat="server" Text="Home" CssClass="btn btn-success"  OnClick="btn_back_Click" />--%>

                <div>
                    <p><a href="../Index.aspx" cssclass="btn btn-secondary">Click here to return</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
