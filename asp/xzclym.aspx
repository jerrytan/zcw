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
<title>��������ҳ��</title>
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
          public string Name { get; set; }  //�����б���ʾ������
		  public string GroupsCode {get; set ; }  //�����б�����������
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
            SqlDataAdapter da = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϸ����");            
            dt = ds.Tables[0];
            
			//string type = Request[""];
            SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='4'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϸ����");            
            dt1 = ds1.Tables[0];			
			conn.Close();
			                 
             this.Items1 = new List<OptionItem>();  //���ݱ�DataTableת����  
            this.Items2 = new List<OptionItem>();
            this.Items3 = new List<OptionItem>();
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];

                if (Convert.ToString(dr["�������"]).Length == 2)
                {
                    OptionItem item = new OptionItem();
                    item.Name = Convert.ToString(dr["��ʾ����"]);
                    item.GroupsCode = Convert.ToString(dr["�������"]);
                    this.Items1.Add(item);
                }
            }
            
            for (int x = 0; x < dt1.Rows.Count; x++)
            {
                DataRow dr = dt1.Rows[x];

                if (Convert.ToString(dr["�������"]).Length == 4)
                {
                    OptionItem item1 = new OptionItem();  
                    item1.Name = Convert.ToString(dr["��ʾ����"]);
                    item1.GroupsCode = Convert.ToString(dr["�������"]);
                    this.Items2.Add(item1);
                }
            }
            
               foreach (var v in this.Items1)
            {
                foreach (var vr in this.Items2)
                {
                    
                    if (vr.GroupsCode.ToString().Substring(0, 2) == v.GroupsCode.ToString())
                    {
					    OptionItem item2 = new OptionItem();  //С��
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
<div class="gyzy">�𾴵�XX����/Ůʿ������</div>

<div class="fxsxx">
<span class="fxsxx1">��˾�ķ�����Ϣ����</span>
<div class="xz1"><div class="xza"> 



<span class="xz2"><a href="#">����</a></span>
 <select name="" class="fux">
 <% foreach(var v  in Items1){%>
 <option value="<%=v.GroupsCode %>" <%=v.SelectedString %>><%=v.Name%></option>
 <%}%> 
 </select> 
 </div>
                <div class="xza"> 
				<span class="xz2"><a href="#">С��</a></span> 
				<select name="" class="fux">
				 <% foreach(var v  in Items3){%>
				<option><%=v.Name%></option>
				<%}%>
				
				</select> </div>

				
<div class="xzz"><span class="xzz0">���û���ʺϵ�С�࣬����ϵ��վ����Ա���ӣ� ��ϵ��ʽ��xxx@xxx.com.��ʹ��ģ�塣 </span>
<span class="xzz1"><a href="#">ģ�����ص�ַ</a></span></div>
</div>

<div class="fxsxx2">
<span class="srcl">�����������Ϣ</span>
 <dl>
     <dd>�������֣�</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>Ʒ    �ƣ�</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>�ͺţ�</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>����Ч����</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>���ó�����</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>
     <dd>��ש�ߴ磺</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>  
     <dd>�Ƽ۵�λ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>  
    <dd>��װ���</dd>
    <dt><input name="" type="text" class="fxsxx3"/></dt>                    
 </dl>
</div>

<div class="cpdt">
   <dl>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>

<div class="cpdt">
<span class="dmt">��ý����Ϣ</span>
   <dl>
     <dd>��Ʒ��Ƶ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>�ɹ�������</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>�������ϣ�</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>                          
 </dl>
 <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span>  
</div>



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
