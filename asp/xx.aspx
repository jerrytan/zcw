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
<title>��Ϣ����ҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script type=text/javascript src="js/lrtk.js"></script>
<script type=text/javascript src="js/jquery-1.4.2.min.js"></script>
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

<script runat="server">  
         protected DataTable dt = new DataTable();   //��������(���ϱ�)
		 protected DataTable dt1 = new DataTable();   //һ����������(���Ϸ����)
		 protected DataTable dt2 = new DataTable();   //Ʒ������,����ͺ�(Ʒ���ֵ�)
		 protected DataTable dt3 = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
		 protected DataTable dt4 = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected void Page_Load(object sender, EventArgs e)
        {		      
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			string cl_id = Request["cl_id"];
            SqlDataAdapter da = new SqlDataAdapter("select ��ʾ��,fl_id,���ϱ��� from ���ϱ� where cl_id='"+cl_id+"' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "���ϱ�");            
            dt = ds.Tables[0];
			
			string fl_id = Request["fl_id"];//��ȡ��������һ���������
			SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ���� from ���Ϸ���� where �������='"+fl_id+"' ", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϸ����");           
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select Ʒ������,����ͺ� from ���ϱ� where cl_id='"+cl_id+"' " , conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���ϱ�");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select ��ϵ���ֻ�,��Ӧ��,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where ��λ����='������' and gys_id in (select gys_id from ���ϱ� where cl_id='"+cl_id+"') " , conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���Ϲ�Ӧ����Ϣ��");            
            dt3 = ds3.Tables[0];
			
			SqlDataAdapter da4 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select gys_id from Ʒ���ֵ� where pp_id in(select pp_id from ���ϱ� where cl_id='"+cl_id+"') ) " , conn);
            DataSet ds4 = new DataSet();
            da4.Fill(ds4, "���Ϲ�Ӧ����Ϣ��");            
            dt4 = ds4.Tables[0];
		   
        }		
        
</script>

<div class="sc">
<div class="sc1"><a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp

<% foreach(System.Data.DataRow row in dt1.Rows){%>
 <a href="#"><%=row["��ʾ����"].ToString() %></a>
 <%}%>
> 
<% foreach(System.Data.DataRow row in dt.Rows){%>
 <a href="#"><%=row["��ʾ��"].ToString() %></a>
 <%}%>

</div>
<div class="xx1">
<div class="xx2">
<div style="HEIGHT: 300px; OVERFLOW: hidden;" id=idTransformView>
<ul id=idSlider class=slider>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="2013���˱��й滮��Ƴɹ������" src="images/01.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="�˱���16�������Ʋ��ֳ���ͬ��" src="images/02.jpg" width=320 height=300></a>
  </div>
  
  <div style="POSITION: relative">
   
   
    <a href="http://www.lanrentuku.com/" target="_blank"><img alt="���硰���ޡ����˱��ˣ�" src="images/03.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
      
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="���˳�����!�˱����ֵ�С���ʰ���𡱹黹" src="images/04.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="�˱���ش���ַ������ҳ�������˳���ѹ��" src="images/05.jpg" width=320 height=300></a>
  </div>
</ul>
</div>

<div>
<ul id=idNum class=hdnum>
  <li><img src="images/01.jpg" width=61px height=45px></li>
  <li><img src="images/02.jpg" width=61px height=45px></li>
  <li><img src="images/03.jpg" width=61px height=45px></li>
  <li><img src="images/04.jpg" width=61px height=45px></li>
  <li><img src="images/05.jpg" width=61px height=45px></li>
</ul>

</div></div>

<div class="xx3">
 <dl>
  <% foreach(System.Data.DataRow row in dt2.Rows){%>
  <dd>Ʒ��:</dd>
  <dt><%=row["Ʒ������"].ToString() %></dt>
  <dd>�ͺ�:</dd>
  <dt><%=row["����ͺ�"].ToString() %></dt>
  <%}%>

 </dl>
 <span class="xx4"><a href="#">���ղأ����ڲ���</a></span></div>
</div>

<div class="xx5"><img src="images/sst_03.jpg" />
<div class="xx6">
         <ul>
          <li class="xx7">��������Ϣ</li>
		<% foreach(System.Data.DataRow row in dt3.Rows){%>  
          <li>������<%=row["��Ӧ��"].ToString()%></li>
          <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
          <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
		<%}%>  
       </ul>
</div>
</div>

<div class="xx8">
<div class="xx9"><div class="fxs1">
<select name="" class="fu1"><option>����</option></select>  
<select name="" class="fu2"><option>����</option></select>ʡ���У�
    <select name="" class="fu3"><option>ʯ��ׯ</option></select> ����
	<select name="" class="fu4"><option>����</option></select> �����أ� </div>
	<% foreach(System.Data.DataRow row in dt4.Rows){%>
    <div class="fxs2">
       <ul>
          <li class="fxsa">������:</li>
          <li>������<%=row["��Ӧ��"].ToString()%></li>
          <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
          <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
       </ul>
    </div>
	<%}%>
    <div class="fxs2">
       <ul>
          <li class="fxsa">������A</li>
          <li>������</li>
          <li>��ַ��</li>
          <li>�绰��</li>
       </ul>
    </div>
    <div class="fxs2">
       <ul>
          <li class="fxsa">������A</li>
          <li>������</li>
          <li>��ַ��</li>
          <li>�绰��</li>
       </ul>
    </div>
</div></div>

<div class="xx10"><img src="images/231_03.jpg" />
  <dl>
     <dd>�����������ſͻ����ٷ�չͬʱ���������Ӫ��Ч�����а���������ҵ������ͨ�Ų��������...   </dd>
     <dt>2013.09.09</dt>
     <dd>�����������ſͻ����ٷ�չͬʱ���������Ӫ��Ч�����а���������ҵ������ͨ�Ų��������...   </dd>
     <dt>2013.09.09</dt>
     <dd>�����������ſͻ����ٷ�չͬʱ���������Ӫ��Ч�����а���������ҵ������ͨ�Ų��������...   </dd>
     <dt>2013.09.09</dt>
     <dd>�����������ſͻ����ٷ�չͬʱ���������Ӫ��Ч�����а���������ҵ������ͨ�Ų��������...   </dd>
     <dt>2013.09.09</dt>
  </dl>
  <div class="xx11"><img src="images/231_03.jpg" /></div>
</div>


</div>

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->



</div>
<script language=javascript>
  mytv("idNum","idTransformView","idSlider",300,5,true,2000,5,true,"onmouseover");
  //��ť����aa����������bb����������cc���������dd����������ee����������ff����ʱgg�������ٶ�hh���Զ�����ii��
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
