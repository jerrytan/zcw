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
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��Ӧ����ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script  runat="server">
    public DataTable dt_yh=new  DataTable();
    public DataConn objConn=new DataConn();
    //public string s_QQ_id="";
    string ppname = "";//����2014��8��28�գ�Ʒ������
    public string name="";
    //����2014��8��13�գ�ע�ʹӹ�Ӧ�������������ȡ������˽���ֶ�
    //public string passed_gys = "";
    public string gys_QQ_id = "";//����2014��8��21��(��Ӧ��id)
    public string power = "";//�û�Ȩ�ޣ�����22�գ�
    public string s_yh_id = "";
    public string lx="";
    public string gys_id = "";//��Ӧ��id
    protected void Page_Load(object sender, EventArgs e)
    {
            if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
            {
                //s_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
                gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();//��,2014��8��22��
            }
            //��ȡQQ_id��������ݿⲻ���ڴ�id������ת��QQ��֤ҳ��  Է
            //string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();��,2014��8��21��
            string sqlExistQQ_id = "select * from �û��� where QQ_id='" + gys_QQ_id + "'";
            string sql_Level = "select �ȼ� from �û��� where QQ_id='" + gys_QQ_id + "'";
            if (objConn.GetRowCount(sqlExistQQ_id) > 0)
            {
                if (objConn.DBLook(sql_Level) == "��ҵ�û�")
                {
                    Response.Redirect("hyyhgl.aspx");
                }
            }
            else
            {
                Response.Redirect("QQ_dlyz.aspx");
            }

            //����2014��8��21��
            string sql_Power = "select ��ɫȨ�� from �û��� where QQ_id='"+gys_QQ_id+"'";
            power = objConn.DBLook(sql_Power).ToString();//21��
        

        if (gys_QQ_id != "")
        {
            //����2014��8��21��          
            //string str_checkuserexist = "select count(*) from �û��� where QQ_id = '" + s_QQ_id + "'";
            string str_checkuserexist = "select count(*) from �û��� where QQ_id = '" + gys_QQ_id + "'";
            string s_Count=objConn.DBLook(str_checkuserexist);    
            if (s_Count != "")
            {
                int count = Convert.ToInt32(s_Count);
                if (count == 0)  //qq_id �����ڣ���Ҫ�����û���
                {
                    string str_insertuser = "insert into �û��� (QQ_id) VALUES ('" + gys_QQ_id + "')";
                     if(!objConn.ExecuteSQL(str_insertuser,false))
                       {
                         // objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_insertuser);
                       }

                     string str_updateuser = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" + gys_QQ_id + "')"
                    + ",updatetime=(select getdate()),ע��ʱ��=(select getdate())where QQ_id = '" + gys_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          //objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_updateuser);
                       }
                } 
            }
            string s_SQL = "select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ�,dw_id from �û��� where QQ_id='" + gys_QQ_id + "'";      
             dt_yh = objConn.GetDataTable(s_SQL);
             
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {
                gys_id = dt_yh.Rows[0]["dw_id"].ToString();//���Ϲ�Ӧ����Ϣ���еĹ�Ӧ��id
                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                name = dt_yh.Rows[0]["����"].ToString();
                lx= dt_yh.Rows[0]["����"].ToString();
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
                foreach (string cookiename in  Request.Cookies.AllKeys)
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

            else
            {

                //need to set session value

                Session["GYS_YH_ID"] = s_yh_id;

                //(��Ӧ������)��yh_id �������쳧��֮����µ�
                //����2014��8��13�գ�ע��sql�������
                //string sSQL = "select ������� from ��Ӧ����������� where yh_id='" + s_yh_id + "' ";
                //DataTable dt_gyssq = new DataTable();
                //dt_gyssq = objConn.GetDataTable(sSQL);
                //if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                //{
                //    passed_gys = dt_gyssq.Rows[0]["�������"].ToString();
                //}
            }
       }
     else
      {
             objConn.MsgBox(this.Page,"QQ_ID�����ڣ������µ�¼");
       }

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
		<%
            //����2014��8��21��    
                //if (passed == "�����")
                //{
                //    Response.Write("�����ĵȺ�,�����µĸ����������ύ,������˵���,�ҷ�������Ա�ᾡ�������!");
                //}
                //else if (passed == "ͨ��")
                //{
                //    //����2014��8��13��ע�ͳ�������ģ�飬���������
                //    //if (passed_gys == "ͨ��")
                //    //{
                //    //    Response.Write("��ϲ��!����������ɹ�,���Խ��й���");
                //    //}
                //    //else if (passed_gys != "ͨ��")
                //    //{
                //    //    Response.Write("��ϲ��!�����ͨ��,���Զ��������̽�������");
                //    //}
                //   Response.Write("��ϲ��!�����ͨ���������Զ������̡������̺Ͳ�����Ϣ�Ľ��й���");
                //}
                //else
                //{
                //    Response.Write("����δ���������Ϣ������д������Ϣ");
                //}    
                  //if(passed_gys.Equals("ͨ��")&&Convert.ToString(row["�Ƿ���֤ͨ��"])=="ͨ��")  
                  //{
                  //   Response.Write("��ϲ��!����������ɹ�,���Խ��й���.");					 
                  //}	
                  //else if(passed_gys.Equals("ͨ��")&&Convert.ToString(row["�Ƿ���֤ͨ��"])!="ͨ��")
                  //{
                  //    Response.Write("�����ĵȺ�,�����µĸ����������ύ,������˵���,�ҷ�������Ա�ᾡ�������!");  
                  //}
                  //else if(!passed_gys.Equals("ͨ��"))
                  //{
                  //    if(Convert.ToString(row["�Ƿ���֤ͨ��"])=="ͨ��")
                  //    {
                  //       Response.Write("��ϲ��!�����ͨ��,���Զ��������̽�������.");
                  //    }	
                  //}				  
		%>
<%--����2014��8��21��--%>
        <%--<%
            //����2014��8��13�����ж����
            //if (passed != "�����"&&passed != "ͨ��")
               if (passed != "�����" && name=="")
            {%>--%>
               <span class="zyy1"><a href="grxx.aspx">���������Ϣ</a></span>
           <%-- <%}  %>--%>
		</span>
		</span>
        <%if (power.Contains("����������"))
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
    <%--/����2014��8��22��--%>
    <%--  <%                   
          if (power)//�ж�Ȩ��
            {
    %>--%>
     <%--/����2014��8��22��--%>
   <%--<div class="gyzy2">--%>
    <%--�����2014��8��13��ע�����쳧��
        <span class="zyy1"><a href="gysbtxx.aspx">���쳧��</a></span>--%>
        <%--<span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">������������Ϣ</a></span>
        <span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">�����������Ϣ</a></span>
        <span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">���������Ϣ</a></span>
        
    </div>--%>
    <%--<% }%>--%>

		<%--<%
	        //����2014��8��13�գ�ע�����ж���䣬������if���
	             //if (passed.Equals("ͨ��")&&(passed_gys==""||passed_gys.Equals("�����"))){	
                     if(passed.Equals("ͨ��")&&(name=="")){
	     %>--%>
	     <%--<div class="gyzy2">--%>
          <%--�����2014��8��13��ע�����쳧�̣�����<span>��ǩ�ĵ����¼�alert��"�������쳧��"����Ϊalert��"�����Ƹ�����Ϣ"��
             <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>--%>
             <%--<span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('�������쳧��')">������������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('�������쳧��')">�����������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('�������쳧��')">���������Ϣ</a></span>--%>
             <%--
         </div>--%>
	  <%--  <%}--%>
          <%--//�����2014��8��13��,ע��if��䣬����else-if���
       //if (passed_gys.Equals("ͨ��")&&passed=="ͨ��"){ 
                     else if (passed.Equals("ͨ��") && name != "")
                     { 
           %>--%>
        <div class="gyzy2">
        <%--�����2014��8��13��ע�����쳧�̣�����������͵��жϣ�if-else���Լ�Ȩ�޵���ʾ
            <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>--%>
            <% if (power.Contains("����������"))
               {
                   //����2014��8��28�գ�if-else�ж�
                   if (ppname == "")
                   { %>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">������������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>" onclick="window.alert('Ϊ�����Ĳ������㣬���ڹ�����������Ϣ�����Ʒ����Ϣ��')">�����������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">���������Ϣ</a></span>
            <%}
                   else
                   {%>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">������������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glfxsxx.aspx?gys_id=<%=gys_id %>">�����������Ϣ</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">���������Ϣ</a></span>  
                  <% }
               }%> 
            <%else
                {%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx?gys_id=<%=gys_id %>">�����������Ϣ</a></span>
            <span class="zyy1" style="margin-left:180px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">���������Ϣ</a></span>       
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
