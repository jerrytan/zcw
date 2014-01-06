<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
                           
               protected void Page_Load(object sender, EventArgs e)
               {  
                    String gys_id = Convert.ToString(Request["gys_id"]);  
                    String yh_id = Convert.ToString(Session["yh_id"]); 	 //获取表单的用户id
                  

			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    conn.Open();
					
					string str_select = "select count(*) from 材料供应商信息表 where yh_id = '"+yh_id +"'";
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count ==0 )  //认领的供应商不存在
                        {
        
                            //更新材料供应商信息表
                            String str_updateuser = "update 材料供应商信息表 set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
                            SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                            cmd_updateuser.ExecuteNonQuery();
                        }
					    if(count !=0)
					    {
					       Response.Write("您已认领了一家生产厂商,不能再继续认领!");
						   return;
					    }
                                     
                    }
                    
					
					//用户验证通过,可以将yh_id出入供应商申请			
             
			                              	
                     string yhid_insert = "insert into 供应商申请(yh_id) values('"+yh_id+"')";
                   　SqlCommand cmd_insert= new SqlCommand(yhid_insert, conn);
				     cmd_insert.ExecuteNonQuery();
					 
					 string sql_yhxx = "update  供应商申请 set updatetime=(select getdate()),gys_id = '"+gys_id+"' "
					 +"where yh_id='"+yh_id+"' ";
			         SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			         int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	
					 conn.Close();
                    
                    
                    Response.Write("恭喜！该供应商已经成功被您认领,我方工作人员核实相关信息后,在三个工作日内给您答复!");

               }
	                  
        
    </script>

