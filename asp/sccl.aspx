<!--
        材料收藏页面
        文件名：sccl.ascx
        传入参数：cl_id   材料id
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
		
		
			HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];
            String cl_id = Request["cl_id"];
			if ((CGS_QQ_ID == null ) || (cgs_yh_id == null))
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
        else
        {
			 DataConn objConn=new DataConn();
           //Response.Write("QQ_id is " + QQ_id.Value + "<p>");
            string yh_id="错误";
            string s_count1="";
            try
			{
				//查询是否该QQid已经登录过
				string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+CGS_QQ_ID.Value+"'";
                s_count1=objConn.DBLook(str_checkuserexist);               
                if (s_count1 != "") 
                {
                    int count = Convert.ToInt32(s_count1);
                    if (count ==0 )  //qq_id 不存在，需要增加用户表
                    {
                        string str_insertuser = "INSERT into 用户表 (QQ_id) VALUES ('"+ CGS_QQ_ID.Value+"')";
                        objConn.ExecuteSQL(str_insertuser,false);

                        string str_updateyhid = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+CGS_QQ_ID.Value+"') where QQ_id = '"+CGS_QQ_ID.Value+"'";
                        objConn.ExecuteSQL(str_updateyhid,true);
                     }

                     //获得yh_id，QQ_id应该为
                     string str_getyhid = "select myId from 用户表 where QQ_id ='"+ CGS_QQ_ID.Value+"'";
                     DataTable dt_yh=objConn.GetDataTable(str_getyhid);
                     if(dt_yh!=null&&dt_yh.Rows.Count>0)
                     {
                        yh_id=dt_yh.Rows[0]["yh_id"].ToString();
                     }

                    
                  
                      //先判断“采购商关注材料表”是否有该记录，如果没有，则插入
                      string str_checkexist = "select count(*) from 采购商关注材料表 where yh_id = '"+yh_id+"' and cl_id ='"+cl_id+"'";
                      string s_count="";
                      s_count=objConn.DBLook(str_checkexist);
                      if (res_checkexist !=1 ) 
                      {
						  string str_getcl = "select 显示名,材料编码 from 材料表 where cl_id ='"+cl_id+"'";
                          DataTable dt_cl = objConn.GetDataTable(str_getcl);
						  string str_clname="";
						  string str_clcode="";
						  if(dt_cl!=null&&dt_cl.Rows.Count()>0)
						  {
							str_clname = dt_cl.Rows[0]["显示名"].ToString();
							str_clcode = dt_cl.Rows[0]["材料编码"].ToString();
						  }
                          string str_addcl = "insert into 采购商关注材料表 (yh_id,cl_id,材料名称,材料编码) values ('"+yh_id+"','"+cl_id+"','"+str_clname+"','"+str_clcode+"')";
                          objConn.ExecuteSQL(str_addcl,true);
                       }
                     
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }          

			Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span>");
            Response.Write("<span class='dlzi'>该材料已被收藏成功！</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span>");

        }
    
            %>
        </div>
    </div>






</body>
</html>
