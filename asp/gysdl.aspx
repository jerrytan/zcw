<!--
        供应商登陆页面
        文件名：gysdl.ascx
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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/gysdl2.aspx" charset="utf8"></script>

    <title>供应商登陆</title>
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

            //insert into db to store openid and its cl_id
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
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
                           String str_updateuser = "update 用户表 set 注册时间=(select getdate()),"
						   +"yh_id = (select myId from 用户表 where QQ_id = '"+QQ_id.Value+"') "
 						   +"where QQ_id = '"+QQ_id.Value+"'";
                           SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                           cmd_updateuser.ExecuteNonQuery();                                   
                      }
                                    
                }
				//确认QQ_id不为空 才连接的供应商主页面
			   string str_select = "select QQ_id from 用户表 where QQ_id = '"+QQ_id.Value+"'";
               SqlDataAdapter da_select = new SqlDataAdapter(str_select,conn);
               DataSet ds_ = new DataSet();
			   DataTable dt_ = new DataTable();
               da_select.Fill(ds_, "用户表");           
               dt_ = ds_.Tables[0];
               string passed_ = Convert.ToString(dt_.Rows[0]["QQ_id"]);
               if(passed_!="")
               {			   
                 Response.Redirect("gyszym.aspx");  
               }
            	
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
            //Response.Write("openid is empty");
            %>
            <span class="dlzi">尊敬的供应商，您好! </span>
            <span class="dlzi">请点击右边按钮登陆！</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //插入按钮的节点id  

                });

            </script>
            <img src="images/wz_03.jpg">
            <%
        }
   
            %>
            
        </div>
    </div>






</body>
</html>
