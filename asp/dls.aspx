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
                var v = $(this).attr("checked");//��ȡ"ȫѡ��ѡ��"                
                $(":checkbox.ck").attr("checked", v);//����class=ck�ĸ�ѡ���Ƿ�ѡ��
            });
		    $(":checkbox.ck").click(function () {               
                var a = $(":checkbox.ck").size(); //��ȡ���е�class=ck�ĸ�ѡ������                
                var b = $(":checkbox.ck:checked").size();//��ȡ���е�class=ck,���ұ�ѡ�е� ��ѡ������
                var c = a == b;
                $("#ckAll").attr("checked", c);
            });
		});
</script>
<title>����������ϸҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />

</head>

<body>

<!-- ͷ����ʼ-->
<!-- #include file="static/header.aspx" -->
<!-- ͷ������-->


<!-- ������ʼ-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- ��������-->


<!-- banner��ʼ-->
<!-- #include file="static/banner.aspx" -->
<!-- banner ����-->

<script runat="server" >
         
        protected DataTable dt = new DataTable();   //һ����������
        protected DataTable dt1 = new DataTable();  //������������ 
		protected DataTable dt2 = new DataTable();  //Ʒ��(�Ͷ���������ص�Ʒ��) ���Ϸ������fl_id Ʒ���ֵ��й�ϵû�ж�Ӧ
		protected DataTable dt3 = new DataTable();  //�������������µĲ���
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();            
            String name= Request["name"];
			string name1=name.ToString().Substring(0, 2); //ȡ�����λ�ַ���
            SqlDataAdapter da = new SqlDataAdapter("select ��ʾ���� from ���Ϸ���� where  left(�������,2)='"+name1+"' and len(�������)='2'  ", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϸ����"); 
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ���� from ���Ϸ���� where �������='"+name+"' ", conn);            
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϸ����"); 
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select distinct Ʒ������ from Ʒ���ֵ� where  fl_id in(select ������� from ���Ϸ���� where �������='"+name+"') ", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "Ʒ���ֵ�"); 
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select ��ʾ��,����ͺ�,һ���������,cl_id from ���ϱ� where �����������='"+name+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ϱ�"); 
            dt3 = ds3.Tables[0];
		} 
</script>


<div class="sc">
<div class="sc1">
<a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp

 <% foreach(System.Data.DataRow row in dt.Rows){%>
    <a href="#"><%=row["��ʾ����"].ToString() %></a>
  <% } %>
 > 
 <% foreach(System.Data.DataRow row in dt1.Rows){%>
    <a href="#"><%=row["��ʾ����"].ToString() %></a>
  <% } %>
 
 </div>

<div class="sc3">
  <div class="rh"><div class="rh1"><a href="#">���ѡȡ����ʯ��</a></div>  <div class="rh2">�ز��й������й�������ƽ������ز���վ...</div></div>
  <div class="rh"><div class="rh1"><a href="#">���ѡȡ����ʯ��</a></div>  <div class="rh2">�ز��й������й�������ƽ������ز���վ...</div></div>
  <div class="rh"><div class="rh1"><a href="#">���ѡȡ����ʯ��</a></div>  <div class="rh2">�ز��й������й�������ƽ������ز���վ...</div></div>
  <div class="rh"><div class="rh1"><a href="#">���ѡȡ����ʯ��</a></div>  <div class="rh2">�ز��й������й�������ƽ������ز���վ...</div></div>
</div>

<div class="xzss">
<div class="ppxz">
<div class="ppxz1">Ʒ�ƣ�</div>
 <div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> 
 
 <% foreach(System.Data.DataRow row in dt2.Rows){%>
<a href="#"><%=row["Ʒ������"].ToString() %></a>    
  <% } %> 
 
 </div></div>
<div class="ppxz">
<div class="ppxz1">����</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">������</a> <a href="#">������</a> <a href="#">��̨��</a></div></div>
<div class="ppxz">

<div class="ppxz1">���ϣ�</div>
<div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> 

<% foreach(System.Data.DataRow row in dt3.Rows){%>
<a href="#"><%=row["��ʾ��"].ToString() %></a> 
<%}%>

</div></div>
<div class="ppxz">
<div class="ppxz1">���ࣺ</div><div class="ppxz2"></a> <a href="#">����1</a> <a href="#">����2</a> <a href="#">����3</a></div></div>

<div class="dlspx"><span class="dlspx1">����</span>
<span class="dlspx2"><a href="#">Ĭ��</a></span>
<span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span>
<span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span> 
<span class="dlspx3"><input name="" type="checkbox" value="" id="ckAll"  class="fx" /><a href="#">ȫѡ</a></span>
<span class="dlspx4"><a href="#">���ղأ����ڲ���</a></span>
</div>
</div>

<div class="dlspxl"> 

 <% foreach(System.Data.DataRow row in dt3.Rows){%>  

<div class="dlspxt"><a href="xx.aspx?fl_id=<%=row["һ���������"]%>&cl_id=<%=row["cl_id"]%>"><img src="images/222_03.jpg" />
<div class="dlspxt1">
<span class="dlsl"><%=row["��ʾ��"].ToString() %></span>  
<span class="dlspx3"><input name="" type="checkbox" value=""  class="ck" /> �ղ�</span> 
<span class="dlsgg">���<%=row["����ͺ�"].ToString() %></span> </div></div>
  <% } %>

<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">����ʯ</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> �ղ�</span> 
<span class="dlsgg">���123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">����ʯ</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> �ղ�</span> 
<span class="dlsgg">���123456789</span> </div></div>
<div class="dlspxt"><a href="#"><img src="images/222_03.jpg" />
<div class="dlspxt1"><span class="dlsl">����ʯ</span>  <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> �ղ�</span> 
<span class="dlsgg">���123456789</span> </div></div>


</div>



<div class="pxright0">
<div class="pxright">
<div class="pxright1">
<ul>

<% foreach(System.Data.DataRow row in dt3.Rows){%>
 <li><a href="#"><%=row["��ʾ��"].ToString() %></a></li>
<%}%>

</ul>

</div> </div>
<div class="pxright2"><a href="#"><img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
</div>

</div>


<div class="fy2">
<div class="fy3"><a href="#">��һҳ</a> <a href="#">1</a> <a href="#">2</a><a href="$"> 3������</a> <a href="#">��һҳ</a> <a href="#"> βҳ</a>  
ֱ�ӵ��� <select name="" class="fu"><option>1</option></select>      
ҳ</div></div>



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
