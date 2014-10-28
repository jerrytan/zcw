<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections.Generic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title></title>
</head>

<script runat="server">

    public List<Option_gys> Items { get; set; }

    public class Option_gys
    {//����
        public string gys_name { get; set; }       //��Ӧ��
        public string gys_address { get; set; }    //��ַ
        public string gys_tel { get; set; }        //�绰
        public string gys_homepage { get; set; }   //��ҳ
        public string gys_fax { get; set; }        //����
        public string gys_area { get; set; }       //��������
        public string gys_user { get; set; }       //��ϵ��
        public string gys_user_phone { get; set; }       //��ϵ���ֻ� 
        public string gys_id { get; set; }       //��Ӧ��id		
        public string sh { get; set; } 
    }
    public List<Option_gys1> Items1 { get; set; }
    public class Option_gys1
    {//����
        public string pp_id { get; set; }
        public string ppmc { get; set; }
    }
    protected DataTable dt_gysxx = new DataTable();
    public DataConn objConn = new DataConn();
    public string fxs_id = "";                   //��ȡ�����򴫹����ķ�����id
    public string sSQL = "";
    public string pp_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string lx = "";
            if (Request["id"] != null && Request["id"].ToString() != "")
            {
                fxs_id = Request["id"].ToString();
            }
            if (Request["lx"]!=null&&Request["lx"].ToString()!="")
            {
                lx = Request["lx"].ToString();
            }
            if (lx=="")
            {
              //  sSQL = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,gys_id,fxs_pp.pp_id,fxs_pp.Ʒ������ from ���Ϲ�Ӧ����Ϣ�� cl join  �����̺�Ʒ�ƶ�Ӧ��ϵ�� fxs_pp on cl.gys_id=fxs_pp.fxs_id where gys_id='" + fxs_id + "'";
                    sSQL = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + fxs_id + "' ";

                dt_gysxx = objConn.GetDataTable(sSQL);

                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

                this.Items = new List<Option_gys>();  //���ݱ�DataTableת����  
                if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
                {
                    DataRow dr2 = dt_gysxx.Rows[0];

                    Option_gys item = new Option_gys();

                    item.gys_name = Convert.ToString(dr2["��Ӧ��"]);
                    item.gys_address = Convert.ToString(dr2["��ַ"]);
                    item.gys_tel = Convert.ToString(dr2["�绰"]);
                    item.gys_homepage = Convert.ToString(dr2["��ҳ"]);
                    item.gys_fax = Convert.ToString(dr2["����"]);
                    item.gys_area = Convert.ToString(dr2["��������"]);
                    item.gys_user = Convert.ToString(dr2["��ϵ��"]);
                    item.gys_user_phone = Convert.ToString(dr2["��ϵ���ֻ�"]);
                    item.gys_id = Convert.ToString(dr2["gys_id"]);
                    this.Items.Add(item);
                }
                else
                {
                    sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,gys_id,������� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + fxs_id + "' ";
                    dt_gysxx = objConn.GetDataTable(sSQL);
                    if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
                    {
                        DataRow dr2 = dt_gysxx.Rows[0];

                        Option_gys item = new Option_gys();

                        item.gys_name = Convert.ToString(dr2["��˾����"]);
                        item.gys_address = Convert.ToString(dr2["��˾��ַ"]);
                        item.gys_tel = Convert.ToString(dr2["��˾�绰"]);
                        item.gys_homepage = Convert.ToString(dr2["��˾��ҳ"]);
                        item.gys_fax = Convert.ToString(dr2["��˾����"]);
                        item.gys_area = Convert.ToString(dr2["��˾����"]);
                        item.gys_user = Convert.ToString(dr2["��ϵ������"]);
                        item.gys_user_phone = Convert.ToString(dr2["��ϵ�˵绰"]);
                        item.gys_id = Convert.ToString(dr2["gys_id"]);
                        item.sh = Convert.ToString(dr2["�������"]);
                        this.Items.Add(item);
                    }
                }
                string jsonStr = serializer.Serialize(Items);
                Response.Clear();
                Response.Write(jsonStr);   //��ǰ��glscsxx.aspx���json�ַ���
                Response.End();
            }
            else
            {

                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                this.Items1 = new List<Option_gys1>();  //���ݱ�DataTableת����  
                sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='" + fxs_id + "' order by myID ";
                DataTable dt_ppxx = objConn.GetDataTable(sSQL);
                if (dt_ppxx != null && dt_ppxx.Rows.Count > 0)
                {
                    for (int i = 0; i < dt_ppxx.Rows.Count; i++)
                    {
                        Option_gys1 item1 = new Option_gys1();
                        item1.pp_id = dt_ppxx.Rows[i]["pp_id"].ToString();
                        item1.ppmc = dt_ppxx.Rows[i]["Ʒ������"].ToString();
                        this.Items1.Add(item1);
                    }
                }
                string jsonStr = serializer.Serialize(Items1);
                Response.Clear();
                Response.Write(jsonStr);   //��ǰ��glscsxx.aspx���json�ַ���
                Response.End();
          
            }
            Response.Redirect("glfxsxx.aspx?id=" + fxs_id);        
    }
</script>
</html>
