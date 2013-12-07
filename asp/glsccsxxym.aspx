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
<title>管理生产厂商信息页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="box">

<div class="topx"><a href="index.aspx"><img src="images/topx_02.jpg" /></a></div>

<script runat="server" >


       protected DataTable dt = new DataTable();  //分销商信息(材料供应商信息表)
       protected void Page_Load(object sender, EventArgs e)
        {
		    string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			//SqlDataAdapter da = new SqlDataAdapter("select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机 from 材料供应商信息表 where 单位类型='分销商'", conn);
           // DataSet ds = new DataSet();
            //da.Fill(ds, "材料供应商信息表");            
            //dt = ds.Tables[0];
			string strr="select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机 from 材料供应商信息表 where 单位类型='分销商' and gys_id='30'";         
            SqlCommand cmd = new SqlCommand(strr, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
			    
                this.companyname.Value = dr["供应商"].ToString();
				this.address.Value = dr["地址"].ToString();
				this.tel.Value = dr["电话"].ToString();
				this.homepage.Value = dr["主页"].ToString();
				this.fax.Value = dr["传真"].ToString();
				this.area.Value = dr["地区名称"].ToString();
				this.name.Value = dr["联系人"].ToString();
				this.phone.Value = dr["联系人手机"].ToString();
			}
			
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
			string sql = "insert into 材料供应商信息表(供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机)values('"+companyname+"','" + address + "','" + tel + "','" + homepage + "','"+fax+"','" + area + "','" + name + "','" + phone + "')";
            System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand(sql, conn);
            int ret =  (int)cmd1.ExecuteNonQuery();
			conn.Close();
		
			}
		}
</script>


<form id="login" name="login" action="glsccsxxym.aspx" method="post">
<div class="gyzy0">
<div class="gyzy">尊敬的XX先生/女士，您好</div>

<div class="fxsxx">
<span class="fxsxx1">贵公司的分销信息如下</span>
<div class="zjgxs"> <select name="" class="fug"><option></option></select> <span class="zjgxs1"><a href="#">增加新的供销商</a></span></div>
<div class="fxsxx2">

 <dl>
     <dd>贵公司名称：</dd>
    <dt><input runat="server" name="companyname" type="text" id="companyname" class="fxsxx3"  /></dt>
     <dd>贵公司地址：</dd>
    <dt><input runat="server" name="address" type="text" id="address" class="fxsxx3" /></dt>
     <dd>贵公司电话：</dd>
    <dt><input runat="server" name="tel" type="text" id="tel" class="fxsxx3" /></dt>
     <dd>贵公司主页：</dd>
    <dt><input runat="server" name="homepage" type="text" id="homepage" class="fxsxx3" /></dt>
     <dd>贵公司传真：</dd>
    <dt><input runat="server" name="fax" type="text" id="fax" class="fxsxx3" /></dt>
     <dd>贵公司地区：</dd>
    <dt><input runat="server" name="area" type="text" id="area" class="fxsxx3" /></dt>           
     <dd>贵公司简介：</dd>
    <dt><textarea name="description" cols="" rows="" class="fgsjj" value="<%=Request.Form["description"] %>"></textarea></dt>
     <dd>贵公司logo：</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>贵公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     <dd>联系人姓名：</dd>
    <dt><input runat="server" name="name" type="text" id="name" class="fxsxx3" /></dt>
     <dd>联系人电话：</dd>
    <dt><input runat="server" name="phone" type="text" id="phone" class="fxsxx3" /></dt>
     <dd>联系人职务：</dd>
    <dt><input name="position" type="text" class="fxsxx3" value="<%=Request.Form["position"] %>"/></dt>
    
 </dl>
 
<span  class="fxsbc"><a href="#"><input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg" ></a></span>


 
</div>



<div class="ggspp">
<span class="ggspp1">贵公司品牌如下</span>
<div class="ggspp2"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />品牌1</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />品牌2</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />品牌3</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />品牌3</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />品牌3</span></div></div>
</div>
</div>


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
