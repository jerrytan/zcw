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
<title>Ʒ����Ϣҳ</title>
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

<script runat="server">  

        protected DataTable dt = new DataTable(); //Ʒ������(Ʒ���ֵ��)
		protected DataTable dt1 = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt2 = new DataTable(); //��������Ϣ(��Ӧ�̺ͷ�������ر�)
		protected DataTable dt3 = new DataTable(); //��Ʒ���µĲ�Ʒ(���ϱ�)
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();          
			string pp_id = Request["pp_id"];  //��ȡ��ҳƷ��������������pp_id
            SqlDataAdapter da = new SqlDataAdapter("select Ʒ������,gys_id  from Ʒ���ֵ� where pp_id='"+pp_id+"'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Ʒ���ֵ�");            
            dt = ds.Tables[0];				
			
            SqlDataAdapter da1 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select uid from Ʒ���ֵ� where pp_id='"+pp_id+"' )", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϲ�Ӧ����Ϣ��");            
            dt1 = ds1.Tables[0];			
			
			//string BrandsName=Request["BrandsName"];
            SqlDataAdapter da2 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select gys_id from Ʒ���ֵ� where pp_id='"+pp_id+"') ", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���Ϲ�Ӧ����Ϣ��");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select ��ʾ�� ,����ͺ� from ���ϱ� where pp_id='"+pp_id+"'  ", conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ϱ� ");
            conn.Close();             
            dt3 = ds3.Tables[0];
        }	
       
</script>

<!-- ��ҳ Ʒ����Ϣ ��ʼ-->

<div class="gysxx"> 
<div class="gysxx1"><a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp
<% foreach(System.Data.DataRow row in dt.Rows){%> 
<a href="#"><%=row["Ʒ������"].ToString() %></a>
 <%}%>
 </div>
<div class="gysxx2"><span class="gytu"><img src="images/133123_03.jpg" /></span>
<div class="gycs">
<% foreach(System.Data.DataRow row in dt1.Rows){%> 
  <p>������<%=row["��Ӧ��"].ToString() %></p>
  <p>��ַ��<%=row["��ϵ��ַ"].ToString() %></p>
  <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
  <p>�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
<%}%>
</div>

</div>

<!-- ��ҳ Ʒ����Ϣ ����-->



<!-- ��Ʒ�Ʒ����� ��ʼ-->

<div class="gydl"><div class="dlpp">��Ʒ�Ʒ�����</div>
    <div class="fxs1"><select name="" class="fu1"><option>����</option></select>  
<select name="" class="fu2"><option>����</option></select>ʡ���У�

    <select name="" class="fu3"><option>ʯ��ׯ</option></select> ����<select name="" class="fu4"><option>����</option></select> �����أ� </div>
	 <%foreach(System.Data.DataRow row in  dt2.Rows){%>
    <div class="fxs2">
       <ul>
	  
          <li class="fxsa"><%=row["��Ӧ��"].ToString()%></li>
          <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
          <li>��ϵ�ˣ�<%=row["��ϵ��"].ToString()%></li>
          <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>		  
       </ul>
    </div>
	<%}%>

</div>

<!-- ��Ʒ�Ʒ����� ����-->


<!-- ��Ʒ���²�Ʒ ��ʼ-->

<div class="gydl"><div class="dlpp">��Ʒ���²�Ʒ</div>

<%foreach(System.Data.DataRow row in dt3.Rows){%>
<div class="ppcp"><img src="images/222_03.jpg" />
<span class="ppcp1"><%=row["��ʾ��"].ToString() %></span>
<span class="ppcp2">���<%=row["����ͺ�"].ToString() %></span></div>

<%}%>

</div></div>

<!-- ��Ʒ���²�Ʒ ����-->

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->


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