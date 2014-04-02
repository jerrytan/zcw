<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
    public string s_yh_id = "";
    public string s_gys_id = "";
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            s_gys_id = Request["gys_id"].ToString();
        }
        string gys_type="";
        if (Request["gys_type"] != null && Request["gys_type"].ToString() != "")
        {
            gys_type = Request["gys_type"].ToString();
        }
        if (s_yh_id != "")
        {
            sSQL = "select count(*) from ��Ӧ����������� where yh_id = '" + s_yh_id + "'";
            Object obj_checkexist_gysid = objConn.DBLook(sSQL);
               if(gys_type=="������")
                {
                    if (obj_checkexist_gysid != null)
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
             
                            if (count == 0)  //����Ĺ�Ӧ�̲�����
                            {

                                //�û���֤ͨ��,���Խ�yh_id���빩Ӧ������		             

                                sSQL = "insert into ��Ӧ�����������(yh_id) values('" + s_yh_id + "')";
                                objConn.ExecuteSQL(sSQL, false);

                                //��������Ĺ�Ӧ��id ��ѯ��Ӧ����Ϣ ���µ���Ӧ���������
                                if (s_gys_id != "")
                                {
                                    sSQL = "select ��Ӧ��,��ҳ,��ַ,�绰,����,dq_id,��ϵ��,��ϵ���ֻ�,��ϵ��QQ,��λ����,��֯�������,��λ���, "
                                    + "��������,����������,ע���ʽ�,��ϵ��ַ,�ʱ�,��������,��Ӫ��Χ,ʡ�е������,��ҵ��� from ���Ϲ�Ӧ����Ϣ�� where "
                                    + "gys_id='" + s_gys_id + "' ";
                                    DataTable dt_gysxx = objConn.GetDataTable(sSQL);
                                    string gys_name = Convert.ToString(dt_gysxx.Rows[0]["��Ӧ��"]);
                                    string homepage = Convert.ToString(dt_gysxx.Rows[0]["��ҳ"]);
                                    string tel = Convert.ToString(dt_gysxx.Rows[0]["�绰"]);
                                    string fax = Convert.ToString(dt_gysxx.Rows[0]["����"]);
                                    string user_name = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��"]);
                                    string user_phone = Convert.ToString(dt_gysxx.Rows[0]["��ϵ���ֻ�"]);
                                    string gys_type = Convert.ToString(dt_gysxx.Rows[0]["��λ����"]);
                                    string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["��֯�������"]);
                                    string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��ַ"]);
                                    string scope = Convert.ToString(dt_gysxx.Rows[0]["��Ӫ��Χ"]);
                                    string area = Convert.ToString(dt_gysxx.Rows[0]["��������"]);


                                    //���¹�Ӧ�������
                                    sSQL = "update  ��Ӧ����������� set updatetime=(select getdate()),gys_id = '" + s_gys_id + "', "
                                    + "��Ӧ��='" + gys_name + "',��ҳ='" + homepage + "',�绰='" + tel + "',����='" + fax + "',��ϵ��='" + user_name + "', "
                                    + "��ϵ���ֻ�='" + user_phone + "',��λ����='" + gys_type + "',��֯�������='" + zzjg_number + "',��ϵ��ַ='" + lx_addrass + "',"
                                    + "��Ӫ��Χ='" + scope + "',��������='" + area + "',�������='�����' where yh_id='" + s_yh_id + "' ";
                                    int ret = objConn.ExecuteSQLForCount(sSQL, true);
                                    Response.Write("�ù�Ӧ���Ѿ��ɹ���������,�ҷ�������Ա��ʵ�����Ϣ��,�������������ڸ�����,�����ĵȺ�!");
                                }
                                else
                                {
                                    objConn.MsgBox(this.Page, "��Ӧ��id�����ڣ����������죡");
                                }
                             }  
                        }
                        if (count != 0)
                        {
                            Response.Write("����������һ����������,�����ټ�������!");
                            return;
                        }
                else
                {
                    //��������Ĺ�Ӧ��id ��ѯ��Ӧ����Ϣ ���µ���Ӧ���������
                    if (s_gys_id != "")
                    {
                        sSQL = "select ��Ӧ��,��ҳ,��ַ,�绰,����,dq_id,��ϵ��,��ϵ���ֻ�,��ϵ��QQ,��λ����,��֯�������,��λ���, "
                        + "��������,����������,ע���ʽ�,��ϵ��ַ,�ʱ�,��������,��Ӫ��Χ,ʡ�е������,��ҵ��� from ���Ϲ�Ӧ����Ϣ�� where "
                        + "gys_id='" + s_gys_id + "' ";
                        DataTable dt_gysxx = objConn.GetDataTable(sSQL);
                        string gys_name = Convert.ToString(dt_gysxx.Rows[0]["��Ӧ��"]);
                        string homepage = Convert.ToString(dt_gysxx.Rows[0]["��ҳ"]);
                        string tel = Convert.ToString(dt_gysxx.Rows[0]["�绰"]);
                        string fax = Convert.ToString(dt_gysxx.Rows[0]["����"]);
                        string user_name = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��"]);
                        string user_phone = Convert.ToString(dt_gysxx.Rows[0]["��ϵ���ֻ�"]);
                        string gys_type = Convert.ToString(dt_gysxx.Rows[0]["��λ����"]);
                        string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["��֯�������"]);
                        string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��ַ"]);
                        string scope = Convert.ToString(dt_gysxx.Rows[0]["��Ӫ��Χ"]);
                        string area = Convert.ToString(dt_gysxx.Rows[0]["��������"]);

                        sSQL = "insert into ��Ӧ�����������(yh_id,updatetime,gys_id,��Ӧ��,��ҳ,�绰,����,��ϵ��,��ϵ���ֻ�,��λ����,��֯�������,��ϵ��ַ,��Ӫ��Χ,��������,�������)"+
                        " values('" + s_yh_id + "',select getdate(), '" + s_gys_id + "','" + gys_name + "','" + homepage +
                         "','" + tel + "','" + fax + "','" + user_name + "','" + user_phone + "','" + gys_type + "','" + zzjg_number +
                          "','" + lx_addrass + "','" + scope + "','" + area + "','�����')";
                        int ret = objConn.ExecuteSQLForCount(sSQL, true);
                        Response.Write("�ù�Ӧ���Ѿ��ɹ���������,�ҷ�������Ա��ʵ�����Ϣ��,�������������ڸ�����,�����ĵȺ�!");
  
              
            }
        }
        else
        {
            Response.Write("��ǰ�û�id������,�����µ�½��");
        }

    }
    </script>

