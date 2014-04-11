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
    <script src="js/SJLD_New.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            $j("#ppxcp").show();
            $j("#ppxfxs").hide();
            $j(".gydl ul li .tab1").click(function () {
                $j("#ppxcp").show();
                $j("#ppxfxs").hide();
            });
            $j(".gydl ul li .tab2").click(function () {
                $j("#ppxfxs").show();
                $j("#ppxcp").hide();
            });

            var url = "";
            $j("#s1").change(function () {
                var item = $j("#s1 option:selected").text();
                var data = { address: item };
                $j.post(url, data, function (msg) { }, "text");
            });
            $j("#s2").change(function () {
                var item = $j("#s2 option:selected").text();
                var data = { address: item };
                $j.post(url, data, function (msg) { }, "text");
            });
            $j("#s2").change(function () {
                var item = $j("#s2 option:selected").text();
                var data = { address: item };
                $j.post(url, data, function (msg) { }, "text");
            });
            $j("#s2").change(function () {
                var item = $j("#s2 option:selected").text();
                var data = { address: item };
                $j.post(url, data, function (msg) { }, "text");
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
        protected DataTable dt_qymc = new DataTable();// 保存区域名称
        protected string pp_id; //品牌id

        protected DataTable dt_content = new DataTable();//分页信息
        protected int CurrentPage=1;    
        protected int Page_Size=2;
        protected int PageCount;
        protected string address;//地址


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                address = Request["address"]; //分销商所在地址
                if (string.IsNullOrEmpty(address))
                {
                    address = "";
                }

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
                dt_content = this.GetPageList(pp_id,begin,end,address);
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

        //获取分页信息:pp_id 品牌id, begin 开始, end 结束, address 地址
        protected DataTable GetPageList(string pp_id, int begin, int end,string address)
        {
            //执行分页的sql语句
            string str_sqlpage = @"select 供应商,联系人,联系人手机,联系地址,gys_id from(select ROW_NUMBER() over (order by gys_id) as RowId ,* from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id=@pp_id))t where t.RowId between @begin and @end and t.联系地址 like '%'+@address+'%'";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@pp_id",SqlDbType.VarChar),
                    new SqlParameter("@address",SqlDbType.VarChar)
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = pp_id;
            parms[3].Value = address;
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
                <li style="float:left; height:30px; line-height:30px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab1"  style="border:1px solid Gray; font-size:14px;display:block">该品牌产品</a>
                </li>
                <li style="float:left; height:30px; line-height:30px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab2"  style="border:1px solid Gray; font-size:14px;display:block">该品牌分销商</a>
                </li>
            </ul>
        </div>
        
        <!-- 该品牌分销商 开始-->
        <div class="gydl" id="ppxfxs">
            <div class="dlpp">该品牌分销商</div>
             <div class="fxs1" style="margin-left:20px;">
                <select id="s1" class="fu1"><option></option></select> 地区
                <select id="s2" class="fu2"><option></option></select> 省(市)
                <select id="s3" class="fu3"><option></option></select> 市(县)
                <select id="s4" class="fu4"><option></option></select> 县(区)
                <script type="text/javascript"  language ="javascript" > 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s1", "s2", "s3", "s4"];
                    var opt0 = ["-地区-", "-省(市)、自治区-", "-市(县)、自治州-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script> 
            </div>
            <!-- 品牌分销商 显示开始-->
             <div style=" margin-left:34%;margin-top:40px;float:left;height:auto;width:400px;">
                    <span style="font-size:12px;color:Black"> 
                     <% if(CurrentPage>1 && CurrentPage!=PageCount){ %>

                        <a href="ppxx.aspx?ppxx_id=<%=pp_id %>&p=<%=CurrentPage-1%>" style="color:Black">上一页</a>
                        <a href="ppxx.aspx?ppxx_id=<%=pp_id %>&p=<%=CurrentPage+1%>" style="color:Black">下一页</a>
                        第<%=CurrentPage%>页/共<%=PageCount%>页
                    <%} %>
                    </span>
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
