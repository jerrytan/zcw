<!--
      ��Ӧ����ҳ�� �������쳧��ҳ�� ����Ӧ�� ���������ҳ�� ��Ӧ�̹������ҳ�� 
	  �ļ���:  gyszym.aspx   
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
   <title>��Ӧ����ҳ��</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->
</div>

<div class="gyzy1">
<span class="zy1">  ��Ϣ�����ҷ�������Աȷ�Ϻ��������������еĹ�Ӧ�̣�or �����µĹ�Ӧ����Ϣ������������²�Ʒ��Ϣ��ͼ1</span>
<span class="zy2"><img src="images/aaa_06.jpg" />ͼ1</span> <span class="zy2"><img src="images/aaa_06.jpg" />ͼ2</span>
</div>


<div class="gyzy2">
      <span class="zyy1"><a href="rlcs.aspx">���쳧��</a></span>
      <span class="zyy1"><a href="glsccsxxym.aspx?gys_id=67">������������Ϣ</a></span>
      <span class="zyy1"><a href="glfxsxx.aspx?gys_id=73">�����������Ϣ</a></span>
      <span class="zyy1"><a href="gysglcl.aspx?gys_id=61 ">���������Ϣ</a></span>      
</div>



<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->





<script type=text/javascript><!--//--><![CDATA[//><!--
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
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
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
