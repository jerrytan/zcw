<!--
        生产商信息首页
        文件名：scsxx.ascx
        传入参数：gys_id    供应商编号
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>生产商信息页</title>
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
        protected DataTable dt = new DataTable();
		protected DataTable dt1 = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt2 = new DataTable(); //公司旗下品牌(品牌字典)
		protected DataTable dt3 = new DataTable(); //改公司下的分销商(供应商和分销商相关表)
        string gys_id;
        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                SqlConnection conn = new SqlConnection(constr);
                conn.Open();          
		        gys_id = Request["gys_id"];  //获取gys_id
                
                //获取生厂商信息
			    SqlDataAdapter da1 = new SqlDataAdapter("select 供应商,联系人,联系人手机,联系地址 from 材料供应商信息表 where gys_id='"+gys_id+"'", conn);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1, "材料供应商信息表");            
                dt1 = ds1.Tables[0];
			
			
			
			    //获取品牌信息
			    SqlDataAdapter da2 = new SqlDataAdapter("select 品牌名称,pp_id from 品牌字典 where 是否启用 = '1' and scs_id='"+gys_id+"'", conn);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2, "品牌字典");            
                dt2 = ds2.Tables[0];
			
                //获取分销商信息
			    //子查询嵌套 先根据传过来的gys_id查品牌名称  再从品牌字典里查复合条件的gys_id 最后根据复合条件的gys_id查分销商信息
			    SqlDataAdapter da3 = new SqlDataAdapter("select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id='"+gys_id+"') )", conn);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3, "材料供应商信息表");            
                dt3 = ds3.Tables[0];
			
			
             }		
        }
    </script>



    <!-- 生产商信息首页 开始-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp 

            <% foreach(System.Data.DataRow row in dt1.Rows){%>
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
            <div class="gyan1"><a href="" onclick="NewWindow(<%=gys_id %>)">请收藏，便于查找</a></div>
        </div>

        <!-- 生产商信息首页 结束-->



        <!-- 公司旗下品牌 开始-->

        <div class="gydl">
            <div class="dlpp">公司旗下品牌</div>
            <%foreach(System.Data.DataRow row in dt2.Rows){%>
            <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">

            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["品牌名称"].ToString()%></div>
            </a>
            <%}%>
        </div>

        <!-- 公司旗下品牌 结束-->


        <!-- 分销商页 开始-->

        <div class="gydl">
            <div class="dlpp">分销商</div>
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

            <%foreach(System.Data.DataRow row in dt3.Rows){%>
            <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">

            <div class="fxs2">
                <ul>
                    <li class="fxsa"><%=row["供应商"].ToString() %></li>
                    <li>联系人：<%=row["联系人"].ToString() %></li>
                    <li>电话：<%=row["联系人手机"].ToString() %></li>
                    <li>地址：<%=row["联系地址"].ToString() %></li>
                </ul>
            </div>
                </a>
            <%}%>
        </div>



    </div>

    <!-- 分销商页 结束-->



    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->


    <script>function NewWindow(id) {
    var url = "scgys.aspx?gys_id=" + id;
    window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
}
</script>
</body>
</html>
