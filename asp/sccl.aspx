<!--
        材料收藏页面
        文件名：sccl.ascx
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

    <title>收藏材料</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
   
        HttpCookie openId = Request.Cookies["OpenId"];
        String  cl_id = Request["cl_id"];
        if (openId != null)
        {
            //Response.Write("openid is " + openId.Value + "<p>");

            //insert into db to store openid and its cl_id
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try{
                //查询是否该QQid已经登录过
                string CommandText1 = "select count(*) from 用户表 where QQ_id = '"+openId.Value+"'";
                SqlCommand cmd1 = new SqlCommand(CommandText1, conn);
       
                conn.Open();
                Object result = cmd1.ExecuteScalar();
                if (result != null) 
                {
                     int count = Convert.ToInt32(result);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
        
                           String CommandText2 = "INSERT into 用户表 (QQ_id) VALUES ('"+ openId.Value+"')";
                           SqlCommand cmd2 = new SqlCommand(CommandText2, conn);         
                           cmd2.ExecuteNonQuery();
                           String CommandText3 = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+openId.Value+"') where QQ_id = '"+openId.Value+"')";
                           SqlCommand cmd3 = new SqlCommand(CommandText3, conn);         
                           cmd3.ExecuteNonQuery();
                      }
                      //需要判重，fixme
                      //更新“采购商关注的材料表”
                      String CommandText4 = "insert into 采购商关注的材料表 (yh_id,cl_id) values ('"+openId.Value+"','"+cl_id+"')";
                      SqlCommand cmd4 = new SqlCommand(CommandText4, conn); 
                      cmd4.ExecuteNonQuery();

                      
                }
            }
            catch (Exception ex){
                throw(ex);
            }
            finally{
                conn.Close();
            }           

           

			Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span>");
            Response.Write("<span class='dlzi'>该材料已被收藏成功！</span>");
            Response.Write("<span class='dlzi'><a href='#'>您可以点击查看已收藏的所有材料</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span>");


        }
        else
        {
            //Response.Write("openid is empty");
            %>

            <span class="dlzi">尊敬的采购商，您好! 请点击右边按钮登陆！</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //插入按钮的节点id  

                });

            </script>
            <%
        }
    
            %>
            <img src="images/wz_03.jpg">
        </div>
    </div>






</body>
</html>
