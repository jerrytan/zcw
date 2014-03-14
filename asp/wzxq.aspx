<!--
        文章详情页面
        文件名：wzxq.ascx
        传入参数：p     列表页数
                  wz_id    文章类型
               
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
    <title>文章详情页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <!-- 头部开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部结束-->

    <!-- 导航开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 导航结束-->

    <!-- banner开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner 结束-->

    <!-- 文章首页 开始-->
    <script runat="server">                         
 	    protected DataTable dt_Wz = new DataTable();  //文章表
        protected DataTable dt_Wzhnr = new DataTable();  //文章和内容相关表
        protected DataTable dt_Wzhcs = new DataTable();  //文章和厂商相关表
        protected DataTable dt_Wzhcl = new DataTable();  //文章和材料相关表
        protected int total_pages = 1;
        protected int current_page = 1;
        protected string wz_Id;
        protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            wz_Id=Request["wz_id"];  //获取文章id
            string str_SqlWz = "select distinct 标题,作者, wz_id from 文章表 where wz_id='"+wz_Id+"'";            
            DataSet ds_Wz = new DataSet();
            string str_WzTable = "文章表";        
            dt_Wz = dc.DataPileDT(str_SqlWz,ds_Wz,str_WzTable); 

            string str_SqlWzhcs = "select 厂商名称,gys_id from 文章和厂商相关表 where wz_id='"+wz_Id+"'";            
            DataSet ds_Wzhcs = new DataSet();
            string str_WzhcsTable = "文章和厂商相关表";        
            dt_Wzhcs = dc.DataPileDT(str_SqlWzhcs,ds_Wzhcs,str_WzhcsTable);

            string str_SqlWzhcl = "select 产品名称,cl_id from 文章和材料表相关表 where wz_id='"+wz_Id+"'";            
            DataSet ds_Wzhcl = new DataSet();
            string str_WzhclTable = "文章和材料表相关表";        
            dt_Wzhcl = dc.DataPileDT(str_SqlWzhcl,ds_Wzhcl,str_WzhclTable);    

            string page = Request["p"];
            if (page != null) 
			{	
				current_page = int.Parse(page);   
            }    
            string str_SqlWzhnr = "select 页面内容, 页面编号, wz_id from 文章和内容相关表 where wz_id='"+wz_Id+"' and 页面编号='"+ current_page+"'";            
            DataSet ds_Wzhnr = new DataSet();
            string str_WzhnrTable = "文章和内容相关表";   
            dt_Wzhnr = dc.DataPileDT(str_SqlWzhnr,ds_Wzhnr,str_WzhnrTable); 

            string str_SqlWzhnrTotal = "select count(*) from 文章和内容相关表 where wz_id='"+wz_Id+"'";
            object result = dc.ExecuteSingleValue(str_SqlWzhnrTotal);
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
        }
    </script>

    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">首页 ></a>正文</div>
        <div class="xwleft">
            <% foreach(System.Data.DataRow row in dt_Wz.Rows){%>
            <div class="xwleft1"><%=row["标题"].ToString() %></div>
            <div class="xwleft2">作者：<%=row["作者"].ToString() %></div>

            <% foreach(System.Data.DataRow row2 in dt_Wzhnr.Rows){%>
            <div class="xwleft3"><%=row2["页面内容"].ToString() %></div>
            <%}%>
		<center>
			<div>
				<div class="fy3">
					<% if(total_pages >1 && current_page !=1) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1%>" class="p">上一页</a>
					<% } %>
              
					<% if(current_page<total_pages ) { %>
					<a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1%>" class="p">下一页</a>
					<% } %>
				</div>   
			</div>
		</center>
            <%}%>
        </div>
        <!-- 文章首页 结束-->

        <div class="xwright">
            <!-- 相关厂商列表 开始-->
            <% if (dt_Wzhcs.Rows != null & dt_Wzhcs.Rows.Count >0 ) {  %>                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcs.Rows){%>
                    <li><a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["厂商名称"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- 相关厂商列表 结束-->

            <!-- 相关产品列表 开始-->
             <% if (dt_Wzhcl.Rows != null & dt_Wzhcl.Rows.Count >0 ) {  %>
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcl.Rows){%>
                    <li><a href="clxx.aspx?cl_id=<% =row["cl_id"]%>"><%=row["产品名称"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- 相关产品列表 结束-->
        </div>
    </div>
    <!-- 文章页码开始 -->
     
    <!-- 文章页码结束 -->

    <!-- 关于我们 广告服务 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 结束-->
	
    <!-- footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->   
    <body>
</html>
