<!--  
	    �����������Ϣҳ��   �����̿��ԶԴ����Լ�Ʒ�Ƶķ�������Ϣ���й��� �޸ı���
        �ļ�����glfxsxx2.aspx
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
			
			string gys_id = Request["gys_id"];   //��ȡ���ύ�����Ĺ�Ӧ��id         
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
                    string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��='" + companyname + "',"
					+"��ַ='" + address + "',�绰='" + tel + "',��ҳ='" + homepage + "',����='" + fax + "',"
					+"��ϵ��='" + name + "',��ϵ���ֻ�='" + phone + "' where gys_id ='"+gys_id+"'";
                    //Response.Write(sql);
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				else
				{
				   //����û�û�е��glfxsxx.aspx ������ ���޸ķ�������Ϣ,��ô��ִ�����´���,�����޸�
				   String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id
            
			       string str_gys_id = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' " ;//��ѯ��Ӧ��id			
                   SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
			       DataSet ds_gys_id = new DataSet();
                   da_gys_id.Fill(ds_gys_id, "���Ϲ�Ӧ����Ϣ��");
                   DataTable dt_gys_id = ds_gys_id.Tables[0];
			       string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //��ȡ��Ӧ��id
			
			       string str_pp_id = "select pp_id from Ʒ���ֵ� where scs_id='"+str_gysid+"' "; //��ѯƷ��id		
                   SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			       DataSet ds_pp_id = new DataSet();
                   da_pp_id.Fill(ds_pp_id, "Ʒ���ֵ�");
                   DataTable dt_pp_id = ds_pp_id.Tables[0];
			       string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id
				   
				   string sql_str = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��='" + companyname + "',"
				   +"��ַ='" + address + "',�绰='" + tel + "',��ҳ='" + homepage + "',����='" + fax + "',"
				   +"��ϵ��='" + name + "',��ϵ���ֻ�='" + phone + "' where gys_id in "
				   +"(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"')";   //�м���������,���м���fxs_id,ȡ��һ��
                   
                   SqlCommand cmd_str = new SqlCommand(sql_str, conn);
                   cmd_str.ExecuteNonQuery();
				}
				conn.Close();
                Response.Write("����ɹ�");
                Response.Redirect("glfxsxx.aspx");
            }
</script>


</html>