<!--
    供应商登陆后操作页面公共的头部
    文件：header2.ascx
    传入参数：无

-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
           
        protected DataTable dt_Yh = new DataTable(); //用户名字(用户表)    	
        protected DataConn  dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie QQ_id = Request.Cookies["QQ_id"];
            if (QQ_id != null )
            {
            string str_Sql = "select 姓名 from 用户表 where QQ_id='"+QQ_id.Value+"'";
            DataSet ds_Yh = new DataSet();
            string str_Table = "用户表";           
            dt_Yh = dc.DataPileDT(str_Sql,ds_Yh,str_Table);
            }
		}	      

</script>

<div class="box">

    <div class="topx">
        <a href="gyszym.aspx">
            <img src="images/topx_02.jpg" /></a>
    </div>
    <div class="gyzy0">
        <div class="gyzy">
            尊敬的
			<%foreach(System.Data.DataRow row in this.dt_yh.Rows){%>            
            <span><%=row["姓名"].ToString() %></span>           
            <%}%>
            先生/女士，您好
        </div>
    </div>
