<!--   
      供应商登录页面 供应商登录成功后 链接到供应商主页面 
      文件名:  gysdlym.aspx   
      传入参数:无	   
	  
       
-->


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
<title>供应商登陆页面</title>
<script src="/asp/js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/gysdlym.aspx" charset="utf-8"></script>


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

    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" charset="utf-8" data-callback="true"></script>  

    <script type="text/javascript">
        if (QC.Login.check()) {//如果已登录  
            QC.Login.getMe(function (openId, accessToken) {
                alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n"));
                
                //using cookie to store openId
                document.cookie="OpenId="+openId;
                opener.location.reload();
            });
            //这里可以调用自己的保存接口  
            //...  
        }

       
+</script> 



</head>

<body>


    <p>
   </p>
   <%
   
       HttpCookie openId = Request.Cookies["OpenId"];
        if (openId != null)
        {
            Response.Write("openid is " + openId.Value);
       }
       else
        {
            Response.Write("openid is empty");
   %>
    <span id="qqLoginBtn"></span>
    <script type="text/javascript">
        QC.Login({
            btnId: "qqLoginBtn" //插入按钮的节点id  

       });

    </script>
    <%}%>




<div class="dlqq">
<div class="dlqq1">
<span class="dlzi">尊敬的供应商，您好请点击右边按钮登陆！</span>
<span class="dlzi2"><img src="images/1wqed_03.jpg" /><a href="#">QQ账号</a></span>
<img src="images/wz_03.jpg" /></div>
<div class="dlqqc"><span class="dlqqc1"></span>
<span class="gybtan"><a href="gyszym.aspx"><img src="images/aaaa_03.jpg" /></a></span></div>


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
