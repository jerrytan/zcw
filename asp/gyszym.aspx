<!--
        页面名称：	供应商主页面
        文件名：	gyszym.ascx
        传入参数：	QQid 用于根据QQid取相关信息
         author：张新颖      
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

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
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>供应商主页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script  runat="server">
    public DataTable dt_yh=new  DataTable();
    public DataConn objConn=new DataConn();
    public string s_QQ_id="";
    string ppname = "";//蒋，2014年8月28日，品牌名称
    public string name="";
    //蒋，2014年8月13日，注释从供应商申请认领表中取出的审核结果字段
    //public string passed_gys = "";
    public string gys_QQ_id = "";//蒋，2014年8月21日(供应商id)
    public string power = "";//用户权限（蒋，22日）
    public string s_yh_id = "";
    public string lx="";
    public string gys_id = "";//供应商id
    public string QQ = "";
    public string dj = "";//等级
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
        {
            s_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            if (s_QQ_id!="")
            {
                string sql_yhid = "select yh_id from 用户表 where QQ_id='" + s_QQ_id + "'";
                s_yh_id = objConn.DBLook(sql_yhid);
            }
        }
        else
        {
            if (Session["GYS_YH_ID"]!=null)
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
        }
        string sql = "select dw_id,角色权限,姓名,yh_id,是否验证通过,类型,等级 from 用户表 where yh_id='" + s_yh_id + "' and 类型<>'采购商'";
        dt_yh = objConn.GetDataTable(sql);
        if (dt_yh!=null&&dt_yh.Rows.Count>0)
        {
            gys_id=dt_yh.Rows[0]["dw_id"].ToString();
            power = dt_yh.Rows[0]["角色权限"].ToString();
            name = dt_yh.Rows[0]["姓名"].ToString();
            lx = dt_yh.Rows[0]["类型"].ToString();
            dj = dt_yh.Rows[0]["等级"].ToString();
        }  
            //蒋，2014年8月28日
            string exists = "select 品牌名称 from 品牌字典 where scs_id='" + gys_id + "'";
            ppname = objConn.DBLook(exists).ToString();
            if (lx == "采购商")
            {
                string cookieName = "";
                cookieName = "GYS_QQ_ID";
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }
                foreach (string cookiename in Request.Cookies.AllKeys)
                {
                    HttpCookie cookies = Request.Cookies[cookiename];
                    if (cookies != null)
                    {
                        cookies.Expires = DateTime.Today.AddDays(-1);
                        Response.Cookies.Add(cookies);
                        Request.Cookies.Remove(cookiename);
                    }
                }    
				Response.Write("<script>window.alert('您是采购商，不能用供销商身份登录！');window.location.href='index.aspx';</" + "script>");
            }
            Session["GYS_YH_ID"] = s_yh_id;         
     
    }
    </script>

<body>
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->
    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp 身份信息经过我方工作人员确认后，您可以管理生厂商、管理分销商和管理材料信息（图1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">	
               <span class="zyy1"><a href="grxx.aspx">补填个人信息</a></span>         
		</span>
		</span>
        <%if (power.Contains("管理生产商") || dj == "企业用户" && lx == "生产商")
          { %>
		<span class="zy2" runat="server" id="scsqx">
            <img src="images/scsqx.jpg" />
		</span>
        <%} %>
        <%else
            { %>
            <span class="zy2" runat ="server" id="Span1">
            <img src="images/fxsqx.jpg" />
		</span> 
		
			<%} %>
    </div>	
            <div class="gyzy2">
            <% if (power.Contains("管理生产商") || dj == "企业用户" && lx == "生产商")
               {
                   if (ppname == "")
                   { %>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">管理生产商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?ppmc=&gys_id=<%=gys_id %>" onclick="window.alert('为了您的操作方便，请在管理生产商信息中添加品牌信息！')">管理分销商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?ejfl=&gys_id=<%=gys_id %>">管理材料信息</a></span>
            <%}
                   else
                   {%>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">管理生产商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glfxsxx.aspx?ppmc=&gys_id=<%=gys_id %>">管理分销商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?ejfl=&gys_id=<%=gys_id %>">管理材料信息</a></span>  
                  <% }
               }%> 
            <%else
                {%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx?ppmc=&gys_id=<%=gys_id %>">管理分销商信息</a></span>
            <span class="zyy1" style="margin-left:180px;"><a href="fxsglcl.aspx?gys_id=<%=gys_id %>">管理材料信息</a></span>       
    <%} %>
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
