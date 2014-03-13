<!--
        文章列表，用于头部
        文件名：clfx.ascx
        传入参数：无
        
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
            DataSet ds_Clfx = new DataSet();
            DataSet ds_Cldg = new DataSet();
            DataSet ds_Clpc = new DataSet();
            DataSet ds_Clbk = new DataSet();

            string str_SqlClfx = "select wz_id,标题 from 文章表 where 文档类型='材料发现' ";
            string str_SqlCldg = "select wz_id,标题 from 文章表 where 文档类型='材料导购' ";
	        string str_SqlCldc = "select wz_id,标题 from 文章表 where 文档类型='材料评测' ";
	        string str_SqlClbk = "select wz_id,标题 from 文章表 where 文档类型='材料百科' ";
            string str_Table = "文章表";	
            
            dt_Clfx =  dc.DataPileDT(str_SqlClfx,ds_Clfx,str_Table);
            dt_Cldg =  dc.DataPileDT(str_SqlCldg,ds_Cldg,str_Table);
            dt_Clpc =  dc.DataPileDT(str_SqlCldc,ds_Clpc,str_Table);
            dt_Clbk =  dc.DataPileDT(str_SqlClbk,ds_Clbk,str_Table);
        }
</script>


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
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>


<div class="clfx">
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
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>


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
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

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
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>
