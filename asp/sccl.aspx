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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl2.aspx" charset="utf8"></script>

    <title>�ղز���</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
   
        HttpCookie openId = Request.Cookies["OpenId"];
        if (openId != null)
        {
            //Response.Write("openid is " + openId.Value + "<p>");
			Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����! �ò����Ѿ��ղسɹ���</span>");

        }
        else
        {
            //Response.Write("openid is empty");
            %>

            <span class="dlzi">�𾴵Ĳɹ��̣�����! �����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

                });

            </script>
            <%
    }
    
            %>
            <img src="images/wz_03.jpg">
        </div>
    </div>






</body>
</html>
