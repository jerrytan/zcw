<!--
        收藏供应商，QQ登陆页面
        文件名：scgys2.ascx
        传入参数：无
               
    -->
<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" charset="utf8" data-callback="true"></script>
</head>
<body>
<%
        Session["logout"] = null;
    %>
    <script type="text/javascript">
        if (QC.Login.check()) {//如果已登录  
            QC.Login.getMe(function (openId, accessToken) {
                //alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n！"));
                alert("您好，您已经用QQ号登陆成功，将自动返回。");
                //using cookie to store openId

                document.cookie = "OpenId=" + openId;
                opener.location.reload();
            });
            
        }


    </script>
</body>
</html>
