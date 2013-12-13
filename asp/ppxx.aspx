<!--
        品牌详情页面
        文件名：ppxx.ascx
        传入参数：pp_id    品牌编号
               
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
    <title>品牌信息页</title>
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

        protected DataTable dt = new DataTable(); //品牌名称(品牌字典表)
		protected DataTable dt1 = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt2 = new DataTable(); //分销商信息(供应商和分销商相关表)
		protected DataTable dt3 = new DataTable(); //该品牌下的产品(材料表)
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();          
			string pp_id = Request["pp_id"];  //获取传过来的pp_id
            SqlDataAdapter da = new SqlDataAdapter("select 品牌名称,scs_id  from 品牌字典 where pp_id='"+pp_id+"'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "品牌字典");            
            dt = ds.Tables[0];				
			
            SqlDataAdapter da1 = new SqlDataAdapter("select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in (select scs_id from 品牌字典 where pp_id='"+pp_id+"' )", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料供应商信息表");            
            dt1 = ds1.Tables[0];			
			
            //获得该品牌的分销信息
			//string BrandsName=Request["BrandsName"];
            SqlDataAdapter da2 = new SqlDataAdapter("select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='"+pp_id+"')", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料供应商信息表");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select 显示名 ,规格型号,cl_id from 材料表 where pp_id='"+pp_id+"'  ", conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "材料表 ");
            conn.Close();             
            dt3 = ds3.Tables[0];
        }	
       
    </script>

    <!-- 首页 品牌信息 开始-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="#"><%=row["品牌名称"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt1.Rows){%>
                <a href="scsxx.aspx?gys_id=<%=row["gys_id"] %>">
                <p>厂名：<%=row["供应商"].ToString() %></p>
                <p>地址：<%=row["联系地址"].ToString() %></p>
                <p>联系人：<%=row["联系人"].ToString() %></p>
                <p>电话：<%=row["联系人手机"].ToString() %></p>
                </a>
                <%}%>
            </div>

        </div>

        <!-- 首页 品牌信息 结束-->



        <!-- 该品牌分销商 开始-->

        <div class="gydl">
            <div class="dlpp">该品牌分销商</div>
            <div class="fxs1">
                <select name="" class="fu1">
                    <option>华北</option>
                </select>
                <select name="" class="fu2">
                    <option>北京</option>
                </select>省（市）

    <select name="" class="fu3">
        <option>石家庄</option>
    </select>
                地区<select name="" class="fu4"><option>市区</option>
                </select>
                区（县）
            </div>
            <%foreach(System.Data.DataRow row in  dt2.Rows){%>
            <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">

            <div class="fxs2">
                <ul>

                    <li class="fxsa"><%=row["供应商"].ToString()%></li>
                    <li>电话：<%=row["联系人手机"].ToString()%></li>
                    <li>联系人：<%=row["联系人"].ToString()%></li>
                    <li>地址：<%=row["联系地址"].ToString()%></li>
                </ul>
            </div>
            </a>
            <%}%>
        </div>

        <!-- 该品牌分销商 结束-->


        <!-- 该品牌下产品 开始-->

        <div class="gydl">
            <div class="dlpp">该品牌下产品</div>

            <%foreach(System.Data.DataRow row in dt3.Rows){%>
            <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
            <div class="ppcp">
                <img src="images/222_03.jpg" />
                <span class="ppcp1"><%=row["显示名"].ToString() %></span>
                <span class="ppcp2">规格：<%=row["规格型号"].ToString() %></span>
            </div>
            </a>
            <%}%>
        </div>
    </div>

    <!-- 该品牌下产品 结束-->

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
