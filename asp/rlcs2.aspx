<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
                           
               protected void Page_Load(object sender, EventArgs e)
               {  
                    String gys_id = Convert.ToString(Request["gys_id"]);  
                    String yh_id = Convert.ToString(Session["yh_id"]);
                  

			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    conn.Open();

                    String str_updateuser = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
                    SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                    cmd_updateuser.ExecuteNonQuery();
                    conn.Close();
                    
                    Response.Write("��ϲ���ù�Ӧ���Ѿ��ɹ���������.");

               }
	                  
        
    </script>

