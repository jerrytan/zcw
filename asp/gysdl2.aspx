﻿<!--
        供应商QQ登陆页面
        文件名：gysdl2.ascx
        传入参数：无
               
    -->
<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
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
                //alert("尊敬的供应商，您好，您已经用QQ号登陆成功，确认后自动返回。");
                //using cookie to store openId

                
				//var exdate=new Date();
				//exdate.setDate(exdate.getDate()+1);
				//var cookieStr = "QQ_id=" + openId + ";expires=" + exdate.toGMTString();
				var cookieStr = "GYS_QQ_ID=" + openId;
				//alert(cookieStr);
				document.cookie = cookieStr;
				window.close();
				opener.close();
				opener.opener.location.href="gyszym.aspx";
				//alert(opener.opener.location.href);
				//opener.opener.location.reload();

            });
            
        }


    </script>
    
</body>
</html>
