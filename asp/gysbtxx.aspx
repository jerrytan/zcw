<!--
        供应商补填信息页  (未做)
        文件名:  gysbuxx.aspx   
        
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
<title>供应商补填信息页</title>
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

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->
<div class="gytb">
<form action="gysbtxx2.aspx" method="post" id="gysbtxx">
<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>
<dd>贵公司名称：</dd>  <dt><input name="gys_name" type="text" class="ggg" /></dt>
<dd>贵公司地址：</dd>  <dt><input name="gys_address" type="text" class="ggg" /></dt>
<dd>贵公司电话：</dd>  <dt><input name="gys_phone" type="text" class="ggg" /></dt>

<dd>贵公司是：</dd>    <dt><input name="gys_type" type="radio" value="scs" checked>生产商  <input name="gys_type" type="radio" value="fxs" />分销商 </dt>

<dd>您的姓名：</dd>    <dt><input name="user_name" type="text" class="ggg" /></dt>
<dd>您的电话：</dd>    <dt><input name="user_phone" type="text" class="ggg" /></dt>
<dd>您的职位：</dd>    <dt><input name="user_title" type="text" class="ggg" /></dt>
<dd>您的QQ号码：</dd>  <dt><input name="user_qq" type="text" class="ggg" /></dt>
<dd>贵公司的营业执照： </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>

</dl>
<span class="gybtan">
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a></span></div>
</div>
</form>

<div>
<!-- 关于我们 广告服务 投诉建议 开始-->
<!-- #include file="static/aboutus.aspx" -->
<!-- 关于我们 广告服务 投诉建议 结束-->
</div>

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->


</div>


</body>
</html>
