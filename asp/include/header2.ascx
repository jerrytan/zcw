<!--
������ʼ
ͷ��2(xxx��ʿ��ӭ��)
��������
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<div class="box">

<script runat="server" >

        

        protected DataTable dt = new DataTable(); //�û�����(�û���)    	
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select ���� from �û��� where yh_id='7'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "�û���");           
            dt = ds.Tables[0];
		}	      
	


</script>  


<div class="topx"><a href="gyszym.aspx" ><img src="images/topx_02.jpg" /></a></div>
<div class="gyzy0">
<div class="gyzy">�𾴵�
  <% foreach (System.Data.DataRow row in dt.Rows){%> 
  <span><%=row["����"].ToString() %></span>
  <%}%>

����/Ůʿ������</div>








