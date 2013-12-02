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
<script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
       $(document).ready(function ()
        {		      
		    $("#ckAll").click(function ()
            {                 			
                var v = $(this).attr("checked");//获取"全选复选框"                
                $(":checkbox.ck").attr("checked", v);//设置class=ck的复选框是否被选中
            });
		    $(":checkbox.ck").click(function () {               
                var a = $(":checkbox.ck").size(); //获取所有的class=ck的复选框数量                
                var b = $(":checkbox.ck:checked").size();//获取所有的class=ck,并且被选中的 复选框数量
                var c = a == b;
                $("#ckAll").attr("checked", c);
            });
		});
</script>
<title>二级分类详细页面</title>
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

<script runat="server" >
         
        protected DataTable dt = new DataTable();   //一级分类名称
        protected DataTable dt1 = new DataTable();  //二级分类名称 
		protected DataTable dt2 = new DataTable();  //品牌(和二级分类相关的品牌) 材料分类表中fl_id 品牌字典中关系没有对应
		protected DataTable dt3 = new DataTable();  //二级分类名称下的材料
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();            
            String name= Request["name"];
			string name1=name.ToString().Substring(0, 2); //取左边两位字符串
            SqlDataAdapter da = new SqlDataAdapter("select 显示名字 from 材料分类表 where  left(分类编码,2)='"+name1+"' and len(分类编码)='2'  ", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "材料分类表"); 
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字 from 材料分类表 where 分类编码='"+name+"' ", conn);            
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表"); 
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select distinct 品牌名称 from 品牌字典 where  fl_id in(select 分类编码 from 材料分类表 where 分类编码='"+name+"') ", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "品牌字典"); 
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select 显示名,规格型号,一级分类编码,cl_id from 材料表 where 二级分类编码='"+name+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "材料表"); 
            dt3 = ds3.Tables[0];
		} 
</script>


<div class="sc">
<div class="sc1">
<a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp

 <% foreach(System.Data.DataRow row in dt.Rows){%>
    <a href="#"><%=row["显示名字"].ToString() %></a>
  <% } %>
 > 
 <% foreach(System.Data.DataRow row in dt1.Rows){%>
    <a href="#"><%=row["显示名字"].ToString() %></a>
  <% } %>
 
 </div>

<div class="sc3">
  <div class="rh"><div class="rh1"><a href="#">如何选取大理石？</a></div>  <div class="rh2">素材中国打造中国最优秀平面设计素材网站...</div></div>
  <div class="rh"><div class="rh1"><a href="#">如何选取大理石？</a></div>  <div class="rh2">素材中国打造中国最优秀平面设计素材网站...</div></div>
  <div class="rh"><div class="rh1"><a href="#">如何选取大理石？</a></div>  <div class="rh2">素材中国打造中国最优秀平面设计素材网站...</div></div>
  <div class="rh"><div class="rh1"><a href="#">如何选取大理石？</a></div>  <div class="rh2">素材中国打造中国最优秀平面设计素材网站...</div></div>
</div>

<div class="xzss">
<div class="ppxz">
<div class="ppxz1">品牌：</div>
 <div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> 
 
 <% foreach(System.Data.DataRow row in dt2.Rows){%>
<a href="#"><%=row["品牌名称"].ToString() %></a>    
  <% } %> 
 
 </div></div>
<div class="ppxz">
<div class="ppxz1">区域：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">朝阳区</a> <a href="#">海淀区</a> <a href="#">丰台区</a></div></div>
<div class="ppxz">

<div class="ppxz1">材料：</div>
<div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> 

<% foreach(System.Data.DataRow row in dt3.Rows){%>
<a href="#"><%=row["显示名"].ToString() %></a> 
<%}%>

</div></div>
<div class="ppxz">
<div class="ppxz1">更多：</div><div class="ppxz2"></a> <a href="#">属性1</a> <a href="#">属性2</a> <a href="#">属性3</a></div></div>

<div class="dlspx"><span class="dlspx1">排序：</span>
<span class="dlspx2"><a href="#">默认</a></span>
<span class="dlspx3"><a href="#">人气</a><img src="images/qweqw_03.jpg" /></span>
<span class="dlspx3"><a href="#">最新</a><img src="images/qweqw_03.jpg" /></span> 
<span class="dlspx3"><input name="" type="checkbox" value="" id="ckAll"  class="fx" /><a href="#">全选</a></span>
<span class="dlspx4"><a href="#">请收藏，便于查找</a></span>
</div>
</div>

<div class="dlspxl"> 

 <% foreach(System.Data.DataRow row in dt3.Rows){%>  

<div class="dlspxt"><a href="xx.aspx?fl_id=<%=row["一级分类编码"]%>&cl_id=<%=row["cl_id"]%>"><img src="images/222_03.jpg" />
<div class="dlspxt1">
<span class="dlsl"><%=row["显示名"].ToString() %></span>  
<span class="dlspx3"><input name="" type="checkbox" value=""  class="ck" /> 收藏</span> 
<span class="dlsgg">规格：<%=row["规格型号"].ToString() %></span> </div></div>
  <% } %>

<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">大理石</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
<span class="dlsgg">规格：123456789</span> </div></div>


</div>



<div class="pxright0">
<div class="pxright">
<div class="pxright1">
<ul>

<% foreach(System.Data.DataRow row in dt3.Rows){%>
 <li><a href="#"><%=row["显示名"].ToString() %></a></li>
<%}%>

</ul>

</div> </div>
<div class="pxright2"><a href="#"><img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
</div>

</div>


<div class="fy2">
<div class="fy3"><a href="#">上一页</a> <a href="#">1</a> <a href="#">2</a><a href="$"> 3···</a> <a href="#">下一页</a> <a href="#"> 尾页</a>  
直接到第 <select name="" class="fu"><option>1</option></select>      
页</div></div>



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
