<!--
        收藏供应商页面
        文件名：scgyc.ascx
        传入参数：gys_id 供应商id
        author:张新颖       
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/scgys2.aspx" charset="utf8"></script>

    <title>收藏供应商</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
	 <script  language="javascript" defer="defer">
        function doload()
        {
            window.close();
            opener.location.href = "cgsgl.aspx";
        }
		<%if(Request.Cookies["CGS_QQ_ID"]!=null) {%>
			setTimeout("doload()",4000);
		<%} %>
    </script>
</head>


<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
   
        
        String  gys_id = Request["gys_id"];
		HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        Object cgs_yh_id = Session["CGS_YH_ID"];
            
	    if ((CGS_QQ_ID == null ) && (cgs_yh_id == null))
	    {
		//Response.Write("QQ_id is " + QQ_id.Value + "<p>");
		
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
        
        } else
        {
            //Response.Write("QQ_id is " + QQ_id.Value + "<p>");

            DataConn objConn=new DataConn();

            string yh_id="错误";
            
            try{
                //查询是否该QQid已经登录过
                string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+CGS_QQ_ID.Value+"'";
           
                Object res_checkuserexist = objConn.DBLook(str_checkuserexist);
                if (res_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(res_checkuserexist);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
                           string str_insertuser = "INSERT into 用户表 (QQ_id) VALUES ('"+ CGS_QQ_ID.Value+"')";
                         objConn.ExecuteSQL(str_insertuser,false);

                           string str_updateyhid = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+CGS_QQ_ID.Value+"') where QQ_id = '"+CGS_QQ_ID.Value+"')";
                          objConn.ExecuteSQL(str_updateyhid,true);
                     }

                     //获得yh_id
                     string str_getyhid = "select myId from 用户表 where QQ_id ='"+ CGS_QQ_ID.Value+"'";
                 
                     Object res_yhid = objConn.DBLook(str_getyhid);
                     if (res_yhid != null) 
                     {
                         yh_id = Convert.ToString(res_yhid);
                     }
                      //先判断“采购商关注供应商表”是否有该记录，如果没有，则插入

                      string str_checkexist = "select count(*) from 采购商关注供应商表 where yh_id = '"+yh_id+"' and gys_id ='"+gys_id+"'";
                      
                      int res_checkexist =Convert.ToInt32(objConn.DBLook(str_checkexist));
                      if (res_checkexist !=1 ) 
                      {
                          string str_getcl = "select 供应商,gys_id from 材料供应商信息表 where gys_id ='"+gys_id+"'";
                          DataTable dt_cl = objConn.GetDataTable(str_getcl);
                          string str_gysid = Convert.ToString(dt_cl.Rows[0]["gys_id"]);
                          string str_gysname = Convert.ToString(dt_cl.Rows[0]["供应商"]);
                          string str_addgys = "insert into 采购商关注供应商表 (yh_id,gys_id,供应商名称) values ('"+yh_id+"','"+str_gysid+"','"+str_gysname+"')";
                         objConn.ExecuteSQL(str_addgys,true);
                      }       
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }           
			Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span>");
            Response.Write("<span class='dlzi'>该供应商信息已被收藏成功！</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl_2.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span>");
        }
    
            %>
        </div>
    </div>






</body>
</html>
