<!--
        ��Ӧ�̲�����Ϣҳ2  
        �ļ���:  gysbtxx2.aspx   
        ���������
			Session["GYS_YH_ID"].ToString();  �û�id
			����Ϊgysbtxx.aspxҳ��post �����Ĳ���
			Request.Form["gys_name"];                  //��˾����
            Request.Form["gys_address"];            //��ַ
            Request.Form["gys_homepage"];     //��˾��ҳ
            Request.Form["gys_phone"];           //��˾�绰
            Request.Form["user_name"];                //��������  
            Request.Form["user_phone"];              //�����ֻ�			 
            Request.Form["user_qq"];               //����QQ����
			Request.Form["scs_type"];             //��Ӧ������
		author:����ӱ
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
		 <script defer="defer">
		     function doload()
		     {
		         window.location.href="gyszym.aspx";
		     }
		     setTimeout("doload()", 2000);
</script>

</head>
<body>
    <script runat="server">                 
        
		public DataConn objConn=new DataConn();
        public string s_yh_id="";
        public string sSQL="";
        protected void Page_Load(object sender, EventArgs e)
        { 
            if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
			{
				s_yh_id = Session["GYS_YH_ID"].ToString();
			}       
             string gys_name = Request["gys_name"];                  //��˾����
             string gys_address = Request["gys_address"];            //��ַ
             string gys_homepage = Request["gys_homepage"];     //��˾��ҳ
             string gys_phone = Request["gys_phone"];           //��˾�绰
             string user_name = Request["user_name"];                //��������  
             string user_phone = Request["user_phone"];              //�����ֻ�			 
             string user_qq = Request["user_qq"];               //����QQ����
			 string scs_type = Request["scs_type"];             //��Ӧ������

			 if(s_yh_id!="")
			 {             		              			  
				  string passed_gys="";	  				  
				  sSQL="select �Ƿ���֤ͨ�� from �û��� where yh_id='"+s_yh_id+"' ";         
				  DataTable dt_gyssq = new DataTable();
				  dt_gyssq=objConn.GetDataTable(sSQL);
				  if(dt_gyssq!=null&&dt_gyssq.Rows.Count>0)
				  {
					 passed_gys =dt_gyssq.Rows[0]["�Ƿ���֤ͨ��"].ToString();    
				  }                          	
				  if(passed_gys.Equals("ͨ��"))   //����û���ƽ̨��֤ͨ���� �ټ���������� �����޸��û���Ϣ ֱ�ӷ���
				  {
						  return;
				  }
				  //�����û���			  
				  sSQL = "update  �û��� set updatetime=(select getdate()), ��˾����='"+gys_name+"',��˾��ַ='"+gys_address+"',"
				  +"��˾��ҳ='"+gys_homepage+"',��˾�绰='"+gys_phone+"',����='"+user_name+"',�ֻ�='"+user_phone+"', "
				  +"QQ����='"+user_qq+"',����='"+scs_type+"',�Ƿ���֤ͨ��='�����',�ȼ�='��ͨ�û�' where yh_id='"+s_yh_id+"' ";

				  int ret =objConn.ExecuteSQLForCount(sSQL,true);
											   
             }
			 else
			 {
				Response.Redirect("gysdl.aspx");	
			 }
		    //Response.Write("�����ĵȴ�,�ҷ�������Ա�ᾡ������ظ�!");
            //Response.Redirect("gyszym.aspx");			
        }

    </script>
    
    <a style="color: Red"  onclick=window.location.href="gyszym.aspx">��Ϣ�ѱ���ɹ�,�ȴ����,�뷵��! </a>

   
</body>

</html>