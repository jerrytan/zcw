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
<title>��������������Ϣҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="box">

<div class="topx"><a href="index.aspx"><img src="images/topx_02.jpg" /></a></div>

<script runat="server" >
  protected void Page_Load(object sender, EventArgs e)
        {
		    string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			if(Request.Form["companyname"] != null )
			{
			string companyname = Request["companyname"];
            string address = Request["address"];
            string tel = Request.Form["tel"];
            string homepage = Request.Form["homepage"];
			string fax = Request["fax"];
            string area = Request["area"];
            string description = Request.Form["description"];
            string name = Request.Form["name"];
			string phone = Request.Form["phone"];
			string position = Request.Form["position"];
			string sql = "insert into ���Ϲ�Ӧ����Ϣ��(��Ӧ��,��ַ,�绰,��ҳ,����,��������,��˾���,��ϵ��,��ϵ���ֻ�,��ϵ��ְ��)values('"+companyname+"','" + address + "','" + tel + "','" + homepage + "','"+fax+"','" + area + "','"+description+"','" + name + "','" + phone + "','"+position+"')";
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, conn);
            int ret =  (int)cmd.ExecuteNonQuery();
			conn.Close();
		
			}
		}
</script>


<form id="login" name="login" action="glsccsxxym.aspx" method="post">
<div class="gyzy0">
<div class="gyzy">�𾴵�XX����/Ůʿ������</div>

<div class="fxsxx">
<span class="fxsxx1">��˾�ķ�����Ϣ����</span>
<div class="zjgxs"> <select name="" class="fug"><option></option></select> <span class="zjgxs1"><a href="#">�����µĹ�����</a></span></div>
<div class="fxsxx2">
 <dl>
     <dd>��˾���ƣ�</dd>
    <dt><input name="companyname" type="text" class="fxsxx3" value="<%=Request.Form["companyname"] %>"/></dt>
     <dd>��˾��ַ��</dd>
    <dt><input name="address" type="text" class="fxsxx3" value="<%=Request.Form["address"] %>"/></dt>
     <dd>��˾�绰��</dd>
    <dt><input name="tel" type="text" class="fxsxx3" value="<%=Request.Form["tel"] %>"/></dt>
     <dd>��˾��ҳ��</dd>
    <dt><input name="homepage" type="text" class="fxsxx3" value="<%=Request.Form["homepage"] %>"/></dt>
     <dd>��˾���棺</dd>
    <dt><input name="fax" type="text" class="fxsxx3" value="<%=Request.Form["fax"] %>"/></dt>
     <dd>��˾������</dd>
    <dt><input name="area" type="text" class="fxsxx3" value="<%=Request.Form["area"] %>"/></dt>           
     <dd>��˾��飺</dd>
    <dt><textarea name="description" cols="" rows="" class="fgsjj" value="<%=Request.Form["description"] %>"></textarea></dt>
     <dd>��˾logo��</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>��˾ͼƬ��</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     <dd>��ϵ��������</dd>
    <dt><input name="name" type="text" class="fxsxx3" value="<%=Request.Form["name"] %>"/></dt>
     <dd>��ϵ�˵绰��</dd>
    <dt><input name="phone" type="text" class="fxsxx3" value="<%=Request.Form["phone"] %>"/></dt>
     <dd>��ϵ��ְ��</dd>
    <dt><input name="position" type="text" class="fxsxx3" value="<%=Request.Form["position"] %>"/></dt>
    
 </dl>
<span  class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span>


 
</div>



<div class="ggspp">
<span class="ggspp1">��˾Ʒ������</span>
<div class="ggspp2"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��1</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��2</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��3</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��3</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />Ʒ��3</span></div></div>
</div>
</div>


</div>

<input type="submit" value="����"/>
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
