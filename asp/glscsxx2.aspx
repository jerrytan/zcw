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
			conn.Open();
                string companyname = Request["companyname"];   //��˾����
                string address = Request["address"];            //��ַ
                string tel = Request.Form["tel"];               //�绰
                string homepage = Request.Form["homepage"];     //��ҳ
                string fax = Request["fax"];                    //����              
                string description = Request.Form["description"];  //��˾���
                string name = Request.Form["name"];                //��ϵ��
                string phone = Request.Form["phone"];              //��ϵ���ֻ�
                
                if (gys_id != "")
                {
                    string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��='" + companyname + "',��ַ='" + address + "',�绰='" + tel + "',��ҳ='" + homepage + "',����='" + fax + "',��ϵ��='" + name + "',��ϵ���ֻ�='" + phone + "' where gys_id ='"+gys_id+"'";
                    //Response.Write(sql);
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				
				conn.Close();
                Response.Write("����ɹ�");
                Response.Redirect("glscsxx.aspx");
            }
</script>


</html>