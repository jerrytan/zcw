<!--
          
       ��Ӧ����������ҳ��	   
       �ļ�����czclym.aspx 
       �������:��	   
	   
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��������ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //����ajax������,������


    function updateFL(id) {

        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }

    


</script>


<script runat="server">  
        
    public List<OptionItem> Items1 { get; set; }
    public List<OptionItem> Items2 { get; set; }
    public class OptionItem
    {
        public string Name { get; set; }  //�����б���ʾ������
        public string GroupsCode { get; set; }  //�����б�����������
        public string SelectedString { get; set; }
        public string Value { get; set; }

    }
    protected DataTable dt = new DataTable();  //���Ϸ������
    protected DataTable dt1 = new DataTable();  //���Ϸ���С��
    protected DataTable dt2 = new DataTable();  //Ҫѡ���Ʒ������(Ʒ���ֵ�)
    protected void Page_Load(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
        SqlDataAdapter da = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "���Ϸ����");
        dt = ds.Tables[0];

        string type = Request["id"];   //��ȡ���ഩ�����ķ������
        SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+type+"' and len(�������)='4'", conn);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1, "���Ϸ����");
        dt1 = ds1.Tables[0];

        string gys_id = Request["gys_id"];
        SqlDataAdapter da2 = new SqlDataAdapter("select Ʒ������ from Ʒ���ֵ� where scs_id='" + gys_id + "' ", conn);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2, "���Ϸ����");
        dt2 = ds2.Tables[0];


        this.Items1 = new List<OptionItem>();  //���ݱ�DataTableת����  
        this.Items2 = new List<OptionItem>();
        for (int x = 0; x < dt.Rows.Count; x++)
        {
            DataRow dr = dt.Rows[x];

            if (Convert.ToString(dr["�������"]).Length == 2)
            {
                OptionItem item = new OptionItem();
                item.Name = Convert.ToString(dr["��ʾ����"]);
                item.GroupsCode = Convert.ToString(dr["�������"]);
                this.Items1.Add(item);   //��������뼯��
            }
        }

        for (int x = 0; x < dt1.Rows.Count; x++)
        {
            DataRow dr = dt1.Rows[x];
            if (Convert.ToString(dr["�������"]).Length == 4)
            {
                OptionItem item1 = new OptionItem();
                item1.Name = Convert.ToString(dr["��ʾ����"]);
                item1.GroupsCode = Convert.ToString(dr["�������"]);
                this.Items2.Add(item1);
            }
        }




        if (Request.Form["clname"] != null)
        {
            conn.Open();
            //string code = Request.QueryString["code"]; //��ȡ������� �Ѳ�����Ϣ����Ӧ�ķ��������뵽���ϱ���
            string clname = Request.Form["clname"];  //��������
            string brand = Request.Form["brand"];    //Ʒ������
            string cltype = Request.Form["cltype"];          //����ͺ�
            string measure = Request.Form["measure"];        //������λ
            string volumetric = Request.Form["volumetric"];  //��λ���
            string instruction = Request.Form["instruction"];  //˵�� 
            string ejflname = Request.Form["ejflname"];        //�������� 				

            string sql1 = " insert into ���ϱ�(��ʾ��,Ʒ������,����ͺ�,������λ,��λ���,˵��,�Ƿ�����,��������,updatetime)values('" + clname + "','" + brand + "','" + cltype + "','" + measure + "','" + volumetric + "','" + instruction + "',1,'" + ejflname + "','getdate()') ";
            SqlCommand cmd3 = new SqlCommand(sql1, conn);
            int ret1 = (int)cmd3.ExecuteNonQuery();
            string sql2 = " update ���ϱ� set gys_id='61' where gys_id is null ";   //������
            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            int ret = (int)cmd2.ExecuteNonQuery();
            conn.Close();

        }

    }				
 
</script>

<body>

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <div class="fxsxx">
        <span class="fxsxx1">��ѡ����Ҫ��ӵĲ�����Ϣ</span>
        <%string gys_id = Request["gys_id"];%>
        <form action="xzclym.aspx?gys_id=<%=gys_id%>" method="get">

            <div class="xz1">
                <div class="xza">



                    <span class="xz2"><a href="#">����</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                        <% foreach(var v  in Items1){%>
                        <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>
                <div class="xza">
                    <span class="xz2"><a href="#">С��</a></span>
                    <select id="drop" name="drop" class="fux">
                        <% foreach(var v  in Items2){%>
                        <option value="<%=v.Name%>&<%=v.GroupsCode%>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>


                <div class="xzz">
                    <span class="xzz0">���û���ʺϵ�С�࣬����ϵ��վ����Ա���ӣ� ��ϵ��ʽ��xxx@xxx.com.��ʹ��ģ�塣 </span>
                    <span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
                </div>
            </div>

            <div class="fxsxx2">
                <span class="srcl">�����������Ϣ</span>
                <dl>
                    <dd>�������֣�</dd>
                    <dt>
                        <input name="clname" type="text" class="fxsxx3" value="<%=Request.Form["clname"] %>" /></dt>

                    <dd>Ʒ    �ƣ�</dd>
                    <dt>
                        <select name="brand" style="width: 300px">
                            <%foreach(System.Data.DataRow row in dt2.Rows){%>
                            <option value="<%=row["Ʒ������"].ToString() %>"><%=row["Ʒ������"].ToString()%></option>
                            <%}%>
                        </select></dt>

                    <dd>�ͺţ�</dd>
                    <dt>
                        <input name="cltype" type="text" class="fxsxx3" value="<%=Request.Form["cltype"] %>" /></dt>
                    <dd>���ó�����</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" value="<%=Request.Form["gysid"] %>" /></dt>
                    <dd>������λ��</dd>
                    <dt>
                        <input name="bit" type="text" class="fxsxx3" value="<%=Request.Form["bit"] %>" /></dt>
                    <dd>��λ�����</dd>
                    <dt>
                        <input name="volumetric" type="text" class="fxsxx3" value="<%=Request.Form["volumetric"] %>" /></dt>
                    <dd>˵����</dd>
                    <dt>
                        <input name="instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></dt>
                </dl>
            </div>


            <!--
<div class="cpdt">
   <dl>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>
-->


            <div class="cpdt">
                <span class="dmt">��ý����Ϣ</span>
                <dl>
                    <dd>��Ʒ��Ƶ��</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>�ɹ�������</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>�������ϣ�</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                </dl>

                <span class="fxsbc"><a href="#">
                    <input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg"></a></span>

            </div>
        </form>
    </div>
    </div>





    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->





</body>
</html>
