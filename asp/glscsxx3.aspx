<!--
          �ļ���:glscsxx3.aspx
		  ������� scs_id
          author:����ӱ
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
		   protected DataTable dt_scsxx = new DataTable();	
           public DataConn objConn=new DataConn();
           public string sSQL="";
		   protected void Page_Load(object sender, EventArgs e)
           {
            string scs_id ="";
           if( Request["id"]!=null&& Request["id"].ToString()!="")
           {
              scs_id = Request["id"];   //��ȡ�����򴫹����ķ�����id
            }
            sSQL = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+scs_id+"' ";
         
            dt_scsxx =objConn.GetDataTable(sSQL);
			
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			this.Items = new List<Option_gys>();  //���ݱ�DataTableת����  
            if (dt_scsxx!=null&&dt_scsxx.Rows.Count>0)
            {
                for (int x = 0; x < dt_scsxx.Rows.Count; x++)
                {
                    DataRow dr2 = dt_scsxx.Rows[x];

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
            }
            else
            {
                sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,gys_id,������� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + scs_id + "' ";
                dt_scsxx = null;
                dt_scsxx = objConn.GetDataTable(sSQL);
                if (dt_scsxx != null && dt_scsxx.Rows.Count > 0)
                {
                    DataRow dr2 = dt_scsxx.Rows[0];

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

</script>
</html>