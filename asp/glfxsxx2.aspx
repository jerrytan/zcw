<!--  
	    管理分销商信息页面   生厂商可以对代理自己品牌的分销商信息进行管理 修改保存
        文件名：glfxsxx2.aspx
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
			
			string gys_id = Request["gys_id"];   //获取表单提交过来的供应商id         
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
                    string sql = "update  材料供应商信息表 set 供应商='" + companyname + "',"
					+"地址='" + address + "',电话='" + tel + "',主页='" + homepage + "',传真='" + fax + "',"
					+"联系人='" + name + "',联系人手机='" + phone + "' where gys_id ='"+gys_id+"'";
                    //Response.Write(sql);
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				else
				{
				   //如果用户没有点击glfxsxx.aspx 下拉框 就修改分销商信息,那么就执行如下代码,进行修改
				   String yh_id = Convert.ToString(Session["yh_id"]);   //获取用户id
            
			       string str_gys_id = "select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' " ;//查询供应商id			
                   SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
			       DataSet ds_gys_id = new DataSet();
                   da_gys_id.Fill(ds_gys_id, "材料供应商信息表");
                   DataTable dt_gys_id = ds_gys_id.Tables[0];
			       string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //获取供应商id
			
			       string str_pp_id = "select pp_id from 品牌字典 where scs_id='"+str_gysid+"' "; //查询品牌id		
                   SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			       DataSet ds_pp_id = new DataSet();
                   da_pp_id.Fill(ds_pp_id, "品牌字典");
                   DataTable dt_pp_id = ds_pp_id.Tables[0];
			       string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //获取品牌id
				   
				   string sql_str = "update  材料供应商信息表 set 供应商='" + companyname + "',"
				   +"地址='" + address + "',电话='" + tel + "',主页='" + homepage + "',传真='" + fax + "',"
				   +"联系人='" + name + "',联系人手机='" + phone + "' where gys_id in "
				   +"(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"')";   //有几个分销商,就有几个fxs_id,取第一个
                   
                   SqlCommand cmd_str = new SqlCommand(sql_str, conn);
                   cmd_str.ExecuteNonQuery();
				}
				conn.Close();
                Response.Write("保存成功");
                Response.Redirect("glfxsxx.aspx");
            }
</script>


</html>