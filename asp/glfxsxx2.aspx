<!--  
	    �����������Ϣҳ��   �����̿��ԶԴ����Լ�Ʒ�Ƶķ�������Ϣ���й��� �޸ı���
        �ļ�����glfxsxx2.aspx
        ���������gys_id    
		author:����ӱ
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script runat="server"  >

   
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string s_gys_id = "";     //��ȡ���ύ�����ķ�����id 
        string s_yh_id = "";
        if ( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
        {       
            s_gys_id=Request.QueryString["gys_id"].ToString();
        }
        if (Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();//��ȡ�û�id
        }

        string companyname = Request.Form["companyname"];   //��˾����
        string address = Request.Form["address"];            //��ַ
        string tel = Request.Form["tel"];               //�绰
        string homepage = Request.Form["homepage"];     //��ҳ
        string area = Request.Form["area"];                    //���� 
        string fax = Request.Form["fax"];
        string description = Request.Form["description"];  //��˾���
        string name = Request.Form["name"];                //��ϵ��
        string phone = Request.Form["phone"];              //��ϵ���ֻ�
        string Business_Scope = Request.Form["Business_Scope"];   //��Ӫ��Χ

        if (s_gys_id != "")
        {
            string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + s_gys_id + "' ";

            Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);
 
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count == 0)
                {
                    string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('" + s_gys_id + "')";
                    objConn.ExecuteSQL(str_insert, false);                 
                }
                string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='" + companyname + "',��˾��ַ='" + address + "',"
                + "��˾�绰='" + tel + "',��˾��ҳ='" + homepage + "',��˾����='" + area + "',��˾����='" + fax + "',�Ƿ�����='1',"
                + "��ϵ������='" + name + "',��ϵ�˵绰='" + phone + "',��λ����='������',��Ӫ��Χ='" + Business_Scope + "',"
                + "�������='�����',updatetime=(select getdate()) where gys_id='" + s_gys_id + "' ";
                objConn.ExecuteSQL(str_update, true);
 
        }
        else
        {
            //����û�"û��"���glfxsxx.aspx ������ ���޸ķ�������Ϣ,��ô��ִ�����´���,�����޸�
            <%--//String yh_id = Convert.ToString(Session["GYS_YH_ID"]);   //��ȡ�û�id  76  ��ȡ���û�id�п�����������--%>

            <%--string str_gys_id = "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='" + s_yh_id + "' ";//��ѯ��Ӧ��id	127--%>		
            string str_gys_id = "select ��λ���� from ���Ϲ�Ӧ����Ϣ�� where gys_id='" + s_gys_id + "' ";
            DataTable dt_gys_id = objConn.GetDataTable(str_gys_id);
            string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //��ȡ��Ӧ��id  127
            string str_gys_type = Convert.ToString(dt_gys_id.Rows[0]["��λ����"]);
            if (str_gys_type.Equals("������"))
            {
               string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + str_gysid + "' ";
                
         
                Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);

                if (obj_check_gys_exist != null)
                {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)
                    {
                        string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('" + str_gysid + "')";

                        objConn.ExecuteSQL(str_insert, false);
                    }
                    string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='" + companyname + "',��˾��ַ='" + address + "',"
                    + "��˾�绰='" + tel + "',��˾��ҳ='" + homepage + "',��˾����='" + area + "',��˾����='" + fax + "',�Ƿ�����='1',"
                    + "��ϵ������='" + name + "',��ϵ�˵绰='" + phone + "',��λ����='������',��Ӫ��Χ='" + Business_Scope + "',"
                    + "�������='�����',updatetime=(select getdate()) where gys_id='" + s_gys_id + "'";

                    objConn.ExecuteSQL(str_update, true);
                }
            }
            if (str_gys_type.Equals("������"))
            {
                string str_pp_id = "select pp_id from Ʒ���ֵ� where scs_id='" + s_gys_id + "' "; //��ѯƷ��id		

                DataTable dt_pp_id = objConn.GetDataTable(str_pp_id);
                string str_ppid = "";       //��ȡƷ��id
                if (dt_pp_id!=null&&dt_pp_id.Rows.Count>0)
                {
                    str_pp_id = dt_pp_id.Rows[0]["pp_id"].ToString();
                }
              
                string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "
                + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')"; //�м���������,���м���fxs_id,ȡ��һ��  139

                Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);

                if (obj_check_gys_exist != null)
                {

                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)
                    {
                        string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� "
                        + "where pp_id='" + str_ppid + "'";
                        objConn.ExecuteSQL(str_insert, false);
                    }
                    string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='" + companyname + "',��˾��ַ='" + address + "',"
                    + "��˾�绰='" + tel + "',��˾��ҳ='" + homepage + "',��˾����='" + area + "',��˾����='" + fax + "',�Ƿ�����='1',"
                    + "��ϵ������='" + name + "',��ϵ�˵绰='" + phone + "',��λ����='������',��Ӫ��Χ='" + Business_Scope + "',"
                    + "�������='�����',updatetime=(select getdate()) where gys_id in"
                    + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')";
                    objConn.ExecuteSQL(str_update, true);
                }
            }
        }
        Response.Redirect("glfxsxx.aspx?gys_id=" + s_gys_id + "");   ////��ȡ���ύ�����ķ�����id ���ص�glfxsxx.aspxҳ

    }
</script>

</html>