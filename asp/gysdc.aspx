<!--
        ��Ӧ�̵ǳ�ҳ��
        �ļ�����gysdc.ascx
        �����������
               
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
   <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>

    <title>��Ӧ�̵ǳ�</title>
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
	     
        String cookieName = "GYS_QQ_ID";
	    if (Request.Cookies[cookieName] != null)
        {
            HttpCookie myCookie = new HttpCookie(cookieName);
            myCookie.Expires = DateTime.Now.AddDays(-10d);
            Response.Cookies.Add(myCookie);
        }		            
		if (Session["GYS_YH_ID"] != null) 
		{
			Session.Remove("GYS_YH_ID");
            		     
		}
        
		//Response.Redirect("index.aspx");
%>
            <a style="color: Red" onclick="clickMe()">�ǳ��ɹ�������ҽ��ص���ҳ�� </a>
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
