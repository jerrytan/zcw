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
	
	   //�������෢��ajax ���µ���Ʒ�Ƶ����� 
	   
      function updateCLFL(id) 
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
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
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
             string cl_id = Request["cl_id"];   //��ȡ����id               
                 sSQL = "select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'";
                 dt_clfl = objConn.GetDataTable(sSQL);
                 sSQL = "select ��ʾ����,������� from ���Ϸ���� where len(�������)='4'";
                 dt_clflej = objConn.GetDataTable(sSQL);
                 sSQL = "select ��ʾ��,��������,Ʒ������,����ͺ�,������λ,��λ���,��λ����,�������,˵��,pp_id,fl_id,���ϱ��� from ���ϱ� where cl_id='" + cl_id + "' ";
                 dt_clxx = objConn.GetDataTable(sSQL);
                 clbm = Convert.ToString(dt_clxx.Rows[0]["���ϱ���"]);
                 s_clmc = Convert.ToString(dt_clxx.Rows[0]["��ʾ��"]);
                 sSQL = "select Ʒ������,pp_id from Ʒ���ֵ� where left(�������,2)='" + clbm.Substring(0, 2) + "'";

                 dt_pp = objConn.GetDataTable(sSQL);
                 sSQL = "select ������������,��������ֵ from �������Ա� where cl_id='" + cl_id + "' and ���ϱ���='" + clbm + "'";
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
    <span class="fxsxx1">���Ϸ�������:</span>
    <div class="xz1">
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
    <div class="xza">
                    <span class="xz2"><a href="#">С��</a></span>
                    <select id="ejflname" name="ejflname" class="fux"  onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
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
    <div class="xzz">
<!--
<span class="xzz0">���û���ʺϵ�С�࣬����ϵ��վ����Ա���ӣ� ��ϵ��ʽ��xxx@xxx.com.��ʹ��ģ�塣 </span>
-->
<span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
</div>
</div>

    <div class="fxsxx2">
<span class="srcl">������Ϣ����:</span>
 <dl>
                    <dd>�������֣�</dd>
                    <dt>
                        <input name="cl_name"  id="cl_name" type="text" class="fxsxx3" value="<%=s_clmc%>"  /></dt>
                    <dd>Ʒ    �ƣ�</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px" >                            
                            <option value="0">��ѡ��Ʒ��</option>                
                            <%foreach (System.Data.DataRow row in dt_pp.Rows)
                              {%>
                                   <option value="<%=row["pp_id"] %>"><%=row["Ʒ������"] %></option>                
                             <% } %>           
                        </select></dt>
  
                    <dd>�������ƣ�</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" >
						
                            <%foreach (System.Data.DataRow v in dt_clsx.Rows)
                              {%>                                          
                            <option value="0"><%=v["������������"].ToString()%></option>
							<%}%>
						
                        </select></dt>		
						
                    <dd>����ֵ��</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <%foreach (System.Data.DataRow v in dt_clsx.Rows)
                              {%>                                          
                            <option value="0"><%=v["��������ֵ"].ToString()%></option>
							<%}%>
                           
                        </select></dt>
					
						
					<dd>����ͺţ�</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=dt_clxx.Rows[0]["����ͺ�"] %>" /></dt>					
						
                    <dd>������λ��</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["������λ"] %>" /></dt>
                    <dd>��λ�����</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ���"] %>" /></dt>
				    <dd>��λ������</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ����"] %>" /></dt>
                    <dd>˵����</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["˵��"] %>" /></dt>
					<dd>���ۣ�</dd>
					<dt>
						<input name="cl_instruction" type="text" class="fxsxx3" value="" /></dt>
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
       <dd>��ý�����ͣ�</dd>
       <dt>
           <select  id="mtlx" runat="server">
                <option value="0">ѡ��ý������</option>
                <option value="��Ƶ">��Ƶ</option>
                <option value="ͼƬ">ͼƬ</option>
                <option value="�ĵ�">�ĵ�</option>
            </select>
       </dt>
       <dd>���ࣺ</dd>
       <dt>
        <input  id="sysm" name="select" type="radio" value="ʹ��˵��" runat="server" validationgroup="select" />ʹ��˵��  
		    <input id="cgal"  runat="server" name="select"  type="radio" value="�ɹ�����" validationgroup="select" />�ɹ�����
            <input id="ys"  runat="server" name="select"  type="radio" value="��ʾ" validationgroup="select" />��ʾ
            <input id="cptp"  runat="server" name="select"  type="radio" value="��ƷͼƬ" validationgroup="select" />��ƷͼƬ
       </dt>
       <dd>�ϴ��ļ�</dd>
               <dt><input name="" id="file1" type="file" class="fxsxx3"  runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="ImageButton1" OnClick="UploadFile" /></dt>
         <%--<dd>��Ʒ��Ƶ��</dd>
        <dt><input name="" id="filesp" type="file" class="fxsxx3"  runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="UploadSP" OnClick="UploadFile" /></dt>
         <dd>�ɹ�������</dd>
        <dt><input name=""  id="fileAL"  type="file" class="fxsxx3" runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="uploadFileAL" OnClick="UploadFileAL" /></dt>
         <dd>�������ϣ�</dd>
        <dt><input name="" id="More"  runat="server" type="file" class="fxsxx3"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="uploadMore" OnClick="UploadFileMore" /></dt>                       --%>
     </dl>
     <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg"  onclick="SaveAll()"/></a></span>  
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
