<!--
        �����ղ�ҳ��
        �ļ�����sccl.ascx
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

    <title>�ղز���</title>
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
                //��ѯ�Ƿ��QQid�Ѿ���¼��
                string CommandText1 = "select count(*) from �û��� where QQ_id = '"+openId.Value+"'";
                SqlCommand cmd1 = new SqlCommand(CommandText1, conn);
       
                conn.Open();
                Object result = cmd1.ExecuteScalar();
                if (result != null) 
                {
                     int count = Convert.ToInt32(result);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
        
                           String CommandText2 = "INSERT into �û��� (QQ_id) VALUES ('"+ openId.Value+"')";
                           SqlCommand cmd2 = new SqlCommand(CommandText2, conn);         
                           cmd2.ExecuteNonQuery();
                           String CommandText3 = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+openId.Value+"') where QQ_id = '"+openId.Value+"')";
                           SqlCommand cmd3 = new SqlCommand(CommandText3, conn);         
                           cmd3.ExecuteNonQuery();
                      }
                      //��Ҫ���أ�fixme
                      //���¡��ɹ��̹�ע�Ĳ��ϱ�
                      String CommandText4 = "insert into �ɹ��̹�ע�Ĳ��ϱ� (yh_id,cl_id) values ('"+openId.Value+"','"+cl_id+"')";
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

           

			Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span>");
            Response.Write("<span class='dlzi'>�ò����ѱ��ղسɹ���</span>");
            Response.Write("<span class='dlzi'><a href='#'>�����Ե���鿴���ղص����в���</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span>");


        }
        else
        {
            //Response.Write("openid is empty");
            %>

            <span class="dlzi">�𾴵Ĳɹ��̣�����! �����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

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
