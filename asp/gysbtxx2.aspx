<!--
        ��Ӧ�̲�����Ϣҳ2  (δ��)
        �ļ���:  gysbuxx.aspx   
        
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">


    </script>
</head>
<body>


    <script runat="server">

        protected DataTable dt_gysxx = new  DataTable();  //��Ӧ�̲�����Ϣ(���Ϲ�Ӧ����Ϣ��)            
        
		
        protected void Page_Load(object sender, EventArgs e)
        { 
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr);
			 String yh_id = Convert.ToString(Session["yh_id"]); 	 //��ȡ�����û�id	 
             //string yh_id = "26";
			 
             string gys_name = Request["gys_name"];                  //��˾����
             string gys_address = Request["gys_address"];            //��ַ
             string gys_homepage = Request.Form["gys_homepage"];     //��˾��ҳ
             string gys_phone = Request.Form["gys_phone"];           //��˾�绰
             string user_name = Request["user_name"];                //��������  
             string user_phone = Request["user_phone"];              //�����ֻ�			 
             string user_qq = Request.Form["user_qq"];               //����QQ����
			 string scs_type = Request.Form["scs_type"];             //��Ӧ������
			 
			 
			 if(gys_name!="")
			 {              			 
              conn.Open();
              //�����û���			  
			  string sql_yhxx = "update  �û��� set ��˾����='"+gys_name+"',��˾��ַ='"+gys_address+"',"
			  +"��˾��ҳ='"+gys_homepage+"',��˾�绰='"+gys_phone+"',����='"+user_name+"',�ֻ�='"+user_phone+"', "
			  +"QQ����='"+user_qq+"',����='"+scs_type+"' where yh_id='"+yh_id+"' ";
			  SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			  int ret = (int)cmd_gysbtxx.ExecuteNonQuery();				  
			
			  		  
              
              //string sql_yhgx = "update �û��� set �Ƿ���֤ͨ��='ͨ��',�ֻ�='"+user_phone+"',�ȼ�='"+user_name+"' where yh_id='"+yh_id+"' ";
              //SqlCommand cmd_yhxx = new SqlCommand (sql_yhgx,conn);	
              //int ret2 = (int)cmd_yhxx.ExecuteNonQuery();
              conn.Close();			  
              Response.Write("�����ĵȴ�,�ҷ�������Ա�ᾡ������ظ�!");

              //string sql = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ";
			  //SqlDataAdapter da_gysxx = new SqlDataAdapter(sql, conn);
			  //DataSet ds_gysxx = new DataSet();
              //da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
              //dt_gysxx = ds_gysxx.Tables[0]; 		  
              			  
             }  
			//string gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
            //Response.Redirect("gyszym.aspx?gys_id="+gys_id+" ");
            Response.Redirect("gyszym.aspx");			
        }

    </script>


   
</body>
</html>