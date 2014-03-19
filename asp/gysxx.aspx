<!--
        供应商信息页面
        文件名：gysxx.ascx
        传入参数：gys_id    供应商编号
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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=8ee0deb4c10c8fb4be0ac652f83e8f5d"></script>
    <title>材料供应商信息</title>
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
        protected DataTable dt_fxsxx = new DataTable();  //供应商信息名字(材料供应商信息表)
		protected DataTable dt_gysxx = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt_ppxx = new DataTable(); //代理品牌(品牌字典)
		protected DataTable dt_clxx = new DataTable(); //现货供应(材料表)
        protected string gys_id;    //供应商id
        protected string gys_type;  //供应商类型：生产商和分销商
		protected string gys_addr;  //供应商地址
        protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {          
			    gys_id = Request["gys_id"];   //获取供应商id                      
			
			    string str_sqlclgys = "select 供应商,单位类型,联系人,联系人手机,联系地址 from 材料供应商信息表 where  gys_id='"+gys_id+"'";            
                dt_gysxx = dc.GetDataTable(str_sqlclgys);

                //访问计数加1
                String str_updatecounter = "update 材料供应商信息表 set 访问计数 = (select 访问计数 from 材料供应商信息表 where gys_id = '"+ gys_id +"')+1 where gys_id = '"+ gys_id +"'";
                dc.ExecuteSQL(str_updatecounter,true);      


                //获得供应商的单位类型，生产商还是分销商
                gys_type = Convert.ToString(dt_gysxx.Rows[0]["单位类型"]);		
                
                //分销商为代理品牌和正在销售材料
                if(gys_type.Equals("分销商")) 
                {
                    //获得代理品牌信息
			        string str_sqldlppxx = "select 品牌名称,pp_id from 分销商和品牌对应关系表 where fxs_id='"+gys_id+"'";           
                    dt_ppxx = dc.GetDataTable(str_sqldlppxx);
			
                    //获得正在分销的材料列表
			        string str_sqlfxcl = "select 显示名,cl_id from 材料表 where pp_id in(select pp_id from  分销商和品牌对应关系表 where fxs_id ='"+gys_id+"') ";           
                    dt_clxx = dc.GetDataTable(str_sqlfxcl);
                }
                else  //生厂商则显示旗下品牌和它的分销商
                {
                     //获取品牌信息
			        string str_sqlppxx = "select 品牌名称,pp_id from 品牌字典 where 是否启用 = '1' and scs_id='"+gys_id+"'";           
                    dt_ppxx = dc.GetDataTable(str_sqlppxx);
			
                    //获取分销商信息
			        //子查询嵌套 先根据传过来的gys_id查品牌名称  再从品牌字典里查复合条件的gys_id 最后根据复合条件的gys_id查分销商信息
			        string str_fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id='"+gys_id+"') )";          
                    dt_fxsxx = dc.GetDataTable(str_fxsxx);
                }
            }		
        }
    </script>

    <!-- 首页 供应商信息 开始-->
    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_gysxx.Rows){%>
            <a href="#"><%=row["供应商"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt_gysxx.Rows){
				   gys_addr = row["联系地址"].ToString();%>
                <p>厂名：<%=row["供应商"].ToString() %></p>
                <p>地址：<%=gys_addr %></p>
                <p>联系人：<%=row["联系人"].ToString() %></p>
                <p>联系电话：<%=row["联系人手机"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="#">本店尚未认领，如果您是店主，请认领本店，认领之后可以维护相关信息</a></div>
            <div class="gyan1"><a href="" onclick="NewWindow(<%=gys_id %>)">请收藏，便于查找</a></div>
        </div>		
		<div class="gydl">
            <div class="dlpp">地理位置</div>
			<div id="allmap"></div>
            <script type="text/javascript">
                // 百度地图API功能
                var map = new BMap.Map("allmap");
                var point = new BMap.Point(116.331398, 39.897445);
                map.centerAndZoom(point, 15);
                // 创建地址解析器实例
                var myGeo = new BMap.Geocoder();
                // 将地址解析结果显示在地图上,并调整地图视野
                myGeo.getPoint("<%=gys_addr %>", function (point) {
                    if (point) {
                        map.centerAndZoom(point, 13);
                        map.addOverlay(new BMap.Marker(point));
                    }
                }, "<%=gys_addr %>");
            </script>
        </div>
		
        <% if (gys_type.Equals("分销商")) 
           {
        %>
        <!-- 代理品牌 开始-->
        <div class="gydl">
            <div class="dlpp">代理品牌</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
              {%>
                    <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <img src="images/222_03.jpg" /><%=row["品牌名称"].ToString()%>
                    </div>
                    </a>
            <%}%>
        </div>
        <!-- 代理品牌 结束-->

        <!-- 现货供应 开始-->
        <div class="gydl">
            <div class="dlpp">现货供应</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">			
                <div class="gydl1">
			    <%	
                    string str_sqltop1 = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"+row["cl_id"]+"' and 大小='小'";
                    string imgsrc= "images/222_03.jpg";
                    object result = dc.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");			
			    %>
			    <%=row["显示名"].ToString() %>
			    </div>
                </a>
            <%}%>
            </div>
        <% }else {  //生产商%>
            <!-- 公司旗下品牌 开始-->
            <div class="gydl">
            <div class="dlpp">公司旗下品牌</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {   %>
                <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <img src="images/222_03.jpg" /><%=row["品牌名称"].ToString()%>
                    </div>
                </a>
            <%}%>
         </div>
            <!-- 公司旗下品牌 结束-->

            <!-- 分销商页 开始-->
            <div class="gydl">
            <div class="dlpp">分销商</div>
            <div class="fxs1">
                <select id="s1" name="" class="fu1">
                    <option></option>
                </select>
                地区
                <select id="s2" name="" class="fu2">
                    <option></option>
                </select>
                省（市）
                <select id="s3" name="" class="fu3">
                    <option></option>
                </select>
                地区
                <select id="s4" name="" class="fu4">
                    <option></option>
                </select>
                区（县）
            </div>
            <%foreach(System.Data.DataRow row in dt_fxsxx.Rows){%>
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
            <!-- 分销商页 结束-->
        <% }
        %>
        <!-- 现货供应 结束-->
    </div>
    <!-- 首页 供应商信息 结束-->

    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->

    <script language="javascript" type="text/javascript">
        function NewWindow(id) {
            var url = "scgys.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
    </script>
</body>
</html>
