<!--
        �ɹ��̹���ҳ��
        �ļ�����cgsgl.ascx
        �����������
               
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

    <title>�ղ��б�</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    
    </script>
    <div class="dlqq">
        <div class="dlqq1">
      <%
   
        HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        Object cgs_yh_id = Session["CGS_YH_ID"];        
       
		if ((CGS_QQ_ID != null ) && (cgs_yh_id != null))
			{
            //Response.Write("openid is " + openId.Value + "<p>");

            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try{
                //��ѯ�Ƿ��QQid�Ѿ���¼��
                string str_checkuserexist = "select count(*) from �û��� where QQ_id = '"+CGS_QQ_ID.Value+"'";
                SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
       
                conn.Open();
                Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();
                if (obj_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(obj_checkuserexist);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
        
                           String str_insertuser = "INSERT into �û��� (QQ_id) VALUES ('"+ CGS_QQ_ID.Value+"')";
                           SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                           cmd_insertuser.ExecuteNonQuery();
                           String str_updateuser = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+CGS_QQ_ID.Value+"') where QQ_id = '"+CGS_QQ_ID.Value+"')";
                           SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                           cmd_updateuser.ExecuteNonQuery();
                      }
                                     
                }

                //write yh_id to session
                string str_getyhid = "select yh_id from �û��� where QQ_id = '"+CGS_QQ_ID.Value+"'";
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
