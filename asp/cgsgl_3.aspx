<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ɹ�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <div class="box">
    <!-- ͷ����ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ������-->
    <!-- ������ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ��������-->
    <!-- banner��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner ����-->
        <script runat="server">
        </script>
<div class="dlqq">
    <div class="dlex">
        <div class="dlex2">
            <span class="dlex3">������Ϣ���£���������뵥�����İ�ť</span>
            <dl>
                <dd>��˾���ƣ�</dd>
                <dt><input name="companyname" type="text" value="test" class="fxsxx3"/></dt>
                <dd>��˾��ַ��</dd>
                <dt><input name="companyaddress" type="text" class="fxsxx3" /></dt>
                <dd>��˾�绰��</dd>
                <dt><input name="companytel" type="text" class="fxsxx3" /></dt>
                <dd>����������</dd>
                <dt><input name="contactorname" type="text" class="fxsxx3" /></dt>
                <dd>���ĵ绰��</dd>
                <dt><input name="contactortel" type="text" class="fxsxx3" /></dt>
                <dd>����QQ�ţ�</dd>
                <dt><input name="contactqqid" type="text" class="fxsxx3" /></dt>
                <dd>����ִ�գ�</dd>
                <dt><img src="images/qqqq_03.jpg" /></dt>
                <dd>�������ʣ�</dd>
                <dt><img src="images/qqqq_03.jpg" /></dt>

            </dl>
            <span class="gg"><a href="#"><img src="images/12ff_03.jpg" /></a></span>
        </div>
    </div>
    </div>

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->
    
</div>

    <script type=text/javascript>
<!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
    <script type="text/javascript">
        var speed = 9//�ٶ���ֵԽ���ٶ�Խ��
        var demo = document.getElementById("demo");
        var demo2 = document.getElementById("demo2");
        var demo1 = document.getElementById("demo1");
        demo2.innerHTML = demo1.innerHTML
        function Marquee() {
            if (demo2.offsetWidth - demo.scrollLeft <= 0)
                demo.scrollLeft -= demo1.offsetWidth
            else {
                demo.scrollLeft++
            }
        }
        var MyMar = setInterval(Marquee, speed)
        demo.onmouseover = function () { clearInterval(MyMar) }
        demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
    </script>
    <script type=text/javascript>
<!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
</body>
</html>
