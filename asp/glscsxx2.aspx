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
			string gys_id = Request["gys_id"];          
			
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
				  string sql_gys_id = "select count(*) from 供应商临时修改表 where gys_id='"+gys_id+"' ";
				  SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);
                  conn.Open();
                  Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       string str_insert = "insert into 供应商临时修改表 (gys_id)values('"+gys_id+"')";
				       
				       SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				       cmd_insert.ExecuteNonQuery();
				  
				       string str_update = "update 供应商临时修改表 set 贵公司名称='"+companyname+"',贵公司地址='"+address+"',"
				       +"贵公司电话='"+tel+"',贵公司主页='"+homepage+"',贵公司地区='"+area+"',贵公司传真='"+fax+"',是否启用='1',"
				       +"联系人姓名='"+name+"',联系人电话='"+phone+"',单位类型='生产商',经营范围='"+Business_Scope+"',"
				       +"审批结果='待审核',updatetime=(select getdate()) where gys_id='"+gys_id+"' ";
				       SqlCommand cmd_update = new SqlCommand(str_update,conn);
				       cmd_update.ExecuteNonQuery();                        

                    }

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













