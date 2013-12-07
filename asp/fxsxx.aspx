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
<title>分销商信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="box">

<div class="topx"><img src="images/topx_02.jpg" /></div>
<div class="gyzy0">
<div class="gyzy">尊敬的XX先生/女士，您好</div>

<div class="fxsxx">
<span class="fxsxx1">贵公司的分销信息如下</span>
<div class="zjgxs"> <select name="" class="fug"><option></option></select> <span class="zjgxs1"><a href="#">增加新的供销商</a></span></div>
<div class="fxsxx2">
 <dl>
    <dd>公司名称：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>公司地址：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>公司电话：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>公司主页：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>公司传真：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
    <dd>分销区域：</dd>
    <dt><div class="fxs1"><select name="" class="fu1"><option>华北</option></select>  <select name="" class="fu2"><option>北京</option></select>省（市）
    <select name="" class="fu3"><option>石家庄</option></select> 地区<select name="" class="fu4"><option>市区</option></select> 区（县） </div></dt>
     <dd>代理品牌：</dd>
    <dt><span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />品牌1</span> 
        <span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />品牌2</span>
        <span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" />品牌3</span> </dt>
     <dd>公司简介：</dd>
    <dt><textarea name="" cols="" rows="" class="fgsjj"></textarea></dt>
     <dd>公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     <dd>联系人姓名：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>联系人电话：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>联系人职务：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
    
 </dl>
<span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span></div>
</div>


</div>


<div>
<!-- 关于我们 广告服务 投诉建议 开始-->
<!-- #include file="static/aboutus.aspx" -->
<!-- 关于我们 广告服务 投诉建议 结束-->
</div>

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->


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
var speed=9//速度数值越大速度越慢
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
