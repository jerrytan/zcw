<!--
        ҳ�����ƣ�	��Ӧ����ҳ��
        �ļ�����	gyszym.ascx
        ���������	QQid ���ڸ���QQidȡ�����Ϣ
         author������ӱ      
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>��Ӧ����ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script  runat="server">
    public DataTable dt_yh=new  DataTable();
    public DataConn objConn=new DataConn();
    public string s_QQ_id="";
    string ppname = "";//����2014��8��28�գ�Ʒ������
    public string name="";
    //����2014��8��13�գ�ע�ʹӹ�Ӧ�������������ȡ������˽���ֶ�
    //public string passed_gys = "";
    public string gys_QQ_id = "";//����2014��8��21��(��Ӧ��id)
    public string power = "";//�û�Ȩ�ޣ�����22�գ�
    public string s_yh_id = "";
    public string lx="";
    public string gys_id = "";//��Ӧ��id
    public string QQ = "";
    public string dj = "";//�ȼ�
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
        {
            s_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            if (s_QQ_id!="")
            {
                string sql_yhid = "select yh_id from �û��� where QQ_id='" + s_QQ_id + "'";
                s_yh_id = objConn.DBLook(sql_yhid);
            }
        }
        else
        {
            if (Session["GYS_YH_ID"]!=null)
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
        }
        string sql = "select dw_id,��ɫȨ��,����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where yh_id='" + s_yh_id + "' and ����<>'�ɹ���'";
        dt_yh = objConn.GetDataTable(sql);
        if (dt_yh!=null&&dt_yh.Rows.Count>0)
        {
            gys_id=dt_yh.Rows[0]["dw_id"].ToString();
            power = dt_yh.Rows[0]["��ɫȨ��"].ToString();
            name = dt_yh.Rows[0]["����"].ToString();
            lx = dt_yh.Rows[0]["����"].ToString();
            dj = dt_yh.Rows[0]["�ȼ�"].ToString();
        }  
            //����2014��8��28��
            string exists = "select Ʒ������ from Ʒ���ֵ� where scs_id='" + gys_id + "'";
            ppname = objConn.DBLook(exists).ToString();
            if (lx == "�ɹ���")
            {
                string cookieName = "";
                cookieName = "GYS_QQ_ID";
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }
                foreach (string cookiename in Request.Cookies.AllKeys)
                {
                    HttpCookie cookies = Request.Cookies[cookiename];
                    if (cookies != null)
                    {
                        cookies.Expires = DateTime.Today.AddDays(-1);
                        Response.Cookies.Add(cookies);
                        Request.Cookies.Remove(cookiename);
                    }
                }    
				Response.Write("<script>window.alert('���ǲɹ��̣������ù�������ݵ�¼��');window.location.href='index.aspx';</" + "script>");
            }
            Session["GYS_YH_ID"] = s_yh_id;         
     
    }
    </script>

<body>
    <!-- ͷ��2��ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ��2����-->
    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp �����Ϣ�����ҷ�������Աȷ�Ϻ������Թ��������̡���������̺͹��������Ϣ��ͼ1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">	
               <span class="zyy1"><a href="grxx.aspx">���������Ϣ</a></span>         
		</span>
		</span>
        <%if (power.Contains("����������") || dj == "��ҵ�û�" && lx == "������")
          { %>
		<span class="zy2" runat="server" id="scsqx">
            <img src="images/scsqx.jpg" />
		</span>
        <%} %>
        <%else
            { %>
            <span class="zy2" runat ="server" id="Span1">
            <img src="images/fxsqx.jpg" />
		</span> 
		
			<%} %>
    </div>	
            <div class="gyzy2">
            <% if (power.Contains("����������") || dj == "��ҵ�û�" && lx == "������")
               {
                   if (ppname == "")
                   { %>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">������������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?ppmc=&gys_id=<%=gys_id %>" onclick="window.alert('Ϊ�����Ĳ������㣬���ڹ�����������Ϣ�����Ʒ����Ϣ��')">�����������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?ejfl=&gys_id=<%=gys_id %>">���������Ϣ</a></span>
            <%}
                   else
                   {%>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">������������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glfxsxx.aspx?ppmc=&gys_id=<%=gys_id %>">�����������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?ejfl=&gys_id=<%=gys_id %>">���������Ϣ</a></span>  
                  <% }
               }%> 
            <%else
                {%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx?ppmc=&gys_id=<%=gys_id %>">�����������Ϣ</a></span>
            <span class="zyy1" style="margin-left:180px;"><a href="fxsglcl.aspx?gys_id=<%=gys_id %>">���������Ϣ</a></span>       
    <%} %>
    </div>	
   
   
   

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->





</body>
</html>
