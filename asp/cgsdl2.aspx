<!--
        供应商QQ登陆页面
        文件名：gysdl2.ascx
        传入参数：无
               
    -->
<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" charset="utf8" data-callback="true"></script>
</head>
<body>
    <%
        Session["logout"] = null;
      %>
    <script type="text/javascript">
        if (QC.Login.check()) {//如果已登录  
            QC.Login.getMe(function (openId, accessToken) {
                //alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n！"));
                //alert("尊敬的供应商，您好，您已经用QQ号登陆成功，确认后自动返回。");
                //using cookie to store openId

                
				//var exdate=new Date();
				//exdate.setDate(exdate.getDate()+1);
				//var cookieStr = "QQ_id=" + openId + ";expires=" + exdate.toGMTString();
				var cookieStr = "QQ_id=" + openId;
				//alert(cookieStr);
				document.cookie = cookieStr;
				window.close();
				opener.close();
				opener.opener.location.href="cgsgl_2.aspx";
				
				//alert(opener.opener.location.href);
				//opener.opener.location.reload();

            });
            
        }


    </script>
    

<%
			String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            HttpCookie QQ_id = Request.Cookies["QQ_id"];  
            try
            {
                
                String str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
       
                conn.Open();
                Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();
                if (obj_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(obj_checkuserexist);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
        
                           String str_insertuser = "insert into 用户表 (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                           cmd_insertuser.ExecuteNonQuery();
                           String str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"'";
                           SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                           cmd_updateuser.ExecuteNonQuery();
                           
                          
                      }
                       SqlDataAdapter da = new SqlDataAdapter("select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='"+QQ_id.Value+"'", conn);
                           DataSet ds = new DataSet();
                           da.Fill(ds, "用户表");           
                           DataTable dt = ds.Tables[0];
                           String yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
                           Session["yh_id"] = yh_id;
                                     
                }
                
                //Response.Redirect("cgsgl_2.aspx");
            	
            }
            catch (Exception ex){
                throw(ex);
            }
            finally{
                conn.Close();
            }           
%>
</body>

</html>
