<!--
          
       ��Ӧ����������ҳ��	   
       �ļ�����czclym.aspx 
       �������:gys_id	 
	   author:����ӱ
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��������ҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //һ�����෢��ajax ���µ���С������� �ļ�����:xzclym2.aspx
    function updateFL(id)
    {

        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();

    }


    //�������෢��ajax ���µ���Ʒ�Ƶ����� �Ͳ������Ե�����
    //�ļ�����xzclym3.aspx �� xzclymSX.aspx
    //С�ࣨ�������ࣩ
    function updateCLFL(id) {
        var xmlhttp1;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp1 = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
//        xmlhttp.onreadystatechange = function ()
//        {

//            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//            {

//                document.getElementById("brand").innerHTML = xmlhttp.responseText;

//            }
//        }
//        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
//        xmlhttp.send();


        xmlhttp1.open("GET", "xzclymSX.aspx?id=" + id, true);
        xmlhttp1.send();
        xmlhttp1.onreadystatechange = function ()
        {

            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
            {

                //document.getElementById("sx_name").innerHTML = xmlhttp1.responseText;				


                var array = new Array();           //��������
                array = xmlhttp1.responseText;     //���շ��ص�json�ַ���

                var json = array;
                var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 
                for (var i = 0; i < myobj.length; i++)
                {  //����			

                    var json = document.getElementById('sx_names');
                    json.options.add(new Option(myobj[i].SX_name, myobj[i].SX_id));  //��������ʾ��������

                    var json_code = document.getElementById('sx_codes');     //��������ʾ���Ա���
                    json_code.options.add(new Option(myobj[i].SX_code, myobj[i].SX_code));

                    var json_id = document.getElementById('sx_id');       //��������ʾ����id
                    json_id.options.add(new Option(myobj[i].SX_id, myobj[i].SX_id));
                }
            }
        }
    }




    //��������ajax ���µ�������ֵ �ļ�����:xzclymSX2.aspx
    //���µ��ǹ���ͺ� �ļ�����:xzclymSX3.aspx  (����ͺ�Ӧ�����ı���ź���)
    function update_clsx(id)
    {

        var xmlhttp1;
        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
            xmlhttp1 = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }

        xmlhttp.open("GET", "xzclymSX2.aspx?id=" + id, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function ()
        {

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {

                //document.getElementById("cl_value").innerHTML = xmlhttp.responseText;

                var array = new Array();           //��������
                array = xmlhttp.responseText;     //�����滻���ص�json�ַ���

                var json = array;
                var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			


                for (var i = 0; i < myobj.length; i++)
                {  //����			
                    var json = document.getElementById('cl_value');
                    json.options.add(new Option(myobj[i].SXZ_name, myobj[i].SXZ_name));  //��������ʾ����ֵ

                    var json_code = document.getElementById('cl_number');     //��������ʾ���Ա��
                    json_code.options.add(new Option(myobj[i].SXZ_code, myobj[i].SXZ_code));

                    var json_id = document.getElementById('cl_ids');       //��������ʾ����ֵid
                    json_id.options.add(new Option(myobj[i].SXZ_id, myobj[i].SXZ_id));
                }
            }
        }

        xmlhttp1.open("GET", "xzclymSX3.aspx?id=" + id, true);
        xmlhttp1.send();
        xmlhttp1.onreadystatechange = function ()
        {
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
            {
                var ggxh_value = xmlhttp1.responseText;

                document.getElementById("cl_type").value = ggxh_value;
            }
        }

    }
    function AddNewBrand(id)
    {
        var url;
        var type = '<%=lx%>';
        if (type == "������")
        {
            url = "xzpp.aspx?gys_id=" + id;
        }
        else
        {
            url = "xzfxpp.aspx?gys_id=" + id;
        }
        window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function onload() {
        var ej_name = document.getElementById("ej_name").value;
        if (ej_name != "" && ej_name != undefined) {
            updateCLFL(ej_name);
        }
    }
</script>


<script runat="server">  
        
    public List<OptionItem> Items1 { get; set; }    
    public class OptionItem
    {
        public string Name { get; set; }  //�����б���ʾ������
        public string GroupsCode { get; set; }  //�����б�����������
      

    }
    protected DataTable dt_clfl = new DataTable();  //���Ϸ������    
    public DataConn objConn=new DataConn();
    public string gys_id = "";
    protected string sSQL = "";
    protected DataTable dt_pp = new DataTable();
    protected string lx = "";
    public string clbm = "";
    public string s_clmc = "";
    public string ejcl = "";
    public string yicl = "";
    protected DataTable dt_clxx = new DataTable();//���ϱ�
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
        {
            gys_id = Request["gys_id"].ToString();
        }
        if (gys_id != "")
        {
            sSQL = "select ��λ���� from ���Ϲ�Ӧ����Ϣ�� where gys_id='" + gys_id + "'";
            lx = objConn.DBLook(sSQL);
        }

        if (lx == "������")
        {
            sSQL = "select Ʒ������,pp_id from Ʒ���ֵ� where scs_id='" + gys_id + "'";
            dt_pp = objConn.GetDataTable(sSQL);
        }
        else
        {
            sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where fxs_id='" + gys_id + "'";
            dt_pp = objConn.GetDataTable(sSQL);
        }
        s_clmc = Request["ej"];
        if (s_clmc =="")
        {
            this.yjfl.Visible = false;
            this.ejfl.Visible = false;
            this.xl.Visible = true;
            this.dl.Visible = true;
            sSQL = "select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'";
            dt_clfl = objConn.GetDataTable(sSQL);
            this.Items1 = new List<OptionItem>();  //���ݱ�DataTableת����  

            for (int x = 0; x < dt_clfl.Rows.Count; x++)
            {
                DataRow dr = dt_clfl.Rows[x];

                if (Convert.ToString(dr["�������"]).Length == 2)
                {
                    OptionItem item = new OptionItem();
                    item.Name = Convert.ToString(dr["��ʾ����"]);
                    item.GroupsCode = Convert.ToString(dr["�������"]);
                    this.Items1.Add(item);   //��������뼯��
                }
            }
        }
        else
        {
            sSQL = "select ��ʾ���� from ���Ϸ���� where �������='" + s_clmc + "'";
            dt_clfl = objConn.GetDataTable(sSQL);
            ejcl=dt_clfl.Rows[0]["��ʾ����"].ToString();
            string yi = s_clmc.Substring(0, 2);
            sSQL = "select ��ʾ���� from ���Ϸ���� where �������='" + yi + "'";
            dt_clfl = objConn.GetDataTable(sSQL);
            yicl=dt_clfl.Rows[0]["��ʾ����"].ToString();
            this.yjfl.Visible = true;
            this.ejfl.Visible = true;
            this.xl.Visible = false;
            this.dl.Visible = false;
        }
    }
   
</script>

<body onload="onload()">

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <div class="fxsxx">
        <span class="fxsxx1">��ѡ����Ҫ��ӵĲ�����Ϣ</span>
        <%string gys_id = Request["gys_id"];%>
        <input id="ej_name" value="<%=s_clmc %>"  type="hidden" />
  <form name="form1" action = "xzclym4.aspx?ejcl=<%=s_clmc%>&gys_id=<%=gys_id %>" method = "post">
  <table width="998" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;���Ϸ�������:</td>
    </tr>
    <tr>
      <td width="100" height="70"></td>
      <td width="180" colspan="2">
      <div  runat="server" id="yjfl">һ�����ϣ�
      <input disabled value="<%=yicl %>" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
      </div>
<div class="xza" runat="server" id="dl">
                    <span class="xz2"><a href="#">����</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                <% foreach(var v  in Items1)
                    {%>
                <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                <%}%>      
                    </select>
                </div>
      </td>
      <td width="180" colspan="2" align="right">
      <div runat="server" id="ejfl">�������ϣ�
      <input  readonly="readonly" value="<%=ejcl %>" type="text" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
      </div>
      <div class="xza" runat="server" id="xl">
                    <span class="xz2"><a href="#">С��</a></span>
                    <select id="ejflname" name="ejflname" class="fux" onchange="updateCLFL(this.options[this.options.selectedIndex].value)"> 
                        <option value="0">��ѡ��С��</option>
                    </select>
                </div>
      </td>
      <td width="490">
      <span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
      </td>
    </tr>
  </table> 
            <%--����2014��8��19�գ���divԭ����ʽ��fxsxx2����Ϊ��gysgybtr��--%>
            <div class="gysgybtr">
                <span class="fxsxx1">�����������Ϣ</span>
                <table width="998" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
      <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;������Ϣ����:</td>
    </tr>
    <tr>
      <td height="20" colspan="6"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td width="120">�������֣�</td>
      <td width="329"><label for="textfield"></label>
        <input name="cl_name" type="text" class="fxsxx3" value="<%=Request.Form["cl_name"] %>" /></td>
      <td width="50" align="right"></td>
      <td width="120">Ʒ    �ƣ�</td>
      <td width="329"><select name="brand"  style="width: 300px">
        <option value="0">��ѡ��Ʒ��</option>
        <%if (dt_pp.Rows.Count > 0)
          {
              foreach (System.Data.DataRow row in dt_pp.Rows)
              {%>
            <option value="<%=row["pp_id"].ToString() %>"><%=row["Ʒ������"].ToString()%></option>
            <% }
          }%>
      </select>
      <%if (dt_pp.Rows.Count == 0)
        {
            if (lx == "������")
            {%>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">�����·���Ʒ��</a></span>
        <%}
            else
            { %>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">������Ʒ��</a></span>
        <%}
        }%>
      </td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>�������ƣ�</td>
      <td><select name="sx_names" id="sx_names" style="width: 300px" onchange="update_clsx(this.options[this.options.selectedIndex].value)">
        <option value="0">��ѡ����������</option>
      </select></td>
      <td>&nbsp;</td>
      <td>���Ա��룺</td>
      <td><select name="sx_codes" id="sx_codes" style="width: 300px">
        <option value="0">��ѡ�����Ա���</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>����id��</td>
      <td><select name="sx_id" id="sx_id" style="width: 300px">
        <option value="0">����id</option>
      </select></td>
      <td>&nbsp;</td>
      <td>����ֵ��</td>
      <td><select name="cl_value" id="cl_value" style="width: 300px">
        <option value="0">��ѡ������ֵ</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>����ֵ��ţ�</td>
      <td><select name="cl_number" id="cl_number" style="width: 300px">
        <option value="0">���</option>
      </select></td>
      <td>&nbsp;</td>
      <td>����ֵID�ţ�</td>
      <td><select name="cl_ids" id="cl_ids" style="width: 300px">
        <option value="0">����ֵid</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>����ͺţ�</td>
      <td><label for="textfield21">
        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=Request.Form["cl_type"] %>" onclick="return cl_type_onclick()" />
      </label></td>
      <td>&nbsp;</td>
      <td>������λ��</td>
      <td><input name="cl_bit" id="cl_bit" type="text" class="fxsxx3" value="<%=Request.Form["cl_bit"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��λ�����</td>
      <td><input name="cl_volumetric"  type="text" class="fxsxx3"  value="<%=Request.Form["cl_volumetric"] %>" /></td>
      <td>&nbsp;</td>
      <td>��λ������</td>
      <td><input name="cl_height" type="text" class="fxsxx3" value="<%=Request.Form["cl_height"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>˵����</td>
      <td><input name="cl_instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
        <tr>
      <td height="20" colspan="6"></td>
    </tr>
</table>
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


<div class="cpdt" style="border:0px">
 <span class="fxsbc"><a href="#" style="padding-left:120px">
 <input type="image" name="Submit" value="Submit" src="images/queding.jpg"/></a></span>
 <span class="fxsbc"><a href="" style="padding-left:280px" >
 <input type="image" name="quxiao" value="quxiao" src="images/quxiao.jpg" /></a>
 </span>
</div>

</form>
    </div>
 

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

</body>
</html>
