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
			 //string yh_id = Request["yh_id"]; 	 //��ȡ�����û�id	 
             string yh_id = "23";
			 
             string gys_name = Request["gys_name"];                  //��˾����
             string gys_address = Request["gys_address"];            //��ַ
             string gys_homepage = Request.Form["gys_homepage"];     //��˾��ҳ
             string gys_phone = Request.Form["gys_phone"];           //��˾�绰
             string user_name = Request["user_name"];                //��������  
             string user_phone = Request["user_phone"];              //�����ֻ�			 
             string user_qq = Request.Form["user_qq"];               //����QQ����
			 //string gys_type = Request.Form["gys_type"];             //��Ӧ������
			 
			 
			 if(gys_name!=null)
			 {
              			 
              conn.Open();			 
			  string sql_xr = "insert into ���Ϲ�Ӧ����Ϣ��(��Ӧ��,��ϵ��ַ,��ҳ,�绰,��ϵ��,��ϵ���ֻ�,��ϵ��QQ)values('"+gys_name+"','"+gys_address+"','"+gys_homepage+"','"+gys_phone+"','"+user_name+"','"+user_phone+"','"+user_qq+"')";
			  SqlCommand cmd_gysbtxx = new SqlCommand(sql_xr,conn);
			  int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	  
			  			  
			  string sql_gx = "update ���Ϲ�Ӧ����Ϣ�� set yh_id='"+yh_id+"' ,gys_id=(select myid from ���Ϲ�Ӧ����Ϣ�� where ��Ӧ��='"+gys_name+"') where ��Ӧ��='"+gys_name+"'";
			  SqlCommand cmd_gysbtxx1 = new SqlCommand(sql_gx,conn);
			  int ret1 = (int)cmd_gysbtxx1.ExecuteNonQuery();
			  
			  
			  
              //�����û���
              string sql_yhgx = "update �û��� set �Ƿ���֤ͨ��='ͨ��',�ֻ�='"+user_phone+"',�ȼ�='"+user_name+"' where yh_id='"+yh_id+"' ";
              SqlCommand cmd_yhxx = new SqlCommand (sql_yhgx,conn);	
              int ret2 = (int)cmd_yhxx.ExecuteNonQuery();
              conn.Close();			  
              Response.Write("��ϲ��!����ͨ��.");

              string sql = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ";
			  SqlDataAdapter da_gysxx = new SqlDataAdapter(sql, conn);
			  DataSet ds_gysxx = new DataSet();
              da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
              dt_gysxx = ds_gysxx.Tables[0]; 
			  
              			  
             }  
			string gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
            Response.Redirect("gyszym.aspx?gys_id="+gys_id+" ");			 
        }

    </script>


   
</body>
</html>