<!--
        品牌详情页面
        文件名：ppxx.ascx
        传入参数：pp_id    品牌编号
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
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>品牌信息页</title>
    <script src="js/ppjilian.js" type="text/javascript"></script>
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
        protected DataTable dt_ppxx = new DataTable(); //品牌名称(品牌字典表)
		protected DataTable dt_scsxx = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt_fxsxx = new DataTable(); //分销商信息(供应商和分销商相关表)
		protected DataTable dt_clxx = new DataTable(); //该品牌下的产品(材料表)
        protected DataConn objdc = new DataConn();
        protected DataTable dt_qymc = new DataTable();// 保存区域名称
        protected string pp_id; //品牌id

        protected void Page_Load(object sender, EventArgs e)
        {
            
             /*获取区域信息*/
            string str_sqlqymc = "select 所属区域编号,所属区域名称  from 地区地域字典 group by 所属区域编号,所属区域名称";
            dt_qymc = objdc.GetDataTable(str_sqlqymc);
                
			 pp_id = Request["pp_id"];  //获取传过来的pp_id
            string str_sqlppxx = "select 品牌名称,scs_id  from 品牌字典 where pp_id='"+pp_id+"'";      
            dt_ppxx = objdc.GetDataTable(str_sqlppxx);				

             //访问计数加1
            string str_updatecounter = "update 品牌字典 set 访问计数 = (select 访问计数 from 品牌字典 where pp_id = '"+ pp_id +"')+1 where pp_id = '"+ pp_id +"'";
            objdc.ExecuteSQL(str_updatecounter,true);

            string str_sqlscsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in (select scs_id from 品牌字典 where pp_id='"+pp_id+"' )";   
            dt_scsxx = objdc.GetDataTable(str_sqlscsxx);			
			
            //获得该品牌的分销信息
            string str_sqlfxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='"+pp_id+"')";           
            dt_fxsxx = objdc.GetDataTable(str_sqlfxsxx);
			
			string str_sqlclxx = "select 显示名 ,规格型号,cl_id from 材料表 where pp_id='"+pp_id+"'  ";        
            dt_clxx = objdc.GetDataTable(str_sqlclxx);
        }	       
    </script>
    <div class="gysxx">
        <!-- 首页 品牌信息 开始-->
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {%>
                <a href="#"><%=row["品牌名称"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt_scsxx.Rows)
                {%>
                <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
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
                <select id="s1" class="fu1" onchange="GetProvince(this.options[this.options.selectedIndex].value,<%=pp_id%>)">
                    <option value="请选择">-请选择-</option>
                     <%foreach(System.Data.DataRow row in dt_qymc.Rows )
                    {%> 
                        <option value="<%=row["所属区域编号"].ToString()%>"><%=row["所属区域名称"].ToString() %></option>
                    <%}%>
                </select>
                地区
                <select id="s2" class="fu2" onchange="GetCity(this.options[this.options.selectedIndex].value,<%=pp_id %>)">
                </select>
                省(市)
                <select id="s3" class="fu3">
                </select>
                市(区)
            </div>
            <!-- 品牌分销商 显示开始-->
        
            <!-- 品牌分销商 显示结束-->
        </div>
        <!-- 该品牌分销商 结束-->

        <!-- 该品牌下产品 开始-->
        <div class="gydl">
            <div class="dlpp">该品牌下产品</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows)
            {%>
            <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
                <div class="ppcp">
                    <%	    
                        string str_sqltop1 = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"+row["cl_id"]+"' and 大小='小'";
                        string imgsrc= "images/222_03.jpg";
                        object result = objdc.DBLook(str_sqltop1);
                        if (result != null) {
                            imgsrc = result.ToString();
                        }
                        Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
				    %>
                    <span class="ppcp1"><%=row["显示名"].ToString() %></span>
                    <span class="ppcp2">规格：<%=row["规格型号"].ToString() %></span>
                </div>
            </a>
            <%}%>
        </div>
        <!-- 该品牌下产品 结束-->
    </div>

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
