<!--
    供应商登陆后操作页面公共的头部
    文件：header2.ascx
    传入参数：无
    owner:丁传宇
	author:张新颖  添加退出登录的按钮
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
    data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>
<script runat="server">
           
    protected DataTable dt_Yh = new DataTable(); //用户名字(用户表)    	
    protected DataConn dc = new DataConn();
    public string DW = "";
    public string QQ_id = "";
    public string yh_lx="";
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["GYS_QQ_ID"] != null)
        {
            HttpCookie QQ_id;
            if (Request.Cookies["GYS_QQ_ID"] == null)
            {
                QQ_id = Request.Cookies["CGS_QQ_ID"];
            }
            else
            {
                QQ_id = Request.Cookies["GYS_QQ_ID"];
            }
            string str_Sql = "select 姓名,yh_id,类型,等级 from 用户表 where QQ_id='" + QQ_id + "'";
            dt_Yh = dc.GetDataTable(str_Sql);
        }
        else
        {
           
            if (Session["GYS_YH_ID"] != null)
            {
                QQ_id = Session["GYS_YH_ID"].ToString();
            }
            else 
            {
                if (Session["CGS_YH_ID"] != null)
                {
                    QQ_id = Session["CGS_YH_ID"].ToString();
                }
            }

            if (QQ_id != "")
            {
                //string str_Sql = "select 姓名,yh_id,类型 from 用户表 where QQ_id='"+QQ_id+"'"; 
                string str_Sql = "select 姓名,yh_id,dw_id,类型,等级 from 用户表 where yh_id='" + QQ_id + "'";

                dt_Yh = dc.GetDataTable(str_Sql);
                if (dt_Yh != null && dt_Yh.Rows.Count > 0)
                {
                    DW = dt_Yh.Rows[0]["dw_id"].ToString();
                }
            }
        }
       if(dt_Yh!=null&&dt_Yh.Rows.Count>0)
       {
       yh_lx=dt_Yh.Rows[0]["等级"].ToString();
       }
    }
</script>
<div class="box">
    <div class="topx">
        <a href="index.aspx">
            <img src="images/topx_02.jpg" /></a>
    </div>
    <%if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null)
      {%>
    <%         
        HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
        Object gys_yh_id = Session["GYS_YH_ID"];

        HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        Object cgs_yh_id = Session["CGS_YH_ID"];


        //采购商登录
        if (((GYS_QQ_ID == null) || (gys_yh_id == null)) && ((CGS_QQ_ID != null) && (cgs_yh_id != null)))
        {
    %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">采购商登出</a></div>
    <%
}
        //供应商登录
        else if (((CGS_QQ_ID == null) || (cgs_yh_id == null)) && ((GYS_QQ_ID != null) && (gys_yh_id != null)))
        {
    %>
    <%if(yh_lx=="企业用户") %>
    <%{ %>
    <div class="anniu">
        <a href="hyyhgl.aspx" target="_self">供应商登出</a></div>
    <%} %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">供应商登出</a></div>
    <div class="anniu">
        <a href="gyszym.aspx" target="_self">供应商主页面</a></div>
    <%
}
    %>
    <%} %>
    <%else
        {
            string gys_yh_id = "";
            string cgs_yh_id = "";
    %>
    <%if (Session["GYS_YH_ID"] != null)
      {
          gys_yh_id = Session["GYS_YH_ID"].ToString();
      }
      if (Session["CGS_YH_ID"] != null)
      {
          cgs_yh_id = Session["CGS_YH_ID"].ToString();
      }
    %>
    <%        
        //采购商登录
        if (gys_yh_id == "" && cgs_yh_id != "")
        {
    %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">采购商登出</a></div>
    <%
        }
             //供应商登录
             else if (cgs_yh_id == "" && gys_yh_id != "")
             {
    %>
      <%if(yh_lx=="企业用户") %>
    <%{ %>
    <div class="anniu">
        <a href="hyyhgl.aspx" target="_self">管理账户</a></div>
    <%} %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">供应商登出</a></div>
    <div class="anniu">
        <a href="gyszym.aspx?QQ=<%=QQ_id %>&GYS_ID=<%=DW %>" target="_self">供应商主页面</a></div>
    <%
        }
    %>
    <%} %>
    <div class="gyzy0">
        <div class="gyzy">
            <%foreach (System.Data.DataRow row in dt_Yh.Rows)
              {%>
            <span>
                <%=row["姓名"].ToString() %></span>
            <%}%>
            欢迎来到众材网！
        </div>
    </div>
