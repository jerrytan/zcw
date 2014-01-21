<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
                           
               protected void Page_Load(object sender, EventArgs e)
               {  
                    String gys_id = Convert.ToString(Request["gys_id"]);   //获取下拉框穿过来的供应商id 
                    String yh_id = Convert.ToString(Session["yh_id"]); 	   //获取表单的用户id                  

			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    conn.Open();
					
					
					
					string str_select = "select count(*) from 供应商认领申请表 where yh_id = '"+yh_id +"'";
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count ==0 )  //认领的供应商不存在
                        {        
                            //更新材料供应商信息表
                            //String str_updateuser = "update 供应商认领申请表 set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
                            //SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                            //cmd_updateuser.ExecuteNonQuery();
							
							//用户验证通过,可以将yh_id插入供应商申请		             
			                              	
                            string yhid_insert = "insert into 供应商认领申请表(yh_id) values('"+yh_id+"')";
                   　       SqlCommand cmd_insert= new SqlCommand(yhid_insert, conn);
				            cmd_insert.ExecuteNonQuery();
					 
					        //根据认领的供应商id 查询供应商信息 更新到供应商申请表中
					 
					        string str_gysxx = "select 供应商,主页,地址,电话,传真,dq_id,联系人,联系人手机,联系人QQ,单位类型,组织机构编号,单位简称, "
					        +"地区名称,法定代表人,注册资金,联系地址,邮编,电子邮箱,经营范围,省市地区编号,企业类别 from 材料供应商信息表 where "
					        +"gys_id='"+gys_id+"' ";
					        SqlDataAdapter da_gysxx = new SqlDataAdapter (str_gysxx,conn);
					        DataSet ds_gysxx = new DataSet();
					        da_gysxx.Fill(ds_gysxx,"材料供应商信息表");
					
					        DataTable dt_gysxx = ds_gysxx.Tables[0];
					        string gys_name = Convert.ToString(dt_gysxx.Rows[0]["供应商"]);
					        string homepage = Convert.ToString(dt_gysxx.Rows[0]["主页"]);
					        string tel = Convert.ToString(dt_gysxx.Rows[0]["电话"]);
					        string fax = Convert.ToString(dt_gysxx.Rows[0]["传真"]);
					        string user_name = Convert.ToString(dt_gysxx.Rows[0]["联系人"]);
					        string user_phone = Convert.ToString(dt_gysxx.Rows[0]["联系人手机"]);
					        string gys_type = Convert.ToString(dt_gysxx.Rows[0]["单位类型"]);
					        string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["组织机构编号"]);
					        string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["联系地址"]);
					        string scope = Convert.ToString(dt_gysxx.Rows[0]["经营范围"]);
							string area = Convert.ToString(dt_gysxx.Rows[0]["地区名称"]);
					
					 
					        //更新供应商申请表
					        string sql_yhxx = "update  供应商认领申请表 set updatetime=(select getdate()),gys_id = '"+gys_id+"', "
					        +"供应商='"+gys_name+"',主页='"+homepage+"',电话='"+tel+"',传真='"+fax+"',联系人='"+user_name+"', "
					        +"联系人手机='"+user_phone+"',单位类型='"+gys_type+"',组织机构编号='"+zzjg_number+"',联系地址='"+lx_addrass+"',"
					        +"经营范围='"+scope+"',地区名称='"+area+"',审批结果='待审核' where yh_id='"+yh_id+"' ";
			                SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			                int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	
					        conn.Close();
                        }
					    if(count !=0)
					    {
					       Response.Write("您已认领了一家生产厂商,不能再继续认领!");
						   return;
					    }
                                     
                    }
                    
					
					
                    
                    
                    Response.Write("该供应商已经成功被您认领,我方工作人员核实相关信息后,在三个工作日内给您答复,请耐心等候!");
					

               }
	                  
        
    </script>

