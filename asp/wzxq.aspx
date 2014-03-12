<!--
        ��������ҳ��
        �ļ�����wzxq.ascx
        ���������p     �б�ҳ��
                  wz_id    ��������
               
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��������ҳ</title>
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

    <!-- ������ҳ ��ʼ-->
    <script runat="server">                         
 	    protected DataTable dt_wz = new DataTable();  //���±�
        protected DataTable dt_wzhnr = new DataTable();  //���º�������ر�
        protected DataTable dt_wzhcs = new DataTable();  //���ºͳ�����ر�
        protected DataTable dt_wzhcl = new DataTable();  //���ºͲ�����ر�
        protected int total_pages = 1;
        protected int current_page = 1;
        protected string wz_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            wz_id=Request["wz_id"];  //��ȡ����id
            SqlDataAdapter da = new SqlDataAdapter("select distinct ����,����, wz_id from ���±� where wz_id='"+wz_id+"'", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "���±�");        
            dt_wz = ds.Tables[0];

            SqlDataAdapter da2 = new SqlDataAdapter("select ��������,gys_id from ���ºͳ�����ر� where wz_id='"+wz_id+"'", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���ºͳ�����ر�");        
            dt_wzhcs = ds2.Tables[0];

            SqlDataAdapter da3 = new SqlDataAdapter("select ��Ʒ����,cl_id from ���ºͲ��ϱ���ر� where wz_id='"+wz_id+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ºͲ��ϱ���ر�");        
            dt_wzhcl = ds3.Tables[0];   

            string page = Request["p"];
            if (page != null) 
			{	
				current_page = int.Parse(page);   
            }    
            string strr="select ҳ������, ҳ����, wz_id from ���º�������ر� where wz_id='"+wz_id+"' and ҳ����='"+ current_page+"'";  
            SqlDataAdapter da1 = new SqlDataAdapter(strr, conn);            
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���º�������ر�");   
            dt_wzhnr = ds1.Tables[0];

            string total_sql_str = "select count(*) from ���º�������ر� where wz_id='"+wz_id+"'";
            SqlCommand cmd = new SqlCommand(total_sql_str,conn);
            Object result = cmd.ExecuteScalar();
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
            conn.Close();
        }
    </script>

    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">��ҳ ></a>����</div>
        <div class="xwleft">
            <% foreach(System.Data.DataRow row in dt_wz.Rows){%>
            <div class="xwleft1"><%=row["����"].ToString() %></div>
            <div class="xwleft2">���ߣ�<%=row["����"].ToString() %></div>

            <% foreach(System.Data.DataRow row2 in dt_wzhnr.Rows){%>
            <div class="xwleft3"><%=row2["ҳ������"].ToString() %></div>
            <%}%>
		<center>
			<div>
				<div class="fy3">
					<% if(total_pages >1 && current_page !=1) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page-1%>" class="p">��һҳ</a>
					<% } %>
              
					<% if(current_page<total_pages ) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page+1%>" class="p">��һҳ</a>
					<% } %>
				</div>   
			</div>
		</center>
            <%}%>
        </div>
        <!-- ������ҳ ����-->

        <div class="xwright">
            <!-- ��س����б� ��ʼ-->
            <% if (dt_wzhcs.Rows != null & dt_wzhcs.Rows.Count >0 ) {  %>                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_wzhcs.Rows){%>
                    <li><a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��������"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- ��س����б� ����-->

            <!-- ��ز�Ʒ�б� ��ʼ-->
             <% if (dt_wzhcl.Rows != null & dt_wzhcl.Rows.Count >0 ) {  %>
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_wzhcl.Rows){%>
                    <li><a href="clxx.aspx?cl_id=<% =row["cl_id"]%>"><%=row["��Ʒ����"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- ��ز�Ʒ�б� ����-->
        </div>
    </div>
    <!-- ����ҳ�뿪ʼ -->
     
    <!-- ����ҳ����� -->

    <!-- �������� ������ ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- �������� ������ ����-->
	
    <!-- footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->   
    <body>
</html>
