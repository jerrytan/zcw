<!--
        十大品牌，用于头部
        文件名：top10brand.ascx
        传入参数：无
        
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<script runat="server">  
        protected DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select distinct top 10 品牌名称 ,pp_id from 品牌字典 where 是否启用=1 ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "品牌字典");
            conn.Close();
            dt = ds.Tables[0];	
        }	
 
</script>

<div class="gz2">
    <div class="wz2">

        <ul>

            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <li><a href="ppxx.aspx?pp_id=<%=row["pp_id"]%>"><%=row["品牌名称"].ToString() %></a></li>
            <% } %>
        </ul>
    </div>
</div>
