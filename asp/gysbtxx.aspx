<!--
        ��Ӧ�̲�����Ϣҳ  (δ��)
        �ļ���:  gysbuxx.aspx   
        
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ӧ�̲�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script>
        function formsubmit()
        {
            //alert("shit");
            document.getElementById("gysbtxx").submit();
        }
    </script>
</head>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->
<div class="gytb">
<form action="gysbtxx2.aspx" method="post" id="gysbtxx">
<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>
<dd>��˾���ƣ�</dd>  <dt><input name="gys_name" type="text" class="ggg" /></dt>
<dd>��˾��ַ��</dd>  <dt><input name="gys_address" type="text" class="ggg" /></dt>
<dd>��˾�绰��</dd>  <dt><input name="gys_phone" type="text" class="ggg" /></dt>

<dd>��˾�ǣ�</dd>    <dt><input name="gys_type" type="radio" value="scs" checked>������  <input name="gys_type" type="radio" value="fxs" />������ </dt>

<dd>����������</dd>    <dt><input name="user_name" type="text" class="ggg" /></dt>
<dd>���ĵ绰��</dd>    <dt><input name="user_phone" type="text" class="ggg" /></dt>
<dd>����ְλ��</dd>    <dt><input name="user_title" type="text" class="ggg" /></dt>
<dd>����QQ���룺</dd>  <dt><input name="user_qq" type="text" class="ggg" /></dt>
<dd>��˾��Ӫҵִ�գ� </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>

</dl>
<span class="gybtan">
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a></span></div>
</div>
</form>

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->


</div>


</body>
</html>
