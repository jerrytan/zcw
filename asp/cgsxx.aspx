<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

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
<title>�ɹ�����Ϣҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<style>
#menu { width:200px; margin:auto;}
 #menu h1 { font-size:12px;margin-top:1px; font-weight:100}
 #menu h2 { padding-left:15px; font-size:12px; font-weight:100}
 #menu ul { padding-left:15px; height:100px;overflow:auto; font-weight:100}
 #menu a { display:block; padding:5px 0 3px 10px; text-decoration:none; overflow:hidden;}
 #menu a:hover{ color:#000;}
 #menu .no {display:none;}
 #menu .h1 a{color:#000;}
 #menu .h2 a{color:#000;}
 #menu  h1 a{color:#000;}
</style>
<script language="JavaScript">
<!--//
function ShowMenu(obj,n){
 var Nav = obj.parentNode;
 if(!Nav.id){
  var BName = Nav.getElementsByTagName("ul");
  var HName = Nav.getElementsByTagName("h2");
  var t = 2;
 }else{
  var BName = document.getElementById(Nav.id).getElementsByTagName("span");
  var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
  var t = 1;
 }
 for(var i=0; i<HName.length;i++){
  HName[i].innerHTML = HName[i].innerHTML.replace("-","+");
  HName[i].className = "";
 }
 obj.className = "h" + t;
 for(var i=0; i<BName.length; i++){if(i!=n){BName[i].className = "no";}}
 if(BName[n].className == "no"){
  BName[n].className = "";
  obj.innerHTML = obj.innerHTML.replace("+","-");
 }else{
  BName[n].className = "no";
  obj.className = "";
  obj.innerHTML = obj.innerHTML.replace("-","+");
 }
}
//-->
</script>
</head>

<body>

<<!-- ͷ����ʼ-->
<!-- #include file="static/header.aspx" -->
<!-- ͷ������-->


<!-- ������ʼ-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- ��������-->


<!-- banner��ʼ-->
<!-- #include file="static/banner.aspx" -->
<!-- banner ����-->



<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2"><div id="menu">
 <h1 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /> һ���˵�A &gt;</a></h1>
 <span class="no">
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ �����˵�A_1</a></a></h2>
  <ul class="no">
   <a href="javascript:void(0)">�����˵�A_0 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_1 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_2 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_3 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_4 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
  </ul>
  <h2 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)">+ �����˵�A_2</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">�����˵�A_0 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_1 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_2 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_3 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_4 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
  </ul>
  <h2 onClick="javascript:ShowMenu(this,2)"><a href="javascript:void(0)">+ �����˵�A_3</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">�����˵�A_0 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_1 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_2 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_3 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�A_4 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
  </ul>
 </span>
        
 <h1 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /> һ���˵�B &gt;</a></h1>
 <span class="no">
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ �����˵�B_1</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">�����˵�B_0 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_1 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_2 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_3 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_4 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
  </ul>
  <h2 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)">+ �����˵�B_2</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">�����˵�B_0 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_1 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_2 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_3 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
   <a href="javascript:void(0)">�����˵�B_4 <input type="checkbox" name="checkbox" id="checkbox" /> ѡ��</a>
  </ul>
 </span>
  
</div></div>
<div class="dlqqz3"><a href="#"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;&nbsp;<a href="#"><img src="images/scxzcl.jpg" border="0" /></a></div>
</div>


<div class="dlex">
<div class="dlex1">ȫ������ΪEXCEL��VIP��ʾΪѡ�����ݽ��������ڲ�ϵͳ��</div>
<div class="dlex2">
<span class="dlex3">������Ϣ���£���������뵥�����İ�ť</span>
  <dl>
     <dd>��˾���ƣ�</dd><dt>������������</dt>
     <dd>��˾��ַ��</dd><dt>������������</dt>
     <dd>��˾�绰��</dd><dt>������������</dt>
     <dd>����������</dd><dt>������������</dt>
     <dd>���ĵ绰��</dd><dt>������������</dt>
     <dd>����QQ�ţ�</dd><dt>������������</dt>
     <dd>����ִ�գ�</dd><dt><img src="images/qqqq_03.jpg" /></dt>
     <dd>�������ʣ�</dd><dt><img src="images/qqqq_03.jpg" /></dt>
     
  </dl>
<span class="gg"><a href="#"><img src="images/12ff_03.jpg" /></a></span></div>
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
