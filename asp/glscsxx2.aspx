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
			
			string gys_id = Request["gys_id"];                  //��ȡ�Ĺ�Ӧ��id
			String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id
			
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
				  string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gys_id+"' ";
				  SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);
                  conn.Open();
                  Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+gys_id+"')";
				       
				       SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				       cmd_insert.ExecuteNonQuery();			 		                          
                    }
					String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gys_id+"' ";
                    SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			        DataSet ds_gysxx = new DataSet();
                    da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                    DataTable dt_gysxx = ds_gysxx.Tables[0];
					string  companyname_xg = Convert.ToString(dt_gysxx.Rows[0]["��Ӧ��"]);
					string  address_xg = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��ַ"]);
					string  tel_xg = Convert.ToString(dt_gysxx.Rows[0]["�绰"]);
					string  homepage_xg = Convert.ToString(dt_gysxx.Rows[0]["��ҳ"]);
					string  fax_xg = Convert.ToString(dt_gysxx.Rows[0]["����"]);
					string  area_xg = Convert.ToString(dt_gysxx.Rows[0]["��������"]);
					string  name_xg = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��"]);
					string  phone_xg = Convert.ToString(dt_gysxx.Rows[0]["��ϵ���ֻ�"]);
					string  Business_Scope_xg = Convert.ToString(dt_gysxx.Rows[0]["��Ӫ��Χ"]);
					
					//�ж� �����ȡ�ı��������ѯ�Ĺ�Ӧ����Ϣ�ֶ���� �͸�Ҫ�޸ĵ� ��Ӧ���Լ��޸Ĵ���˱� ����ֵ
					//string companyname_;
					//if(companyname_xg==companyname)  //��Ӧ��
					//{
					 //companyname_ = "";
					//}
					//else
					//{companyname_ = companyname;}
					
					//string address_;
					//if(address_xg==address)     //��ϵ��ַ
					//{
					// address_ = "";
					//}
					//else
					//{ address_ = address;}
					
					//string tel_;
					//if(tel_xg==tel)       //�绰
					//{
					// tel_ = "";
					//}
					//else
					//{ tel_ = tel;}
					
					//string homepage_;
					//if(homepage_xg==homepage)   //��ҳ
					//{
					// homepage_ = "";
					//}
					//else
					//{ homepage_ = homepage;}
					
					//string fax_;
					//if(fax_xg==fax)  //����
					//{
					// fax_ = "";
					//}
					//else
					//{ fax_ = fax;}
					
					//string area_;
					//if(area_xg==area)  //����
					//{
					// area_ = "";
					//}
					//else
					//{ area_ = area;}
					
					//string name_;
					//if(name_xg==name)     //��ϵ��
					//{
					// name_ = "";
				//	}
					//else
					//{ name_ = name;}
					
					//string phone_;
					//if(phone_xg==phone)       //��ϵ�˵绰
					//{
					// phone_ = "";
					//}
					//else
					//{ phone_ = phone;}
					
					//string Business_Scope_;
					//if(Business_Scope_xg==Business_Scope)       //��Ӫ��Χ
					//{
					// Business_Scope_ = "";
					//}
					//else
					//{ Business_Scope_ = Business_Scope;}
					 
					//�޸� ��Ӧ���Լ��޸Ĵ���˱� ʱ��yh_id��ֵ
                    string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				    +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				    +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				    +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				    SqlCommand cmd_update = new SqlCommand(str_update,conn);
				    cmd_update.ExecuteNonQuery(); 
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













