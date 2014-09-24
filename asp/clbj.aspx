<!--
             ���ϱ༭ҳ��
             �ļ���:  clbj.aspx 
			 �������: cl_id
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
<title>���ϱ༭ҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //һ�����෢��ajax ���µ���С������� �ļ�����:xzclym2.aspx
    function updateFL(id) 
	{
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }

    //�������෢��ajax ���µ���Ʒ�Ƶ����� �Ͳ������Ե�����
    //�ļ�����xzclym3.aspx �� xzclymSX.aspx
    function updateCLFL(id)
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

                document.getElementById("brand").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();

        var xmlhttp1;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp1 = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp1.open("GET", "xzclymSX.aspx?id=" + id, true);
        xmlhttp1.send();
        xmlhttp1.onreadystatechange = function ()
        {

            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
            {
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
    function SaveAll()
    {
        document.getElementById("form1").action = "xzclym4.aspx?ym=clbj";
        document.getElementById("form1").method = "post";
        document.getElementById("form1").submit();
    }
</script>	
<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix()
    {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++)
        {
            sfEls[i].onmouseover = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function ()
            {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
<script type="text/javascript">
    var speed = 9//�ٶ���ֵԽ���ٶ�Խ��
    var demo = document.getElementById("demo");
    var demo2 = document.getElementById("demo2");
    var demo1 = document.getElementById("demo1");
    demo2.innerHTML = demo1.innerHTML
    function Marquee()
    {
        if (demo2.offsetWidth - demo.scrollLeft <= 0)
            demo.scrollLeft -= demo1.offsetWidth
        else
        {
            demo.scrollLeft++
        }
    }
    var MyMar = setInterval(Marquee, speed)
    demo.onmouseover = function () { clearInterval(MyMar) }
    demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
</script>
<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix()
    {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++)
        {
            sfEls[i].onmouseover = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function ()
            {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
<script runat="server">  
         protected DataTable dt_clfl = new DataTable();  //���Ϸ������   
         protected DataTable dt_clflej = new DataTable();  //���Ϸ������   
         protected DataTable dt_clxx = new DataTable();    //������Ϣ
         protected DataTable dt_clsx = new DataTable();    //������������,����ֵ(�������Ա�)	 
         protected DataConn objConn = new DataConn();
         protected DataTable dt_pp = new DataTable();                 //Ʒ������
         public string sSQL = "";
         public string s_clmc = "";
         public string clbm = "";
         public string fl_id = "";
   
         protected void Page_Load(object sender, EventArgs e)
         {
             string cl_mc = Request["cl_mc"].ToString();   //��ȡ��������              
                 sSQL = "select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'";
                 dt_clfl = objConn.GetDataTable(sSQL);
                 sSQL = "select ��ʾ����,������� from ���Ϸ���� where len(�������)='4'";
                 dt_clflej = objConn.GetDataTable(sSQL);
                 sSQL = "select ��ʾ��,��������,Ʒ������,����ͺ�,������λ,��λ���,��λ����,�������,˵��,pp_id,fl_id,���ϱ��� from ���ϱ� where ��ʾ��='" + cl_mc + "' ";
                 dt_clxx = objConn.GetDataTable(sSQL);
                 clbm = Convert.ToString(dt_clxx.Rows[0]["���ϱ���"]);
                 s_clmc = Convert.ToString(dt_clxx.Rows[0]["��ʾ��"]);
                 sSQL = "select Ʒ������,pp_id from Ʒ���ֵ� where left(�������,2)='" + clbm.Substring(0, 2) + "'";

                 dt_pp = objConn.GetDataTable(sSQL);
                 sSQL = "select ������������,��������ֵ from �������Ա� where ��������='" + cl_mc + "' and ���ϱ���='" + clbm + "'";
                 dt_clsx = objConn.GetDataTable(sSQL);
             
         }
         protected void UploadFile(object sender, EventArgs e)
         {
             if (file1.PostedFile.FileName.ToString().Trim() == "")
             {
                 objConn.MsgBox(this.Page, "����ѡ���ϴ��ļ���");
                 return;
             }
            string FilePath = Server.MapPath("temp\\");
             FilePath = FilePath + "Vedio\\";
             if (!System.IO.Directory.Exists(FilePath))
             {
                 System.IO.Directory.CreateDirectory(FilePath);
             }
             string name = "";
             name = System.IO.Path.GetFileName(this.file1.PostedFile.FileName.Trim());
             if (System.IO.File.Exists(FilePath+name))
             {
                 try
                 {
                     System.IO.File.Delete(FilePath + name);
                 }
                 catch (Exception)
                 {
                 }
                
             }
             file1.PostedFile.SaveAs(FilePath+name);
             if (System.IO.File.Exists(FilePath + name))
             {
                 string ip = "";
                 ip = Page.Request.Url.ToString().Trim();
                 int iPos;
                 ip = ip.Replace("http://", "");
                 ip = ip.Replace("HTTP://", "");
                 iPos = ip.IndexOf("/");
                 if (iPos != -1)
                 {
                     ip = ip.Substring(0, iPos);
                 }
                
                 string strVD = Request.ApplicationPath.ToString().Trim().Substring(1);
                 int intPos;
                 intPos = FilePath.LastIndexOf("\\");
                 if (intPos < 0)
                     intPos = FilePath.LastIndexOf("/");
                 FilePath = FilePath.Substring(intPos + 1);
                 FilePath = strVD + "/" + FilePath + "/" + name;
                 FilePath = "http://" + ip + "/" + FilePath;
                 
                 
                 
                 
                 
                 
                 string s_mtlx = "";   //ý������
                 string s_fl = "";
                 s_mtlx = mtlx.Value;
                 if (this.sysm.Checked)
                 {
                     s_fl = "ʹ��˵��";
                 }
                 else if (this.cgal.Checked)
                 {
                     s_fl = "�ɹ�����";
                 }
                 else if (this.ys.Checked)
                 {
                     s_fl = "��ʾ";
                 }
                 else if (this.cptp.Checked)
                 {
                     s_fl = "��ƷͼƬ";
                 }
                 sSQL = "insert into ���϶�ý����Ϣ��(cl_id,���ϱ���,��������,�Ƿ�����,ý������,����,��ŵ�ַ) values(" +
               "'" + Convert.ToString(Request["cl_id"]) + "','" + clbm + "','" + s_clmc + "','1','" +
               s_mtlx + "','" + s_fl + "','" + FilePath + "')";
                 Response.Write("<script>window.alert('" + sSQL + "')</" + "script>");
                 bool b = objConn.ExecuteSQL(sSQL, true);
                 if (b)
                 {
                     Response.Write("<script>window.alert('�ϴ��ɹ���')</" + "script>");
                 }
                 else
                 {
                     Response.Write("<script>window.alert('���浽���ݿ���ʧ�ܣ��������ϴ���')</" + "script>");
                 }
                
             }
             else
             {
                 Response.Write("<script>window.alert('�ϴ�ʧ�ܣ�')</" + "script>");
             }           
         }
 
         protected bool CheckFileType(string FileName)
         {
             bool b = false;
             System.IO.FileStream fs = new System.IO.FileStream(FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
             System.IO.BinaryReader reader = new System.IO.BinaryReader(fs);
             byte[] buff = new byte[2];
             string result = string.Empty;
             try
             {
                 fs.Read(buff, 0, 2);
                 result = buff[0].ToString() + buff[1].ToString();
             }
             catch (Exception ex)
             {
             }            
             reader.Close();
             fs.Close();
             if (result=="4838"||result=="7368"||result=="6787")
             {
                 b = true;
             }
             return b;
        }

        
</script>
<body>

 <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
 <!-- ͷ������-->

<div>
 <form runat="server" id="form1">
 <div class="fxsxx">
    <table width="998" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;���Ϸ�������:</td>
    </tr>
    <tr>
      <td width="100" height="70"></td>
      <td width="180" colspan="2">
<div class="xza">

                    <span class="xz2"><a href="#">����</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                     <option value="0">��ѡ�����</option>
                       <% foreach (System.Data.DataRow v in dt_clfl.Rows)
                           {
                                   if (v["�������"].ToString() == dt_clxx.Rows[0]["���ϱ���"].ToString().Substring(0, 2))
                                   {%>
                                        <option value="<%=v["�������"].ToString() %>" selected="selected"><%=v["��ʾ����"].ToString()%></option>
                                 <%}
                                   else
                                   { %>
                                   <option value="<%=v["�������"].ToString() %>"><%=v["��ʾ����"].ToString()%></option>
                                  <%}
                         }%>
                    </select>
                </div>
      </td>
      <td width="180" colspan="2" align="right">
      <div class="xza">
                    <span class="xz2"><a href="#">С��</a></span>
                    <select id="ejflname" name="ejflname" class="fux" onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
                        <%for (int i = 0; i < dt_clflej.Rows.Count; i++)
                          {
                              if (dt_clflej.Rows[i]["�������"].ToString()==dt_clxx.Rows[0]["���ϱ���"].ToString().Substring(0,4))
                              {%>
                                   <option value="<%=dt_clflej.Rows[i]["�������"].ToString() %>" selected="selected"><%=dt_clflej.Rows[i]["��ʾ����"].ToString()%></option>
                              <%}
                          } %>
                        <option value="0">��ѡ��С��</option>
                    
                    </select>
                </div>
      </td>
      <td width="490">
      <span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
      </td>
    </tr>
  </table> 
    <%--����2014��8��19�գ��������div��ʽΪ��gysgybtr��--%>

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
        <input name="cl_name" id="cl_name" type="text" class="fxsxx3" value="<%=s_clmc%>" disabled /></td>
      <td width="50" align="right"></td>
      <td width="120">Ʒ    �ƣ�</td>
      <td width="329"><select name="brand" id="brand" style="width: 300px">
        <option value="0">��ѡ��Ʒ��</option>
        <%foreach (System.Data.DataRow row in dt_pp.Rows)
        {%>
            <option value="<%=row["pp_id"] %>"><%=row["Ʒ������"] %></option>                
        <% } %>
      </select></td>
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
        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=dt_clxx.Rows[0]["����ͺ�"] %>" disabled  />
      </label></td>
      <td>&nbsp;</td>
      <td>������λ��</td>
      <td><input name="cl_bit" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["������λ"] %>"  disabled /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��λ�����</td>
      <td><input name="cl_volumetric" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ���"] %>" disabled  /></td>
      <td>&nbsp;</td>
      <td>��λ������</td>
      <td><input name="cl_height" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ����"] %>" disabled /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>˵����</td>
      <td><input name="cl_instruction" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["˵��"] %>" disabled  /></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
        <tr>
      <td height="20" colspan="6"></td>
    </tr>
</table>

<div class="cpdt">
    <span class="dmt">&nbsp;&nbsp;��ý����Ϣ</span>
    <div class="dmt2">
    <dl>
       <dd>��ý�����ͣ�</dd>
       <dt><select runat="server" id="mtlx">
	<option value="0">ѡ��ý������</option>
	<option value="��Ƶ">��Ƶ</option>
	<option value="ͼƬ">ͼƬ</option>
	<option value="�ĵ�">�ĵ�</option>
</select>
       </dt>
       <dd>���ࣺ</dd>
       <dt>
        <input runat="server" value="ʹ��˵��" name="select" type="radio" id="sysm" validationgroup="select"/>ʹ��˵��  
		    <input runat="server" value="�ɹ�����" name="select" type="radio" id="cgal" validationgroup="select"/>�ɹ�����
            <input runat="server" value="��ʾ" name="select" type="radio" id="ys" validationgroup="select"/>��ʾ
            <input runat="server" value="��ƷͼƬ" name="select" type="radio" id="cptp" validationgroup="select"/>��ƷͼƬ
       </dt>
       <dd>�ϴ��ļ���</dd>
               <dt><input name="file1" runat="server" type="file" id="file1" class="fxsxx3"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="ImageButton1" OnClick="UploadFile" /></dt>
     </dl>
     <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" onclick="SaveAll()"/></a></span>  
</div>
</div>

 </form>
 </div>
<div class="foot">
<span class="foot2"><a href="#">��վ����</a>  |<a href="#"> ���ݼල</a> | <a href="#"> ������ѯ</a> |  <a href="#">Ͷ�߽���010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012�ڲ�����Ȩ����      ��ICP֤0000111��      ����������110101000005��</p>
<p>��ַ�������к��������Ŵ���11��  ��ϵ�绰��010-87654321    ����֧�֣���������</p></span>
</div>
</body>
</html>
