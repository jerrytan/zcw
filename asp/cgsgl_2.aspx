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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>采购商关注材料管理页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <link href="css/cgsgzl.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
     <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
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
    public string xx = "";   //是否存在信息   
    public string sftg = "";

    protected DataTable dt_type = new DataTable();//一级分类列表    
    protected List<string> list = new List<string>();//用户已关注类别列表  
	           
    protected void Page_Load(object sender, EventArgs e)
    {
        string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
        string sqlExistQQ_id = "select * from 用户表 where QQ_id='" + cgs_QQ_id + "'";
        string sql_Level = "select 等级 from 用户表 where QQ_id='" + cgs_QQ_id + "'";
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
         if (Request.Cookies["CGS_QQ_ID"] != null && Request.Cookies["CGS_QQ_ID"].Value.ToString()!="")
        {
            s_QQid = Request.Cookies["CGS_QQ_ID"].Value.ToString();
        }
      if(s_QQid!="")
        {
            sSQL = "select count(*) from 用户表 where QQ_id = '" + s_QQid + "'";
           string count = objConn.DBLook(sSQL);
           //if (Convert.ToInt32(count)==0)  //qq_id 不存在，需要增加用户表
           // {
               //2014-09-09 yuan
               // sSQL = "insert into 用户表 (QQ_id) VALUES ('" + s_QQid + "')";
               //if(!objConn.ExecuteSQL(sSQL,false))
               //{
               //   objConn.MsgBox(this.Page,"执行SQL语句失败"+sSQL);
               //}
               // sSQL = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + s_QQid + "'),类型='采购商' where QQ_id = '" + s_QQid + "'";
               // if(!objConn.ExecuteSQL(sSQL,false))
               //{
               //   objConn.MsgBox(this.Page,"执行SQL语句失败"+sSQL);
               //   return;
               //}

            //}
           string lx = "";
            sSQL = "select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id = '" + s_QQid + "'";
            dt = objConn.GetDataTable(sSQL);
            if (dt!=null&&dt.Rows.Count>0)
            {              
                s_yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
                string vip=dt.Rows[0]["等级"].ToString();
                if (vip=="VIP用户")
                {
                    userIsVIP = true;
                }
                lx = dt.Rows[0]["类型"].ToString();
                sftg = dt.Rows[0]["是否验证通过"].ToString();
            }

            if (lx != "采购商")
            {
                string cookieName = "";
                cookieName = "CGS_YH_ID";
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }
                Response.Write("<script>window.alert('您不是采购商，不能用采购商身份登录！');window.location.href='index.aspx';</" + "script>");
            }
            Session["CGS_YH_ID"] = s_yh_id;
         
             if (!IsPostBack)
            {
                //蒋，2014年8月18日   
                sSQL = "select * from 用户表 where yh_id='" + s_yh_id + "'";

                DataTable dt_userInfo = new DataTable();
                dt_userInfo = objConn.GetDataTable(sSQL);
                if (dt_userInfo != null && dt_userInfo.Rows.Count > 0)
                {
                    this.companyname.Value = dt_userInfo.Rows[0]["公司名称"].ToString();
                    this.companytel.Value = dt_userInfo.Rows[0]["公司电话"].ToString();
                    this.companyaddress.Value = dt_userInfo.Rows[0]["公司地址"].ToString();
                    this.contactorname.Value = dt_userInfo.Rows[0]["姓名"].ToString();
                    this.contactortel.Value = dt_userInfo.Rows[0]["手机"].ToString();
                    this.QQ_id.Value = dt_userInfo.Rows[0]["QQ号码"].ToString();
                    if ( dt_userInfo.Rows[0]["公司名称"].ToString()==""&&dt_userInfo.Rows[0]["公司电话"].ToString()==""&&dt_userInfo.Rows[0]["公司地址"].ToString()==""
                        && dt_userInfo.Rows[0]["姓名"].ToString() == "" && dt_userInfo.Rows[0]["手机"].ToString()=="")
                    {
                        xx = "否";
                    }
                    else
                    {
                        xx = "是";
                    }
                } 
            }
            listFollowCLIDs();
        }
        else
        {
            objConn.MsgBox(this.Page,"QQ_ID不存在，请重新登录！");
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
                         " from 采购商关注的材料表 as b ,材料表 as c  " +
                         " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                        " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=2";

         dt_cgsgzcl_dl = objConn.GetDataTable(sSQL);

         sSQL = "select * from (select distinct a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct c.分类编码 as flbm " +
                        " from 采购商关注的材料表 as b ,材料表 as c  " +
                        " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                       " where a.分类编码=d.flbm or a.分类编码=left(d.flbm,2))#temp where len(分类编码)=4";
         dt_cgsgzcl_xl = objConn.GetDataTable(sSQL);
      

        sSQL ="select b.cl_id ,分类编码,显示名 from 采购商关注的材料表 as a ,材料表 as b  " +
             "  where a.yh_id='" + s_yh_id + "' and a.cl_id=b.cl_id order by b.cl_id";

        dt_clb = objConn.GetDataTable(sSQL);
      

        sSQL = "select a.gys_id ,a.供应商 from 材料供应商信息表 as a ,采购商关注供应商表 as b  " +
               " where b.yh_id='" + s_yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
        dt_clgysxx = objConn.GetDataTable(sSQL);

      
        CancelFollowButton.Attributes.Add("onClick", "return confirm('您真的要取消对这些材料或供应商的关注吗？');");

    }
   
/// <summary>
/// 获得采购商关注的材料表
/// </summary>
/// <param name="sender"></param>
/// <param name="e"></param>
    protected void dumpFollowCLs(object sender, EventArgs e)
    {
        sSQL = "select b.* from 采购商关注的材料表 as  a ,材料表 as b  where a.yh_id='" + s_yh_id + "'  and a.cl_id = b.cl_id ";
        dt = null;
        dt = objConn.GetDataTable(sSQL);
        outToExcel(dt);   //导出Excel表
        //if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        //{
        //    s_yh_id = Session["CGS_YH_ID"].ToString();
        //}

        // sSQL="select QQ号码,手机,类型,姓名,公司名称,公司地址,公司主页,公司电话,是否验证通过 from 用户表 where yh_id='"+s_yh_id+"'";
        //DataTable dt_yhbt=objConn.GetDataTable(sSQL);
        //if(dt_yhbt!=null&&dt_yhbt.Rows.Count>0)
        //{
        //    string user_type=dt_yhbt.Rows[0]["类型"].ToString();
        //    string tel=dt_yhbt.Rows[0]["手机"].ToString();
        //    string name=dt_yhbt.Rows[0]["姓名"].ToString();
        //    string com_name=dt_yhbt.Rows[0]["公司名称"].ToString();
        //    string com_add=dt_yhbt.Rows[0]["公司地址"].ToString();
        //    string com_tel=dt_yhbt.Rows[0]["公司电话"].ToString();
        //    if(user_type!=""&&tel!=""&&name!=""&&com_name!=""&&com_add!=""&&com_tel!="")
        //    {
        //        if (dt_yhbt.Rows[0]["是否验证通过"].ToString()=="通过")
        //        {
        //            sSQL = "select b.* from 采购商关注的材料表 as  a ,材料表 as b  where a.yh_id='" + s_yh_id + "'  and a.cl_id = b.cl_id ";
        //            dt = null;
        //            dt = objConn.GetDataTable(sSQL);
        //            outToExcel(dt);
        //        }
        //        else
        //        {
        //            Response.Redirect("cgsbtxx.aspx");
        //        }
        //    }
        //    else
        //    {
        //         Response.Redirect("cgsbtxx.aspx");
        //    }

        //}
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

        sSQL = "delete 采购商关注的材料表 where yh_id ='" + s_yh_id + "' and cl_id in (" + s_clid + ")";
        objConn.ExecuteSQL(sSQL,false);

        string s_gys_id = Request.Form["gysid"];
        sSQL = "delete 采购商关注供应商表 where yh_id ='" + s_yh_id + "' and gys_id in (" + s_gys_id + ")";
        objConn.ExecuteSQL(sSQL, true);
        listFollowCLIDs();
    }
        //蒋，2014年8月18日
        protected void updateUserInfo(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
      
        if (this.contactortel.Value == "")
        {
            objConn.MsgBox(this.Page, "手机不能为空,请填写!");
            this.contactortel.Focus();
            return;
        }
        if (this.contactorname.Value == "")
        {
            objConn.MsgBox(this.Page, "姓名不能为空,请填写!");
            this.contactorname.Focus();
            return;
        }
        if (this.companyname.Value == "")
        {
            objConn.MsgBox(this.Page, "公司名称不能为空,请填写!");
            this.companyname.Focus();
            return;
        }
        if (this.companyaddress.Value == "")
        {
            objConn.MsgBox(this.Page, "公司地址不能为空,请填写!");
            this.companyaddress.Focus();
            return;
        }
        if (this.companytel.Value == "")
        {
            objConn.MsgBox(this.Page, "公司电话不能为空,请填写!");
            this.companytel.Focus();
            return;
        }
        string typeList = this.hid.Value.ToString();    
        sSQL   = " update 用户表 " +
                " set 手机='" +this.contactortel.Value + "', " +
                " 姓名='" +this.contactorname.Value + "',  " +
                " 公司名称='"+this.companyname.Value+"',"+
                " 公司地址='"+this.companyaddress.Value+"',"+
                " 公司电话='"+this.companytel.Value+"',"+
                " QQ号码='"+this.QQ_id.Value+"',"+
                " 是否验证通过='待审核'," + "用户关注类别='" + typeList + "'" +
                "  where yh_id='" + s_yh_id + "'";
        
        if (!objConn.ExecuteSQL(sSQL, true)) 
        {
            objConn.MsgBox(this.Page, "更新失败，请重试！");
        }
    }
    </script>
       <form id="form1" runat="server">
       <div class="dlqqz">
        <div class="dlqqz1">
            <img src="images/sccp.jpg" />
        </div>
        
        <div class="dlqqz2">
            <div id="menu">
                <% 
 	      firstlevel = 0;
            foreach (DataRow dr_dl in dt_cgsgzcl_dl.Rows)
            { %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                    <a href="javascript:void(0)"><img src="images/biao2.jpg" /><%=dr_dl["显示名字"]%>&gt;</a></h1>
                    <span class="no">
                     <% 
 	                   int secondlevel = 0;
 		                      foreach (DataRow dr_xl in dt_cgsgzcl_xl.Rows)
                              {
                                  if (dr_xl["分类编码"].ToString().Substring(0, 2) == dr_dl["分类编码"].ToString())
                                  { %>
                                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                                        <a href="javascript:void(0)">+
                                    <%=dr_xl["显示名字"].ToString()%></a></h2>
                                     <ul class="no">
                                            <% 
                                                foreach (DataRow dr_cl in dt_clb.Rows)
                                                {
                                                    if (dr_cl["分类编码"].ToString().Substring(0, 4) == dr_xl["分类编码"].ToString())
                                                    {%>
                                                        <input type="checkbox" name="clid" value='<%=dr_cl["cl_id"].ToString()%>' />
                                                        <a  href='clxx.aspx?cl_id=<%=dr_cl["cl_id"].ToString() %>'>
                                                            <%=dr_cl["显示名"].ToString().Trim()%></a><br/>
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
                        <a href='gysxx.aspx?gys_id=<%=dr_gys["gys_id"].ToString() %>'>
                            <%=dr_gys["供应商"].ToString()%></a><br />
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
    </div>
       <div class="cgdlqq">
		    <div class="cgdlex">
			    <div class="cgdlex2">
                <%if (xx == "否")
                  {%>
                   <span class="cgdlex3">请补填您的详细信息</span>
                <%}
                  else
                  {
                      if (sftg == "不通过")
                      {%>
                       <span class="cgdlex3">您提交的信息未通过审核，请修改后提交！</span>
                      <%}
                      else
                      {
                       %>
                   <span class="cgdlex3">您的信息如下，如需更改请单击更改按钮</span>
                <%}
                  }%>
				   
				    <dl>						
					    <dd>公司名称：</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>公司地址：</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>公司电话：</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
                        <dd>您的姓名：</dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>您的电话：</dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>您的QQ号：</dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>	
                        <dd>用户关注的类别：</dd><dt><input type="button" name="name" value="请选择" id="btn" style="background-color:#0033FF"/></dt><input type="hidden" name="hid" id="hid" value=""  runat="server"/>	
                        <div id="show"><span >请选择关注的类别：</span><a id="clos" href="javascript:void(0)" >关闭</a><br />
                          <% foreach(System.Data.DataRow row in dt_type.Rows){%>
                                        <% if(this.list.Count>0 &&this.list.Contains(row["分类编码"].ToString())){ %>
                                           <input type="checkbox"  name="item" value="<%=row["分类编码"].ToString() %>" checked="checked" /><%=row["显示名字"].ToString()%><br />
                                         <% }
                                         else
                                         {%>
                                          <input type="checkbox"  name="item" value="<%=row["分类编码"].ToString() %>" /><%=row["显示名字"].ToString()%><br />
                                        <% }                                                                            
                                    } %> 
                        <input type="button" name="name" value="保存" id="btnSave" />
                        </div>
                        <div id="layer"></div>			  
				    </dl>
                    
				    <asp:Label ID="label2" runat="server" Text="" />
                    <%if (xx == "否")
                      { %>
                      <span class="cggg"><asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
                    <%}
                      else
                      { %>
                       <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
                    <%} %>				   
			    </div>
		    </div>
	    </div>
        </form>
            <div class="gyzy2"></div>
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