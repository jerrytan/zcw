<!--
        ��Ӧ�̵�½ҳ��
        �ļ�����gysdl.ascx
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
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/gysdl2.aspx" charset="utf8"></script>

    <title>��Ӧ�̵�½</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    
    </script>
    <div class="dlqq">
        <div class="dlqq1">
      <%
        HttpCookie CGS_QQ_id = Request.Cookies["CGS_QQ_ID"];   
        Object cgs_yh_id = Session["CGS_YH_ID"];     
 
		if (CGS_QQ_id != null && cgs_yh_id != null) 	
        {
            Response.Write("���Ѿ���Ϊ�ɹ��̵�¼���뷵�ء�<p>");                            
        }
        
        else 
        {
            HttpCookie gys_QQ_id = Request.Cookies["GYS_QQ_ID"];   
            Object gys_yh_id = Session["GYS_YH_ID"];          
        
		    if (gys_QQ_id != null && gys_yh_id != null) 	
            {
                 Response.Write("���Ѿ���Ϊ��Ӧ�̵�¼���뷵�ء�<p>");                            
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
            //Response.Write("openid is empty");
            %>
            <span class="dlzi">�𾴵Ĺ�Ӧ�̣�����! </span>
            <span class="dlzi">�����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

                });

            </script>
            <img src="images/wz_03.jpg">
            <%
            }
          }
     %>
            
        </div>
    </div>






</body>
</html>
