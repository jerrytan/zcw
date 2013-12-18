<!--
      认领厂商页面
	  (当用户认领厂商后 把对应的用户id赋给认领的供应商(材料供应商信息表的yh_id))
	  文件名:  认领厂商.aspx 
       
	  传入参数:无	   

     
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
   <title>认领厂商页面</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />

   <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
   <script type="text/javascript" language="javascript">

        $(function()
	    {
         $("#btnSubmit1").click(function()
		 {   //调试用的           
            var list= $('input:radio[name="list"]:checked').val();
            if(list==null)
			{
               alert("请选中一个!");
               return false;
            }
            else
			{
                //alert(list);
            }           
         });
       }); 
	 
       function send_request() 
       { 
          http_request = false;
          if(window.XMLHttpRequest)
          {   //Mozilla 浏览器
              http_request = new XMLHttpRequest();
              if (http_request.overrideMimeType) 
	          {  //设置MiME类别
                 http_request.overrideMimeType("text/xml");
              }
          }
          else
          {
            if (window.ActiveXObject)
	        { // IE浏览器
             try 
	          {
                    http_request = new ActiveXObject("Msxml2.XMLHTTP");
              }
	         catch (e) 
	          {
                 try 
	              {
                       http_request = new ActiveXObject("Microsoft.XMLHTTP");
                  } 
	             catch (e)	{}
              }
            }
           }
       if (!http_request) 
        {     // 异常，创建对象实例失败
              window.alert("不能创建XMLHttpRequest对象实例.");
              return false;
        }
 
           var x=document.getElementsByName("list"); //获取复选框 属性name为list
           var checkedvalue;   //局部变量
           for(var i=0;i<x.length;i++)  //遍历选中的
            {
               if(x[i].checked)
               {
                   checkedvalue=x[i].value  //获取选中的value的值
	               window.alert(checkedvalue);
                   break;
               }
            }
            //ajax请求
            http_request.open("GET", "rlcs.aspx?name="+checkedvalue, true);
            http_request.onreadystatechange = processRequest;
            http_request.send(null);
            alert("认领成功!");
    }
           function processRequest() 
		   {
            if (http_request.readyState == 4) 
            {     // 判断对象状态
                  if (http_request.status == 200) 
                  {   // 信息已经成功返回，开始处理信息
                      var response = http_request.responseText;
                      c1.innerHTML=response;
                  } 
                  else
                  {         //页面不正常
                      alert("您所请求的页面有异常。");
                  }
            }
            }
</script>





</head>


<script runat="server"  > 
		
		
               protected DataTable dt = new DataTable(); //未认领的供应商信息(材料供应商信息表) 		
               protected void Page_Load(object sender, EventArgs e)
               {           
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    string sql = "select 供应商,gys_id from 材料供应商信息表 where yh_id='0' ";
                    SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "材料供应商信息表");
                    dt = ds.Tables[0];	

			        string yh_id = Request["name"];   //点击认领之后 把选中的供应商id传过来作为条件,修改材料供应商信息表
                    if(yh_id!=null)
			        {            
			          conn.Open();
                      string sql1 = "update 材料供应商信息表 set yh_id='7' where gys_id='"+yh_id+"' ";
                      SqlCommand cmd = new SqlCommand(sql1,conn);
			          int ret = (int)cmd.ExecuteNonQuery();
                      conn.Close();			
		            }
               }
	                  
        
    </script>

<body>

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->



<form id="form1" >
  <div class="rlcs"><span class="rlcszi">您可以认领信息已经在本站的生产厂商， 流程如下图</span><img src="images/www_03.jpg" /></div>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">查询结果</span>
      <%foreach (System.Data.DataRow row in dt.Rows)
      { %>
        <span class="rlcs6"><input name="list" type="radio" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["供应商"].ToString() %></span>
    <%} %>


   <a  onclick="send_request()" href="#"></div> <img src="images/rl_03.jpg" /></a>

  </div>

    <span class="rlcs7">如果您没有找到贵公司，您可以提交贵公司资料，我方工作人员会在3个工作日内完成审核工作（流程图如下）</span>
    <span><img src="images/www_03.jpg" /></span>
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
