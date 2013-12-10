<%@ Page Language="C#" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/asp/js/jquery1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="1101078572" data-redirecturi="http://zhcnet.cn/test/qq/test2.aspx" charset="utf8"></script>

</head>
<body>





    <p>
    </p>
    <%
   
        HttpCookie openId = Request.Cookies["OpenId"];
        if (openId != null)
        {
            Response.Write("openid is " + openId.Value);
        }
        else
        {
            Response.Write("openid is empty");
    %>
    <span id="qqLoginBtn"></span>
    <script type="text/javascript">
        QC.Login({
            btnId: "qqLoginBtn" //插入按钮的节点id  

        });

    </script>
    <%
    }
    
    %>
</body>
</html>
