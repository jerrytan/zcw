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
<title>搜索结果页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- 头部开始-->
<!-- #include file="static/header.aspx" -->
<!-- 头部结束-->


<!-- 导航开始-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- 导航结束-->


<!-- banner开始-->
<!-- #include file="static/banner.aspx" -->
<!-- banner 结束-->



<div class="sc">

<div class="xzss">
<div class="ppxz">
<div class="ppxz1">品牌：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">品牌1</a> <a href="#">品牌2</a> <a href="#">品牌3</a></div></div>
<div class="ppxz">
<div class="ppxz1">区域：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">朝阳区</a> <a href="#">海淀区</a> <a href="#">丰台区</a></div></div>
<div class="ppxz">
<div class="ppxz1">材料：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">材料1</a> <a href="#">材料2</a> <a href="#">材料3</a></div></div>
<div class="ppxz">
<div class="ppxz1">更多：</div><div class="ppxz2"></a> <a href="#">属性1</a> <a href="#">属性2</a> <a href="#">属性3</a></div></div>

<div class="dlspx"><span class="dlspx1">排序：</span><span class="dlspx2"><a href="#">默认</a></span><span class="dlspx3"><a href="#">人气</a><img src="images/qweqw_03.jpg" /></span>
<span class="dlspx3"><a href="#">最新</a><img src="images/qweqw_03.jpg" /></span> <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /><a href="#">全选</a></span>
<span class="dlspx4"><a href="#">请收藏，便于查找</a></span>
</div>
</div>


<div class="dlspxl"> 
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>


<div class="fy2">
<div class="fy3"><a href="#">上一页</a> <a href="#">1</a> <a href="#">2</a><a href="$"> 3···</a> <a href="#">下一页</a> <a href="#"> 尾页</a>  
直接到第 <select name="" class="fu"><option>1</option></select>      
页</div></div>
</div>



<div class="pxright0">
<div class="pxright">
<div class="pxright1">
<ul>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">大理石</a></li>
   <li><a href="#">白锈石</a></li>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">黄锈石</a></li>
   <li><a href="#">黄锈石</a></li>
</ul>

</div> </div>
<div class="pxright2"><a href="#"><img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
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
