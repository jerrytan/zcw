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
    protected DataConn dc = new DataConn();
    public string DW = "";
    public string QQ_id = "";
    public string yh_lx="";
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["GYS_QQ_ID"] != null)
        {
            HttpCookie QQ_id;
            if (Request.Cookies["GYS_QQ_ID"] == null)
            {
                QQ_id = Request.Cookies["CGS_QQ_ID"];
            }
            else
            {
                QQ_id = Request.Cookies["GYS_QQ_ID"];
            }
            string str_Sql = "select ����,yh_id,����,�ȼ� from �û��� where QQ_id='" + QQ_id + "'";
            dt_Yh = dc.GetDataTable(str_Sql);
        }
        else
        {
           
            if (Session["GYS_YH_ID"] != null)
            {
                QQ_id = Session["GYS_YH_ID"].ToString();
            }
            else 
            {
                if (Session["CGS_YH_ID"] != null)
                {
                    QQ_id = Session["CGS_YH_ID"].ToString();
                }
            }

            if (QQ_id != "")
            {
                //string str_Sql = "select ����,yh_id,���� from �û��� where QQ_id='"+QQ_id+"'"; 
                string str_Sql = "select ����,yh_id,dw_id,����,�ȼ� from �û��� where yh_id='" + QQ_id + "'";

                dt_Yh = dc.GetDataTable(str_Sql);
                if (dt_Yh != null && dt_Yh.Rows.Count > 0)
                {
                    DW = dt_Yh.Rows[0]["dw_id"].ToString();
                }
            }
        }
       if(dt_Yh!=null&&dt_Yh.Rows.Count>0)
       {
       yh_lx=dt_Yh.Rows[0]["�ȼ�"].ToString();
       }
    }
</script>
<div class="box">
    <div class="topx">
        <a href="index.aspx">
            <img src="images/topx_02.jpg" /></a>
    </div>
    <%if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null)
      {%>
    <%         
        HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
        Object gys_yh_id = Session["GYS_YH_ID"];

        HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        Object cgs_yh_id = Session["CGS_YH_ID"];


        //�ɹ��̵�¼
        if (((GYS_QQ_ID == null) || (gys_yh_id == null)) && ((CGS_QQ_ID != null) && (cgs_yh_id != null)))
        {
    %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">�ɹ��̵ǳ�</a></div>
    <%
}
        //��Ӧ�̵�¼
        else if (((CGS_QQ_ID == null) || (cgs_yh_id == null)) && ((GYS_QQ_ID != null) && (gys_yh_id != null)))
        {
    %>
    <%if(yh_lx=="��ҵ�û�") %>
    <%{ %>
    <div class="anniu">
        <a href="hyyhgl.aspx" target="_self">��Ӧ�̵ǳ�</a></div>
    <%} %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">��Ӧ�̵ǳ�</a></div>
    <div class="anniu">
        <a href="gyszym.aspx" target="_self">��Ӧ����ҳ��</a></div>
    <%
}
    %>
    <%} %>
    <%else
        {
            string gys_yh_id = "";
            string cgs_yh_id = "";
    %>
    <%if (Session["GYS_YH_ID"] != null)
      {
          gys_yh_id = Session["GYS_YH_ID"].ToString();
      }
      if (Session["CGS_YH_ID"] != null)
      {
          cgs_yh_id = Session["CGS_YH_ID"].ToString();
      }
    %>
    <%        
        //�ɹ��̵�¼
        if (gys_yh_id == "" && cgs_yh_id != "")
        {
    %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">�ɹ��̵ǳ�</a></div>
    <%
        }
             //��Ӧ�̵�¼
             else if (cgs_yh_id == "" && gys_yh_id != "")
             {
    %>
      <%if(yh_lx=="��ҵ�û�") %>
    <%{ %>
    <div class="anniu">
        <a href="hyyhgl.aspx" target="_self">�����˻�</a></div>
    <%} %>
    <div class="anniu">
        <a href="QQ_out.aspx" target="_self">��Ӧ�̵ǳ�</a></div>
    <div class="anniu">
        <a href="gyszym.aspx?QQ=<%=QQ_id %>&GYS_ID=<%=DW %>" target="_self">��Ӧ����ҳ��</a></div>
    <%
        }
    %>
    <%} %>
    <div class="gyzy0">
        <div class="gyzy">
            <%foreach (System.Data.DataRow row in dt_Yh.Rows)
              {%>
            <span>
                <%=row["����"].ToString() %></span>
            <%}%>
            ��ӭ�����ڲ�����
        </div>
    </div>
