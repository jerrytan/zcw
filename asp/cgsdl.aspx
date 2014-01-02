<!--
        采购商登陆页面
        文件名：cgsdl.aspx
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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/cgsdl2.aspx" charset="utf8"></script>

    <title>采购商用户登陆</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<body>
    </script>
    <div class="dlqq">
        <div class="dlqq1">
            <%
   
        HttpCookie QQ_id = Request.Cookies["QQ_id"];   
        Object logout = Session["logout"];          
        
		if (QQ_id != null && logout == null) 	
        {
            Response.Write("您已经登录，请返回。<p>");

            
        }
        else
        {
           
            %>
            <span class="dlzi">尊敬的采购商用户，您好! </span><span class="dlzi">请点击右边按钮登陆！</span> <span
                class="dlzi2" id="qqLoginBtn"></span>

            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //插入按钮的节点id  

                });

            </script>

            <img src="images/wz_03.jpg">
            <%
        }
   
            %>
        </div>
    </div>
</body>
</html>
