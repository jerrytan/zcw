<!--
        更多材料页面
        文件名：gdfl.aspx
        传入参数：无
        owner:苑伟业
               
    -->


<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <!-- 头部 开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部 结束-->

    <!-- 头部导航 include menu.ascx 开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 头部导航 include menu.ascx 结束-->

    <!-- 头部广告 static bannder.aspx 开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- 头部广告 static bannder.aspx 结束-->

    <script runat="server">
        public class Manufacturer
        {
            public string Gys_id { get; set; }
            public string Type { get; set; }
            public string Name { get; set; }
        }
        public class FLObject
        {
            public string Sid { get; set; } //分类编号
            public string Name { get; set; } //名称
        }

        public List<Manufacturer> Items { get; set; }
        public List<FLObject> Items_Yjfl { get; set; }
        public List<FLObject> Items_Ejfl { get; set; }

        protected DataTable dt_NewGys = new DataTable();  //最新加入的供应商(材料供应商信息表)
        protected DataTable dt_NewBrand = new DataTable();  //最新加入品牌(品牌字典)
        protected DataTable dt_Yjfl = new DataTable();  //取一级分类名称全部
        protected DataTable dt_Ejfl = new DataTable();  //取二级分类名称全部

        protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {
            //sql语句集合
            string sql_TopGys = "select top 10 供应商 ,gys_id,单位类型 from 材料供应商信息表 where 是否启用=1 order by updatetime desc";
            string sql_NewBrand = "select top 10 品牌名称,pp_id from 品牌字典 where 是否启用=1 order by updatetime desc";
            string sql_Yjfl = "select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 ";
            string sql_Ejfl = "select distinct  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=4 ";

            dt_NewGys = dc.GetDataTable(sql_TopGys);
            dt_NewBrand = dc.GetDataTable(sql_NewBrand);
            dt_Yjfl = dc.GetDataTable(sql_Yjfl);
            dt_Ejfl = dc.GetDataTable(sql_Ejfl);

            //数据表DataTable转集合  
            this.Items = new List<Manufacturer>();
            this.Items_Yjfl = new List<FLObject>();
            this.Items_Ejfl = new List<FLObject>();

            for (int i = 0; i < dt_NewGys.Rows.Count; i++)
            {
                DataRow dr = dt_NewGys.Rows[i];
                Manufacturer mf = new Manufacturer();
                mf.Gys_id = dr["gys_id"].ToString();
                mf.Type = dr["单位类型"].ToString();
                mf.Name = dr["供应商"].ToString();
                Items.Add(mf);
            }

            for (int i = 0; i < dt_Yjfl.Rows.Count; i++)
            {
                DataRow dr = dt_Yjfl.Rows[i];
                if (dr["分类编码"].ToString().Length == 2)
                {
                    FLObject yjfl = new FLObject();
                    yjfl.Sid = dr["分类编码"].ToString();
                    yjfl.Name = dr["显示名字"].ToString();
                    Items_Yjfl.Add(yjfl);
                }
            }

            for (int i = 0; i < dt_Ejfl.Rows.Count; i++)
            {
                DataRow dr = dt_Ejfl.Rows[i];
                if (dr["分类编码"].ToString().Length == 4)
                {
                    FLObject ejfl = new FLObject();
                    ejfl.Sid = dr["分类编码"].ToString();
                    ejfl.Name = dr["显示名字"].ToString();
                    Items_Ejfl.Add(ejfl);
                }
            }
        }   
    </script>

    <!-- 更多内容 开始 -->
    <div class="gengduo">
         <!-- 更多左边 开始 -->
         <div class="gd_left">
               <div class="gd_left_top">
                   材料分类 
               </div>
               <%foreach(var v in this.Items_Yjfl) {%>
               <div class="gd_left_cont gd_link">
                    <ul>
                        <li class="font_bold"><a href="yjfl.aspx?name=<%=v.Sid.ToString() %>"><%=v.Name%></a></li>
                        <li>
                        <%foreach(var vr in this.Items_Ejfl){ 
                            if (vr.Sid.ToString().Substring(0, 2) == v.Sid.ToString()){%>
                            <a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a> |
                        <%}} %>
                        </li>
                    </ul>
               </div>
               <%} %>
         </div>
         <!-- 更多左边 结束 -->

         <!-- 更多右边上部 开始 -->
         <div class="gd_right">
            <div class="gd_right_top">
                最近加入供应商 
            </div>
            <div class="gd_right_b">
                <div class="gd_right_b_cont gd_link">
                    <ul>
                        <% foreach (var v in Items){ %>
                        <li style="overflow:hidden"><a href="gysxx.aspx?gys_id=<%=v.Gys_id %>"><%=v.Name %></a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
         </div>
         <!-- 更多右边上部 结束 -->

         <!-- 更多右边下部 开始 -->
         <div class="gd_right">
            <div class="gd_right_top">
                最新品牌
            </div>
            <div  class="gd_right_b">
                <div class="gd_right_b_cont gd_link">
                    <ul>
                        <%foreach (System.Data.DataRow row in dt_NewBrand.Rows){ %>
                        <li><a href="ppxx.aspx?pp_id=<%=row["pp_id"]%>"><%=row["品牌名称"].ToString() %></a></li>
                        <%} %>
                    </ul>
                </div>
            </div>
         </div>
         <!-- 更多右边下部 开始 -->

    </div>
    <!-- 更多内容 结束 -->

    <!-- 中下 关于我们 aboutus.aspx 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 中下 关于我们 aboutus.aspx 结束-->

    <!-- 尾部 footer.aspx 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- 尾部 footer.aspx 结束-->

</body>
</html>
