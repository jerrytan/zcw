<!--
        收藏列表页面
        文件名：sclb.ascx
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
        String  cl_id = Request["cl_id"];

       

        if (QQ_id != null)
        {
            //Response.Write("openid is " + openId.Value + "<p>");

            //insert into db to store openid and its cl_id
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try{
                //查询是否该QQid已经登录过
                string CommandText1 = "select count(*) from 用户表 where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd1 = new SqlCommand(CommandText1, conn);
       
                conn.Open();
                Object result = cmd1.ExecuteScalar();
                if (result != null) 
                {
                     int count = Convert.ToInt32(result);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
        
                           String CommandText2 = "INSERT into 用户表 (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd2 = new SqlCommand(CommandText2, conn);         
                           cmd2.ExecuteNonQuery();
                           String CommandText3 = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"')";
                           SqlCommand cmd3 = new SqlCommand(CommandText3, conn);         
                           cmd3.ExecuteNonQuery();
                      }
                                     
                }

                //列表出所收藏的供应商和材料
                DataTable dt_sccl = new DataTable(); //收藏的材料
		        DataTable dt_scgys= new DataTable(); //收藏的供应商
                
                SqlDataAdapter da_sccl = new SqlDataAdapter("select 材料名称,cl_id from 采购商关注材料表 ", conn);
                DataSet ds_sccl = new DataSet();
                da_sccl.Fill(ds_sccl, "采购商关注材料表");            
                dt_sccl = ds_sccl.Tables[0];
			    
                SqlDataAdapter da_scgys = new SqlDataAdapter("select 供应商名称,gys_id from 采购商关注供应商表 ", conn);
                DataSet ds_scgys = new DataSet();
                da_scgys.Fill(ds_scgys, "采购商关注供应商表");            
                dt_scgys = ds_scgys.Tables[0];
		

           

			    Response.Write("<span class='dlzi'>尊敬的采购商，您好! <br>");
                Response.Write("<span class='2'>您收藏的供应商名单如下!<p>");
                foreach(DataRow row in dt_scgys.Rows){
                    Response.Write("<a href=gysxx.aspx?gys_id="+row["gys_id"].ToString()+">"+row["供应商名称"]+"<br></a>");
                }
                Response.Write("</span><span class='dlzi'>您收藏的材料名单如下!<p>");
                foreach(DataRow row in dt_sccl.Rows){
                    Response.Write("<a href=clxx.aspx?cl_id="+row["cl_id"].ToString()+">"+row["材料名称"]+"<br></a>");
                }
                Response.Write("</span>");
            	
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
            <span class="dlzi">尊敬的采购商，您好! </span>
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
