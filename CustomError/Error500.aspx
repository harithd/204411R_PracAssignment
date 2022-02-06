<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error500.aspx.cs" Inherits="_204411R_PracAssignment.CustomError.Error500" %>

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
                <h1 class="m-3">500 Server Error</h1>
                <h4>Oops! Something went wrong.</h4>
                <%--<asp:Button ID="btn_back" runat="server" Text="Home" CssClass="btn btn-secondary" OnClick="btn_back_Click"/>--%>
                <div>
                    <p><a href="../Index.aspx" cssclass="btn btn-secondary">Click here to return</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
