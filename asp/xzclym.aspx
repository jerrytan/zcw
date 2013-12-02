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
<title>新增材料页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>


<script runat="server">  
        public List<OptionItem> Items1 { get; set; }
        public List<OptionItem> Items2 { get; set; }
		public List<OptionItem> Items3 { get; set; }
        public class OptionItem
        {
          public string Name { get; set; }  //下拉列表显示名属性
		  public string GroupsCode {get; set ; }  //下拉列表分类编码属性
          public string SelectedString { get; set; }
          public string Value { get; set; }      
       
        }
        protected DataTable dt = new DataTable();
		protected DataTable dt1 = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料分类表");            
            dt = ds.Tables[0];
            
			//string type = Request[""];
            SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='4'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表");            
            dt1 = ds1.Tables[0];			
			conn.Close();
			                 
             this.Items1 = new List<OptionItem>();  //数据表DataTable转集合  
            this.Items2 = new List<OptionItem>();
            this.Items3 = new List<OptionItem>();
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];

                if (Convert.ToString(dr["分类编码"]).Length == 2)
                {
                    OptionItem item = new OptionItem();
                    item.Name = Convert.ToString(dr["显示名字"]);
                    item.GroupsCode = Convert.ToString(dr["分类编码"]);
                    this.Items1.Add(item);
                }
            }
            
            for (int x = 0; x < dt1.Rows.Count; x++)
            {
                DataRow dr = dt1.Rows[x];

                if (Convert.ToString(dr["分类编码"]).Length == 4)
                {
                    OptionItem item1 = new OptionItem();  
                    item1.Name = Convert.ToString(dr["显示名字"]);
                    item1.GroupsCode = Convert.ToString(dr["分类编码"]);
                    this.Items2.Add(item1);
                }
            }
            
               foreach (var v in this.Items1)
            {
                foreach (var vr in this.Items2)
                {
                    
                    if (vr.GroupsCode.ToString().Substring(0, 2) == v.GroupsCode.ToString())
                    {
					    OptionItem item2 = new OptionItem();  //小类
                        item2.Name = Convert.ToString(vr.Name);
                        this.Items3.Add(item2);
                    }
                }
            }
        }	
		
		
	
 
</script>


<div class="box">

<div class="topx"><img src="images/topx_02.jpg" /></div>
<div class="gyzy0">
<div class="gyzy">尊敬的XX先生/女士，您好</div>

<div class="fxsxx">
<span class="fxsxx1">贵公司的分销信息如下</span>
<div class="xz1"><div class="xza"> 



<span class="xz2"><a href="#">大类</a></span>
 <select name="" class="fux">
 <% foreach(var v  in Items1){%>
 <option value="<%=v.GroupsCode %>" <%=v.SelectedString %>><%=v.Name%></option>
 <%}%> 
 </select> 
 </div>
                <div class="xza"> 
				<span class="xz2"><a href="#">小类</a></span> 
				<select name="" class="fux">
				 <% foreach(var v  in Items3){%>
				<option><%=v.Name%></option>
				<%}%>
				
				</select> </div>

				
<div class="xzz"><span class="xzz0">如果没有适合的小类，请联系网站管理员增加！ 联系方式是xxx@xxx.com.请使用模板。 </span>
<span class="xzz1"><a href="#">模板下载地址</a></span></div>
</div>

<div class="fxsxx2">
<span class="srcl">请输入材料信息</span>
 <dl>
     <dd>材料名字：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>品    牌：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>型号：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>纹理效果：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>适用场所：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>瓷砖尺寸：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>  
     <dd>计价单位：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>  
    <dd>家装风格：</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>                    
 </dl>
</div>

<div class="cpdt">
   <dl>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>

<div class="cpdt">
<span class="dmt">多媒体信息</span>
   <dl>
     <dd>产品视频：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>成功案例：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>更多资料：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>                          
 </dl>
 <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span>  
</div>



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
