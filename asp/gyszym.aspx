<!--
      ��Ӧ����ҳ�� �������쳧��ҳ�� ����Ӧ�� ���������ҳ�� ��Ӧ�̹������ҳ�� 
	  �ļ���:  gyszym.aspx   
      �������:��	   
      
   
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��Ӧ����ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <!-- ͷ��2��ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ��2����-->
 

    <div class="gyzy1">
        <span class="zy1">�����Ϣ�����ҷ�������Աȷ�Ϻ��������������еĹ�Ӧ�̣����������µĹ�Ӧ����Ϣ������������²�Ʒ��Ϣ��ͼ1</span>
        <span class="zy2">
            <img src="images/aaa_06.jpg" />ͼ1</span> <span class="zy2">
                <img src="images/aaa_06.jpg" />ͼ2</span>
    </div>

    <%
            HttpCookie QQ_id = Request.Cookies["QQ_id"];
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where QQ_id='054C93797C32272E3C65FEAC1495C308'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "�û���");           
            DataTable dt = ds.Tables[0];
            String yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
			
            Session["yh_id"] = yh_id;      //�û�yh_id ����session��
            String passed = Convert.ToString(dt.Rows[0]["�Ƿ���֤ͨ��"]);
            String name=  Convert.ToString(dt.Rows[0]["����"]);
            if (!passed.Equals("ͨ��"))
            {
    %>

    <div class="gyzy2">
        <span class="zyy1"><a href="gysbtxx.aspx">���쳧��</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">������������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">�����������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">���������Ϣ</a></span>
        
    </div>
    <%       }
            else { %>
    <div class="gyzy2">
        <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>
        <span class="zyy1"><a href="glscsxx.aspx">������������Ϣ</a></span>
        <span class="zyy1"><a href="glfxsxx.aspx">�����������Ϣ</a></span>
        <span class="zyy1"><a href="gysglcl.aspx">���������Ϣ</a></span>        
    </div>
    <%        }%>


    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->





</body>
</html>
