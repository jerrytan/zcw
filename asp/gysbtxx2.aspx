<!--
        供应商补填信息页2  (未做)
        文件名:  gysbuxx.aspx   
        
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">


    </script>
</head>
<body>


    <script runat="server">

        protected DataTable dt_gysxx = new  DataTable();  //供应商补填信息(材料供应商信息表)            
        
		
        protected void Page_Load(object sender, EventArgs e)
        { 
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr);
			 //string yh_id = Request["yh_id"]; 	 //获取表单的用户id	 
             string yh_id = "23";
			 
             string gys_name = Request["gys_name"];                  //公司名字
             string gys_address = Request["gys_address"];            //地址
             string gys_homepage = Request.Form["gys_homepage"];     //公司主页
             string gys_phone = Request.Form["gys_phone"];           //公司电话
             string user_name = Request["user_name"];                //您的姓名  
             string user_phone = Request["user_phone"];              //您的手机			 
             string user_qq = Request.Form["user_qq"];               //您的QQ号码
			 //string gys_type = Request.Form["gys_type"];             //供应商类型
			 
			 
			 if(gys_name!=null)
			 {
              			 
              conn.Open();			 
			  string sql_xr = "insert into 材料供应商信息表(供应商,联系地址,主页,电话,联系人,联系人手机,联系人QQ)values('"+gys_name+"','"+gys_address+"','"+gys_homepage+"','"+gys_phone+"','"+user_name+"','"+user_phone+"','"+user_qq+"')";
			  SqlCommand cmd_gysbtxx = new SqlCommand(sql_xr,conn);
			  int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	  
			  			  
			  string sql_gx = "update 材料供应商信息表 set yh_id='"+yh_id+"' ,gys_id=(select myid from 材料供应商信息表 where 供应商='"+gys_name+"') where 供应商='"+gys_name+"'";
			  SqlCommand cmd_gysbtxx1 = new SqlCommand(sql_gx,conn);
			  int ret1 = (int)cmd_gysbtxx1.ExecuteNonQuery();
			  
			  
			  
              //更新用户表
              string sql_yhgx = "update 用户表 set 是否验证通过='通过',手机='"+user_phone+"',等级='"+user_name+"' where yh_id='"+yh_id+"' ";
              SqlCommand cmd_yhxx = new SqlCommand (sql_yhgx,conn);	
              int ret2 = (int)cmd_yhxx.ExecuteNonQuery();
              conn.Close();			  
              Response.Write("恭喜您!您已通过.");

              string sql = "select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ";
			  SqlDataAdapter da_gysxx = new SqlDataAdapter(sql, conn);
			  DataSet ds_gysxx = new DataSet();
              da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
              dt_gysxx = ds_gysxx.Tables[0]; 
			  
              			  
             }  
			string gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
            Response.Redirect("gyszym.aspx?gys_id="+gys_id+" ");			 
        }

    </script>


   
</body>
</html>