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




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�����������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/javascript" language="javascript">

    function Update_CS(id)
    {
        if (window.XMLHttpRequest)
        {
            xmlhttp = new XMLHttpRequest();
        }
        else
        {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {
                document.getElementById("fxsxx").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "glfxsxx4.aspx?id=" + id+"&lx=pp", true);
        xmlhttp.send();
    }
    function Update_gys(id)
    {
        document.getElementById("ck_fgxsxx").href = "gysxx.aspx?gys_id=" + id;
        if (window.XMLHttpRequest)
        {
            xmlhttp = new XMLHttpRequest();
        }
        else
        {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {
                var array = new Array();           //��������
                array = xmlhttp.responseText;     //�����滻���ص�json�ַ���

                var json = array;
                var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			

                if (myobj.length == 0)
                {
                    document.getElementById('companyname').value = "";       //��Ӧ��
                    document.getElementById('address').value = "";        //��ַ
                    document.getElementById('tel').value = "";                //�绰  			 
                    document.getElementById('homepage').value = "";       //��ҳ
                    document.getElementById('fax').value = "";                 //����
                    document.getElementById('area').value = "";               //��������
                    document.getElementById('name').value = "";               //��ϵ��
                    document.getElementById('phone').value = "";        //��ϵ�˵绰 
                    document.getElementById('sh').style.visibility = "hidden";
                    if (confirm("�÷�������δ��д��ϸ��Ϣ,�Ƿ��"))
                    {
                        window.location.href = "btgysxx.aspx?gxs_id=" + id + "&lx=fxs";
                    }
                }
                for (var i = 0; i < myobj.length; i++)
                {  //����,��ajax���ص�������䵽�ı�����				

                    document.getElementById('companyname').value = myobj[i].gys_name;       //��Ӧ��
                    document.getElementById('address').value = myobj[i].gys_address;        //��ַ
                    document.getElementById('tel').value = myobj[i].gys_tel;                //�绰  			 
                    document.getElementById('homepage').value = myobj[i].gys_homepage;       //��ҳ
                    document.getElementById('fax').value = myobj[i].gys_fax;                 //����
                    document.getElementById('area').value = myobj[i].gys_area;               //��������
                    document.getElementById('name').value = myobj[i].gys_user;               //��ϵ��
                    document.getElementById('phone').value = myobj[i].gys_user_phone;        //��ϵ�˵绰 	
                    if (myobj[i].sh == "�����")
                    {
                        document.getElementById('sh').style.visibility = "visible";
                    }
                    else
                    {
                        document.getElementById('sh').style.visibility = "hidden";
                    }
                }

            }
        }
        xmlhttp.open("GET", "glfxsxx3.aspx?id=" + id, true);
        xmlhttp.send();
    }
    function AddNewBrand(id)
    {
        var url;
        var type = '<%=s_gys_type%>';
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
    function DeleteBrand(id)
    {
        var lx = '<%=s_gys_type %>';
        var r = confirm("��ȷ������ȡ��������Ʒ��!");
        if (r == true)
        {
            var brands = document.getElementsByName("brand");
            var ppid;
            ppid = "";
            for (var i = 0; i < brands.length; i++)
            {
                if (brands[i].checked)
                {
                    ppid += brands[i].value + ",";
                    //                    brand_str = brand_str + "," + brands[i].value;
                }

            }
            var url;
            if (lx == "������")
            {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=1";
            }
            else
            {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=2";
            }
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
    }

    function Update_gysxx()
    {
        alert("�����µ���Ϣ���ύ,�ȴ����,�뷵��!");
    }

</script>
	
<script runat="server">
    protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
    protected DataTable dt_ppxx = new DataTable();  //Ʒ����Ϣ(Ʒ���ֵ�)
    protected DataTable dt_gys_name = new DataTable();  //�����б�Ӧ�̵�����(���Ϲ�Ӧ����Ϣ��)
    public string gys_id="";
    public string s_yh_id="";   //�û�id
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    public string sp_result = "";        //�������������������
    public string s_gys_type = "";         //��λ����
    public DataTable dt_pp_id = new DataTable();
    public DataTable dt_fxs;
    public DataTable dt_DLPP=null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
            sSQL = "select ��λ���� ,gys_id from  ���Ϲ�Ӧ����Ϣ�� where yh_id='" + s_yh_id + "' ";  //��ѯ��λ����
            DataTable dt_type = objConn.GetDataTable(sSQL);
            if (dt_type != null && dt_type.Rows.Count > 0)
            {
                s_gys_type = dt_type.Rows[0]["��λ����"].ToString();
                gys_id = dt_type.Rows[0]["gys_id"].ToString();
            }
            if (s_gys_type == "������")
            {
                string ppid="";
                sSQL = "select pp_id,Ʒ������ from Ʒ���ֵ� where scs_id='" + gys_id + "' order by scs_id "; //��ѯƷ��id		
                dt_pp_id = objConn.GetDataTable(sSQL);
                if (dt_pp_id != null && dt_pp_id.Rows.Count > 0)
                {
                    ppid = dt_pp_id.Rows[0]["pp_id"].ToString();         //��ȡƷ��id
                }

                sSQL = "select fxs_id,������ from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + ppid + "' "; //��ѯ������id	
                dt_fxs = objConn.GetDataTable(sSQL);
                string str_fxsid = "";
                if (dt_fxs!=null&&dt_fxs.Rows.Count>0)
                {
                    str_fxsid = dt_fxs.Rows[0]["fxs_id"].ToString();
                }
                //���ݲ�ͬ�ķ�����id ��ѯ��ͬ�ķ�������Ϣ
                sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + str_fxsid + "' order by gys_id ";
                dt_gysxx = objConn.GetDataTable(sSQL);

                sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='" + str_fxsid + "'  order by fxs_id ";
                dt_ppxx = objConn.GetDataTable(sSQL);
            }
            if (s_gys_type.Equals("������"))
            {
                //����Ƿ�������Ϣ ֱ�Ӹ���yh_id ��ѯ��Ӧ����Ϣ 
                sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='" + s_yh_id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);
                if(dt_gysxx!=null&&dt_gysxx.Rows.Count>0)
                {
                    gys_id = Convert.ToString(dt_gysxx.Rows[0]["gys_id"]);
                }
                sSQL = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='" + gys_id + "' order by myID ";
                dt_ppxx = objConn.GetDataTable(sSQL);
                if (dt_gysxx.Rows.Count == 0)
                {
                    Response.Redirect("gysbtxx.aspx");
                }
            }



        
             //��ȡglfxsxx2ҳ�淵�صĹ�Ӧ��id
            string id = "";
            if(Request["id"]!=null&& Request["id"].ToString()!="")
            {
                id=Request["id"].ToString();
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
        if (str_gysid_type.Equals("������"))
        {
            sSQL = "select pp_id from Ʒ���ֵ� where scs_id='" + str_gysid + "' order by myID "; //��ѯƷ��id		
            string str_ppid="";
             dt_pp_id = objConn.GetDataTable(sSQL);
            if(dt_pp_id!=null&&dt_pp_id.Rows.Count>0)
            {
                str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id	185
            }

            sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "    //139
            + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')";
            int count = objConn.ExecuteSQLForCount(sSQL, false);
            if (count != 0)
            {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                sSQL = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "  //139
                + "(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + str_ppid + "')";
                 string gysid ="";
                DataTable dt_select = objConn.GetDataTable(sSQL);
                if(dt_select!=null&&dt_select.Rows.Count>0)
                {
                     sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
                     gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
                }               
                spjg(gysid, gysid);
            }
        }
        #endregion
        #region
        else  if (str_gysid_type.Equals("������"))
        {
            sSQL = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + str_gysid + "' ";

            Object obj_check_gys_exist = objConn.DBLook(sSQL);
            if (obj_check_gys_exist != null)
            {
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)
                {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                    sSQL = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + str_gysid + "' ";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
                    string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
                    spjg(gysid, gysid);
                }
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
                + "��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),"
                + "��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),"
                + "��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'),"
                + "��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='" + id + "') where gys_id ='" + id + "'";
                int ret = objConn.ExecuteSQLForCount(sSQL, false);

                sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);

                Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
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

                Response.Write("��˵���!");
            }
        }

    }
   
</script>

<body>
<!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
	
 <div class="fxsxx">

    <form id="Form1" name="update_fxs" action="glfxsxx2.aspx" method="post" runat="server">
     <%if (s_gys_type.Equals("������"))
       {%>
             <div class="zjgxs">
             <span>��˾Ʒ�ƣ�</span><br />
			    <select name="scs" id="scs" class="fug" style="width:200px" onchange="Update_CS(this.options[this.options.selectedIndex].value)">
			     <% foreach (System.Data.DataRow row_fxs in dt_pp_id.Rows)
                  { %>			
			         <option value='<%=row_fxs["pp_id"].ToString()%>'><%=row_fxs["Ʒ������"].ToString()%></option>
	            <% }%>			
			    </select> 			
			</div>
           <br />
           <br />
            <div class="zjgxs">
            <span>Ʒ�ƴ����̣�</span><br />
			    <select name="fxsxx" id="fxsxx" class="fug" style="width:200px" onchange="Update_gys(this.options[this.options.selectedIndex].value)">			
                </select> 
			    <span class="zjgxs1"><a href="xzgxs.aspx?xzlx=fxs">�����µķ�����</a></span>
			</div>
             <span class="fxsxx1">�÷����̵���Ϣ����:</span>
             <div class="fxsxx2">
             <% if (dt_gysxx.Rows.Count > 0)
               {
                   if (sp_result == "�����")
                   {  %>
                    <span class="fxsxx1">�÷����̵���Ϣ���������</span>
				       <dl>
					<dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
					<dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>" /></dt>
					<dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>" /></dt>
					<dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></dt>
					<dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
					<dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
					<dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></dt>
					<dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></dt>
					<dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
				</dl>
				 <%}
                   else
                   { %>
					  <dl>
					  <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></dt>
					  <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>" /></dt>
					  <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>" /></dt>
					  <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></dt>
					  <dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>" /></dt>
					  <dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>" /></dt>
					  <dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></dt>
					  <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></dt>
					  <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
					</dl>
				 <%}
               }
               else
               { %>
                <span class="fxsxx1" id="sh" style=" visibility:hidden">�÷����̵���Ϣ���������</span>
                   <dl>
					  <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" /></dt>
					  <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" /></dt>
					  <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3"/></dt>
					  <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3"  /></dt>
					  <dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3"  /></dt>
					  <dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" /></dt>
					  <dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3"  /></dt>
					  <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3"  /></dt>
					  <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3"/></dt>
					</dl>
               <%} %>	
               </div>
               <div class="fxsxx2">             
                        <span class="fxsbc" >
                            <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                            <input type="submit"  onclick="Update_gysxx()"  value="����"/>
                            <span class="zjgxs1"> <a id="ck_fgxsxx">�鿴��������ҳ</a></span>
                        </span>
                 </div>
                <span class="fxsxx1"></span>	
     <%}
       else
       { %>
             <span class="fxsxx1">��˾����ϸ��Ϣ����:</span>	
             <div class="fxsxx2">
            <% if (sp_result == "�����")
                {  %>
				    <dl>
                    <span class="fxsxx1">��˾����Ϣ���������</span>	
				<dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
				<dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>" /></dt>
				<dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>" /></dt>
				<dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></dt>
				<dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
				<dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
				<dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></dt>
				<dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></dt>
				<dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
			</dl>
			<%}
                else
                { %>
					<dl>
					<dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></dt>
					<dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>" /></dt>
					<dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>" /></dt>
					<dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></dt>
					<dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>" /></dt>
					<dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>" /></dt>
					<dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></dt>
					<dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></dt>
					<dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
				</dl>
			<%}%>
            </div>
                    <div class="fxsxx2">             
                        <span class="fxsbc">
                            <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                            <input type="submit" value="����" onclick="Update_gysxx()" />
                        </span>
                    </div>
                 	<span class="fxsxx1"></span>
                    <div class="ggspp">
                        <span class="ggspp1">��˾�������Ʒ������</span> 
                        <div class="fgstp">
                                <img src="images/wwwq_03.jpg" />
                                <span class="fdlpp1">
                                <%foreach (System.Data.DataRow row in dt_ppxx.Rows)
                                  {%>
                                      <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                                      <a  id="brandname" ><%=row["Ʒ������"].ToString() %></a>
                                 <%} %>
                                </span>
                         </div>      
                    </div>	
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand(<%=gys_id %>)">ȡ��ѡ�еķ���Ʒ��</a></span>             
             <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">�����·���Ʒ��</a></span>
     <%} %>
     </form>
     </div>
	 <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����--> 
</body>
</html>



