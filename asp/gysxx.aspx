<!--
        ��Ӧ����Ϣҳ��
        �ļ�����gysxx.ascx
        ���������gys_id    ��Ӧ�̱��
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <!-- ͷ����ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ������-->


    <!-- ������ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ��������-->


    <!-- banner��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner ����-->


    <script runat="server">
        protected DataTable dt = new DataTable();  //��Ӧ����Ϣ����(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt1 = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt2 = new DataTable(); //����Ʒ��(Ʒ���ֵ�)
		protected DataTable dt3 = new DataTable(); //�ֻ���Ӧ(���ϱ�)
        protected void Page_Load(object sender, EventArgs e)
        {
		if (!Page.IsPostBack)
         {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			string gys_id = Request["gys_id"];   //��ȡ��Ӧ��id
            SqlDataAdapter da = new SqlDataAdapter("select  ��Ӧ��  from ���Ϲ�Ӧ����Ϣ�� where �Ƿ�����=1 and gys_id='"+gys_id+"' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϲ�Ӧ����Ϣ��");
            
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gys_id+"'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϲ�Ӧ����Ϣ��");            
            dt1 = ds1.Tables[0];
			
			//����gys_id���в�ѯgys_id='"+gys_id+"'
			SqlDataAdapter da2 = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"'", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���Ϲ�Ӧ����Ϣ��");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select ��ʾ�� from ���ϱ� where gys_id in(select gys_id from Ʒ���ֵ� where Ʒ������ in(select Ʒ������ from Ʒ���ֵ� where gys_id='"+gys_id+"') )", conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ϱ�");            
            dt3 = ds3.Tables[0];

            conn.Close();
			
			
         }		
        }
    </script>



    <!-- ��ҳ ��Ӧ����Ϣ ��ʼ-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp 
  <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="#"><%=row["��Ӧ��"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">

                <% foreach(System.Data.DataRow row in dt1.Rows){%>
                <p>������<%=row["��Ӧ��"].ToString() %></p>
                <p>��ַ��<%=row["��ϵ��ַ"].ToString() %></p>
                <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                <p>��ϵ�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="#">������δ���죬������ǵ����������챾�꣬����֮�����ά�������Ϣ</a></div>
            <div class="gyan1"><a href="#">���ղأ����ڲ���</a></div>
        </div>

        <!-- ��ҳ ��Ӧ����Ϣ ����-->



        <!-- ����Ʒ�� ��ʼ-->

        <div class="gydl">
            <div class="dlpp">����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt2.Rows){%>
            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["Ʒ������"].ToString()%></div>
            <%}%>
        </div>

        <!-- ����Ʒ�� ����-->


        <!-- �ֻ���Ӧ ��ʼ-->

        <div class="gydl">
            <div class="dlpp">�ֻ���Ӧ</div>

            <%foreach(System.Data.DataRow row in dt3.Rows){%>
            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["��ʾ��"].ToString() %></div>
            <%}%>
        </div>


    </div>

    <!-- �ֻ���Ӧ ����-->

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
