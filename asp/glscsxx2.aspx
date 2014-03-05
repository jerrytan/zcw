<!--  
	    管理生产商信息页面   对生产商信息进行修改保存
        文件名：glscsxx2.aspx
        传入参数：gys_id    
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
<title>分销商信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

             
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			conn.Open();
			
			string gys_id = Request["gys_id"];                  //获取的供应商id
			String yh_id = Convert.ToString(Session["GYS_YH_ID"]);   //获取用户id
			
                string companyname = Request["companyname"];   //公司名字
                string address = Request["address"];            //地址
                string tel = Request.Form["tel"];               //电话
                string homepage = Request.Form["homepage"];     //主页
                string fax = Request["fax"];                    //传真  
				string area = Request["area"];                  //地区
                string description = Request.Form["description"];  //公司简介
                string name = Request.Form["name"];                //联系人
                string phone = Request.Form["phone"];              //联系人手机
				string Business_Scope = Request.Form["Business_Scope"];   //经营范围
				
				if(gys_id!="")
				{
				  string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gys_id+"' ";
				  SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);
                  
                  Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       string str_insert = "insert into 供应商自己修改待审核表 (gys_id)values('"+gys_id+"')";
				       
				       SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				       cmd_insert.ExecuteNonQuery();			 		                          
                    }										 
				
                    string str_update = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				    +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				    +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				    +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				    SqlCommand cmd_update = new SqlCommand(str_update,conn);
				    cmd_update.ExecuteNonQuery(); 
                  }		 				  			  
				}
				else
				{
				   //如果用户"没有"点击glscsxx.aspx 下拉框 就修改分销商信息,那么就执行如下代码,进行修改
				   //根据用户id 查询的类型 有可能是分销商,有可能是生厂商
				   
            
			       string str_gys_id = "select 单位类型, gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' " ;//查询供应商id	141	
                   SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
			       DataSet ds_gys_id = new DataSet();
                   da_gys_id.Fill(ds_gys_id, "材料供应商信息表");
                   DataTable dt_gys_id = ds_gys_id.Tables[0];
			       string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //获取供应商id  141
				   string str_gys_type = Convert.ToString(dt_gys_id.Rows[0]["单位类型"]);   
				   if(str_gys_type.Equals("分销商"))
				   {
				      
			      
				       String str_gysxxs_first = "select pp_id from  材料供应商信息从表 where gys_id='"+str_gysid+"' ";   //183
				
                       SqlDataAdapter da_gysxxs_first = new SqlDataAdapter(str_gysxxs_first, conn);
			           DataSet ds_gysxxs_first = new DataSet();
                       da_gysxxs_first.Fill(ds_gysxxs_first, "材料供应商信息从表");
                       DataTable dt_gysxxs_first = ds_gysxxs_first.Tables[0];
               	       string gys_pp_id = Convert.ToString(dt_gysxxs_first.Rows[0]["pp_id"]);	 //183	

              
                			
				
                       String str_frist = "select gys_id "
				       +"from 材料供应商信息表 where  gys_id in (select scs_id from 品牌字典 where pp_id='"+gys_pp_id+"')"    //pp_id=183
				       +"and 单位类型='生产商'";
                        SqlDataAdapter da_frist = new SqlDataAdapter(str_frist, conn);
			           DataSet ds_frist = new DataSet();
                       da_frist.Fill(ds_frist, "材料供应商信息表");
                       DataTable dt_frist = ds_frist.Tables[0];
				       string gysid_frist = Convert.ToString(dt_frist.Rows[0]["gys_id"]);   //获取默认的生产商id  125
				       string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gysid_frist+"' ";
				     
				       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                       Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();              				
                   
                       if (obj_check_gys_exist != null)
                       {				     
                           int count = Convert.ToInt32(obj_check_gys_exist);
                           if (count == 0)  
                           {                     				                          
						       string str_insert = "insert into 供应商自己修改待审核表 (gys_id)values('"+gysid_frist+"')";
				       
				               SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				               cmd_insert.ExecuteNonQuery();
				           }
				           string str_update = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				           +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				           +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				           +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gysid_frist+"'";						   
					  
				           SqlCommand cmd_update = new SqlCommand(str_update,conn);
				           cmd_update.ExecuteNonQuery();                                        
                       }			 				    
				   }
				   
			       if(str_gys_type.Equals("生产商"))
				   {
			          //string str_pp_id = "select pp_id from 品牌字典 where scs_id='"+str_gysid+"' "; //查询品牌id		
                      //SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			          //DataSet ds_pp_id = new DataSet();
                      //da_pp_id.Fill(ds_pp_id, "品牌字典");
                      //DataTable dt_pp_id = ds_pp_id.Tables[0];
			          //string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //获取品牌id  185		   				 
				   
				      //string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id in "
				      //+"(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"')"; //有几个分销商,就有几个fxs_id,取第一个  139
				      //SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                      //Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
					  
					   string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id ='"+str_gysid+"' ";				     
				       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                       Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
                   
                       if (obj_check_gys_exist != null)
                       {
				     
                        int count = Convert.ToInt32(obj_check_gys_exist);
                        if (count == 0)  
                        {                        					 
                           //string str_insert = "insert into 供应商自己修改待审核表 (gys_id)select top 1 fxs_id from 分销商和品牌对应关系表 "
						   //+"where pp_id='"+str_ppid+"'";				       
				           //SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				          // cmd_insert.ExecuteNonQuery();
						   
						   string str_insert = "insert into 供应商自己修改待审核表 (gys_id)values('"+str_gysid+"')";
				       
				           SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				           cmd_insert.ExecuteNonQuery();
				        }
				        //string str_update = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				        //+"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				        //+"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='分销商',经营范围='"+Business_Scope+"',"
				        //+"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id in"
						//+"(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"')";					  
				        //SqlCommand cmd_update = new SqlCommand(str_update,conn);
				        //cmd_update.ExecuteNonQuery();  

						string str_update = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				        +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				        +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='分销商',经营范围='"+Business_Scope+"',"
				        +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id = '"+str_gysid+"'";					  
				        SqlCommand cmd_update = new SqlCommand(str_update,conn);
				        cmd_update.ExecuteNonQuery();
                      }			 				  
				   }
				}
				
                
				conn.Close();	
                //Response.Write("保存成功");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<%string gys_id = Request["gys_id"];                  //获取的供应商id%>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx?id=<%=gys_id%>">您更新的信息已提交,等待审核,请返回! </a>
</body>
</html>













