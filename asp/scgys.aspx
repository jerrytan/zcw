<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>

 
<script runat="server">
    DataConn objConn = new DataConn();
    DataTable dt = new DataTable();
    public string gys_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
          gys_id = Request["gys_id"];
        HttpCookie CGS_QQ_ID = null;
        string CGS_QQ_ID1 = "";
        //�ɹ��� 
        if (Request.Cookies["CGS_QQ_ID"] != null)
        {
            CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        }
        if (Session["CGS_YH_ID"] != null)
        {
            CGS_QQ_ID1 = Session["CGS_YH_ID"].ToString();
        }
        if (CGS_QQ_ID == null && CGS_QQ_ID1 == "")
        {
           // Response.Write("<script> window.open(\"cgsdl.aspx\", \"\", \"height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes\");window.close();</" + "script>");
            Response.Write("0");
        }
        else
        {
            DataConn objConn = new DataConn();
            DataTable dt = new DataTable();
            string dw_id = "";
            string yh_id = "";
            try
            {
                //��ѯ�Ƿ��QQid�Ѿ���¼��
     
                if (CGS_QQ_ID == null)
                {
                    string qqid = CGS_QQ_ID1;
                    string sql_scrxx = "select yh_id,����,QQ����,dw_id from  �û��� where yh_id='" + qqid + "'";
                    dt = objConn.GetDataTable(sql_scrxx);
                }
                else
                {
                    string qqid = CGS_QQ_ID.Value.ToString();
                    string sql_scrxx = "select yh_id,����,QQ����,dw_id from  �û��� where QQ_id='" + qqid + "'";
                    dt = objConn.GetDataTable(sql_scrxx);
                }
                string QQ = "";
                string name = "";
                if (dt != null && dt.Rows.Count > 0)
                {
                    dw_id = dt.Rows[0]["dw_id"].ToString();
                    yh_id = dt.Rows[0]["yh_id"].ToString();
                    QQ = dt.Rows[0]["QQ����"].ToString();
                    name = dt.Rows[0]["����"].ToString();
                }               //���жϡ��ɹ��̹�ע��Ӧ�̱��Ƿ��иü�¼�����û�У������

                string str_checkexist = "select count(*) from �ɹ��̹�ע��Ӧ�̱� where dw_id = '" + dw_id + "' and gys_id ='" + gys_id + "'";

                int res_checkexist = Convert.ToInt32(objConn.DBLook(str_checkexist));
                if (res_checkexist ==0)
                {
                    string str_getcl = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id ='" + gys_id + "'";
                    DataTable dt_cl = objConn.GetDataTable(str_getcl);
                    string str_gysid = Convert.ToString(dt_cl.Rows[0]["gys_id"]);
                    string str_gysname = Convert.ToString(dt_cl.Rows[0]["��Ӧ��"]);
                    string str_addgys = "insert into �ɹ��̹�ע��Ӧ�̱� (yh_id,gys_id,��Ӧ������,dw_id,updatetime,�ղ�ʱ��,�Ƿ�����,�ղ���QQ,�ղ���) values ('" +
                        yh_id + "','" + str_gysid + "','" + str_gysname + "','" + dw_id + "',(select getdate()),(select getdate()),'1','"+QQ+"','"+name+"')";
                    if (objConn.ExecuteSQL(str_addgys, true))
                    {
                        Response.Write("1");
                    }
                    else
                    {
                        Response.Write("�ղ�ʧ��");
                    }
                    
                }
                else
                {
                    Response.Write("��˾�����ղظó���");
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
            //Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span><br/>");
            //Response.Write("<span class='dlzi'>�ù�Ӧ����Ϣ�ѱ��ղسɹ���</span><br/>");
            //Response.Write("<span class='dlzi'><a href='cgsgl_2.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span><br/>");
            //Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span><br/>");
        }
    }

</script>
 