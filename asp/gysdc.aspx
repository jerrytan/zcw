<!--
        供应商登出页面
        文件名：gysdc.ascx
        传入参数：无
               
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
   <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>

    <title>供应商登出</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<script>
    function QQ_logout() {
        //alert("logout from QQ");
        QC.Login.signOut();
    }
    
</script>

<body >

    <div class="dlqq">
        <div class="dlqq1">
<%
	     
        String cookieName = "QQ_id";
	    if (Request.Cookies[cookieName] != null)
        {
            HttpCookie myCookie = new HttpCookie(cookieName);
            myCookie.Expires = DateTime.Now.AddDays(-10d);
            Response.Cookies.Add(myCookie);
        }		            
		if (Session["yh_id"] != null) 
		{
			Session["yh_id"] = null;
            		     
		}
        Session["logout"]= "true";
		//Response.Redirect("index.aspx");
%>
            <a style="color: Red" onclick="clickMe()">登出成功，点击我将回到主页。 </a>
        <script>
            function clickMe() {
                QQ_logout();          
                window.opener.location.href= "index.aspx";
                window.close();
            }
        </script>
        </div>
    </div>






</body>
</html>
