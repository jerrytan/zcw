<!--
        �ɹ��̹���ҳ��
        �ļ�����cgsgl.ascx
        ���������QQ_ID  ��½���QQ Id
               
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
    
    <div class="dlqq">
        <div class="dlqq1">
      <%
        
        public string sCGS_QQ_id = "";
        public DataConn objConn = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["CGS_QQ_ID"]!=null&&Request.Cookies["CGS_QQ_ID"].Value.ToString()!="")
            {
                sCGS_QQ_id=Request.Cookies["CGS_QQ_ID"].Value.ToString();
            }      
            
            if (sCGS_QQ_id!="")
            {
                try
                {
                    /*��ѯ�Ƿ��QQid�Ѿ���¼��*/
                    string s_checkuserexist = "select count(*) from �û��� where QQ_id = '" + sCGS_QQ_id + "'";
					string s_Count=objConn.DBLook(s_checkuserexist);
                    int i_count =Convert.ToInt32(s_Count);
                    /* qq_id �����ڣ���Ҫ�����û���*/
                    if (i_count == 0) 
                    {
                        string s_insertuser = "INSERT into �û��� (QQ_id) VALUES ('" +sCGS_QQ_id + "')";
                        objConn.ExecuteSQL(s_insertuser,false);
                        string s_updateuser = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" +sCGS_QQ_id + "') where QQ_id = '" + sCGS_QQ_id + "')";
                        objConn.ExecuteSQL(s_updateuser,false);
                    }
                    /*��ȡ�û�id ����session */
                    string s_getyhid = "select yh_id from �û��� where QQ_id = '" + sCGS_QQ_id + "'";
                    string yh_id = objConn.DBLook(s_getyhid);
                    Session["yh_id"] = yh_id;
                    //Response.Redirect("cgsgl_2.aspx");
                }
                catch (Exception ex)
                {             
                }
            }
            else
            {
                Response.Redirect("cgsdl.aspx");
            }
        }
            %>
            
        </div>
    </div>
</body>
</html>
