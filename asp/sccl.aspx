<!--
        �����ղ�ҳ��
        �ļ�����sccl.ascx
        ���������cl_id   ����id
        author:����ӱ       
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
		
		
			HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];
            String cl_id = Request["cl_id"];
			if ((CGS_QQ_ID == null ) || (cgs_yh_id == null))
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
        else
        {
			 DataConn objConn=new DataConn();
           //Response.Write("QQ_id is " + QQ_id.Value + "<p>");
            string yh_id="����";
            string s_count1="";
            try
			{
				//��ѯ�Ƿ��QQid�Ѿ���¼��
				string str_checkuserexist = "select count(*) from �û��� where QQ_id = '"+CGS_QQ_ID.Value+"'";
                s_count1=objConn.DBLook(str_checkuserexist);               
                if (s_count1 != "") 
                {
                    int count = Convert.ToInt32(s_count1);
                    if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                    {
                        string str_insertuser = "INSERT into �û��� (QQ_id) VALUES ('"+ CGS_QQ_ID.Value+"')";
                        objConn.ExecuteSQL(str_insertuser,false);

                        string str_updateyhid = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+CGS_QQ_ID.Value+"') where QQ_id = '"+CGS_QQ_ID.Value+"'";
                        objConn.ExecuteSQL(str_updateyhid,true);
                     }

                     //���yh_id��QQ_idӦ��Ϊ
                     string str_getyhid = "select myId from �û��� where QQ_id ='"+ CGS_QQ_ID.Value+"'";
                     DataTable dt_yh=objConn.GetDataTable(str_getyhid);
                     if(dt_yh!=null&&dt_yh.Rows.Count>0)
                     {
                        yh_id=dt_yh.Rows[0]["yh_id"].ToString();
                     }

                    
                  
                      //���жϡ��ɹ��̹�ע���ϱ��Ƿ��иü�¼�����û�У������
                      string str_checkexist = "select count(*) from �ɹ��̹�ע���ϱ� where yh_id = '"+yh_id+"' and cl_id ='"+cl_id+"'";
                      string s_count="";
                      s_count=objConn.DBLook(str_checkexist);
                      if (res_checkexist !=1 ) 
                      {
						  string str_getcl = "select ��ʾ��,���ϱ��� from ���ϱ� where cl_id ='"+cl_id+"'";
                          DataTable dt_cl = objConn.GetDataTable(str_getcl);
						  string str_clname="";
						  string str_clcode="";
						  if(dt_cl!=null&&dt_cl.Rows.Count()>0)
						  {
							str_clname = dt_cl.Rows[0]["��ʾ��"].ToString();
							str_clcode = dt_cl.Rows[0]["���ϱ���"].ToString();
						  }
                          string str_addcl = "insert into �ɹ��̹�ע���ϱ� (yh_id,cl_id,��������,���ϱ���) values ('"+yh_id+"','"+cl_id+"','"+str_clname+"','"+str_clcode+"')";
                          objConn.ExecuteSQL(str_addcl,true);
                       }
                     
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }          

			Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span>");
            Response.Write("<span class='dlzi'>�ò����ѱ��ղسɹ���</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span>");

        }
    
            %>
        </div>
    </div>






</body>
</html>
