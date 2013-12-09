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

        protected DataTable dt = new DataTable();
        protected DataTable dt1 = new DataTable();
        protected DataTable dt2 = new DataTable();
        protected DataTable dt3 = new DataTable();
		
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select wz_id,标题 from 文章表 where 文档类型='材料发现' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "文章表");            
            dt = ds.Tables[0];	

            SqlDataAdapter da1 = new SqlDataAdapter("select wz_id,标题 from 文章表 where 文档类型='材料导购' ", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "文章表");            
            dt1 = ds1.Tables[0];

	        SqlDataAdapter da2 = new SqlDataAdapter("select wz_id,标题 from 文章表 where 文档类型='材料评测' ", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "文章表");            
            dt2 = ds2.Tables[0];
			
	        SqlDataAdapter da3 = new SqlDataAdapter("select wz_id,标题 from 文章表 where 文档类型='材料百科' ", conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "文章表");            
            dt3 = ds3.Tables[0];		
            conn.Close();			
		
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
            <% foreach(System.Data.DataRow row in dt.Rows){%>
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
            <% foreach(System.Data.DataRow row in dt1.Rows){%>
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
            <% foreach(System.Data.DataRow row in dt2.Rows){%>
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
            <% foreach(System.Data.DataRow row in dt3.Rows){%>
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>
