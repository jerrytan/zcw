<!--
    ��Ӧ�̵�½�����ҳ�湫����ͷ��
    �ļ���header2.ascx
    �����������

-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
            

        protected DataTable dt = new DataTable(); //�û�����(�û���)    	
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie QQ_id = Request.Cookies["QQ_id"];
            if (QQ_id != null )
            {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select ���� from �û��� where yh_id='"+QQ_id.Value+"'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "�û���");           
            dt = ds.Tables[0];
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
            �𾴵�
            <% foreach (System.Data.DataRow row in dt.Rows){%>
            <span><%=row["����"].ToString() %></span>
            <%}%>

            ����/Ůʿ������
        </div>
    </div>
