<!--
导航开始
头部2(xxx男士欢迎您)
导航结束
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<div class="box">

<script runat="server" >

        

        protected DataTable dt = new DataTable(); //用户名字(用户表)    	
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select 姓名 from 用户表 where yh_id='7'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "用户表");           
            dt = ds.Tables[0];
		}	      
	


</script>  


<div class="topx"><a href="gyszym.aspx" ><img src="images/topx_02.jpg" /></a></div>
<div class="gyzy0">
<div class="gyzy">尊敬的
  <% foreach (System.Data.DataRow row in dt.Rows){%> 
  <span><%=row["姓名"].ToString() %></span>
  <%}%>

先生/女士，您好</div>








