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
    public string s_QQ_id="";
    public string passed="";
    public string name="";
    public string passed_gys = "";
    public string s_yh_id = "";
    public string lx="";
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (Request.Cookies["GYS_QQ_ID"]!=null&& Request.Cookies["GYS_QQ_ID"].Value.ToString()!="")
        {
             s_QQ_id= Request.Cookies["GYS_QQ_ID"].Value.ToString();
        }
        if(s_QQ_id!="")
        {            
            string str_checkuserexist = "select count(*) from �û��� where QQ_id = '" + s_QQ_id + "'";
            string s_Count=objConn.DBLook(str_checkuserexist);    
            if (s_Count != "")
            {
                int count = Convert.ToInt32(s_Count);
                if (count == 0)  //qq_id �����ڣ���Ҫ�����û���
                {
                    string str_insertuser = "insert into �û��� (QQ_id) VALUES ('" + s_QQ_id + "')";
                     if(!objConn.ExecuteSQL(str_insertuser,false))
                       {
                         // objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_insertuser);
                       }
               
                    string str_updateuser = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" + s_QQ_id + "')"
				    +",updatetime=(select getdate()),ע��ʱ��=(select getdate())where QQ_id = '" + s_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          //objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_updateuser);
                       }
                } 
            }
            string s_SQL="select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where QQ_id='" + s_QQ_id + "'";      
             dt_yh = objConn.GetDataTable(s_SQL);
             
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {

                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                passed = dt_yh.Rows[0]["�Ƿ���֤ͨ��"].ToString();
                name = dt_yh.Rows[0]["����"].ToString();
                lx= dt_yh.Rows[0]["����"].ToString();
		    }
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
                ////����2014��8��8�գ�ע������ģ��Ĺ���
                //string sSQL = "select ������� from ��Ӧ����������� where yh_id='" + s_yh_id + "' ";
                //DataTable dt_gyssq = new DataTable();
                //dt_gyssq = objConn.GetDataTable(sSQL);
                //if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                //{
                //    passed_gys = dt_gyssq.Rows[0]["�������"].ToString();
                //}
                ////����2014��8��8�գ��ӹ�Ӧ���û���¼����������Ϣ���ж��û�����
                string sSQL = "select ���� from �û��� where yh_id='" + s_yh_id + "'";
                DataTable dt_gyssq = new DataTable();
                dt_gyssq = objConn.GetDataTable(sSQL);
                if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                {
                    passed_gys = dt_gyssq.Rows[0]["����"].ToString();
                }
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
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp �����Ϣ�����ҷ�������Աȷ�Ϻ������Խ��й��������̡�����������Լ����������Ϣ�ȣ�ͼ1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
                if (passed == "�����")
                {
                    Response.Write("�����ĵȺ�,�����µĸ����������ύ,������˵���,�ҷ�������Ա�ᾡ�������!");
                }
                else if (passed == "ͨ��")
                {
                    //����2014��8��8�գ�ע��if-else�����������
                    //if (passed_gys == "ͨ��")
                    //{
                    //    Response.Write("��ϲ��!����������ɹ�,���Խ��й���");
                    //}
                    //else if (passed_gys != "ͨ��")
                    //{
                    //    Response.Write("��ϲ��!�����ͨ��,���Զ��������̽�������");
                    //}
                    Response.Write("��ϲ���������ͨ�������Զ������̣������̺Ͳ��Ͻ��й���");
                }
                else
                {
                    Response.Write("����δ���������Ϣ������д������Ϣ");
                }    
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
        <%
            if (passed != "�����"&&passed != "ͨ��")
            {%>
               <span class="zyy1"><a href="gysbtxx.aspx">���������Ϣ</a></span>
            <%}  %>
		</span>
		</span>
		<span class="zy2">
            <img src="images/aaa_06.jpg" />ͼ1
		</span> 
		<span class="zy2">
            <img src="images/aaa_06.jpg" />ͼ2
		</span>
			
    </div>	

      <%                   
		    if (passed!="ͨ��")
            {
    %>

    <div class="gyzy2">
    <%----����2014��8��8��
    ɾ�����첿�֣�ע�����쳧��--%>
        <%--<span class="zyy1"><a href="gysbtxx.aspx">���쳧��</a></span>--%>
        <span class="zyy1" style="margin-left:180px;"><a href="gysbtxx.aspx">������������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">�����������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">���������Ϣ</a></span>
        
    </div>
    <% }%>

		<%
            //����2014��8��8��
                 //if (passed.Equals("ͨ��")&&(passed_gys==""||passed_gys.Equals("�����"))){
		if(passed.Equals("ͨ��")&&(passed_gys=="������")) {   	
	     %>
	     <div class="gyzy2">
         <%--����2014��8��8��
         ɾ�����첿�֣�ע�����쳧�̣�--%>
            <%-- <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>--%>
            <%-- <span class="zyy1" style="margin-left:180px;"><a href="gyszym.aspx" onclick="window.alert('�����Ƹ�����Ϣ')">������������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('�����Ƹ�����Ϣ')">�����������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('�����Ƹ�����Ϣ')">���������Ϣ</a></span>--%>
              <span class="zyy1" style="margin-left:180px;"><a href="glscsxx.aspx">������������Ϣ</a></span>
            <span class="zyy1"><a href="glfxsxx.aspx">�����������Ϣ</a></span>
            <span class="zyy1"><a href="gysglcl.aspx">���������Ϣ</a></span>    
         </div>
	    <%}
        //����2014��8��8�գ�ע��if���¸�һ��if���  
       //if (passed_gys.Equals("ͨ��")&&passed=="ͨ��"){ 
            if (passed.Equals("ͨ��")&&(passed_gys=="������"))
            {   %>
        <div class="gyzy2">
        <%----����2014��8��8��
        ɾ�����첿�֣�ע�����쳧�̺͹�����������Ϣ--%>
            <%--<span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>--%>
            <%--<span class="zyy1" style="margin-left:180px;"><a href="glscsxx.aspx">������������Ϣ</a></span>--%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx">�����������Ϣ</a></span>
            <span class="zyy1"><a href="gysglcl.aspx">���������Ϣ</a></span>        
        </div>	
    <%} %>
   
   
   

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
