<!--  
	    管理生产商信息页面   对生产商信息进行修改保存
        文件名：glscsxx2.aspx
        传入参数：gys_id 
         author:张新颖   
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

          public DataConn objConn=new DataConn();   
          public string sSQL="";
        protected void Page_Load(object sender, EventArgs e)
        {
             string gys_id ="";
             string yh_id="";
               if( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
               {
                 gys_id = Request["gys_id"].ToString(); //获取的供应商id
               }
			    if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
                {
                    yh_id =Session["GYS_YH_ID"].ToString();   //获取用户id
                }           
               
                string companyname = Request.Form["companyname"];   //公司名字
                string address = Request.Form["address"];            //地址
                string tel = Request.Form["tel"];               //电话
                string homepage = Request.Form["homepage"];     //主页
                string fax = Request.Form["fax"];                    //传真  
				string area = Request.Form["area"];                  //地区
                string description = Request.Form["description"];  //公司简介
                string name = Request.Form["name"];                //联系人
                string phone = Request.Form["phone"];              //联系人手机
				string Business_Scope = Request.Form["Business_Scope"];   //经营范围
				
				if(gys_id!="")
				{
				  sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gys_id+"' ";
				
                  Object obj_check_gys_exist = objConn.DBLook(sSQL);

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       sSQL = "insert into 供应商自己修改待审核表 (gys_id)values('"+gys_id+"')";
	                    objConn.ExecuteSQL(sSQL,false);		 		                          
                    }										 
				
                   sSQL = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				    +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				    +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				    +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				   objConn.ExecuteSQL(sSQL,false);		 	
                  }		 				  			  
				}
				else
				{
				   //如果用户"没有"点击glscsxx.aspx 下拉框 就修改分销商信息,那么就执行如下代码,进行修改
				   //根据用户id 查询的类型 有可能是分销商,有可能是生厂商            
			       sSQL = "select 单位类型, gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' " ;//查询供应商id	141	
                   string str_gysid ="";
                    string str_gys_type="";
                   DataTable dt_gys_id = objConn.GetDataTable(sSQL);
                   if(dt_gys_id!=null&&dt_gys_id.Rows.Count>0)
                   {
                         str_gysid = dt_gys_id.Rows[0]["gys_id"].ToString();   //获取供应商id  141
                         str_gys_type =dt_gys_id.Rows[0]["单位类型"].ToString();   
                   }	
                   <%--蒋，2014年8月14日注释分销商模块		--%>    
				  <%-- if(str_gys_type.Equals("分销商"))
				   {
				       sSQL = "select pp_id from  材料供应商信息从表 where gys_id='"+str_gysid+"' ";   //183				
                    
                       DataTable dt_gysxxs_first = objConn.GetDataTable(sSQL);
                       string gys_pp_id="";
                       if(dt_gysxxs_first!=null&&dt_gysxxs_first.Rows.Count>0)
                       {
                            gys_pp_id =dt_gysxxs_first.Rows[0]["pp_id"].ToString();	 //183	
                       }
                      sSQL = "select gys_id from 材料供应商信息表 where  gys_id in (select scs_id from 品牌字典 where pp_id='"+gys_pp_id+"') and 单位类型='生产商'";
                        string gysid_frist ="";
                         string sql_gys_id="";
                       DataTable dt_frist = objConn.GetDataTable(sSQL);
                       if(dt_frist!=null&&dt_frist.Rows.Count>0)
                       {
                             gysid_frist = dt_frist.Rows[0]["gys_id"].ToString();   //获取默认的生产商id  125				           		     
                       }
                        sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gysid_frist+"' ";		
				                     
                       Object obj_check_gys_exist = objConn.DBLook(sSQL);              				
                   
                       if (obj_check_gys_exist != null)
                       {				     
                           int count = Convert.ToInt32(obj_check_gys_exist);
                           if (count == 0)  
                           {                     				                          
						       sSQL = "insert into 供应商自己修改待审核表 (gys_id)values('"+gysid_frist+"')";
				                objConn.ExecuteSQL(sSQL,false);
				           }
				           sSQL = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				           +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				           +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				           +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gysid_frist+"'";						   
					          objConn.ExecuteSQL(sSQL,true);                            
                       }			 				    
				   }
				   --%>
			       if(str_gys_type.Equals("生产商"))
				   {
			         
					   sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id ='"+str_gysid+"' ";	     
				
                       Object obj_check_gys_exist = objConn.DBLook(sSQL);
                   
                       if (obj_check_gys_exist != null)
                       {
				     
                        int count = Convert.ToInt32(obj_check_gys_exist);
                        if (count == 0)  
                        {                        					 
						   sSQL = "insert into 供应商自己修改待审核表 (gys_id)values('"+str_gysid+"')";
				             objConn.ExecuteSQL(sSQL,false);
				        }  
                       <%--蒋，2014年8月14日， 将下面的sql语句中单位类型从分销商改为生产商--%>
						sSQL = "update 供应商自己修改待审核表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				        +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				        +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				        +"审批结果='待审核',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id = '"+str_gysid+"'";					  
				       objConn.ExecuteSQL(sSQL,true);
                      }			 				  
				   }
				}

                //Response.Write("保存成功");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<%string gys_id = Request["gys_id"];                  //获取的供应商id%>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx?id=<%=gys_id%>">您更新的信息已提交,等待审核,请返回! </a>
</body>
</html>













