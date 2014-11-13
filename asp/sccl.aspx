<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>
 
<script runat="server">
    DataConn objConn = new DataConn();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
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
         object cgs_yh_id = Session["CGS_YH_ID"];
            string str_cl = Request["cl_id"];	   
            string str_gysid = Request["gys_id"];  //��ȡҳ�洫�����Ĺ�Ӧ��id
            string str_sccs = Request["sccs"];     //��ȡҳ�洫��������������
            string str_clid = Request["clid"];     //��ȡҳ�洫�����Ĳ���id
            string str_clmc = Request["clmc"];     //��ȡҳ�洫�����Ĳ�������  
            string str_clbm = Request["clbm"];     //��ȡҳ�洫�����Ĳ��ϱ��� ;            
            Session["cl_id"] = str_clid;
			//�ɹ��� ��½
            if (CGS_QQ_ID == null && CGS_QQ_ID1 == "")
            {
                Response.Write("0");
              //  Response.Write("<script> window.open(\"cgsdl.aspx\", \"\", \"height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes\");window.close();</" + "script>");
            }
            else   //�ɹ��̵�¼�����
            {

                if (CGS_QQ_ID != null || CGS_QQ_ID1 != "")
                {
                    try
                    {
                        string qqid = "";
                        DataTable dt_scrxx = new DataTable();
                        string sql_scrxx = "";
                        if (CGS_QQ_ID == null)
                        {
                            qqid = CGS_QQ_ID1;
                            sql_scrxx = "select yh_id,����,QQ����,dw_id from  �û��� where yh_id='" + qqid + "'";
                            dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        }
                        else
                        {
                            qqid = CGS_QQ_ID.Value.ToString();
                            sql_scrxx = "select yh_id,����,QQ����,dw_id from  �û��� where QQ_id='" + qqid + "'";
                            dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        }
                         
                        dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        string scryhid = dt_scrxx.Rows[0]["yh_id"].ToString() == "" ? "" : dt_scrxx.Rows[0]["yh_id"].ToString();
                        string scrxm = dt_scrxx.Rows[0]["����"].ToString() == "" ? "" : dt_scrxx.Rows[0]["����"].ToString();
                        string scrqq = dt_scrxx.Rows[0]["QQ����"].ToString() == "" ? "" : dt_scrxx.Rows[0]["QQ����"].ToString();
                        string scrdwid = dt_scrxx.Rows[0]["dw_id"].ToString() == "" ? "" : dt_scrxx.Rows[0]["dw_id"].ToString();

                        string sql_clcount = "select * from �ɹ��̹�ע�Ĳ��ϱ� where cl_id ='" + str_clid + "' and dw_id = '" + scrdwid + "'";
                        //Response.Write(objConn.GetRowCount(sql_clcount));
                        if (objConn.GetRowCount(sql_clcount) == 0)
                        {
                            string sql_scxx = @"insert into �ɹ��̹�ע�Ĳ��ϱ� (yh_id,cl_id,��������,���ϱ���,�ղ�ʱ��,�ղ���QQ,�Ƿ�����,dw_id,�ղ���,updatetime) 
                            values ('" + scryhid + "','" + str_clid + "','" + str_clmc + "','" + str_clbm + "',GETDATE(),'" + scrqq + "','1','" + scrdwid + "','" + scrxm + "',GETDATE())";
                            if (objConn.ExecuteSQL(sql_scxx, true))
                            {
                                Response.Write("1");
                            }
                            else
                            {
                                Response.Write("�ղ�ʧ�ܣ�");
                            }
                        }
                        else
                        {
                            Response.Write("����˾���ղظĲ��ϣ�");
                        }                      

                        string sql_gyscount = "select * from �ɹ��̹�ע��Ӧ�̱� where gys_id='" + str_gysid + "' and dw_id='" + scrdwid + "'";
                      
                        if (objConn.GetRowCount(sql_gyscount) == 0)
                        {
                            string sql_scgys = @"insert into �ɹ��̹�ע��Ӧ�̱� (yh_id,gys_id,��Ӧ������,�ղ�ʱ��,�ղ���QQ,�Ƿ�����,dw_id,�ղ���,updatetime)  
                            values ('" + scryhid + "','" + str_gysid + "','" + str_sccs + "',GETDATE(),'" + scrqq + "',1,'" + scrdwid + "','" + scrxm + "',GETDATE())";
                            
                            objConn.ExecuteSQL(sql_scgys, true);
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                    }

                    //Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span><br/>");
                    //Response.Write("<span class='dlzi'>�ò����ѱ��ղسɹ���</span><br/>");
                    //Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span><br/>");
                    //Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span><br/>");
                }
            }
    }
</script>
