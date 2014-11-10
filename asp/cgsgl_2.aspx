<!--
        页面名称：	采购商关注材料管理页
        文件名：	cgsgl_2.ascx
        传入参数：	QQid 用于根据QQid取相关信息
         author：张新颖      
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>
<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>采购商关注材料管理页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <%-- <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <link href="css/cgsgzl.css" rel="stylesheet" type="text/css" />--%>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
    <script type="text/javascript">

            
        function setTab(name, cursel, n) {
            for (i = 1; i <= n; i++) {
                var menu = document.getElementById(name + i);
                var con = document.getElementById("con_" + name + "_" + i);
                menu.className = i == cursel ? "hover" : "";
                con.style.display = i == cursel ? "block" : "none";
            }
        }


        function xscl(obj) {
            var flbm = obj;
            document.getElementById("cgsglcl_frame").src = "Cgsgzcl.aspx?s_yh_id=<%=s_yh_id %>&clbm=" + flbm;
        }
        function ppgys(obj) {
            var ppid = obj;
            document.getElementById("cgsglgys_iframe").src = "Cgsgzgys.aspx?s_yh_id=<%=s_yh_id %>&ppid=" +ppid;
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
    <script runat="server">  
        public Boolean userIsVIP = false;                //是否为VIP用户
        protected string s_yh_id = "";                   //用户ID
        public string s_QQid = "";                       //用户QQ_ID
        public DataConn objConn = new DataConn();        //DataHelper类
        public string sSQL = "";                         //Sql语句
        public DataTable dt = new DataTable();           //查询到的表
        public int firstlevel;                           //一级菜单
        public int flevel = 0;
        public string xx = "";                           //是否存在信息   
        public string sftg = "";                         //是否验证通过
        //public DataTable dt_content;                     //分页查询的结果

        //public string tbName = "材料表,采购商关注的材料表,材料供应商信息表";   //分页用的表名
        //public string fields = "显示名,生产厂商,品牌名称,地址,规格型号";  //需要返回的列名
        //public string orderName = "显示名";//排序字段名
        //public int pageSize = 10;    //页尺寸
        //public int pageIndex = 1;    //页码
        //public int totalCount = 0;   //返回记录总数, 非 0 值则返回
        //public int orderType = 0;    //设置排序类型, 非 0 值则降序
        //public string strWhere = " 采购商关注的材料表.cl_id=材料表.cl_id  and  材料供应商信息表.gys_id=材料表.gys_id "; //查询条件

        //public int pageCounts;        //记录总条数
        //public int pages;             //总页数


        protected DataTable dt_type = new DataTable();   //一级分类列表    
        protected List<string> list = new List<string>();//用户已关注类别列表  
        Object yh_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            //蒋，注释（11月7日）,并加上IF判断
            //string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
            //string sqlExistQQ_id = "select myID from 用户表 where QQ_id='" + cgs_QQ_id + "'";
            //string sql_Level = "select 等级 from 用户表 where QQ_id='" + cgs_QQ_id + "'";
            if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
            {
                yh_id = Session["CGS_YH_ID"];
            }
            string sqlExistQQ_id = "select myID from 用户表 where yh_id='" + yh_id + "'";
            string sql_Level = "select 等级 from 用户表 where yh_id='" + yh_id + "'";
            if (objConn.GetRowCount(sqlExistQQ_id) > 0)
            {
                if (objConn.DBLook(sql_Level) == "企业用户")
                {
                    Response.Redirect("hyyhgl.aspx");
                }
            }
            else
            {
                Response.Redirect("QQ_dlyz.aspx");
            }
            //蒋，20141110注释
            //if (Request.Cookies["CGS_QQ_ID"] != null && Request.Cookies["CGS_QQ_ID"].Value.ToString() != "")
            //{
            //    s_QQid = Request.Cookies["CGS_QQ_ID"].Value.ToString();   //获取采购商登录QQ的ID
            //}
            //if (s_QQid != "")
            //{
            if (yh_id != "")
            {
                sSQL = "select count(*) from 用户表 where yh_id='" + yh_id + "'";  //根据QQ_id查询用户是否存在
                string count = objConn.DBLook(sSQL);

                string lx = "";    //用户类型
                sSQL = "select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where yh_id='" + yh_id + "'";  //根据QQ_id查询用户信息
                dt = objConn.GetDataTable(sSQL);
                if (dt != null && dt.Rows.Count > 0)
                {
                    s_yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);  //获取用户ID
                    string vip = dt.Rows[0]["等级"].ToString();         //获取用户等级
                    if (vip == "VIP用户")
                    {
                        userIsVIP = true;
                    }
                    lx = dt.Rows[0]["类型"].ToString();               //获取用户类型
                    sftg = dt.Rows[0]["是否验证通过"].ToString();     //获取是否验证通过
                }

                if (lx != "采购商")        //如果从数据库获取的信息中类型是采购商
                {
                    //string cookieName = "";
                    //cookieName = "CGS_YH_ID";
                    //if (Request.Cookies[cookieName] != null)
                    //{
                    //    HttpCookie myCookie = new HttpCookie(cookieName);
                    //    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    //    Response.Cookies.Add(myCookie);   //如果用户ID不为空，将用户ID写入Cookie
                    //}
                    Response.Write("<script>window.alert('您不是采购商，不能用采购商身份登录！');window.location.href='index.aspx';</" + "script>");
                }
                Session["CGS_YH_ID"] = s_yh_id;  //将用户ID保存到session

                listFollowCLIDs();
            }
            else
            {
                objConn.MsgBox(this.Page, "QQ_ID不存在，请重新登录！");
            }

            //加载一级分类
            string sqlType_yj = "select 分类编码,显示名字 from 材料分类表 where LEN(分类编码)=2 order by 分类编码";
            dt_type = objConn.GetDataTable(sqlType_yj);

            //加载该用户已关注的类
            string sqlType_yj_focus = "select 用户关注类别 from 用户表 where yh_id='" + s_yh_id + "' ";
            string Str_type_yj_focus = objConn.DBLook(sqlType_yj_focus);
            if (Str_type_yj_focus != "")
            {
                string[] strArr = Str_type_yj_focus.Split(',');
                for (int i = 0; i < strArr.Length; i++)
                {
                    list.Add(strArr[i]);
                }
            }


        }
        public DataTable dt_cgsgzcl_dl = new DataTable();   //采购商关注大类
        public DataTable dt_cgsgzcl_xl = new DataTable();   //采购商关注小类
        public DataTable dt_clb = new DataTable();          //材料表
        public DataTable dt_clgysxx = new DataTable();      //材料供应商信息
        public DataTable dt_topcl = new DataTable();        //材料Table加载前10条数据
        public DataTable dt_ppxx = new DataTable();         //品牌信息

        /// <summary>
        /// 加载关注材料和供应商
        /// </summary>   
        protected void listFollowCLIDs()
        {
            //获取总页数
            //Response.Write(s_yh_id);
            //strWhere = strWhere + " and 采购商关注的材料表.yh_id='" + s_yh_id + "'";
            // DataTable dt_pageCount =  GetProductFormDB(tbName, fields, orderName, pageSize, pageIndex, 1, orderType, strWhere);
            // dt_pageCount.Rows[0]["Total"].ToString();
            // Response.Write(dt_pageCount.Rows[0]["Total"].ToString());



            string strFlmc = Request["strFlmc"];
            string sVD = Request.ApplicationPath.ToString().Substring(1);

            if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
            {
                s_yh_id = Session["CGS_YH_ID"].ToString();
            }
            //20141030 小张修改  取单位收藏
            string sql_dwid = "select dw_id from 采购商关注的材料表 where yh_id='" + s_yh_id + "'";
            string dwid = objConn.DBLook(sql_dwid);
            //根据用户ID查出分类编码和显示名字
            sSQL = "select * from (select distinct a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct c.分类编码 as flbm " +
                            " from 采购商关注的材料表 as b ,材料表 as c  " +
                            " where b.yh_id in(select yh_id from 用户表 where dw_id='" + dwid + "') and b.cl_id=c.cl_id  ) as  d " +
                           " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=2";


            dt_cgsgzcl_dl = objConn.GetDataTable(sSQL);  //采购商关注材料 一级分类

            sSQL = "select * from (select distinct a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct c.分类编码 as flbm " +
                           " from 采购商关注的材料表 as b ,材料表 as c  " +
                           " where b.yh_id in(select yh_id from 用户表 where dw_id='" + dwid + "') and b.cl_id=c.cl_id  ) as  d " +
                          " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=4";
            dt_cgsgzcl_xl = objConn.GetDataTable(sSQL);  //采购商关注材料 二级分类


            sSQL = "select b.cl_id ,分类编码,显示名 from 采购商关注的材料表 as a ,材料表 as b  " +
                "  where a.yh_id in(select yh_id from 用户表 where dw_id='" + dwid + "') and a.cl_id=b.cl_id order by b.cl_id";
            dt_clb = objConn.GetDataTable(sSQL);
          
//            if (string.IsNullOrEmpty(strFlmc))
//            {
//                sSQL = @"select top 10 材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号 from 采购商关注的材料表   
//                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
//                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
//                    where 采购商关注的材料表.yh_id='" + s_yh_id + "' ";          //加载材料前10条信息
//                dt_topcl = objConn.GetDataTable(sSQL);
//            }
//            else
//            {
//                sSQL = @"select  材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号 from 采购商关注的材料表   
//                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
//                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
//                    where 采购商关注的材料表.yh_id='" + s_yh_id + "' and 分类名称='" + strFlmc + "' ";          //加载材料前10条信息
//                dt_topcl = objConn.GetDataTable(sSQL);
//            }


            //sSQL = "select a.gys_id ,a.供应商 from 材料供应商信息表 as a ,采购商关注供应商表 as b  " +
            //       " where b.yh_id='" + s_yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
            sSQL = "select distinct gys_id,供应商名称,收藏人,收藏人QQ from 采购商关注供应商表 where yh_id in(select yh_id from 用户表 where dw_id='" + dwid + "') and 是否启用='1'";
            dt_clgysxx = objConn.GetDataTable(sSQL);
 
            //CancelFollowButton.Attributes.Add("onClick", "return confirm('您真的要取消对这些材料或供应商的关注吗？');");

        }

        /// <summary>
        /// 获得采购商关注材料表
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void dumpFollowCLs(object sender, EventArgs e)
        {
            //20141030 小张修改  取单位收藏
            string sql_dwid = "select dw_id from 采购商关注的材料表 where yh_id='" + s_yh_id + "'";
            string dwid = objConn.DBLook(sql_dwid);
            sSQL = "select b.* from 采购商关注的材料表 as  a ,材料表 as b  where a.yh_id in(select yh_id from 用户表 where dw_id='" + dwid + "')  and a.cl_id = b.cl_id ";
            dt = null;
            dt = objConn.GetDataTable(sSQL);
            outToExcel(dt);   //导出Excel表


        }
        private StringBuilder AppendCSVFields(StringBuilder argSource, string argFields)
        {
            return argSource.Append(argFields.Replace(",", " ").Trim()).Append(",");
        }

        public static void DownloadFile(HttpResponse argResp, StringBuilder argFileStream, string strFileName)
        {
            try
            {
                string strResHeader = "attachment; filename=" + Guid.NewGuid().ToString() + ".csv";
                if (!string.IsNullOrEmpty(strFileName))
                {
                    strResHeader = "inline; filename=" + strFileName;
                }
                argResp.AppendHeader("Content-Disposition", strResHeader);//attachment说明以附件下载，inline说明在线打开
                argResp.ContentType = "application/ms-excel";
                argResp.ContentEncoding = Encoding.GetEncoding("GB2312");
                argResp.Write(argFileStream);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 导出excel
        /// </summary>
        /// <param name="followcls">准备导出的DataTable</param>
        public void outToExcel(DataTable followcls)
        {

            StringWriter swCSV = new StringWriter();
            StringBuilder sbText = new StringBuilder();
            for (int i = 0; i < followcls.Columns.Count; i++)
            {
                AppendCSVFields(sbText, followcls.Columns[i].ColumnName);
            }
            sbText.Remove(sbText.Length - 1, 1);
            swCSV.WriteLine(sbText.ToString());

            for (int i = 0; i < followcls.Rows.Count; i++)
            {
                sbText.Clear();
                for (int j = 0; j < followcls.Columns.Count; j++)
                {
                    AppendCSVFields(sbText, followcls.Rows[i][j].ToString());
                }
                sbText.Remove(sbText.Length - 1, 1);
                swCSV.WriteLine(sbText.ToString());
            }
            string fileName = Path.GetRandomFileName();
            DownloadFile(Response, swCSV.GetStringBuilder(), fileName + ".csv");
            swCSV.Close();
            Response.End();
        }

        //根据参数,获取数据库中分页存储过程的结果
        //private DataTable GetProductFormDB(string tbName, string fields, string orderName, int pageSize, int pageIndex, int totalCount, int orderType, string strWhere)
        //{
        //    SqlParameter[] spt = new SqlParameter[]
        //    {
        //        new SqlParameter("@tbName",tbName),
        //        new SqlParameter("@strGetFields",fields),
        //        new SqlParameter("@orderName",orderName),
        //        new SqlParameter("@pageSize",pageSize),
        //        new SqlParameter("@pageIndex",pageIndex),
        //        new SqlParameter("@totalCount",totalCount),
        //        new SqlParameter("@orderType",orderType),
        //        new SqlParameter("@strWhere",strWhere)
        //    };
        //    return dt_content = objConn.ExecuteProcForTable("Public_Paging", spt);
        //}

        /// <summary>
        /// 取消关注材料
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //public void cancelFollows(object sender, EventArgs e)
        //{
        //    if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
        //    {
        //        s_yh_id = Session["CGS_YH_ID"].ToString();
        //    }
        //    string s_clid = Request.Form["clid"];

        //    sSQL = "delete 采购商关注的材料表 where yh_id ='" + s_yh_id + "' and cl_id in (" + s_clid + ")";
        //    objConn.ExecuteSQL(sSQL, false);

        //    string s_gys_id = Request.Form["gysid"];
        //    sSQL = "delete 采购商关注供应商表 where yh_id ='" + s_yh_id + "' and gys_id in (" + s_gys_id + ")";
        //    objConn.ExecuteSQL(sSQL, true);
        //    listFollowCLIDs();
        //}
    </script>
    <form id="form1" runat="server">
    <div class="dlqqz">
      <%--  <div class="dlqqz3">
            &nbsp;&nbsp;<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg"
                runat="server" OnClick="cancelFollows" />
        </div>--%>
        <asp:Label ID="label1" runat="server" Text="" />
        <%
            if (userIsVIP)
            {
        %>
        <div class="dlex1">
            <div class="dlex1">
                <asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
            </div>
        </div>
        <%
            }
            else
            {
        %>
        <div class="dlex1">
            您也可以把您收藏的材料数据和供应商数据导出为excel，供线下使用
            <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
        </div>
        <%
            }	
        %>
    </div>
    </form>
    <div class="gyzy2">
    </div>
    <div>
        <div class="lib_Menubox">
            <ul>
                <li id="two1" onclick="setTab('two',1,2)" class="hover">材料列表</li>
                <li id="two2" onclick="setTab('two',2,2)">供应商列表</li>
            </ul>
        </div>
        <div class="dlqqz5" id="con_two_1" style="border: 1px solid #4ea6ee; padding-top: 10px;
            margin-bottom: 10px;">
            <div class="dlqqz2">
                <div id="menu">
                    <% 
                        firstlevel = 0;
                        foreach (DataRow dr_dl in dt_cgsgzcl_dl.Rows)
                        { %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                        <a href="javascript:void(0)">
                            <img src="images/biao2.jpg" /><%=dr_dl["显示名字"]%></a></h1>
                    <span class="no">
                        <%                          
                            int secondlevel = 0;
                            foreach (DataRow dr_xl in dt_cgsgzcl_xl.Rows)
                            {
                                if (dr_xl["分类编码"].ToString().Substring(0, 2) == dr_dl["分类编码"].ToString())
                                { %>
                                                    <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                                                        <a href="javascript:void(0)" onclick="xscl('<%=dr_xl["分类编码"].ToString()%>')">
                                                            <%=dr_xl["显示名字"].ToString()%></a></h2>
                                                    <ul class="no">
                                                        <% 
                                                            foreach (DataRow dr_cl in dt_clb.Rows)
                                                            {
                                                                if (dr_cl["分类编码"].ToString().Substring(0, 4) == dr_xl["分类编码"].ToString())
                                                                {%>
                                                        <%-- <input type="checkbox" name="clid" value='<%=dr_cl["cl_id"].ToString()%>' />--%>
                                                       <%-- <li><a href='clxx.aspx?cl_id=<%=dr_cl["cl_id"].ToString() %>'>
                                                            <%=dr_cl["显示名"].ToString().Trim()%></a></li>--%>
                                                        <%}
                                                                        }
                                                                        secondlevel++;%>
                                                    </ul>
                                                    <%}
                                            } %>
                   </span>
                                                <% 
                            firstlevel++;

                    }%>
                </div>
                <div id="cgs_lb1" class="cgs_lb"  style="width:795px; margin-left:182px;" > 
                <iframe id="cgsglcl_frame" width="100%" height="370" src="Cgsgzcl.aspx?s_yh_id=<%=s_yh_id %>" frameborder="0"></iframe>
             
                </div>
            </div>
        </div>
        <div class="dlqqz5" id="con_two_2" style="border: 1px solid #4ea6ee; padding-top: 10px;
            margin-bottom: 10px; display: none;">
            <div id="menu2" >
                <% 
                    flevel = 0;
                        foreach (DataRow dr_gys in dt_clgysxx.Rows)
                        { %>
                <h1 onclick="javascript:ShowMenu(this,<%=flevel %>)">
                  <a href="javascript:void(0)">
                        <img src="images/biao2.jpg" />
                        <%=dr_gys["供应商名称"].ToString()%></a></h1>
                       
             <span class="no">
                     <% string gys_Id = dr_gys["gys_id"].ToString();
                        string sql_ppxx = "select * from 品牌字典 where scs_id='" + gys_Id + "'";
                        dt_ppxx = objConn.GetDataTable(sql_ppxx);
                            %>
                    <%      int secondlevel = 0;
                            foreach (DataRow drpp in dt_ppxx.Rows)
                      {%>
                    <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %>)">
                        <a href="javascript:void(0)" onclick="ppgys('<%=drpp["pp_id"].ToString()%>')"><%=drpp["品牌名称"] %></a></h2>
                        <%} %>
                <ul class="no">
                  <%--  <%
                        foreach (DataRow dr_gys in dt_clgysxx.Rows)
                        {   
                        %>
                     <input type="checkbox" name="gysid" value='<%=dr_gys["gys_id"].ToString()%>' />
                   <li><a href='gysxx.aspx?gys_id=<%=dr_gys["gys_id"].ToString() %>'>
                        <%=dr_gys["供应商名称"].ToString()%></a></li>
                    <% } %> --%>
                    <% secondlevel++;%>
                </ul>
                 </span>
                  <%flevel++; }%>
            </div>
            <div id="cgs_lb" class="cgs_lb"  style="width:755px; margin-left:232px;">
                <iframe id="cgsglgys_iframe" width="100%" height="370" src="Cgsgzgys.aspx?s_yh_id=<%=s_yh_id %>" frameborder="0"></iframe>
            </div>
        </div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
