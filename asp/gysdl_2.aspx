<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gysdl_2.aspx.cs" Inherits="asp_gysdl_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script type="text/javascript">
    function isQQ(str)
    {
        var reg = /^\d{5,10}$/;
        if (!reg.test(str.value) && document.getElementById("username").value != "")
        {
            alert("QQ号格式错误，请重新输入");
            document.getElementById("username").focus();
        }
        if (document.getElementById("username").value == "")
        {
            alert("请输入有效的QQ号码");
            document.getElementById("username").focus();
        }
    }
</script>
<body>
    <form id="form1" runat="server">
    <div style="margin-left:100px; margin-top:100px">
        <span>账号：</span><input type="text" id="username" runat="server" onblur="isQQ(this)" /><br /><br />
      <span>密码：</span><input type="text" id="Text1" runat="server" /><br /><br />
         <asp:Button ID="Button1" runat="server" Text="登录" onclick="Button1_Click" />
    </div>
 
    </form>
</body>
</html>
