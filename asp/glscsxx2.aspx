<!--  
	    ������������Ϣҳ��   ����������Ϣ�����޸ı���
        �ļ�����glscsxx2.aspx
        ���������gys_id 
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
<title>��������Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

          public DataConn objConn=new DataConn();   
          public string sSQL="";
        protected void Page_Load(object sender, EventArgs e)
        {
             string gys_id ="";
             string yh_id="";
               if( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
               {
                 gys_id = Request["gys_id"].ToString(); //��ȡ�Ĺ�Ӧ��id
               }
			    if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
                {
                    yh_id =Session["GYS_YH_ID"].ToString();   //��ȡ�û�id
                }           
               
                string companyname = Request.Form["companyname"];   //��˾����
                string address = Request.Form["address"];            //��ַ
                string tel = Request.Form["tel"];               //�绰
                string homepage = Request.Form["homepage"];     //��ҳ
                string fax = Request.Form["fax"];                    //����  
				string area = Request.Form["area"];                  //����
                string description = Request.Form["description"];  //��˾���
                string name = Request.Form["name"];                //��ϵ��
                string phone = Request.Form["phone"];              //��ϵ���ֻ�
				string Business_Scope = Request.Form["Business_Scope"];   //��Ӫ��Χ
				
				if(gys_id!="")
				{
				  sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gys_id+"' ";
				
                  Object obj_check_gys_exist = objConn.DBLook(sSQL);

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       sSQL = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+gys_id+"')";
	                    objConn.ExecuteSQL(sSQL,false);		 		                          
                    }										 
				
                   sSQL = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				    +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				    +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				    +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				   objConn.ExecuteSQL(sSQL,false);		 	
                  }		 				  			  
				}
				else
				{
				   //����û�"û��"���glscsxx.aspx ������ ���޸ķ�������Ϣ,��ô��ִ�����´���,�����޸�
				   //�����û�id ��ѯ������ �п����Ƿ�����,�п�����������            
			       sSQL = "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' " ;//��ѯ��Ӧ��id	141	
                   string str_gysid ="";
                    string str_gys_type="";
                   DataTable dt_gys_id = objConn.GetDataTable(sSQL);
                   if(dt_gys_id!=null&&dt_gys_id.Rows.Count>0)
                   {
                         str_gysid = dt_gys_id.Rows[0]["gys_id"].ToString();   //��ȡ��Ӧ��id  141
                         str_gys_type =dt_gys_id.Rows[0]["��λ����"].ToString();   
                   }	
                   <%--����2014��8��14��ע�ͷ�����ģ��		--%>    
				  <%-- if(str_gys_type.Equals("������"))
				   {
				       sSQL = "select pp_id from  ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+str_gysid+"' ";   //183				
                    
                       DataTable dt_gysxxs_first = objConn.GetDataTable(sSQL);
                       string gys_pp_id="";
                       if(dt_gysxxs_first!=null&&dt_gysxxs_first.Rows.Count>0)
                       {
                            gys_pp_id =dt_gysxxs_first.Rows[0]["pp_id"].ToString();	 //183	
                       }
                      sSQL = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+gys_pp_id+"') and ��λ����='������'";
                        string gysid_frist ="";
                         string sql_gys_id="";
                       DataTable dt_frist = objConn.GetDataTable(sSQL);
                       if(dt_frist!=null&&dt_frist.Rows.Count>0)
                       {
                             gysid_frist = dt_frist.Rows[0]["gys_id"].ToString();   //��ȡĬ�ϵ�������id  125				           		     
                       }
                        sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"' ";		
				                     
                       Object obj_check_gys_exist = objConn.DBLook(sSQL);              				
                   
                       if (obj_check_gys_exist != null)
                       {				     
                           int count = Convert.ToInt32(obj_check_gys_exist);
                           if (count == 0)  
                           {                     				                          
						       sSQL = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+gysid_frist+"')";
				                objConn.ExecuteSQL(sSQL,false);
				           }
				           sSQL = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				           +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				           +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				           +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gysid_frist+"'";						   
					          objConn.ExecuteSQL(sSQL,true);                            
                       }			 				    
				   }
				   --%>
			       if(str_gys_type.Equals("������"))
				   {
			         
					   sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+str_gysid+"' ";	     
				
                       Object obj_check_gys_exist = objConn.DBLook(sSQL);
                   
                       if (obj_check_gys_exist != null)
                       {
				     
                        int count = Convert.ToInt32(obj_check_gys_exist);
                        if (count == 0)  
                        {                        					 
						   sSQL = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+str_gysid+"')";
				             objConn.ExecuteSQL(sSQL,false);
				        }  
                       <%--����2014��8��14�գ� �������sql����е�λ���ʹӷ����̸�Ϊ������--%>
						sSQL = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				        +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				        +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				        +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id = '"+str_gysid+"'";					  
				       objConn.ExecuteSQL(sSQL,true);
                      }			 				  
				   }
				}

                //Response.Write("����ɹ�");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<%string gys_id = Request["gys_id"];                  //��ȡ�Ĺ�Ӧ��id%>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx?id=<%=gys_id%>">�����µ���Ϣ���ύ,�ȴ����,�뷵��! </a>
</body>
</html>













