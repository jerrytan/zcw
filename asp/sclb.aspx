<!--
        �ղ��б�ҳ��
        �ļ�����sclb.ascx
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
   
        HttpCookie QQ_id = Request.Cookies["QQ_id"];
        String  cl_id = Request["cl_id"];

       

        if (QQ_id != null)
        {
            //Response.Write("openid is " + openId.Value + "<p>");

            //insert into db to store openid and its cl_id
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try{
                //��ѯ�Ƿ��QQid�Ѿ���¼��
                string CommandText1 = "select count(*) from �û��� where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd1 = new SqlCommand(CommandText1, conn);
       
                conn.Open();
                Object result = cmd1.ExecuteScalar();
                if (result != null) 
                {
                     int count = Convert.ToInt32(result);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
        
                           String CommandText2 = "INSERT into �û��� (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd2 = new SqlCommand(CommandText2, conn);         
                           cmd2.ExecuteNonQuery();
                           String CommandText3 = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"')";
                           SqlCommand cmd3 = new SqlCommand(CommandText3, conn);         
                           cmd3.ExecuteNonQuery();
                      }
                                     
                }

                //�б�����ղصĹ�Ӧ�̺Ͳ���
                DataTable dt_sccl = new DataTable(); //�ղصĲ���
		        DataTable dt_scgys= new DataTable(); //�ղصĹ�Ӧ��
                
                SqlDataAdapter da_sccl = new SqlDataAdapter("select ��������,cl_id from �ɹ��̹�ע���ϱ� ", conn);
                DataSet ds_sccl = new DataSet();
                da_sccl.Fill(ds_sccl, "�ɹ��̹�ע���ϱ�");            
                dt_sccl = ds_sccl.Tables[0];
			    
                SqlDataAdapter da_scgys = new SqlDataAdapter("select ��Ӧ������,gys_id from �ɹ��̹�ע��Ӧ�̱� ", conn);
                DataSet ds_scgys = new DataSet();
                da_scgys.Fill(ds_scgys, "�ɹ��̹�ע��Ӧ�̱�");            
                dt_scgys = ds_scgys.Tables[0];
		

           

			    Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����! <br>");
                Response.Write("<span class='2'>���ղصĹ�Ӧ����������!<p>");
                foreach(DataRow row in dt_scgys.Rows){
                    Response.Write("<a href=gysxx.aspx?gys_id="+row["gys_id"].ToString()+">"+row["��Ӧ������"]+"<br></a>");
                }
                Response.Write("</span><span class='dlzi'>���ղصĲ�����������!<p>");
                foreach(DataRow row in dt_sccl.Rows){
                    Response.Write("<a href=clxx.aspx?cl_id="+row["cl_id"].ToString()+">"+row["��������"]+"<br></a>");
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
            <span class="dlzi">�𾴵Ĳɹ��̣�����! </span>
            <span class="dlzi">�����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

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
