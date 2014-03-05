<!--
             材料编辑页面
             文件名:  clbj.aspx 
			 传入参数: cl_id
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
<title>材料编辑页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //一级分类发送ajax 更新的是小类的名称 文件名是:xzclym2.aspx
    function updateFL(id) 
	{
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }
	
	   //二级分类发送ajax 更新的是品牌的名称 
	   
      function updateCLFL(id) 
	  {
        var xmlhttp;		
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();			
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
		
	
	
        }
</script>	

<script runat="server">  
        
         public List<OptionItem> Items1 { get; set; }    //材料分类大类
         public List<OptionItem_sx> Items2 { get; set; }	 //属性名称,分类属性值	 
         public class OptionItem
         {
            public string Name { get; set; }  //下拉列表显示名属性
            public string GroupsCode { get; set; }  //下拉列表分类编码属性    
         }
		 public class OptionItem_sx
         {
            public string Sx_Name { get; set; }      //下拉列表属性名称
            public string Sx_value { get; set; }     //下拉列表分类属性值    
         }
         protected DataTable dt_clfl = new DataTable();  //材料分类大类   
         protected DataTable dt_clxx = new DataTable();    //材料信息
         protected DataTable dt_clsx = new DataTable();    //材料属性名称,属性值(材料属性表)	 
    
         protected void Page_Load(object sender, EventArgs e)
         {
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr); 
		
		     string cl_id = Request["cl_id"];   //获取材料id
			 
             SqlDataAdapter da_clfl = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'", conn);
             DataSet ds_clfl = new DataSet();
             da_clfl.Fill(ds_clfl, "材料分类表");
             dt_clfl = ds_clfl.Tables[0];         

             this.Items1 = new List<OptionItem>();  //数据表DataTable转集合  
        
             for (int x = 0; x < dt_clfl.Rows.Count; x++)
             {
                DataRow dr = dt_clfl.Rows[x];
                if (Convert.ToString(dr["分类编码"]).Length == 2)
                {
                   OptionItem item = new OptionItem();
                   item.Name = Convert.ToString(dr["显示名字"]);
                   item.GroupsCode = Convert.ToString(dr["分类编码"]);
                   this.Items1.Add(item);   //将大类存入集合
                }
             }    
             String str_clxx = "select 显示名,分类名称,品牌名称,规格型号,计量单位,单位体积,单位重量,分类编码,说明 from 材料表 where cl_id='"+cl_id+"' ";
             SqlDataAdapter da_clxx = new SqlDataAdapter(str_clxx, conn);
			 DataSet ds_clxx = new DataSet();
             da_clxx.Fill(ds_clxx, "材料表");
             dt_clxx = ds_clxx.Tables[0];
			 
			 String str_clsx = "select 分类属性名称,分类属性值 from 材料属性表 where cl_id='"+cl_id+"' ";
             SqlDataAdapter da_clsx = new SqlDataAdapter(str_clsx, conn);
			 DataSet ds_clsx = new DataSet();
             da_clsx.Fill(ds_clsx, "材料表");
             dt_clsx = ds_clsx.Tables[0];
			  
			 this.Items2 = new List<OptionItem_sx>();
			 for(int x= 0;x<dt_clsx.Rows.Count;x++)
			 {
			    DataRow dr = dt_clsx.Rows[x];
				OptionItem_sx sx = new OptionItem_sx();
				sx.Sx_Name = Convert.ToString(dr["分类属性名称"]);
				sx.Sx_value = Convert.ToString(dr["分类属性值"]);
				this.Items2.Add(sx);
			 }
         }				
 
</script>
<body>

 <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
 <!-- 头部结束-->
 

<div class="fxsxx">
<span class="fxsxx1">材料分类如下:</span>
<div class="xz1">
                <div class="xza">

                    <span class="xz2"><a href="#">大类</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                        <% foreach(var v  in Items1){%>
                        <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>
                <div class="xza">
                    <span class="xz2"><a href="#">小类</a></span>
                    <select id="ejflname" name="ejflname" class="fux"  onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
                        
                        <option value="0">请选择小类</option>
                    
                    </select>
                </div>           



<div class="xzz">
<!--
<span class="xzz0">如果没有适合的小类，请联系网站管理员增加！ 联系方式是xxx@xxx.com.请使用模板。 </span>
-->
<span class="xzz1"><a href="#">模板下载地址</a></span>
</div>

</div>

<div class="fxsxx2">
<span class="srcl">材料信息如下:</span>
 <dl>
                    <dd>材料名字：</dd>
                    <dt>
                        <input name="cl_name" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["显示名"] %>" /></dt>

                    <dd>品    牌：</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px">
                            
                            <option value="0">请选择品牌</option>
                           
                        </select></dt>
  
                    <dd>属性名称：</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" >
						
                            <%foreach(var v in this.Items2){%>                                          
                            <option value="0"><%=v.Sx_Name%></option>
							<%}%>
						
                        </select></dt>
						
		  <!--
	                <dd>属性名称：</dd>                    
                    <dt>
                        <input name="sx_names" type="text" id="sx_names" class="fxsxx3" value="<%=dt_clxx.Rows[0]["规格型号"] %>" /></dt>
			-->				
						
                    <dd>属性值：</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <%foreach(var v in this.Items2){%>                                          
                            <option value="0"><%=v.Sx_value%></option>
							<%}%>
                           
                        </select></dt>
					
						
					<dd>规格型号：</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=dt_clxx.Rows[0]["规格型号"] %>" /></dt>					
						
                    <dd>计量单位：</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["计量单位"] %>" /></dt>
                    <dd>单位体积：</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["单位体积"] %>" /></dt>
				    <dd>单位重量：</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["单位重量"] %>" /></dt>
                    <dd>说明：</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["说明"] %>" /></dt>
					<dd>报价：</dd>
					<dt>
						<input name="cl_instruction" type="text" class="fxsxx3" value="" /></dt>
                </dl>
</div>

<!--
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
-->

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




<div class="foot">
<span class="foot2"><a href="#">网站合作</a>  |<a href="#"> 内容监督</a> | <a href="#"> 商务咨询</a> |  <a href="#">投诉建议010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012众材网版权所有      京ICP证0000111号      京公安网备110101000005号</p>
<p>地址：北京市海淀区天雅大厦11层  联系电话：010-87654321    技术支持：京企在线</p></span>
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
