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
 	    protected DataTable dt_Wz = new DataTable();  //���±�
        protected DataTable dt_Wzhnr = new DataTable();  //���º�������ر�
        protected DataTable dt_Wzhcs = new DataTable();  //���ºͳ�����ر�
        protected DataTable dt_Wzhcl = new DataTable();  //���ºͲ�����ر�
        protected int total_pages = 1;
        protected int current_page = 1;
        protected string wz_Id;
        protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            wz_Id=Request["wz_id"];  //��ȡ����id
            string str_SqlWz = "select distinct ����,����, wz_id from ���±� where wz_id='"+wz_Id+"'";            
            DataSet ds_Wz = new DataSet();
            string str_WzTable = "���±�";        
            dt_Wz = dc.DataPileDT(str_SqlWz,ds_Wz,str_WzTable); 

            string str_SqlWzhcs = "select ��������,gys_id from ���ºͳ�����ر� where wz_id='"+wz_Id+"'";            
            DataSet ds_Wzhcs = new DataSet();
            string str_WzhcsTable = "���ºͳ�����ر�";        
            dt_Wzhcs = dc.DataPileDT(str_SqlWzhcs,ds_Wzhcs,str_WzhcsTable);

            string str_SqlWzhcl = "select ��Ʒ����,cl_id from ���ºͲ��ϱ���ر� where wz_id='"+wz_Id+"'";            
            DataSet ds_Wzhcl = new DataSet();
            string str_WzhclTable = "���ºͲ��ϱ���ر�";        
            dt_Wzhcl = dc.DataPileDT(str_SqlWzhcl,ds_Wzhcl,str_WzhclTable);    

            string page = Request["p"];
            if (page != null) 
			{	
				current_page = int.Parse(page);   
            }    
            string str_SqlWzhnr = "select ҳ������, ҳ����, wz_id from ���º�������ر� where wz_id='"+wz_Id+"' and ҳ����='"+ current_page+"'";            
            DataSet ds_Wzhnr = new DataSet();
            string str_WzhnrTable = "���º�������ر�";   
            dt_Wzhnr = dc.DataPileDT(str_SqlWzhnr,ds_Wzhnr,str_WzhnrTable); 

            string str_SqlWzhnrTotal = "select count(*) from ���º�������ر� where wz_id='"+wz_Id+"'";
            object result = dc.ExecuteSingleValue(str_SqlWzhnrTotal);
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
        }
    </script>

    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">��ҳ ></a>����</div>
        <div class="xwleft">
            <% foreach(System.Data.DataRow row in dt_Wz.Rows){%>
            <div class="xwleft1"><%=row["����"].ToString() %></div>
            <div class="xwleft2">���ߣ�<%=row["����"].ToString() %></div>

            <% foreach(System.Data.DataRow row2 in dt_Wzhnr.Rows){%>
            <div class="xwleft3"><%=row2["ҳ������"].ToString() %></div>
            <%}%>
		<center>
			<div>
				<div class="fy3">
					<% if(total_pages >1 && current_page !=1) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1%>" class="p">��һҳ</a>
					<% } %>
              
					<% if(current_page<total_pages ) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1%>" class="p">��һҳ</a>
					<% } %>
				</div>   
			</div>
		</center>
            <%}%>
        </div>
        <!-- ������ҳ ����-->

        <div class="xwright">
            <!-- ��س����б� ��ʼ-->
            <% if (dt_Wzhcs.Rows != null & dt_Wzhcs.Rows.Count >0 ) {  %>                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcs.Rows){%>
                    <li><a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��������"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- ��س����б� ����-->

            <!-- ��ز�Ʒ�б� ��ʼ-->
             <% if (dt_Wzhcl.Rows != null & dt_Wzhcl.Rows.Count >0 ) {  %>
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcl.Rows){%>
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
