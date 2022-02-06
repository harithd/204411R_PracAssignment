<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="_204411R_PracAssignment.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Homepage</title>
</head>
<body>
    <br />
    <h2>Homepage</h2>
    <div>
        <div>
            <form id="homepageForm" runat="server">
                <br />
                <div>
                    <asp:Label ID="lbl_msg" runat="server" EnableViewState="False"></asp:Label>
                </div>
                <br />
                <br />
                <div class="row">  
                    <div>  
                         <asp:Button ID="btn_logout" runat="server" Text="Logout" OnClick="btn_logout_Click" Visible="false" />  
                    </div>  
                </div>  
                
            </form>
        </div>
    </div>

</body>
</html>
