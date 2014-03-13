﻿<!--
        十大产品，用于头部
        文件名：top10product.ascx
        传入参数：无        
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">

        protected DataTable dt_Top10cp = new DataTable();
        protected DataConn dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {		    
            DataSet ds_Top10cp = new DataSet();  
            string str_Sql = "select top 10 显示名,cl_id,材料编码,fl_id,分类编码 from 材料表 order by fl_id ";
            string str_Table = "材料表";
		    dt_Top10cp = dc.DataPileDT(str_Sql,ds_Top10cp,str_Table);
        }	
		
        
</script>

<div class="gz">
    <div class="wz">
        <ul>

            <% foreach(System.Data.DataRow row in dt_Top10cp.Rows){%>

            <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%> "><%=row["显示名"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>
