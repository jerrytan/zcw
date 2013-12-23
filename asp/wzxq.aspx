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
    <style type="text/css">
        .p {
            font-size: 12px;
            color: Black;
            font-weight: bold;
            text-decoration: none;
        }

        .p1 {
            font-size: 15px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
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
                         
 	    protected DataTable dt=new DataTable();  //文章表
        protected DataTable dt1=new DataTable();  //文章和内容相关表
        protected DataTable dt2=new DataTable();  //文章和厂商相关表
        protected DataTable dt3=new DataTable();  //文章和产品相关表
        protected int total_pages =1;
        protected int current_page = 1;
        protected string wz_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            wz_id=Request["wz_id"];  //获取文章id
            SqlDataAdapter da = new SqlDataAdapter("select distinct 标题,作者, wz_id from 文章表 where wz_id='"+wz_id+"'", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "文章表");        
            dt = ds.Tables[0];

            SqlDataAdapter da2 = new SqlDataAdapter("select 厂商名称,gys_id from 文章和厂商相关表 where wz_id='"+wz_id+"'", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "文章和厂商相关表");        
            dt2 = ds2.Tables[0];

            SqlDataAdapter da3 = new SqlDataAdapter("select 产品名称,cl_id from 文章和材料表相关表 where wz_id='"+wz_id+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "文章和材料表相关表");        
            dt3 = ds3.Tables[0];   


            string page = Request["p"];
            if (page != null) current_page = int.Parse(page);   
                    
            string strr="select 页面内容, 页面编号, wz_id from 文章和内容相关表 where wz_id='"+wz_id+"' and 页面编号='"+ current_page+"'";  
            SqlDataAdapter da1 = new SqlDataAdapter(strr, conn);            
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "文章和内容相关表");   
            dt1 = ds1.Tables[0];

            string total_sql_str = "select count(*) from 文章和内容相关表 where wz_id='"+wz_id+"'";
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
        <div class="xwn1"><a href="index.aspx" class="p1">首页 ></a>正文</div>
        <div class="xwleft">

            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <div class="xwleft1"><%=row["标题"].ToString() %></div>
            <div class="xwleft2">作者：<%=row["作者"].ToString() %></div>

            <% foreach(System.Data.DataRow row2 in dt1.Rows){%>
            <div class="xwleft3"><%=row2["页面内容"].ToString() %></div>
            <%}%>
          
            <center>
        <div>
            <div class="fy3">
                <% if(total_pages >1 && current_page !=1) { %>
                <a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page-1%>" class="p">上一页</a>
                <% } %>
              
                <% if(current_page<total_pages ) { %>
                <a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page+1%>" class="p">下一页</a>
                <% } %>

              </div>
               
          </div>
    </center>
            <%}%>
        </div>

        <!-- 文章首页 结束-->





        <div class="xwright">
            <!-- 相关厂商列表 开始-->
            <% if (dt2.Rows != null & dt2.Rows.Count >0 ) {  %>
                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt2.Rows){%>
                    <li><a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["厂商名称"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- 相关厂商列表 结束-->



            <!-- 相关产品列表 开始-->
             <% if (dt3.Rows != null & dt3.Rows.Count >0 ) {  %>
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt3.Rows){%>
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
