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
			
			string gys_id = Request["gys_id"];                  //获取的供应商id
			String yh_id = Convert.ToString(Session["yh_id"]);   //获取用户id
			
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
                  conn.Open();
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
					String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+gys_id+"' ";
                    SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			        DataSet ds_gysxx = new DataSet();
                    da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                    DataTable dt_gysxx = ds_gysxx.Tables[0];
					string  companyname_xg = Convert.ToString(dt_gysxx.Rows[0]["供应商"]);
					string  address_xg = Convert.ToString(dt_gysxx.Rows[0]["联系地址"]);
					string  tel_xg = Convert.ToString(dt_gysxx.Rows[0]["电话"]);
					string  homepage_xg = Convert.ToString(dt_gysxx.Rows[0]["主页"]);
					string  fax_xg = Convert.ToString(dt_gysxx.Rows[0]["传真"]);
					string  area_xg = Convert.ToString(dt_gysxx.Rows[0]["地区名称"]);
					string  name_xg = Convert.ToString(dt_gysxx.Rows[0]["联系人"]);
					string  phone_xg = Convert.ToString(dt_gysxx.Rows[0]["联系人手机"]);
					string  Business_Scope_xg = Convert.ToString(dt_gysxx.Rows[0]["经营范围"]);
					
					//判断 如果获取的表单变量与查询的供应商信息字段相等 就给要修改的 供应商自己修改待审核表 赋空值
					//string companyname_;
					//if(companyname_xg==companyname)  //供应商
					//{
					 //companyname_ = "";
					//}
					//else
					//{companyname_ = companyname;}
					
					//string address_;
					//if(address_xg==address)     //联系地址
					//{
					// address_ = "";
					//}
					//else
					//{ address_ = address;}
					
					//string tel_;
					//if(tel_xg==tel)       //电话
					//{
					// tel_ = "";
					//}
					//else
					//{ tel_ = tel;}
					
					//string homepage_;
					//if(homepage_xg==homepage)   //主页
					//{
					// homepage_ = "";
					//}
					//else
					//{ homepage_ = homepage;}
					
					//string fax_;
					//if(fax_xg==fax)  //传真
					//{
					// fax_ = "";
					//}
					//else
					//{ fax_ = fax;}
					
					//string area_;
					//if(area_xg==area)  //地区
					//{
					// area_ = "";
					//}
					//else
					//{ area_ = area;}
					
					//string name_;
					//if(name_xg==name)     //联系人
					//{
					// name_ = "";
				//	}
					//else
					//{ name_ = name;}
					
					//string phone_;
					//if(phone_xg==phone)       //联系人电话
					//{
					// phone_ = "";
					//}
					//else
					//{ phone_ = phone;}
					
					//string Business_Scope_;
					//if(Business_Scope_xg==Business_Scope)       //经营范围
					//{
					// Business_Scope_ = "";
					//}
					//else
					//{ Business_Scope_ = Business_Scope;}
					 
					//修改 供应商自己修改待审核表 时给yh_id赋值
                    string str_update = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				    +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				    +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				    +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				    SqlCommand cmd_update = new SqlCommand(str_update,conn);
				    cmd_update.ExecuteNonQuery(); 
                  }
				 
				  conn.Close();				  
				}
				
				
                
				
                //Response.Write("保存成功");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx">您更新的信息已提交,等待审核,请返回! </a>
</body>
</html>













