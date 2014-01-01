<!--
        采购商管理页面
        文件名：cgsgl.ascx
        传入参数：无
               
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl2.aspx" charset="utf8"></script>

    <title>收藏列表</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    
    </script>
    <div class="dlqq">
        <div class="dlqq1">
      <%
   
        HttpCookie QQ_id = Request.Cookies["QQ_id"];
        Object logout = Session["logout"];          
       
		if (QQ_id != null && logout == null) 	
        {
            //Response.Write("openid is " + openId.Value + "<p>");

            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try{
                //查询是否该QQid已经登录过
                string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
       
                conn.Open();
                Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();
                if (obj_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(obj_checkuserexist);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
        
                           String str_insertuser = "INSERT into 用户表 (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                           cmd_insertuser.ExecuteNonQuery();
                           String str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"')";
                           SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                           cmd_updateuser.ExecuteNonQuery();
                      }
                                     
                }

                //write yh_id to session
                string str_getyhid = "select yh_id from 用户表 where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd_getyhid = new SqlCommand(str_getyhid, conn);
                String yh_id = cmd_getyhid.ExecuteScalar().ToString();
                Session["yh_id"]=yh_id;

                Response.Redirect("cgsgl_2.aspx");

                
            	
            }
            catch (Exception ex){
                throw(ex);
            }
            finally{
                conn.Close();
            }           
        }
        else
        {
            Response.Redirect("cgsdl.aspx");
          
        }
    
            %>
            
        </div>
    </div>






</body>
</html>
