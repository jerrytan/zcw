 
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
            SqlDataAdapter da = new SqlDataAdapter("select top 10 显示名,cl_id,材料编码,fl_id,一级分类编码 from 材料表 order by fl_id ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料表");
            conn.Close();
            dt = ds.Tables[0];
		   
        }	
		
        
</script>

<div class="gz">
<div class="wz">
 <ul> 

    <% foreach(System.Data.DataRow row in dt.Rows){%>
    
  <li><a href="xx.aspx?fl_id=<%=row["一级分类编码"]%>&cl_id=<%=row["cl_id"]%> "><%=row["显示名"].ToString() %></a></li>
  
  <% } %>

</ul>
</div></div>