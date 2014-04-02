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
        protected DataConn  dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
             HttpCookie QQ_id;
             if(Request.Cookies["GYS_QQ_ID"]==null)
             {
                QQ_id=Request.Cookies["CGS_QQ_ID"];
             }
             else
             {
                 QQ_id=Request.Cookies["GYS_QQ_ID"];
             }
            if (QQ_id != null )
            {
                string str_Sql = "select 姓名,yh_id from 用户表 where QQ_id='"+QQ_id.Value+"'";           
                dt_Yh = dc.GetDataTable(str_Sql);
            }
		}
 </script>
  
<div class="box">

    <div class="topx">
        <a href="gyszym.aspx"><img src="images/topx_02.jpg" /></a>
    </div>

      <%         
			HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  

            HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];     
    
              
            //采购商登录
             if(((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID != null ) && (cgs_yh_id != null)))
            {
    %>
             <div class="anniu"><a  href="QQ_out.aspx" target="_self">采购商登出</a></div>
    <%
            }
            //供应商登录
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
    %>
                 <div class="anniu"><a  href="QQ_out.aspx" target="_self">供应商登出</a></div>
    <%
            }
    %>
    <div class="gyzy0">
        <div class="gyzy">
            尊敬的
			<%foreach(System.Data.DataRow row in dt_Yh.Rows){%>            
            <span><%=row["姓名"].ToString() %></span>           
            <%}%>
            先生/女士，您好
        </div>
    </div>

    


 
  