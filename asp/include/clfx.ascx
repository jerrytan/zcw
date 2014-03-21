<!--
        文章列表，用于头部
        文件名：clfx.ascx
        传入参数：无
        owner:丁传宇
        
    -->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">

        protected DataTable dt_Clfx = new DataTable();
        protected DataTable dt_Cldg = new DataTable();
        protected DataTable dt_Clpc = new DataTable();
        protected DataTable dt_Clbk = new DataTable();
		protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {
            string str_SqlClfx = "select top 5 wz_id,标题 from 文章表 where 文档类型='材料发现' and 是否上头条='是' and 是否启用=1 order by 发表时间 desc ";
            string str_SqlCldg = "select top 5 wz_id,标题 from 文章表 where 文档类型='材料导购' and 是否上头条='是' and 是否启用=1 order by 发表时间 desc ";
	        string str_SqlCldc = "select top 5 wz_id,标题 from 文章表 where 文档类型='材料评测' and 是否上头条='是' and 是否启用=1 order by 发表时间 desc ";
	        string str_SqlClbk = "select top 5 wz_id,标题 from 文章表 where 文档类型='材料百科' and 是否上头条='是' and 是否启用=1 order by 发表时间 desc ";
            
            dt_Clfx =  dc.GetDataTable(str_SqlClfx);
            dt_Cldg =  dc.GetDataTable(str_SqlCldg);
            dt_Clpc =  dc.GetDataTable(str_SqlCldc);
            dt_Clbk =  dc.GetDataTable(str_SqlClbk);
        }
</script>

<div class="clfx_cldg" style=" width:536px; margin:0 0; padding:0 0; clear:both;">
<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料发现
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料发现 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt_Clfx.Rows){%>
            <li style=" overflow:hidden"><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>


<div class="clfx" >
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料导购
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料导购 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt_Cldg.Rows){%>
            <li style=" overflow:hidden"><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>
</div>

<div class="clpc_clbk" style=" width:536px; margin:0 0; padding:0 0; clear:both;">
<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料评测
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料评测 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt_Clpc.Rows){%>
            <li style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>

<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料百科
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料百科 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt_Clbk.Rows){%>
            <li style=" overflow:hidden"><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>
</div>
