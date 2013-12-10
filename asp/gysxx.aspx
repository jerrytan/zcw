<!--
        供应商信息页面
        文件名：gysxx.ascx
        传入参数：gys_id    供应商编号
               
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
    <title>分销商信息</title>
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


    <script runat="server">
        protected DataTable dt = new DataTable();  //供应商信息名字(材料供应商信息表)
		protected DataTable dt1 = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt2 = new DataTable(); //代理品牌(品牌字典)
		protected DataTable dt3 = new DataTable(); //现货供应(材料表)
        protected void Page_Load(object sender, EventArgs e)
        {
		if (!Page.IsPostBack)
         {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			string gys_id = Request["gys_id"];   //获取供应商id
            SqlDataAdapter da = new SqlDataAdapter("select  供应商  from 材料供应商信息表 where 是否启用=1 and gys_id='"+gys_id+"' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料供应商信息表");
            
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select 供应商,联系人,联系人手机,联系地址 from 材料供应商信息表 where  gys_id='"+gys_id+"'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料供应商信息表");            
            dt1 = ds1.Tables[0];
			
			//接受gys_id进行查询gys_id='"+gys_id+"'
			SqlDataAdapter da2 = new SqlDataAdapter("select 品牌名称,pp_id from 品牌字典 where scs_id='"+gys_id+"'", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料供应商信息表");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select 显示名 from 材料表 where gys_id in(select gys_id from 品牌字典 where 品牌名称 in(select 品牌名称 from 品牌字典 where gys_id='"+gys_id+"') )", conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "材料表");            
            dt3 = ds3.Tables[0];

            conn.Close();
			
			
         }		
        }
    </script>



    <!-- 首页 供应商信息 开始-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp 
  <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="#"><%=row["供应商"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">

                <% foreach(System.Data.DataRow row in dt1.Rows){%>
                <p>厂名：<%=row["供应商"].ToString() %></p>
                <p>地址：<%=row["联系地址"].ToString() %></p>
                <p>联系人：<%=row["联系人"].ToString() %></p>
                <p>联系电话：<%=row["联系人手机"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="#">本店尚未认领，如果您是店主，请认领本店，认领之后可以维护相关信息</a></div>
            <div class="gyan1"><a href="#">请收藏，便于查找</a></div>
        </div>

        <!-- 首页 供应商信息 结束-->



        <!-- 代理品牌 开始-->

        <div class="gydl">
            <div class="dlpp">代理品牌</div>
            <%foreach(System.Data.DataRow row in dt2.Rows){%>
            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["品牌名称"].ToString()%></div>
            <%}%>
        </div>

        <!-- 代理品牌 结束-->


        <!-- 现货供应 开始-->

        <div class="gydl">
            <div class="dlpp">现货供应</div>

            <%foreach(System.Data.DataRow row in dt3.Rows){%>
            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["显示名"].ToString() %></div>
            <%}%>
        </div>


    </div>

    <!-- 现货供应 结束-->

    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->


</body>
</html>
