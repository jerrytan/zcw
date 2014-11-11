<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gysdl_2.aspx.cs" Inherits="asp_gysdl_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-left:100px; margin-top:100px">
        <span>账号：</span><input type="text" id="username" runat="server" /><br /><br />
      <span>密码：</span><input type="text" id="Text1" runat="server" /><br /><br />
         <asp:Button ID="Button1" runat="server" Text="登录" onclick="Button1_Click" />
    </div><%--<input type="submit" value="登录" />--%>
 
    </form>
</body>
</html>
