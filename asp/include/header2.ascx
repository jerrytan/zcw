<!--
    ��Ӧ�̵�½�����ҳ�湫����ͷ��
    �ļ���header2.ascx
    �����������
    owner:������
	author:����ӱ  ����˳���¼�İ�ť
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>

  <script runat="server">
           
        protected DataTable dt_Yh = new DataTable(); //�û�����(�û���)    	
        protected DataConn  dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
             HttpCookie QQ_id;
             if(Request.Cookies["GYS_QQ_ID"]==null)
             {
                QQ_id=Request.Cookies["CGS_QQ_ID"];
             }
             else
             {
                 QQ_id=Request.Cookies["GYS_QQ_ID"];
             }
            if (QQ_id != null )
            {
                string str_Sql = "select ����,yh_id from �û��� where QQ_id='"+QQ_id.Value+"'";           
                dt_Yh = dc.GetDataTable(str_Sql);
            }
		}
 </script>
  
<div class="box">

    <div class="topx">
        <a href="gyszym.aspx"><img src="images/topx_02.jpg" /></a>
    </div>

      <%         
			HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  

            HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];     
    
              
            //�ɹ��̵�¼
             if(((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID != null ) && (cgs_yh_id != null)))
            {
    %>
             <div class="anniu"><a  href="QQ_out.aspx" target="_self">�ɹ��̵ǳ�</a></div>
    <%
            }
            //��Ӧ�̵�¼
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
    %>
                 <div class="anniu"><a  href="QQ_out.aspx" target="_self">��Ӧ�̵ǳ�</a></div>
    <%
            }
    %>
    <div class="gyzy0">
        <div class="gyzy">
            �𾴵�
			<%foreach(System.Data.DataRow row in dt_Yh.Rows){%>            
            <span><%=row["����"].ToString() %></span>           
            <%}%>
            ����/Ůʿ������
        </div>
    </div>

    


 
  