<!--
        ��������ҳ��
        �ļ�����wzxq.ascx
        ���������p     �б�ҳ��
                  wz_id    ��������
        ������:����
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
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>��������ҳ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
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
            dt_Wz = dc.GetDataTable(str_SqlWz); 

            string str_SqlWzhcs = "select ��������,gys_id from ���ºͳ�����ر� where wz_id='"+wz_Id+"'";                  
            dt_Wzhcs = dc.GetDataTable(str_SqlWzhcs);

            string str_SqlWzhcl = "select ��Ʒ����,cl_id from ���ºͲ��ϱ���ر� where wz_id='"+wz_Id+"'";                    
            dt_Wzhcl = dc.GetDataTable(str_SqlWzhcl);    

            string page = Request["p"];
            if (page != null) 
			{	
				current_page = int.Parse(page);   
            }    
            string str_SqlWzhnr = "select ҳ������, ҳ����, wz_id from ���º�������ر� where wz_id='"+wz_Id+"' and ҳ����='"+ current_page+"'";             
            dt_Wzhnr = dc.GetDataTable(str_SqlWzhnr); 

            string str_SqlWzhnrTotal = "select count(*) from ���º�������ر� where wz_id='"+wz_Id+"'";
            object result = dc.DBLook(str_SqlWzhnrTotal);
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
        }
    </script>
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
    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">��ҳ ></a>����</div>
        <div class="xwleft">
            <% foreach(System.Data.DataRow row in dt_Wz.Rows){%>
            <div class="xwleft1" style="overflow:hidden;"><%=row["����"].ToString() %></div>
            <div class="xwleft2" >���ߣ�<%=row["����"].ToString() %></div>
            <%} %>
            
            <% foreach(System.Data.DataRow row2 in dt_Wzhnr.Rows){%>
            <div class="xwleft3" ><%=row2["ҳ������"].ToString() %></div>
            <%}%>
		<center>
		<div>
				<div class="fy3" style="padding-left:70px">
                <% if(current_page<=1 && total_pages >1) {%> 
                    <font style="color:Gray">��ҳ</font>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1 %>" class="p" style="color:Black">��һҳ</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=total_pages %>" class="p" style="color:Black">ĩҳ</a>
                <%} %>
                <% else if(current_page <=1 && total_pages <=1) {%>   
                     
                <%} %>
                <% else if(!(current_page<=1)&&!(current_page == total_pages)){ %>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=1 %>"class="p" style="color:Black">��ҳ</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1 %>" class="p" style="color:Black">��һҳ</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1 %>" class="p" style="color:Black">��һҳ</a>
                     <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=total_pages %>" class="p" style="color:Black">ĩҳ</a>
                <%}%>
                <% else if( current_page !=1 && current_page == total_pages){ %>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=1 %>"class="p" style="color:Black">��ҳ</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1 %>" class="p" style="color:Black">��һҳ</a>
                    <font style="color:Gray">ĩҳ</font>
                <%} %>
				</div>   
			</div>
		</center>
        </div>
        <!-- ������ҳ ����-->

        <div class="xwright">
            <!-- ��س����б� ��ʼ-->
            <% if (dt_Wzhcs.Rows != null & dt_Wzhcs.Rows.Count >0 ) {  %>                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcs.Rows){%>
                    <li>
                        <%--<a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��������"].ToString()%></a>--%>
                        <a href="#"><%=row["��������"].ToString()%></a>
                    </li>
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
</body>
</html>
