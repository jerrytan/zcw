<!--      
	   �����������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glfxsxx.aspx 
       ���������s_yh_id  �û�id  session
       author:����ӱ  
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>�����������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #homepage
        {
            margin-bottom: 0px;
        }
        #homepage0
        {
            margin-bottom: 0px;
        }
        .style11
        {
            width: 111px;
        }
        .style12
        {
            width: 108px;
        }
        .style13
        {
            width: 104px;
        }
        .style14
        {
            width: 107px;
        }
    </style>
</head>

<script type="text/javascript" language="javascript">
    function Update_CS(id, pp_name) {
        document.getElementById("pp_name").value = pp_name;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("fxsxx").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "glfxsxx4.aspx?id=" + id + "&lx=pp", true);
        xmlhttp.send();
    }
    function Update_gys(id) {
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var array = new Array();           //��������
                array = xmlhttp.responseText;     //�����滻���ص�json�ַ���
                var json = array;
                var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			
                if (myobj.length == 0) {
                    document.getElementById('companyname').value = "";       //��Ӧ��
                    document.getElementById('address').value = "";        //��ַ
                    document.getElementById('tel').value = "";                //�绰  			 
                    document.getElementById('homepage').value = "";       //��ҳ
                    document.getElementById('fax').value = "";                 //����
                    document.getElementById('area').value = "";               //��������
                    document.getElementById('name').value = "";               //��ϵ��
                    document.getElementById('phone').value = "";        //��ϵ�˵绰 
                    document.getElementById('sh').style.visibility = "hidden";
                    if (id != "0") {
                        if (confirm("�÷�������δ��д��ϸ��Ϣ,�Ƿ��")) {
                            window.location.href = "grxx.aspx?gys_id=" + id + "&lx=fxs";
                        }
                    }
                }
                for (var i = 0; i < myobj.length; i++) {  //����,��ajax���ص�������䵽�ı�����				

                    document.getElementById('companyname').value = myobj[i].gys_name;       //��Ӧ��
                    document.getElementById('address').value = myobj[i].gys_address;        //��ַ
                    document.getElementById('tel').value = myobj[i].gys_tel;                //�绰  			 
                    document.getElementById('homepage').value = myobj[i].gys_homepage;       //��ҳ
                    document.getElementById('fax').value = myobj[i].gys_fax;                 //����
                    document.getElementById('area').value = myobj[i].gys_area;               //��������
                    document.getElementById('name').value = myobj[i].gys_user;               //��ϵ��
                    document.getElementById('phone').value = myobj[i].gys_user_phone;        //��ϵ�˵绰 	
                    if (myobj[i].sh == "�����") {
                        document.getElementById('sh').style.visibility = "visible";
                    }
                    else {
                        document.getElementById('sh').style.visibility = "hidden";
                    }
                }

            }
        }
        xmlhttp.open("GET", "glfxsxx3.aspx?id=" + id, true);
        xmlhttp.send();

        if (window.XMLHttpRequest) {
            xmlhttp1 = new XMLHttpRequest();
        }
        else {
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp1.onreadystatechange = function () {
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                var array1 = new Array();           //��������
                array1 = xmlhttp1.responseText;     //�����滻���ص�json�ַ���
                var json1 = array1;
                var myobj1 = eval(json1);              //�����ص�JSON�ַ���ת��JavaScript���� 	
                var s = "";
                for (var j = 0; j < myobj1.length; j++) {  //����,��ajax���ص�������䵽�ı�����				

                    s += " <div class='fgstp'><image src='images/wwwq_03.jpg'/>";
                    s += "  <span class='fdlpp1'>";
                    s += " <a href='ppxx.aspx?pp_id=" + myobj1[j].pp_id + "' class='fxsfxk'>" + myobj1[j].ppmc + "</a></span></div>";
                }
                document.getElementById("ppxx").innerHTML = s;
            }
        }
        xmlhttp1.open("GET", "glfxsxx3.aspx?id=" + id + "&lx=ppxx", true);
        xmlhttp1.send();
    }
    function AddNewBrand(id) {
        var url;
        var type = '<%=s_gys_type%>';
        if (type == "������") {
            url = "xzpp.aspx?gys_id=" + id;
        }
        else {
            url = "xzfxpp.aspx?gys_id=" + id;
        }
        window.open(url, "", "height=400,width=500,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function DeleteBrand(id) {
        var lx = '<%=s_gys_type %>';
        var r = confirm("��ȷ������ȡ��������Ʒ��!");
        if (r == true) {
            var brands = document.getElementsByName("brand");
            var ppid;
            ppid = "";
            for (var i = 0; i < brands.length; i++) {
                if (brands[i].checked) {
                    ppid += brands[i].value + ",";
                    //                    brand_str = brand_str + "," + brands[i].value;
                }

            }
            var url;
            if (lx == "������") {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=1";
            }
            else {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=2";
            }
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
    }

    function Update_gysxx() {
        alert("�����µ���Ϣ���ύ,�ȴ����,�뷵��!");
    }

    function tel_onclick() {

    }

    function scs_onclick() {

    }

    function companyname_onclick() {

    }
    function Trim(str) {
        str = str.replace(/^(\s|\u00A0)+/, '');
        for (var i = str.length - 1; i >= 0; i--) {
            if (/\S/.test(str.charAt(i))) {
                str = str.substring(0, i + 1);
                break;
            }
        }
        return str;
    }
    function Add(obj) {
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        var cl_mc = Trim(tds[1].innerHTML);
        document.getElementById("cl_mc").value = cl_mc;
    }
    function CZ_P(obj,pp_mc,pp_id)
    {
        var h = obj.parentNode.parentNode;
        var a = h.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.color = "#707070";
        }
        obj.style.color = "#4876FF";
        var g;
        g = document.getElementById("lblgys_id").value;
        document.getElementById("frame1").src = "glfxsxx_2.aspx?gys_id=" + g + "&pp_mc=" + pp_mc+"&pp_id="+pp_id; 
    }
</script>
	
<script runat="server">
    protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
    protected DataTable dt_ppxx = new DataTable();  //Ʒ����Ϣ(Ʒ���ֵ�)
    public string gys_id="";
    public string s_yh_id="";   //�û�id
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    public string sp_result = "";        //�������������������
    public string s_gys_type = "";         //��λ����
    public DataTable dt_pp_id = new DataTable();
    public string[] pplb;
    public DataTable dt_fxs;//��������Ʒ�ƶ�Ӧ��ϵ��
    public DataTable dt_DLPP=null;
    public string ppid = "";
    public string pp_mc="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        gys_id = Request["gys_id"].ToString();
        this.lblgys_id.Value = gys_id;
        sSQL = "select ��λ���� from ���Ϲ�Ӧ����Ϣ�� where gys_id='"+gys_id+"'";
        DataTable dt_type = objConn.GetDataTable(sSQL);
        if (dt_type != null && dt_type.Rows.Count > 0)
        {
            s_gys_type = dt_type.Rows[0]["��λ����"].ToString();
        }
        if (s_gys_type == "������")
        {
            sSQL = "select pp_id,Ʒ������ from Ʒ���ֵ� where isnull(�Ƿ�����,'')='1' and scs_id='" + gys_id + "' order by scs_id "; //��ѯƷ��id
            dt_pp_id = objConn.GetDataTable(sSQL);
            if (dt_pp_id != null && dt_pp_id.Rows.Count > 0)
            {
                pplb=new string[dt_pp_id.Rows.Count];
                ppid = dt_pp_id.Rows[0]["pp_id"].ToString(); //��ȡƷ��id
                pp_mc = dt_pp_id.Rows[0]["Ʒ������"].ToString();
            }
            sSQL = "select fxs_id,������ from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + ppid + "' ";//��ѯ������id
            dt_fxs = objConn.GetDataTable(sSQL);
            string str_fxsid = "";
            if (dt_fxs!=null&&dt_fxs.Rows.Count>0)
            {
                str_fxsid = dt_fxs.Rows[0]["fxs_id"].ToString();
            }
            //���ݲ�ͬ�ķ�����id ��ѯ��ͬ�ķ�������Ϣ
            sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,ע������,ע���ʽ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + str_fxsid + "' order by gys_id ";
            dt_gysxx = objConn.GetDataTable(sSQL);

            sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='" + str_fxsid + "'  order by fxs_id ";
            dt_ppxx = objConn.GetDataTable(sSQL);
        }
        if (s_gys_type.Equals("������"))
        {
            //����Ƿ�������Ϣ ֱ�Ӹ���yh_id ��ѯ��Ӧ����Ϣ 
            //����26��
            //sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='" + s_yh_id + "' ";
            sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ from ���Ϲ�Ӧ����Ϣ�� where gys_id='" + gys_id+ "' ";
            dt_gysxx = objConn.GetDataTable(sSQL);
            sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='" + gys_id + "' order by myID ";
            dt_ppxx = objConn.GetDataTable(sSQL);
            if (dt_gysxx.Rows.Count == 0)
            {
                Response.Redirect("grxx.aspx");
            }
        }

             //��ȡglfxsxx2ҳ�淵�صĹ�Ӧ��id
            string id = "";
        //����2014��8��27�ո��������������idΪgys_id
            if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
            {
                id = Request["gys_id"].ToString();//324
            }   
            #region
            if (id != "")
            {              
                DWLX(s_gys_type, id, gys_id);
            }
             #endregion

    }
    public void DWLX(string str_gysid_type, string id, string str_gysid)
    {
        #region
        str_gysid = id;
        if (str_gysid_type.Equals("������"))
        {
            sSQL = "select pp_id,Ʒ������ from Ʒ���ֵ� where isnull(�Ƿ�����,'')='1' and scs_id='" + str_gysid + "' order by myID "; //��ѯƷ��id		
            string str_ppid="";
             dt_pp_id = objConn.GetDataTable(sSQL);
            if(dt_pp_id!=null&&dt_pp_id.Rows.Count>0)
            {
                str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id	
            }
            sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "    //139
            + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')";
            int count = objConn.ExecuteSQLForCount(sSQL, false);
            if (count != 0)
            {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                sSQL = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "  //139
                + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')";
                 //string gysid ="";
                DataTable dt_select = objConn.GetDataTable(sSQL);
                if(dt_select!=null&&dt_select.Rows.Count>0)
                {
                     sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
                    //����2014��8��27��
                     //gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
                }
                //spjg(gysid, gysid);����2014��8��27��
                spjg(gys_id, gys_id);
                
            }
        }
        #endregion
        #region
        else  if (str_gysid_type.Equals("������"))
        {
            sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + str_gysid + "' ";
            Object obj_check_gys_exist = objConn.DBLook(sSQL);
           
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)
                {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������df
                    sSQL = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + str_gysid + "' ";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
                    string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139����2014��8��27��
                    //����2014��8��27��
                    spjg(gysid, gysid);
                    //spjg(gys_id, gys_id);
                }
            
        }
        #endregion
        #region
        else
        {
            sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "' ";
            Object obj_check_gys_exist = objConn.DBLook(sSQL);
            if (obj_check_gys_exist != null)
            {
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)
                {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                    sSQL = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "' ";

                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);
                    spjg(gys_id, id);
                }
            }
        }
        #endregion
    }
    public void spjg(string gysid,string id)
    {
        if (sp_result != "")
        {
            if (sp_result.Equals("ͨ��"))
            {

                //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                sSQL = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),"
                + "��ϵ��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),"
                + "��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),"
                + "��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'),"
                + "��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "') where gys_id ='" + id + "'";
                int ret = objConn.ExecuteSQLForCount(sSQL, false);

                sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);
                //this.lblfile.Text = "��ϲ��!���޸ĵ������Ѿ�����,����!";
                //Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
            }
            else if (sp_result.Equals("��ͨ��"))
            {
                sSQL = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='" + gys_id + "' ";
                int ret = objConn.ExecuteSQLForCount(sSQL, true);

                Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
            }
            else if (sp_result.Equals("�����"))
            {
                //�޸��ύ�� ҳ������ʾ���� ��Ӧ���Լ��޸Ĵ���˱� ����Ϣ
                sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
                + "��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id ='" + id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);
                //this.lblfile.Text = "��˵���";
            }
        }

    }
    protected void CY_Click(object sender, EventArgs e)
    {
        this.gg.Visible = true;
        
    }
    protected void AddCL(object sender, EventArgs e)
    {
        Response.Redirect("xzgxs.aspx"); 
    } 

</script>

<body>
	  <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
    <form id="Form1" runat="server" name="update_fxs" action="glfxsxx2.aspx?gys_id=<%=gys_id %>" method="post">
    <input type="hidden" id="lblgys_id" runat="server" /> 
     <%if (s_gys_type.Equals("������"))
       {%>
        <div class="dlqqz5"  style="border:1px solid #ddd; padding-top:10px; margin: 10px 0 0 0;">
    <div class="dlqqz2">
      <div id="menu">
        <div class="dlqqz1">����Ʒ���б�</div>
        <h2 id="h2">
        <ul>
        <%foreach (System.Data.DataRow PP_MC in dt_pp_id.Rows)
          {%>
        <li><a href="javascript:void(0)" onclick="CZ_P(this,'<%=PP_MC["Ʒ������"].ToString() %>','<%=PP_MC["pp_id"].ToString() %>')"><img src="images/biao2.jpg" />&nbsp;&nbsp;<%=PP_MC["Ʒ������"].ToString()%></a></li>
         <%} %></ul></h2>
      </div>
 <div id="cgs_lb" style="width:795px; margin-left:182px;">
<div id="divtable" runat="server">
      <iframe id="frame1" src="glfxsxx_2.aspx?gys_id=<%=gys_id %>" frameborder="0" marginheight="0"  style=" width:100%; height:450px; padding:0px; margin:0px; border:0px; " > 
    </iframe> 
     </div>
     </div>
    </div>
  </div>
         <%} %> 
          <%-- //��������ݵĲ���Ȩ��--%>
     <%  else
       { %>
             <div class="gysgybtr">
            <% if (sp_result == "�����")
                { %>
				   <table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;��˾����Ϣ���������</td>
    </tr>
    <tr>
      <td height="20" colspan="6" align="right"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td class="style11">��˾���ƣ�</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" id="companyname" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" onclick="return companyname_onclick()" /></td>
      <td width="50" align="right"></td>
      <td class="style12">��˾��ַ��</td>
      <td width="329"><input name="address" type="text" id="address" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��˾�绰��</td>
      <td><input name="tel" type="text" id="tel" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/></td>
      <td>&nbsp;</td>
      <td class="style12">��˾��ҳ��</td>
      <td><input name="homepage" type="text" id="homepage" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��˾���棺</td>
      <td><input name="fax" type="text" id="fax" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">��˾������</td>
      <td><input name="area" type="text" id="area" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��ϵ��������</td>
      <td><input name="name" type="text" id="name" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">��ϵ�˵绰��</td>
      <td><input name="phone" type="text" id="phone" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td class="style11">���鷶Χ��</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
         <input name="Business_Scope" readonly style="height:70px; width:795px;" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></td>
    </tr>
  </table>
  </div>
			<%}
                else
                { %>
				<div runat="server" id="gg"><table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;��˾������Ϣ����:</td>
    </tr>
    <tr>
      <td height="20" colspan="6" align="right"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td class="style13">��˾���ƣ�</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" readonly id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></td>
      <td width="50" align="right"></td>
      <td class="style14">��˾��ַ��</td>
      <td width="329"><input name="address" type="text" readonly id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">��˾�绰��</td>
      <td><input name="tel" type="text" id="tel" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["�绰"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">��˾��ҳ��</td>
      <td><input name="homepage" type="text" id="homepage" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">��˾���棺</td>
      <td><input name="fax" type="text" id="fax" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["����"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">��˾������</td>
      <td><input name="area" type="text" id="area" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��������"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">��ϵ��������</td>
      <td><input name="name" type="text" id="name" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">��ϵ�˵绰��</td>
      <td><input name="phone" type="text" id="phone" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td class="style13">���鷶Χ��</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
        <input name="Business_Scope" readonly style="height:70px; width:795px;" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></td>
    </tr>
  </table></div>
			<%}    %>

                   <%-- <div class="fxsxx2">             
                    <span class="fxsbc" >
                            <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                            <asp:Label runat="server" ID="lblfile"  ForeColor="red" Width="200px" Text=""></asp:Label>
                            <input type="submit" class="fxsbc2" value="����" onclick="Update_gysxx()" style="cursor:pointer;" />
                   </span>
                    </div>--%>
                    <div class="ggspp" runat="server" id="ggspp">
                        <div style="font-size:14px; font-weight:bold; line-height:36px; float:left; width:100%; background-color:#f7f7f7;">&nbsp;&nbsp;��˾���������Ʒ������</div>
                                <%foreach (System.Data.DataRow row in dt_ppxx.Rows)
                                  {%>
                                   <div class="fgstp">
                                        <img src="images/wwwq_03.jpg" />
                                        <span class="fdlpp1">
                                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                                            <%=row["Ʒ������"].ToString() %>
                                        </span>
                                    </div>
                                 <%} %>     
                    </div>	
             <span class="fxsbc1"><a onclick="DeleteBrand(<%=gys_id %>)" style="cursor:pointer;">ȡ��ѡ��Ʒ��</a></span>
             <span class="fxsbc1"><a onclick="AddNewBrand(<%=gys_id %>)" style="cursor:pointer;">������Ʒ��</a></span>
     <%} %>   
      </form>
     <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  
</body>
</html>



