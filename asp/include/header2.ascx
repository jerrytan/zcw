<!--
    ��Ӧ�̵�½�����ҳ�湫����ͷ��
    �ļ���header2.ascx
    �����������
    owner:������

-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
           
        protected DataTable dt_Yh = new DataTable(); //�û�����(�û���)    	
        protected DataConn  dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie QQ_id = Request.Cookies["QQ_id"];
            if (QQ_id != null )
            {
            string str_Sql = "select ���� from �û��� where QQ_id='"+QQ_id.Value+"'";           
            dt_Yh = dc.GetDataTable(sttr_Sql);
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
			<%foreach(System.Data.DataRow row in dt_Yh.Rows){%>            
            <span><%=row["����"].ToString() %></span>           
            <%}%>
            ����/Ůʿ������
        </div>
    </div>
