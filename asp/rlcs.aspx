<!--
      ���쳧��ҳ��
	  (���û����쳧�̺� �Ѷ�Ӧ���û�id��������Ĺ�Ӧ��(���Ϲ�Ӧ����Ϣ���yh_id))
	  �ļ���:  ���쳧��.aspx 
       
	  �������:��	   

     
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
   <title>���쳧��ҳ��</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />

   <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
   <script type="text/javascript" language="javascript">

        $(function()
	    {
         $("#btnSubmit1").click(function()
		 {   //�����õ�           
            var list= $('input:radio[name="list"]:checked').val();
            if(list==null)
			{
               alert("��ѡ��һ��!");
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
          {   //Mozilla �����
              http_request = new XMLHttpRequest();
              if (http_request.overrideMimeType) 
	          {  //����MiME���
                 http_request.overrideMimeType("text/xml");
              }
          }
          else
          {
            if (window.ActiveXObject)
	        { // IE�����
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
        {     // �쳣����������ʵ��ʧ��
              window.alert("���ܴ���XMLHttpRequest����ʵ��.");
              return false;
        }
 
           var x=document.getElementsByName("list"); //��ȡ��ѡ�� ����nameΪlist
           var checkedvalue;   //�ֲ�����
           for(var i=0;i<x.length;i++)  //����ѡ�е�
            {
               if(x[i].checked)
               {
                   checkedvalue=x[i].value  //��ȡѡ�е�value��ֵ
	               window.alert(checkedvalue);
                   break;
               }
            }
            //ajax����
            http_request.open("GET", "rlcs.aspx?name="+checkedvalue, true);
            http_request.onreadystatechange = processRequest;
            http_request.send(null);
            alert("����ɹ�!");
    }
           function processRequest() 
		   {
            if (http_request.readyState == 4) 
            {     // �ж϶���״̬
                  if (http_request.status == 200) 
                  {   // ��Ϣ�Ѿ��ɹ����أ���ʼ������Ϣ
                      var response = http_request.responseText;
                      c1.innerHTML=response;
                  } 
                  else
                  {         //ҳ�治����
                      alert("���������ҳ�����쳣��");
                  }
            }
            }
</script>





</head>


<script runat="server"  > 
		
		
               protected DataTable dt = new DataTable(); //δ����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 		
               protected void Page_Load(object sender, EventArgs e)
               {           
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    string sql = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='0' ";
                    SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "���Ϲ�Ӧ����Ϣ��");
                    dt = ds.Tables[0];	

			        string yh_id = Request["name"];   //�������֮�� ��ѡ�еĹ�Ӧ��id��������Ϊ����,�޸Ĳ��Ϲ�Ӧ����Ϣ��
                    if(yh_id!=null)
			        {            
			          conn.Open();
                      string sql1 = "update ���Ϲ�Ӧ����Ϣ�� set yh_id='7' where gys_id='"+yh_id+"' ";
                      SqlCommand cmd = new SqlCommand(sql1,conn);
			          int ret = (int)cmd.ExecuteNonQuery();
                      conn.Close();			
		            }
               }
	                  
        
    </script>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->



<form id="form1" >
  <div class="rlcs"><span class="rlcszi">������������Ϣ�Ѿ��ڱ�վ���������̣� ��������ͼ</span><img src="images/www_03.jpg" /></div>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">��ѯ���</span>
      <%foreach (System.Data.DataRow row in dt.Rows)
      { %>
        <span class="rlcs6"><input name="list" type="radio" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString() %></span>
    <%} %>


   <a  onclick="send_request()" href="#"></div> <img src="images/rl_03.jpg" /></a>

  </div>

    <span class="rlcs7">�����û���ҵ���˾���������ύ��˾���ϣ��ҷ�������Ա����3���������������˹���������ͼ���£�</span>
    <span><img src="images/www_03.jpg" /></span>
  </div>

  </div>
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
