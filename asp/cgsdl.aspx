<!--
        �ɹ��̵�½ҳ��
        �ļ�����cgsdl.aspx
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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/cgsdl2.aspx" charset="utf8"></script>

    <title>�ɹ����û���½</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<body>
    </script>
    <div class="dlqq">
        <div class="dlqq1">
    <%-- <%
        HttpCookie gys_QQ_id = Request.Cookies["GYS_QQ_ID"];   
        Object gys_yh_id = Session["GYS_YH_ID"];     
 
		if (gys_QQ_id != null && gys_yh_id != null) 	
        {
            Response.Write("���Ѿ���Ϊ��Ӧ�̵�¼���뷵�ء�<p>");                            
        }
        
        else 
        {
            HttpCookie cgs_QQ_id = Request.Cookies["CGS_QQ_ID"];   
            Object cgs_yh_id = Session["CGS_YH_ID"];          
        
		    if (cgs_QQ_id != null && cgs_yh_id != null) 	
            {
                 Response.Write("���Ѿ���Ϊ�ɹ��̵�¼���뷵�ء�<p>");                            
             }

            else
           {
            foreach (string cookiename in Request.Cookies.AllKeys)
                {
                    HttpCookie cookies = Request.Cookies[cookiename];
                    if (cookies != null)
                    {
                        cookies.Expires = DateTime.Today.AddDays(-1);
                        Response.Cookies.Add(cookies);
                        Request.Cookies.Remove(cookiename);
                    }
                }    
            %>--%>
            <span class="dlzi">�𾴵Ĳɹ����û�������! </span><span class="dlzi">�����ұ߰�ť��½��</span> <span
                class="dlzi2" id="qqLoginBtn"></span>
                <input type="button" value="��¼" onclick="login()" />
            <script type="text/javascript">
//                QC.Login({
//                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

//                });
                function login()
                {
                    window.location.href = "cgsdl_2.aspx";
                }
            </script>

            <img src="images/wz_03.jpg">
           <%-- <%
            }
        }
   
            %>--%>
        </div>
    </div>
</body>
</html>
