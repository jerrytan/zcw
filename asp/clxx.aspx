<!--
        材料详情页面
        文件名：clxx.aspx
        传入参数：cl_id
        owner:丁传宇
               
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
<title>材料信息详情页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
 <script src="js/SJLD_New.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
    var $j = jQuery.noConflict();
    $j(document).ready(function () {
        var url = "clxx_ajax.aspx";
        var fxsmsg = $j("#fxsid_msg").val();
        var fxscount = $j("#fxscount_msg").val();

        $j("#s1").change(function () {
            var item1 = $j("#s1 option:selected").text();
            var data = { address: item1, cl_id: fxsmsg, gys_count: fxscount };
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //进行分割
                    var fxs_list = str_fxs[0];  //供应商信息
                    var fxs_fy = str_fxs[1];    //分页信息
                    $j("#clfxs_list").html(fxs_list); //替换筛选的内容
                    $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                }
            }, "text");
        });
        $j("#s2").change(function () {
            var item2 = $j("#s2 option:selected").text();
            var data = { address: item2, cl_id: fxsmsg, gys_count: fxscount };
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //进行分割
                    var fxs_list = str_fxs[0];  //供应商信息
                    var fxs_fy = str_fxs[1];    //分页信息
                    $j("#clfxs_list").html(fxs_list); //替换筛选的内容
                    $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                }
            }, "text");
        });
        $j("#s3").change(function () {
            var item3 = $j("#s3 option:selected").text();
            var data = { address: item3, cl_id: fxsmsg, gys_count: fxscount };
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //进行分割
                    var fxs_list = str_fxs[0];  //供应商信息
                    var fxs_fy = str_fxs[1];    //分页信息
                    $j("#clfxs_list").html(fxs_list); //替换筛选的内容
                    $j("#fy_list").html(fxs_fy);      //替换筛选的内容
                }
            }, "text");
        });
    });
    </script>
<script runat="server"> 

        protected DataTable dt_clxx = new DataTable();   //材料名字(材料表)
		protected DataTable dt_flxx = new DataTable();   //分类名称(材料分类表)
		protected DataTable dt_ppxx = new DataTable();   //品牌名称(品牌字典)
		protected DataTable dt_scsxx = new DataTable();   //生产商信息(材料供应商信息表)
		protected DataTable dt_fxsxx = new DataTable();  //分销商信息(材料供应商信息表)
		protected DataTable dt_image = new DataTable();  //材料大图片(材料多媒体信息表)
		protected DataTable dt_images = new DataTable();  //材料小图片(材料多媒体信息表)
        
        protected int CurrentPage=1;    
        protected int Page_Size=2;
        protected int PageCount;

        private string cl_id;
        protected DataConn dc_obj = new DataConn();
        protected string content; //保存供应商信息
        protected string fy_list; //保存分页信息

        protected void Page_Load(object sender, EventArgs e)
        {		      
        
			cl_id = Request["cl_id"];

            string str_sqlclname = "select 显示名,fl_id,材料编码 from 材料表 where cl_id='"+cl_id+"' ";           
            dt_clxx = dc_obj.GetDataTable(str_sqlclname);

             //材料表访问计数加1
            string str_updatecounter = "update 材料表 set 访问计数 = (select 访问计数 from 材料表 where cl_id = '"+ cl_id +"')+1 where cl_id = '"+ cl_id +"'";   
            dc_obj.ExecuteSQL(str_updatecounter,true);
			
            string fl_id = Convert.ToString(dt_clxx.Rows[0]["fl_id"]);
			string str_sqlxsmz = "select 显示名字,分类编码 from 材料分类表 where fl_id='"+fl_id+"' ";           
            dt_flxx = dc_obj.GetDataTable(str_sqlxsmz);
			
			string str_sqlppmc = "select 品牌名称,规格型号,材料编码 from 材料表 where cl_id='"+cl_id+"' ";            
            dt_ppxx = dc_obj.GetDataTable(str_sqlppmc);
			
			string str_sqlgysxx =  "select 联系人手机,供应商,联系地址,gys_id from 材料供应商信息表 where 单位类型='生产商' and gys_id in (select gys_id from 材料表 where cl_id='"+cl_id+"') ";
            dt_scsxx = dc_obj.GetDataTable(str_sqlgysxx);
			
			string str_sqltop3 =  "select top 3 存放地址,材料名称 from 材料多媒体信息表 where cl_id='"+cl_id+"' and 媒体类型 = '图片' and 大小='大'";        
            dt_image = dc_obj.GetDataTable(str_sqltop3);
			
			string str_sqlfcdz = "select 存放地址,材料名称 from 材料多媒体信息表 where cl_id='"+cl_id+"' and 媒体类型 = '图片' and 大小='小'";            
            dt_images = dc_obj.GetDataTable(str_sqlfcdz);
        
            string str_fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"'))";         
            dt_fxsxx = dc_obj.GetDataTable(str_fxsxx);
			
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
                
            //获取"总页数"
            string strC = "";
            if(string.IsNullOrEmpty(strC))
            {
                double recordCount = this.GetCLFXSCount(); 
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
            dt_fxsxx = this.GetPageList(cl_id,begin,end);

            if(dt_fxsxx != null && dt_fxsxx.Rows.Count>0 )
            {
                //供应商列表
                foreach(System.Data.DataRow row in dt_fxsxx.Rows)
                {
                     content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                            + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                            + row["供应商"].ToString() + "</li><li>联系人："
                            + row["联系人"].ToString() + "</li><li>电话："
                            + row["联系人手机"].ToString() + "</li><li>地址："
                            + row["联系地址"].ToString() + "</li></ul></a></div>";
                }
                 //分页显示信息
                if(CurrentPage>1 && CurrentPage!=PageCount)
                {
                    fy_list += "<span style='font-size:12px;color:Black'><a href='clxx.aspx?cl_id="
                    + cl_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a><a href='clxx.aspx?gys_id="
                    + cl_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>第"
                    + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
                }
            }
        
        }		
         //从数据库获取记录的总数量
        protected int GetCLFXSCount()
        {
            int i_count=0;
            try
            {
                string cl_id = Request["cl_id"];   //获取供应商id
                string str_sql_fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"'))"; 
                i_count = dc_obj.GetRowCount(str_sql_fxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 

        //获取分页信息:cl_id 材料id, begin 开始, end 结束
        protected DataTable GetPageList(string cl_id, int begin, int end)
        {
            
            //执行分页的sql语句
            string str_sqlpage = @"select 供应商,联系人,联系人手机,联系地址,gys_id from (select ROW_NUMBER() over (order by gys_id) as RowId,* from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id= @cl_id )))t where t.RowId between @begin and @end";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@cl_id",SqlDbType.VarChar),
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = cl_id;
            return  dc_obj.GetDataTable(str_sqlpage,parms);
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

<div class="sc">
    <!-- 导航链接栏 开始 -->
    <div class="sc1"><a href="index.aspx">首页 ></a>
    <% foreach(System.Data.DataRow row in dt_flxx.Rows){%>
        <a href="ejfl.aspx?name=<%=row["分类编码"].ToString() %>"><%=row["显示名字"].ToString() %></a>
    <%}%>> 
    <% foreach(System.Data.DataRow row in dt_clxx.Rows){%>
        <a href="clxx.aspx?cl_id=<%=cl_id %>"><%=row["显示名"].ToString() %></a>
    <%}%>
    </div>
    <!-- 导航链接栏 结束 -->
    
    <!-- 图片列表和收藏 开始 -->
    <div class="xx1">
        <div class="xx2">
            <div style="HEIGHT: 300px; OVERFLOW: hidden;" id="idTransformView">
                <ul id="idSlider" class="slider">
                    <div style="POSITION: relative">
                    <%
	                foreach(System.Data.DataRow row in dt_images.Rows)
                    {
	                    if(dt_images.Rows[0]["存放地址"]!="")
	                    {%>
                            <a ><img  src="<%=dt_images.Rows[0]["存放地址"].ToString()%>" width="320" height="300" id="bigImage"></a>
                        <%}
                    }%>
                    </div>
                </ul>
            </div>
            <div>
                <ul id="idNum" class="hdnum">
                <% for (int i=0;i< dt_images.Rows.Count;i++){
                    System.Data.DataRow row =dt_images.Rows[i];
                %>   
                    <li>
                        <img src='<%=row["存放地址"].ToString()%>' width="61px" height="45px" ="changeImage('<%=row["存放地址"].ToString()%>')">
                    </li>
                <%}%>
                </ul>
            </div>
        </div>
    
        <div class="xx3">
                                                    <dl>
                  <% foreach(System.Data.DataRow row in dt_ppxx.Rows){%>
                  <dd>品牌:</dd>
                  <dt><%=row["品牌名称"].ToString() %></dt>
                  <dd>型号:</dd>
                  <dt><%=row["规格型号"].ToString() %></dt>
                  <dd>编码:</dd>
                  <dt><%=row["材料编码"].ToString() %></dt>
                  <%}%> 
            </dl>
                <span class="xx4" style=" display:block; margin-left:40%; margin-right:auto;"  onclick="sc_login(<%=cl_id %>)">
                    <a href="" onclick="NewWindow(<%=cl_id %>)">请收藏，便于查找</a>
                </span>
        </div>
    </div>
    <!-- 图片列表和收藏 结束 -->

    <!-- 材料所对应的生产商信息 开始 -->
    <div class="xx5">
        <img src="images/sst_03.jpg" />
        <div class="xx6">
            <ul>
                <li class="xx7">生产商信息</li>
		        <% foreach(System.Data.DataRow row in dt_scsxx.Rows){%>  
                <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
                <li>厂名：<%=row["供应商"].ToString()%></li>
                <li>地址：<%=row["联系地址"].ToString()%></li>
                <li>电话：<%=row["联系人手机"].ToString()%></li>
                </a>
		        <%}%>  
            </ul>
        </div>
    </div>
    <!-- 材料所对应的生产商信息 结束 -->

    <!-- 显示 下拉列表对应供应商信息 开始 -->
    <div class="xx8" >
        <div class="xx9">
            <div class="fxs1">
                 <select id="s0" class="fu1"><option></option></select> 区域
                <select id="s1" class="fu1"><option></option></select> 省（市）
                <select id="s2" class="fu2"><option></option></select> 地级市
                <select id="s3" class="fu3"><option></option></select> 市、县级市、县
                <script type="text/javascript"  language ="javascript" > 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s0","s1", "s2", "s3"];
                    var opt0 = ["-区域-","-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                    document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script>
            </div>
            <!-- 存放传值数据-->
                <input type="hidden" id="fxsid_msg" name="fxsid_msg" value="<%=cl_id %>"/>
                <input type="hidden" id="fxscount_msg" name="fxscount_msg" value="<%=GetCLFXSCount() %>" />

            <div id="clfxs_list">
                <%=content %>
            </div>
        </div>
    </div>
    <!-- 显示 下拉列表对应供应商信息 结束 -->
    <div id="fy_list">
            <%=fy_list %> 
    </div>


    <!-- 显示3张大图片 开始 -->
    <%foreach(System.Data.DataRow row in dt_image.Rows){%>
    <div class="xx10">
        <div class="xx11">
            <img alt="存放地址" src="<%=row["存放地址"].ToString()%>" />
        </div>
    </div>
    <%}%>
    <!-- 显示3张大图片 结束 -->
   
    <!-- 显示 视频 开始 -->
    <% if (cl_id.Equals("74")) { %>
    <div class="xx10">
        <div class="xx11">介绍视频</div>
        <embed src="http://tv.people.com.cn/img/2010tv_flash/outplayer.swf?xml=/pvservice/xml/2011/10/6/12d1c210-dd85-4872-8eb2-33b224fb0743.xml&key=人民电视:/150716/152576/152586/&quote=1&" quality="high" width="480" height="384" align="middle" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash"></embed>
    </div>
    <% } %>
    <!-- 显示 视频 结束 -->
</div>

<div>
<!-- 关于我们 广告服务 投诉建议 开始-->
<!-- #include file="static/aboutus.aspx" -->
<!-- 关于我们 广告服务 投诉建议 结束-->
</div>

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->

<script type="text/javascript">
    function NewWindow(id) {
        var url = "sccl.aspx?cl_id="+id;
        window.open(url,"","height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function changeImage(src) {
        document.getElementById("bigImage").src = src;
    }
</script>
</body>
</html>