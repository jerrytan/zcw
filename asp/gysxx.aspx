<!--
        供应商信息页面
        文件名：gysxx.aspx
        传入参数：gys_id    供应商编号
        负责人:任武       
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=8ee0deb4c10c8fb4be0ac652f83e8f5d"></script>
	<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>
		
    <title>材料供应商信息</title>
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        $(function () {
            $("#s1").change(function () {
                $("#region").val($("#s0").children('option:selected').val() + $("#s1").children('option:selected').val());
            });
        });
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            var url = "gysxx_ajax.aspx";
            var fxsmsg = $j("#fxsid_msg").val();
            var fxscount = $j("#fxscount_msg").val();
            $j("#s1").change(function () {
                var item1 = $j("#s1 option:selected").text();
                var data = { address: item1, gys_id: fxsmsg};
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var fxs_list = str_fxs[0];  //供应商信息
                        var fxs_fy = str_fxs[1];    //分页信息
                        $j("#fxsxx_list").html(fxs_list); //替换筛选的内容
                        $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                    }
                }, "text");
            });
            $j("#s2").change(function () {
                var item2 = $j("#s2 option:selected").text();
                var data = { address: item2, gys_id: fxsmsg};
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var fxs_list = str_fxs[0];  //供应商信息
                        var fxs_fy = str_fxs[1];    //分页信息
                        $j("#fxsxx_list").html(fxs_list); //替换筛选的内容
                        $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                    }
                },"text");
            });
            $j("#s3").change(function () {
                var item3 = $j("#s3 option:selected").text();
                var data = { address: item3, gys_id: fxsmsg };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@")>= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var fxs_list = str_fxs[0];  //供应商信息
                        var fxs_fy = str_fxs[1];    //分页信息
                        $j("#fxsxx_list").html(fxs_list); //替换筛选的内容
                        $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                    } 
                }, "text");
            });
        });
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

     <script runat="server">
        protected DataTable dt_fxsxx = new DataTable();  //供应商信息名字(材料供应商信息表)
		protected DataTable dt_gysxx = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt_ppxx = new DataTable(); //代理品牌(品牌字典)
		protected DataTable dt_clxx = new DataTable(); //现货供应(材料表)

        protected string gys_id;    //供应商id
        protected string gys_type;  //供应商类型：生产商和分销商
        protected string gys_addr="";
        protected string address;  //供应商地址
        protected DataConn dc = new DataConn();
        protected DataTable dt_content = new DataTable(); //分页后存放的分销商信息
        protected DataTable dt_qymc = new DataTable();// 保存区域名称

        private const int Page_Size = 2; //每页的记录数量
        private int CurrentPage=1;//当前默认页为第一页
        private int PageCount; //总页数

        protected string content = "";  //存放供应商信息
        protected string fy_list = "";  //存放分页信息
		
		public string yh_id = "";
		public string QQ_id="";
		private string pass="";
		
        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                gys_id = Request["gys_id"];   //获取供应商id 

			    string str_sqlclgys = "select 供应商,单位类型,联系人,联系人手机,地址,传真,主页 from 材料供应商信息表 where  gys_id='"+gys_id+"'";            
                dt_gysxx = dc.GetDataTable(str_sqlclgys);

                //访问计数加1
                String str_updatecounter = "update 材料供应商信息表 set 访问计数 = (select 访问计数 from 材料供应商信息表 where gys_id = '"+ gys_id +"')+1 where gys_id = '"+ gys_id +"'";
                dc.ExecuteSQL(str_updatecounter,true);      

                //对数据进行判断
                if(dt_gysxx!=null && dt_gysxx.Rows.Count>0)
                {
                    //获得供应商的单位类型，生产商还是分销商
                    gys_type = Convert.ToString(dt_gysxx.Rows[0]["单位类型"]);
                 }

                //判断gys_type是否为空
                if(!string.IsNullOrEmpty(gys_type))
                {
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
                    else   //生厂商则显示旗下品牌和它的分销商
                    {
                        //获取品牌信息
			            string str_sqlppxx = "select 品牌名称,pp_id from 品牌字典 where 是否启用 = '1' and scs_id='"+gys_id+"'";           
                        dt_ppxx = dc.GetDataTable(str_sqlppxx);
			
                        //获取分销商信息
                        //子查询嵌套 先根据传过来的gys_id查品牌名称  再从品牌字典里查复合条件的gys_id 最后根据复合条件的gys_id查分销商信息
			            string str_fxsxx = "select 供应商,联系人,联系人手机,地址,gys_id from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id='"+gys_id+"') )";          
                        dt_fxsxx = dc.GetDataTable(str_fxsxx);

                        //生产商旗下分销商 分页显示
                           //从查询字符串中获取"页号"参数
                            string strP = Request.QueryString["p"];
                            if(string.IsNullOrEmpty(strP))//判断传过来的参数是否为空  
                            {
                                strP = "1";
                            }
            
                            int p;
                            bool b1 = int.TryParse(strP, out p);
                            if (b1 == false)
                            {
                                p = 1;
                            }
                            CurrentPage = p;
                
                            //从查询字符串中获取"总页数"参数
                            string strC = "";
                            if(string.IsNullOrEmpty(strC))
                            {
                                double recordCount = this.GetFXSCount(); 
                                double d1 = recordCount / Page_Size; 
                                double d2 = Math.Ceiling(d1); 
                                int pageCount = (int)d2; 
                                strC = pageCount.ToString();
                            }
                            int c;
                            bool b2 = int.TryParse(strC,out c);
                            if (b2 == false)
                            {
                                c = 1;
                            }
                            PageCount = c;

                            //计算/查询分页数据
                            int begin = (p - 1) * Page_Size + 1;
                            int end = p * Page_Size;
                            dt_content = this.GetPageList(gys_id,begin,end);

                            if(dt_content != null && dt_content.Rows.Count>0)//有数据,则进行遍历
                            {   
                                foreach(System.Data.DataRow row in dt_content.Rows)
                                {
									content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                                        + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                                        + row["供应商"].ToString() + "</li><li>联系人："
                                        + row["联系人"].ToString() + "</li><li>电话："
                                        + row["联系人手机"].ToString() + "</li><li>"
                                        + SubStrings.GetWidth(20,"地址："+row["地址"].ToString(),"地址："+row["地址"].ToString()) + "</li></ul></a></div>";
                                }

                               //分页显示信息
								if((CurrentPage <= 1) && (PageCount <=1)) { //一页
									 fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
									+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";

								}
								else if((CurrentPage<= 1)  && (PageCount>1)) {//两页 
									fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
									+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
								}   
								else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //多页
									fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
									+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
								}
								else if((CurrentPage == PageCount) && (PageCount > 1)){  //末页
									fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
									+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>"; 
								}
                            }        
                        }	
                    }	
                }
        }

        //从数据库获取记录的总数量
        protected int GetFXSCount()
        {
            int i_count=0;
            try
            {
                string gys_id = Request["gys_id"];   //获取供应商id
				string str_sql_fxsxx = "";
				str_sql_fxsxx = "select gys_id, 供应商,联系人,联系人手机,地址 from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id='"+gys_id+"') )";
                i_count = dc.GetRowCount(str_sql_fxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 

        //获取分页信息:gys_id 生产商id, begin 开始, end 结束, address 地址
        protected DataTable GetPageList(string gys_id, int begin, int end)
        {
            
            //执行分页的sql语句
            string str_sqlpage = @"select gys_id,供应商,联系人,联系人手机,地址 from (select ROW_NUMBER() over (order by gys_id) as RowId ,* from 材料供应商信息表  where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id=@gys_id) ))t where t.RowId between @begin and @end ";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@gys_id",SqlDbType.VarChar),
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = gys_id;
            return  dc.GetDataTable(str_sqlpage,parms);
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
            <% if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
               {
                   gys_addr = dt_gysxx.Rows[0]["地址"].ToString();%>
 <ul>
   <li>厂名：<a href="#" class="fxsa"><%=dt_gysxx.Rows[0]["供应商"].ToString()%></a></li>
   <li>联系人：<%=dt_gysxx.Rows[0]["联系人"].ToString()%></li>
   <li>电话：<%=dt_gysxx.Rows[0]["联系人手机"].ToString()%></li> 
   <li>传真：<%=dt_gysxx.Rows[0]["传真"].ToString()%></li>
   <li>主页：<%=dt_gysxx.Rows[0]["主页"].ToString()%></li>  
   <li>地址：<%=gys_addr%></li></ul>
 <%} %>
            </div>
            <%if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null)
              { %>
            <%
                //供应商
                HttpCookie GYS_QQ_id = Request.Cookies["GYS_QQ_ID"];
                Object GYS_YH_id = Session["GYS_YH_ID"];

                HttpCookie CGS_QQ_id = Request.Cookies["CGS_QQ_ID"];
                Object CGS_YH_id = Session["CGS_YH_ID"];

                if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
                {
                    QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
                }
                if (QQ_id != "")
                {
                    string str_sqlyhid = "select dw_id from 用户表 where QQ_id = '" + QQ_id + "'";
                    string dwid = dc.DBLook(str_sqlyhid);
                    if (dwid != "")
                    {
                        string sql = "select count(*) from 采购商关注供应商表 where dw_id='" + dwid + "' and gys_id='" + gys_id + "'";
                        int count = Convert.ToInt32(dc.DBLook(sql));
                        if (count > 0)
                        {%>
            <span class="xx4_1" style="display: block; margin-left: 40%; margin-right: auto;"><a
                href="javascript:void(0)">已收藏</a> </span>
            <%}
              else
              { %>
            <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">请收藏，便于查找</a></div>
            <% }
          }
      }
    }%>
            <%else
                { %>
            <%
                //供应商                     
                string YH_id = "";
                if (Session["GYS_YH_ID"] != null)
                {
                    YH_id = Session["GYS_YH_ID"].ToString();
                }


                if (Session["CGS_YH_ID"] != null)
                {
                    YH_id = Session["CGS_YH_ID"].ToString();
                }
                string str_sqlyhid = "select dw_id from 用户表 where yh_id = '" + YH_id + "'";
                string dwid = dc.DBLook(str_sqlyhid);
                if (dwid != "")
                {
                    string sql = "select count(*) from 采购商关注供应商表 where dw_id='" + dwid + "' and gys_id='" + gys_id + "'";
                    int count = Convert.ToInt32(dc.DBLook(sql));
                    if (count > 0)
                    {%>
            <span class="xx4_1" style="display: block; margin-left: 40%; margin-right: auto;"><a
                href="javascript:void(0)">已收藏</a> </span>
            <%	}

          else
          {%>
            <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">请收藏，便于查找</a></div>
            <%}
      }
else
	{%>
             <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">请收藏，便于查找</a></div>        
	<%}
      }%>

		<div class="ditu">
            <div class="ditu_zi">地理位置</div>
			<div id="allmap"></div>
            <script>
                // 百度地图API功能
                var map = new BMap.Map("allmap");
                var point = new BMap.Point(116.331398, 39.897445);
                map.centerAndZoom(point, 15);
                // 创建地址解析器实例
                var myGeo = new BMap.Geocoder();
                // 将地址解析结果显示在地图上,并调整地图视野
                myGeo.getPoint'<%=gys_addr %>', function (point) {
                    if (point) {
                        map.centerAndZoom(point, 13);
                        map.addOverlay(new BMap.Marker(point));
                    }
                }, '<%=gys_addr %>');
            </script>
        </div>	
        </div>		
		
		
        <% if (gys_type.Equals("分销商")) {%>
        <!-- 代理品牌 开始-->
        <div class="gydl2">
            
            <%
                if (dt_gysxx.Rows[0]["单位类型"].ToString()=="分销商")
                {
                    Response.Write("<div class='dlpp'>公司代理的品牌</div>");
                }
                else if (dt_gysxx.Rows[0]["单位类型"].ToString()=="生产商")
                {
                    Response.Write("<div class='dlpp'>公司旗下品牌</div>");
                }
                %>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
              {%>
                    <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <%--<img src="images/222_03.jpg" />--%>
                        <span><%=row["品牌名称"].ToString()%></span>
                    </div>
                    </a>
            <%}%>
        </div>
        <!-- 代理品牌 结束-->
        
        <!-- 现货供应 开始-->
        <div class="gydl2">
            <div class="dlpp">现货供应</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">			
                <div class="gydl1">
			    <%	
                    string str_sqltop1 = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"+row["cl_id"]+"'";
                    string imgsrc= "images/222_03.jpg";
                    object result = dc.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    imgsrc = MyHelper.GetCrossDomainServer("../App_Code/config.xml") + "/" + imgsrc;
                    string strs = row["显示名"].ToString();
                    StringBuilder sb = new StringBuilder();
                    int temp = 0;
                    for (int i = 0; i < strs.Length; i++)
                    {
                        if ((int)strs[i] > 127 && temp < 21)
                        {
                            sb.Append(strs[i]);
                            temp = temp + 2;
                        }
                        else if ((int)strs[i] < 127 && temp < 21)
                        {
                            sb.Append(strs[i]);
                            temp = temp + 1;
                        }
                        else
                        {
                            sb.Append("...");
                            break;
                        }
                    }
                  
                    Response.Write("<img src="+imgsrc+ " width=156px height=156px />");			
			    %>
			    <lable style=" width:156px;"><%=sb.ToString() %></lable>
			    </div>
                </a>
            <%}%>
            </div>
        <% }else {  //生产商%>
            <!-- 公司旗下品牌 开始-->
            <div class="gydl2">
            <div class="dlpp">公司旗下品牌</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {   %>
                <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <%--<img src="images/222_03.jpg" />--%>
                        <span ><%=row["品牌名称"].ToString()%></span>
                    </div>
                </a>
            <%}%>
         </div>
            <!-- 公司旗下品牌 结束-->

            <!-- 分销商页 开始-->
         <div class="gydl2">
            <div class="dlpp">公司旗下分销商</div>
            <div class="fxs1" style="margin-left:20px;">
            <select id="s0" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>省（市）
                        <select id="s1" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>地级市
                        <input type="hidden" id="region"  value="北京市" runat="server" />
                        <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
                            <script src="Scripts/Address.js" type="text/javascript"></script>
                <%--<select id="s1" class="fu1"><option></option></select> 省（市）
                <select id="s2" class="fu2"><option></option></select> 地级市
                <select id="s3" class="fu3"><option></option></select> 市、县级市、县
                <script type="text/javascript"  language ="javascript"> 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s1", "s2", "s3"];
                    var opt0 = ["-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script> --%>
            </div>
               <!-- 动态显示 开始-->
                <!-- 存放传值数据-->
                <input type="hidden" id="fxsid_msg" name="fxsid_msg" value="<%=gys_id %>"/>
            
            <div class="fxsxx_list">
                <%=content %>
            </div>
               <!-- 动态显示 结束-->
        <div id="fy_list" style=" margin-left:34%;margin-top:10px;float:left;height:auto;width:400px;margin-bottom:10px;">
                <%=fy_list %>
        </div>
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
           //window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    var value = xmlhttp.responseText;

                    if (value == "1")
                    {
                        alert("收藏成功！");
                        window.location.reload();
                    }
                    else if (value == "0")
                    { 
                       window.open("cgsdl.aspx", "", "height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes");
                    }
                    else
                    {
                        alert(value);
                    }
                }
            }
             
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
           
        }
    </script>
</body>
</html>
