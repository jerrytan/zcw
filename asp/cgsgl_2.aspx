<!--
        页面名称：	采购商关注材料管理页
        文件名：	cgsgl_2.ascx
        传入参数：	QQid 用于根据QQid取相关信息
               
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>采购商关注材料管理页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
	 <link href="css/cgsgl2.css" rel="stylesheet" type="text/css" />
    <script src="js/cgsgl2.js" type="text/javascript"></script>
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
 public Boolean userIsVIP = false;

    protected string s_yh_id="";
    public string s_QQid = "";
    public DataConn objConn = new DataConn();
    public string sSQL = "";
    public DataTable dt = new DataTable();
    public int firstlevel;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CGS_QQ_ID"] != null && Request.Cookies["CGS_QQ_ID"].Value.ToString()!="")
        {
            s_QQid = Request.Cookies["CGS_QQ_ID"].Value.ToString();
        }
      
        sSQL = "select count(*) from 用户表 where QQ_id = '" + s_QQid + "'";
		string s_Count=objConn.DBLook(sSQL);
        int count = Convert.ToInt32(s_Count);
            if (count == 0)  //qq_id 不存在，需要增加用户表
            {

                sSQL = "insert into 用户表 (QQ_id) VALUES ('" + s_QQid + "')";
                objConn.ExecuteSQL(sSQL,false);

                sSQL = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + s_QQid + "') where QQ_id = '" + s_QQid + "'";
                objConn.ExecuteSQL(sSQL,false);

            }
            sSQL="select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='" + s_QQid + "'";           
            dt =objConn.GetDataTable(sSQL);
            if (dt!=null&&dt.Rows.Count>0)
            {
                s_yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
            }           
            Session["CGS_YH_ID"] = s_yh_id;

        listFollowCLIDs();
    }
    public DataTable dt_cgsgzcl_dl = new DataTable();
    public DataTable dt_cgsgzcl_xl = new DataTable();
    public DataTable dt_clb = new DataTable();
    public DataTable dt_clgysxx = new DataTable();
    protected void listFollowCLIDs()
    {
        string sVD = Request.ApplicationPath.ToString().Substring(1);

        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
         sSQL = "select * from (select distinct a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct c.分类编码 as flbm " +
                         " from 采购商关注材料表 as b ,材料表 as c  " +
                         " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                        " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=2";

         
         dt_cgsgzcl_dl = objConn.GetDataTable(sSQL);

         sSQL = "select * from (select distinct a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct c.分类编码 as flbm " +
                        " from 采购商关注材料表 as b ,材料表 as c  " +
                        " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                       " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=4";
         dt_cgsgzcl_xl = objConn.GetDataTable(sSQL);
      

        sSQL ="select b.cl_id ,分类编码,显示名 from 采购商关注材料表 as a ,材料表 as b  " +
             "  where a.yh_id='" + s_yh_id + "' and a.cl_id=b.cl_id order by b.cl_id";

        dt_clb = objConn.GetDataTable(sSQL);
      

        sSQL = "select a.gys_id ,a.供应商 from 材料供应商信息表 as a ,采购商关注供应商表 as b  " +
               " where b.yh_id='" + s_yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
        dt_clgysxx = objConn.GetDataTable(sSQL);

      
        CancelFollowButton.Attributes.Add("onClick", "return confirm('您真的要取消对这些材料或供应商的关注吗？');");

    }
   
/// <summary>
/// 获得采购商关注材料表
/// </summary>
/// <param name="sender"></param>
/// <param name="e"></param>
    protected void dumpFollowCLs(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }

       sSQL = "select b.* from 采购商关注材料表 as  a ,材料表 as b  where a.yh_id='" + s_yh_id + "'  and a.cl_id = b.cl_id ";
       dt = null;
        dt = objConn.GetDataTable(sSQL);
        outToExcel(dt);
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
    /// <summary>
    /// 取消关注材料
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
   public void cancelFollows(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }   
        string s_clid = Request.Form["clid"];

        sSQL = "delete 采购商关注材料表 where yh_id ='" + s_yh_id + "' and cl_id in (" + s_clid + ")";
        objConn.ExecuteSQL(sSQL,false);

        string s_gys_id = Request.Form["gysid"];
        sSQL = "delete 采购商关注供应商表 where yh_id ='" + s_yh_id + "' and gys_id in (" + s_gys_id + ")";
        objConn.ExecuteSQL(sSQL, true);
        listFollowCLIDs();
    }
    </script>

       <div class="dlqqz">
        <div class="dlqqz1">
            <img src="images/sccp.jpg" />
        </div>
        <form id="form1" runat="server">
        <div class="dlqqz2">
            <div id="menu">
                <% 
 	      firstlevel = 0;
            foreach (DataRow dr_dl in dt_cgsgzcl_dl.Rows){
                %>
                <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                    <a href="javascript:void(0)">
                        <img src="images/biao2.jpg" /><%=dr_dl["显示名字"]%>
                        &gt;</a></h1>
                <span class="no">
                    <% 
 	                   int secondlevel = 0;
 		                      foreach (DataRow dr_xl in dt_cgsgzcl_xl.Rows){
                                  if (dr_xl["分类编码"].ToString().Substring(0, 2) == dr_dl["分类编码"].ToString())
                                  {  
                    %>
                    <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                        <a href="javascript:void(0)">+
                            <%=dr_xl["显示名字"].ToString()%></a></h2>
                    <ul class="no">
                        <% 
                            foreach (DataRow dr_cl in dt_clb.Rows){
                                if (dr_cl["分类编码"].ToString().Substring(0, 4) == dr_xl["分类编码"].ToString())
                                {
                        %>
                        <input type="checkbox" name="clid" value='<%=dr_cl["cl_id"].ToString()%>' />
                        <a  href='clxx.aspx?cl_id=<%=dr_cl["cl_id"].ToString() %>'>
                            <%=dr_cl["显示名"].ToString().Trim()%></a><br/>
                        <% 	
   			                    }
   		                    }
   		            secondlevel++;
                        %>
                    </ul>
                    <% 	
                                   } 
                        }   
                    %>
                </span>
                <% 
 		            firstlevel++;
                      } 
                %>
                <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                    <a href="javascript:void(0)">
                        <img src="images/biao2.jpg" />
                        供应商列表 &gt;</a></h1>
                <span class="no">
                    <h2 onclick="javascript:ShowMenu(this,0)">
                        <a href="javascript:void(0)">+ 材料供应商</a></h2>
                    <ul class="no">
                        <%
                  foreach (DataRow dr_gys in dt_clgysxx.Rows){
                        %>
                        <input type="checkbox" name="gysid" value='<%=dr_gys["gys_id"].ToString()%>' />
                        <a href="javascript:void(0)">
                            <%=dr_gys["供应商"].ToString()%></a>
                        <% } %>
                    </ul>
                </span>
            </div>
        </div>
        <div class="dlqqz3">
            &nbsp;&nbsp;<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg"
                runat="server" OnClick="cancelFollows" />
        </div>
        <asp:Label ID="label1" runat="server" Text="" />
        <%
	if (userIsVIP){
        %>
        <div class="dlex1">
            <div class="dlex1">
                <asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
            </div>
        </div>
        <%
	}else {
        %>
        <div class="dlex1">
            您也可以把您收藏的材料数据和供应商数据导出为excel，供线下使用
            <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
        </div>
        <%
	}	
        %>
        </form>
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
