<!--  
	    ������������Ϣҳ��   ����������Ϣ�����޸ı���
        �ļ�����glscsxx2.aspx
        ���������gys_id    
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
<title>��������Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

             
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			string gys_id = Request["gys_id"];          
			
                string companyname = Request["companyname"];   //��˾����
                string address = Request["address"];            //��ַ
                string tel = Request.Form["tel"];               //�绰
                string homepage = Request.Form["homepage"];     //��ҳ
                string fax = Request["fax"];                    //����  
				string area = Request["area"];                  //����
                string description = Request.Form["description"];  //��˾���
                string name = Request.Form["name"];                //��ϵ��
                string phone = Request.Form["phone"];              //��ϵ���ֻ�
				string Business_Scope = Request.Form["Business_Scope"];   //��Ӫ��Χ
				
				if(gys_id!="")
				{
				  string sql_gys_id = "select count(*) from ��Ӧ����ʱ�޸ı� where gys_id='"+gys_id+"' ";
				  SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);
                  conn.Open();
                  Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       string str_insert = "insert into ��Ӧ����ʱ�޸ı� (gys_id)values('"+gys_id+"')";
				       
				       SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				       cmd_insert.ExecuteNonQuery();
				  
				       string str_update = "update ��Ӧ����ʱ�޸ı� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				       +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				       +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				       +"�������='�����',updatetime=(select getdate()) where gys_id='"+gys_id+"' ";
				       SqlCommand cmd_update = new SqlCommand(str_update,conn);
				       cmd_update.ExecuteNonQuery();                        

                    }

                  }
				 
				  conn.Close();				  
				}
				
				
                
				
                //Response.Write("����ɹ�");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx">�����µ���Ϣ���ύ,�ȴ����,�뷵��! </a>
</body>
</html>













