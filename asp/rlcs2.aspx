<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
                           
               protected void Page_Load(object sender, EventArgs e)
               {  
                    String gys_id = Convert.ToString(Request["gys_id"]);  
                    String yh_id = Convert.ToString(Session["yh_id"]); 	 //��ȡ�����û�id
                  

			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    conn.Open();
					
					string str_select = "select count(*) from ���Ϲ�Ӧ����Ϣ�� where yh_id = '"+yh_id +"'";
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count ==0 )  //����Ĺ�Ӧ�̲�����
                        {
        
                            //���²��Ϲ�Ӧ����Ϣ��
                            String str_updateuser = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
                            SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                            cmd_updateuser.ExecuteNonQuery();
                        }
					    if(count !=0)
					    {
					       Response.Write("����������һ����������,�����ټ�������!");
						   return;
					    }
                                     
                    }
                    
					
					//�û���֤ͨ��,���Խ�yh_id���빩Ӧ������			
             
			                              	
                     string yhid_insert = "insert into ��Ӧ������(yh_id) values('"+yh_id+"')";
                   ��SqlCommand cmd_insert= new SqlCommand(yhid_insert, conn);
				     cmd_insert.ExecuteNonQuery();
					 
					 string sql_yhxx = "update  ��Ӧ������ set updatetime=(select getdate()),gys_id = '"+gys_id+"' "
					 +"where yh_id='"+yh_id+"' ";
			         SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			         int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	
					 conn.Close();
                    
                    
                    Response.Write("��ϲ���ù�Ӧ���Ѿ��ɹ���������,�ҷ�������Ա��ʵ�����Ϣ��,�������������ڸ�����!");

               }
	                  
        
    </script>

