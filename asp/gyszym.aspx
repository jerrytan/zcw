<!--
      ��Ӧ����ҳ�� �������쳧��ҳ�� ����Ӧ�� ���������ҳ�� ��Ӧ�̹������ҳ�� 
	  �ļ���:  gyszym.aspx   
      �������:QQ_id 
	  author:����ӱ
         
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��Ӧ����ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <!-- ͷ��2��ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ��2����-->

  <% 
        DataConn objConn=new DataConn();
         string s_QQ_id="";
        if ( Request.Cookies["QQ_id"]!=null&& Request.Cookies["QQ_id"].Value.ToString()!="")
        {
             s_QQ_id= Request.Cookies["QQ_id"].Value.ToString();
        }
        if(s_QQ_id!="")
        {
            string s_yh_id = "";
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
                          objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_insertuser);
                       }
               
                    string str_updateuser = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" + s_QQ_id + "')"
				    +",updatetime=(select getdate()),ע��ʱ��=(select getdate())where QQ_id = '" + s_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+str_updateuser);
                       }
                }
            }
            string s_SQL="select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where QQ_id='" + s_QQ_id + "'";      
            DataTable dt_yh = objConn.GetDataTable(s_SQL);
             string passed="";
              string name="";
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {
                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                passed = dt_yh.Rows[0]["�Ƿ���֤ͨ��"].ToString();
                name = dt_yh.Rows[0]["����"].ToString();
		    }
		    //need to set session value
            Session["GYS_YH_ID"] = s_yh_id;

            //(��Ӧ������)��yh_id �������쳧��֮����µ�

            string str_gyssq = "select count(*) from ��Ӧ����������� where yh_id='" + s_yh_id + "'";
            string s_count="";
            s_count=objConn.DBLook(str_gyssq);
            string passed_gys = "";
            if (s_count != "")
            {
                int count = Convert.ToInt32(s_count);
                if (count != 0)  //���(��Ӧ������)������ ��û��yh_id ���²�ִ��
                {
                    string sSQL="select ������� from ��Ӧ����������� where yh_id='" + s_yh_id + "' ";              
                    DataTable dt_gyssq = new DataTable();              
                    dt_gyssq = objConn.GetDataTable(sSQL);
                    if(dt_gyssq!=null&&dt_gyssq.Rows.Count>0)
                    {
                        passed_gys =dt_gyssq.Rows[0]["�������"].ToString();
                    }
                }
            }
       }
       else
       {
             objConn.MsgBox(this.Page,"QQ_ID�����ڣ������µ�¼");
       }	
    %>

    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp �����Ϣ�����ҷ�������Աȷ�Ϻ��������������еĹ�Ӧ�̣����������µĹ�Ӧ����Ϣ������������²�Ʒ��Ϣ��ͼ1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
		    foreach(System.Data.DataRow row in dt_yh.Rows)
			{	    
                  if(passed_gys.Equals("ͨ��"))  
                  {
				     Response.Write("��ϲ��!����������ɹ�,���Խ��й���.");					 
				  }	
				  if(!passed_gys.Equals("ͨ��"))
				  {
					  if(Convert.ToString(row["�Ƿ���֤ͨ��"])=="ͨ��")
					  {
						 Response.Write("��ϲ��!�����ͨ��,���Զ��������̽�������.");
					  }	
                  }				  
			} 
		%>
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
		    if (!passed.Equals("ͨ��"))
            {
    %>

    <div class="gyzy2">
        <span class="zyy1"><a href="gysbtxx.aspx">���쳧��</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">������������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">�����������Ϣ</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">���������Ϣ</a></span>
        
    </div>
    <% }%>

		<%
	        
	             if (passed_gys==""&passed.Equals("ͨ��")||passed_gys.Equals("�����")){	
	     %>
	     <div class="gyzy2">
             <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>
             <span class="zyy1"><a href="gyszym.aspx">������������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx">�����������Ϣ</a></span>
             <span class="zyy1"><a href="gyszym.aspx">���������Ϣ</a></span>
        
         </div>
	    <%}
	   if (passed_gys.Equals("ͨ��")){ %>
        <div class="gyzy2">
            <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>
            <span class="zyy1"><a href="glscsxx.aspx">������������Ϣ</a></span>
            <span class="zyy1"><a href="glfxsxx.aspx">�����������Ϣ</a></span>
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
