<!--
        供应商补填信息页2  
        文件名:  gysbtxx2.aspx   
        传入参数：
			Session["GYS_YH_ID"].ToString();  用户id
			以下为gysbtxx.aspx页面post 过来的参数
			Request.Form["gys_name"];                  //公司名字
            Request.Form["gys_address"];            //地址
            Request.Form["gys_homepage"];     //公司主页
            Request.Form["gys_phone"];           //公司电话
            Request.Form["user_name"];                //您的姓名  
            Request.Form["user_phone"];              //您的手机			 
            Request.Form["user_qq"];               //您的QQ号码
			Request.Form["scs_type"];             //供应商类型
		author:张新颖
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
		 <script defer="defer">
		     function doload()
		     {
		         window.close();
		         window.location.href="gyszym.aspx";
		     }
		     setTimeout("doload()", 2000);
</script>

</head>
<body>
    <script runat="server">                 
        
		public DataConn objConn=new DataConn();
        public string s_yh_id="";
        public string sSQL="";
        protected void Page_Load(object sender, EventArgs e)
        { 
            if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
			{
				s_yh_id = Session["GYS_YH_ID"].ToString();
			}       
            if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
            {
                 s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
            }
             string gys_name = Request["gys_name"];                  //公司名字
             string gys_address = Request["gys_address"];            //地址
             string gys_homepage = Request["gys_homepage"];     //公司主页
             string gys_phone = Request["gys_phone"];           //公司电话
             string user_name = Request["user_name"];                //您的姓名  
             string user_phone = Request["user_phone"];              //您的手机			 
             string user_qq = Request["user_qq"];               //您的QQ号码
			 string scs_type = Request["scs_type"];             //供应商类型

			 if(s_yh_id!="")
			 {             		              			  
				  string passed_gys="";	  				  
				  sSQL="select 是否验证通过 from 用户表 where yh_id='"+s_yh_id+"' ";         
				  DataTable dt_gyssq = new DataTable();
				  dt_gyssq=objConn.GetDataTable(sSQL);
				  if(dt_gyssq!=null&&dt_gyssq.Rows.Count>0)
				  {
					 passed_gys =dt_gyssq.Rows[0]["是否验证通过"].ToString();    
				  }                          	
				  if(passed_gys.Equals("通过"))   //如果用户在平台验证通过后 再继续点击保存 不在修改用户信息 直接返回
				  {
						  return;
				  }
				  //更新用户表			  
				  sSQL = "update  用户表 set updatetime=(select getdate()), 公司名称='"+gys_name+"',公司地址='"+gys_address+"',"
				  +"公司主页='"+gys_homepage+"',公司电话='"+gys_phone+"',姓名='"+user_name+"',手机='"+user_phone+"', "
				  +"QQ号码='"+user_qq+"',类型='"+scs_type+"',是否验证通过='待审核',等级='普通用户' where yh_id='"+s_yh_id+"' ";

				  int ret =objConn.ExecuteSQLForCount(sSQL,true);
											   
             }
			 else
			 {
				Response.Redirect("gysdl.aspx");	
			 }
		    //Response.Write("请耐心等待,我方工作人员会尽快给您回复!");
            //Response.Redirect("gyszym.aspx");			
        }

    </script>
    
    <a style="color: Red"  onclick=window.location.href="gyszym.aspx">信息已保存成功,等待审核,请返回! </a>

   
</body>

</html>