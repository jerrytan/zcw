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
			conn.Open();
                string companyname = Request["companyname"];   //公司名字
                string address = Request["address"];            //地址
                string tel = Request.Form["tel"];               //电话
                string homepage = Request.Form["homepage"];     //主页
                string fax = Request["fax"];                    //传真              
                string description = Request.Form["description"];  //公司简介
                string name = Request.Form["name"];                //联系人
                string phone = Request.Form["phone"];              //联系人手机
                
                if (gys_id != "")
                {
                    string sql = "update  材料供应商信息表 set 供应商='" + companyname + "',地址='" + address + "',电话='" + tel + "',主页='" + homepage + "',传真='" + fax + "',联系人='" + name + "',联系人手机='" + phone + "' where gys_id ='"+gys_id+"'";
                    //Response.Write(sql);
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				
				conn.Close();
                Response.Write("保存成功");
                Response.Redirect("glscsxx.aspx");
            }
</script>


</html>