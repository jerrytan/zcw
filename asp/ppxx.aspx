<!--
        品牌详情页面
        文件名：ppxx.ascx
        传入参数：pp_id    品牌编号
        负责人:任武           
-->
<%@ Register Src="/asp/include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
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
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            $j("#ppxfxs").show();
            $j("#ppxcp").hide();
            $j(".gydl ul li .tab1").click(function () {
                $j("#ppxfxs").show();
                $j("#ppxcp").hide();
            });
            $j(".gydl ul li .tab2").click(function () {
                $j("#ppxcp").show();
                $j("#ppxfxs").hide();
            });


            var url = "ppxx_ajax.aspx";
            var pp_id = $j("#ppfid_msg").val();
            var ppfxs_count = $j("#ppfcount_msg").val();
            $j("#s1").change(function () {
                var item1 = $j("#s1 option:selected").text();
                var data = { address: item1, pp_id: pp_id};
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var ppfxs_list = str_fxs[0];  //供应商信息
                        var pp_fy = str_fxs[1];    //分页信息
                        $j("#ppfxs_list").html(ppfxs_list); //替换筛选的内容
                        $j("#fy_list").html(pp_fy);      //替换筛选的内容
                    }
                }, "text");
            });
            $j("#s2").change(function () {
                var item2 = $j("#s2 option:selected").text();
                var data = { address: item2, pp_id: pp_id };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var ppfxs_list = str_fxs[0];  //供应商信息
                        var pp_fy = str_fxs[1];    //分页信息
                        $j("#ppfxs_list").html(ppfxs_list); //替换筛选的内容
                        $j("#fy_list").html(pp_fy);      //替换筛选的内容
                    }
                }, "text");
                
            });
            $j("#s3").change(function () {
                var item3 = $j("#s3 option:selected").text();
                var data = { address: item3, pp_id: pp_id };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //进行分割
                        var ppfxs_list = str_fxs[0];  //供应商信息
                        var pp_fy = str_fxs[1];    //分页信息
                        $j("#ppfxs_list").html(ppfxs_list); //替换筛选的内容
                        $j("#fy_list").html(pp_fy);      //替换筛选的内容
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
        protected DataTable dt_ppxx = new DataTable(); //品牌名称(品牌字典表)
		protected DataTable dt_scsxx = new DataTable(); //供应商信息(材料供应商信息表)
		protected DataTable dt_fxsxx = new DataTable(); //分销商信息(供应商和分销商相关表)
		protected DataTable dt_clxx = new DataTable(); //该品牌下的产品(材料表)
        protected DataConn objdc = new DataConn();
        protected string pp_id; //品牌id

        protected DataTable dt_content = new DataTable();//分页信息
        protected int CurrentPage=1;    
        protected int Page_Size=2;
        protected int PageCount;
        protected string content;
        protected string fy_list;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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
                    double recordCount = this.GetPPFXSCount(); 
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
                dt_content = this.GetPageList(pp_id,begin,end);
                if(dt_content !=null && dt_content.Rows.Count>0)
                {
                    foreach(System.Data.DataRow row in dt_content.Rows)
                    {
                        content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                            + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                            + row["供应商"].ToString() + "</li><li>联系人："
                            + row["联系人"].ToString() + "</li><li>电话："
                            + row["联系人手机"].ToString() + "</li><li>地址："
                            + row["联系地址"].ToString() + "</li></ul></a></div>";
                    }
                    //分页显示信息
					 if((CurrentPage <= 1) && (PageCount <=1)) { //一页
						 fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
                        + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";

					}
					else if((CurrentPage<= 1)  && (PageCount>1)) {//两页 
						fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
                        + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
					}   
					else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //多页
						fy_list += "<span style='font-size:12px;color:Black'><a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
                        + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
					}
					else if((CurrentPage == PageCount) && (PageCount > 1)){  //末页
						fy_list += "<span style='font-size:12px;color:Black'><a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
                        + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>"; 
					}
                }

            }
        }	      
        
        //从数据库获取记录的总数量
        protected int GetPPFXSCount()
        {
            int i_count=0;
            try
            {
                string ppxx_id = Request["ppxx_id"];   //获取品牌id
                string str_sql_ppfxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='"+pp_id+"')"; 
                i_count = objdc.GetRowCount(str_sql_ppfxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        }    

        //获取分页信息:pp_id 品牌id, begin 开始, end 结束
        protected DataTable GetPageList(string pp_id, int begin, int end)
        {
            //执行分页的sql语句
            string str_sqlpage = @"select 供应商,联系人,联系人手机,联系地址,gys_id from(select ROW_NUMBER() over (order by gys_id) as RowId ,* from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id=@pp_id))t where t.RowId between @begin and @end ";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@pp_id",SqlDbType.VarChar)
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = pp_id;
            return  objdc.GetDataTable(str_sqlpage,parms);
        } 
    </script>
    <div class="gysxx">
        <!-- 首页 品牌信息 开始-->
        <div class="gysxx1">
            <a href="index.aspx">首页 ></a>&nbsp
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
        <div class="gydl">
            <ul style="padding-left:20px; margin-top:4px;">
                <li style="float:left; height:28px; line-height:28px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab1"  style="border:1px solid Gray; font-size:14px;display:block">该品牌下分销商</a>
                </li>
                <li style="float:left; height:28px; line-height:28px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab2"  style="border:1px solid Gray; font-size:14px;display:block">该品牌下产品</a>
                </li>
            </ul>
        </div>
        
        <!-- 该品牌分销商 开始-->
        <div class="gydl" id="ppxfxs">
            <div class="dlpp">该品牌分销商</div>
            <div class="fxs1" style="margin-left:10px;">
                <select id="s1" class="fu1"><option></option></select> 省（市）
                <select id="s2" class="fu2"><option></option></select> 地级市
                <select id="s3" class="fu3"><option></option></select> 市、县级市、县
                <script type="text/javascript"  language ="javascript" > 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s1", "s2", "s3"];
                    var opt0 = ["-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script>
                <div id="ppfxs_list">
                    <%=content %>
                </div>
           </div>
            <!-- 存放传值数据-->
                <input type="hidden" id="ppfid_msg" name="ppfid_msg" value="<%=pp_id %>"/>

            <!-- 品牌分销商 显示开始-->
             <div id="fy_list" style=" margin-left:34%;margin-top:10px;float:left;height:auto;width:400px;">
                    <%=fy_list %>
             </div>
            <!-- 品牌分销商 显示结束-->
        </div>
        <!-- 该品牌分销商 结束-->

        <!-- 该品牌下产品 开始-->
        <div class="gydl" id="ppxcp">
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
