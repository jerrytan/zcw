<!--
        文章详情页面
        文件名：wzxq.ascx
        传入参数：p     列表页数
                  wz_id    文章类型
        负责人:任武
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
    <title>文章详情页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
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
            dt_Wz = dc.GetDataTable(str_SqlWz); 

            string str_SqlWzhcs = "select 厂商名称,gys_id from 文章和厂商相关表 where wz_id='"+wz_Id+"'";                  
            dt_Wzhcs = dc.GetDataTable(str_SqlWzhcs);

            string str_SqlWzhcl = "select 产品名称,cl_id from 文章和材料表相关表 where wz_id='"+wz_Id+"'";                    
            dt_Wzhcl = dc.GetDataTable(str_SqlWzhcl);    

            string page = Request["p"];
            if (page != null) 
			{	
				current_page = int.Parse(page);   
            }    
            string str_SqlWzhnr = "select 页面内容, 页面编号, wz_id from 文章和内容相关表 where wz_id='"+wz_Id+"' and 页面编号='"+ current_page+"'";             
            dt_Wzhnr = dc.GetDataTable(str_SqlWzhnr); 

            string str_SqlWzhnrTotal = "select count(*) from 文章和内容相关表 where wz_id='"+wz_Id+"'";
            object result = dc.DBLook(str_SqlWzhnrTotal);
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
        }
    </script>
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
    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">首页 ></a>正文</div>
        <div class="xwleft">
            <% foreach(System.Data.DataRow row in dt_Wz.Rows){%>
            <div class="xwleft1" style="overflow:hidden;"><%=row["标题"].ToString() %></div>
            <div class="xwleft2" >作者：<%=row["作者"].ToString() %></div>
            <%} %>
            
            <% foreach(System.Data.DataRow row2 in dt_Wzhnr.Rows){%>
            <div class="xwleft3" ><%=row2["页面内容"].ToString() %></div>
            <%}%>
		<center>
		<div>
				<div class="fy3" style="padding-left:70px">
                <% if(current_page<=1 && total_pages >1) {%> 
                    <font style="color:Gray">首页</font>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1 %>" class="p" style="color:Black">下一页</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=total_pages %>" class="p" style="color:Black">末页</a>
                <%} %>
                <% else if(current_page <=1 && total_pages <=1) {%>   
                     
                <%} %>
                <% else if(!(current_page<=1)&&!(current_page == total_pages)){ %>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=1 %>"class="p" style="color:Black">首页</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1 %>" class="p" style="color:Black">上一页</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page+1 %>" class="p" style="color:Black">下一页</a>
                     <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=total_pages %>" class="p" style="color:Black">末页</a>
                <%}%>
                <% else if( current_page !=1 && current_page == total_pages){ %>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=1 %>"class="p" style="color:Black">首页</a>
                    <a href="wzxq.aspx?wz_id=<%=wz_Id %>&p=<%=current_page-1 %>" class="p" style="color:Black">上一页</a>
                    <font style="color:Gray">末页</font>
                <%} %>
				</div>   
			</div>
		</center>
        </div>
        <!-- 文章首页 结束-->

        <div class="xwright">
            <!-- 相关厂商列表 开始-->
            <% if (dt_Wzhcs.Rows != null & dt_Wzhcs.Rows.Count >0 ) {  %>                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt_Wzhcs.Rows){%>
                    <li>
                        <%--<a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["厂商名称"].ToString()%></a>--%>
                        <a href="#"><%=row["厂商名称"].ToString()%></a>
                    </li>
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
</body>
</html>
