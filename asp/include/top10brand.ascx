﻿   <!--
        十大品牌，用于头部
        文件名：top10brand.ascx
        传入参数：无
        owner:丁传宇
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<script runat="server">  
        protected DataTable dt_Top10ppmc = new DataTable();
        protected DataConn dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            string str_Sql = "select distinct top 10 品牌名称 ,pp_id,访问计数 from 品牌字典 where 是否启用=1 order by 访问计数 desc";
            dt_Top10ppmc = dc.GetDataTable(str_Sql);
        }	
 
</script>

<div class="gz2">
    <div class="wz2">

        <ul>

            <% foreach(System.Data.DataRow row in dt_Top10ppmc.Rows){%>
            <li style=" padding-left:5px;"><a  style=" margin-left:8px;" href="ppxx.aspx?pp_id=<%=row["pp_id"]%>"><%=row["品牌名称"].ToString() %></a></li>
            <% } %>
        </ul>
    </div>
</div>
