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
			 String yh_id = Convert.ToString(Session["yh_id"]); 	 //获取表单的用户id	 
             //string yh_id = "26";
			 
             string gys_name = Request["gys_name"];                  //公司名字
             string gys_address = Request["gys_address"];            //地址
             string gys_homepage = Request.Form["gys_homepage"];     //公司主页
             string gys_phone = Request.Form["gys_phone"];           //公司电话
             string user_name = Request["user_name"];                //您的姓名  
             string user_phone = Request["user_phone"];              //您的手机			 
             string user_qq = Request.Form["user_qq"];               //您的QQ号码
			 string scs_type = Request.Form["scs_type"];             //供应商类型
			 
			 
			 if(gys_name!="")
			 {              			 
              conn.Open();
              //更新用户表			  
			  string sql_yhxx = "update  用户表 set 公司名称='"+gys_name+"',公司地址='"+gys_address+"',"
			  +"公司主页='"+gys_homepage+"',公司电话='"+gys_phone+"',姓名='"+user_name+"',手机='"+user_phone+"', "
			  +"QQ号码='"+user_qq+"',类型='"+scs_type+"' where yh_id='"+yh_id+"' ";
			  SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			  int ret = (int)cmd_gysbtxx.ExecuteNonQuery();				  
			
			  		  
              
              //string sql_yhgx = "update 用户表 set 是否验证通过='通过',手机='"+user_phone+"',等级='"+user_name+"' where yh_id='"+yh_id+"' ";
              //SqlCommand cmd_yhxx = new SqlCommand (sql_yhgx,conn);	
              //int ret2 = (int)cmd_yhxx.ExecuteNonQuery();
              conn.Close();			  
              Response.Write("请耐心等待,我方工作人员会尽快给您回复!");

              //string sql = "select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ";
			  //SqlDataAdapter da_gysxx = new SqlDataAdapter(sql, conn);
			  //DataSet ds_gysxx = new DataSet();
              //da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
              //dt_gysxx = ds_gysxx.Tables[0]; 		  
              			  
             }  
			//string gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
            //Response.Redirect("gyszym.aspx?gys_id="+gys_id+" ");
            Response.Redirect("gyszym.aspx");			
        }

    </script>


   
</body>
</html>