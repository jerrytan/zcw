<!--
        ��������ҳ��
        �ļ�����clxx.aspx
        ���������cl_id
        owner:������
               
    -->

<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ϣ����ҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="js/SJLD.js" type="text/javascript"></script>
<script runat="server"> 

        protected DataTable dt_clxx = new DataTable();   //��������(���ϱ�)
		protected DataTable dt_flxx = new DataTable();   //��������(���Ϸ����)
		protected DataTable dt_ppxx = new DataTable();   //Ʒ������(Ʒ���ֵ�)
		protected DataTable dt_scsxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_fxsxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_image = new DataTable();  //���ϴ�ͼƬ(���϶�ý����Ϣ��)
		protected DataTable dt_images = new DataTable();  //����СͼƬ(���϶�ý����Ϣ��)
        private string cl_id;
        protected DataConn dc_obj = new DataConn();
        
        protected void Page_Load(object sender, EventArgs e)
        {		      
        
			cl_id = Request["cl_id"];

            string str_sqlclname = "select ��ʾ��,fl_id,���ϱ��� from ���ϱ� where cl_id='"+cl_id+"' ";           
            dt_clxx = dc_obj.GetDataTable(str_sqlclname);

             //���ϱ���ʼ�����1
            string str_updatecounter = "update ���ϱ� set ���ʼ��� = (select ���ʼ��� from ���ϱ� where cl_id = '"+ cl_id +"')+1 where cl_id = '"+ cl_id +"'";   
            dc_obj.ExecuteSQL(str_updatecounter,true);
			
            string fl_id = Convert.ToString(dt_clxx.Rows[0]["fl_id"]);
			string str_sqlxsmz = "select ��ʾ����,������� from ���Ϸ���� where fl_id='"+fl_id+"' ";           
            dt_flxx = dc_obj.GetDataTable(str_sqlxsmz);
			
			string str_sqlppmc = "select Ʒ������,����ͺ�,���ϱ��� from ���ϱ� where cl_id='"+cl_id+"' ";            
            dt_ppxx = dc_obj.GetDataTable(str_sqlppmc);
			
			string str_sqlgysxx =  "select ��ϵ���ֻ�,��Ӧ��,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where ��λ����='������' and gys_id in (select gys_id from ���ϱ� where cl_id='"+cl_id+"') ";
            dt_scsxx = dc_obj.GetDataTable(str_sqlgysxx);
			
            string str_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id = (select pp_id from ���ϱ� where cl_id='"+cl_id+"'))";         
            dt_fxsxx = dc_obj.GetDataTable(str_fxsxx);
			
			string str_sqltop3 =  "select top 3 ��ŵ�ַ,�������� from ���϶�ý����Ϣ�� where cl_id='"+cl_id+"' and ý������ = 'ͼƬ' and ��С='��'";        
            dt_image = dc_obj.GetDataTable(str_sqltop3);
			
			string str_sqlfcdz = "select ��ŵ�ַ,�������� from ���϶�ý����Ϣ�� where cl_id='"+cl_id+"' and ý������ = 'ͼƬ' and ��С='С'";            
            dt_images = dc_obj.GetDataTable(str_sqlfcdz);   
        }		
        
</script>
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

<div class="sc">
    <!-- ���������� ��ʼ -->
    <div class="sc1"><a href="index.aspx">��ҳ ></a>
    <% foreach(System.Data.DataRow row in dt_flxx.Rows){%>
        <a href="ejfl.aspx?name=<%=row["�������"].ToString() %>"><%=row["��ʾ����"].ToString() %></a>
    <%}%>> 
    <% foreach(System.Data.DataRow row in dt_clxx.Rows){%>
        <a href="clxx.aspx?cl_id=<%=cl_id %>"><%=row["��ʾ��"].ToString() %></a>
    <%}%>
    </div>
    <!-- ���������� ���� -->
    <div class="xx1">
        <div class="xx2">
            <div style="HEIGHT: 300px; OVERFLOW: hidden;" id="idTransformView">
                <ul id="idSlider" class="slider">
                    <div style="POSITION: relative">
                    <%
	                foreach(System.Data.DataRow row in dt_images.Rows)
                    {
	                    if(dt_images.Rows[0]["��ŵ�ַ"]!="")
	                    {%>
                            <a ><img  src="<%=dt_images.Rows[0]["��ŵ�ַ"].ToString()%>" width=320 height=300 id="bigImage"></a>
                        <%}
                    }%>
                    </div>
                </ul>
            </div>
        <div>
        <ul id="idNum" class="hdnum">
        <% for (int i=0;i< dt_images.Rows.Count;i++) 
        {
            System.Data.DataRow row =dt_images.Rows[i];
        %>   
            <li>
                <img src='<%=row["��ŵ�ַ"].ToString()%>' width=61px height=45px onmouseover="changeImage('<%=row["��ŵ�ַ"].ToString()%>')">
            </li>
        <%}%>
        </ul>
        </div>
</div>

<div class="xx3">
 <dl>
  <% foreach(System.Data.DataRow row in dt_ppxx.Rows){%>
  <dd>Ʒ��:</dd>
  <dt><%=row["Ʒ������"].ToString() %></dt>
  <dd>�ͺ�:</dd>
  <dt><%=row["����ͺ�"].ToString() %></dt>
  <dd>����:</dd>
  <dt><%=row["���ϱ���"].ToString() %></dt>
  <%}%> 
 </dl>
 <span class="xx4" style=" display:block; margin-left:40%; margin-right:auto;"  onclick="sc_login(<%=cl_id %>)">
    <a href="" onclick="NewWindow(<%=cl_id %>)">���ղأ����ڲ���</a>
 </span>
 </div>
</div>

<div class="xx5"><img src="images/sst_03.jpg" />
<div class="xx6">
         <ul>
          <li class="xx7">��������Ϣ</li>
		<% foreach(System.Data.DataRow row in dt_scsxx.Rows){%>  
          <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
          <li>������<%=row["��Ӧ��"].ToString()%></li>
          <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
          <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
          </a>
		<%}%>  
       </ul>
</div>
</div>

<div class="xx8" >
<div class="xx9">
<div class="fxs1">
	<select id="s1" class="fu1"><option></option></select> ʡ���У�
	<select id="s2" class="fu2"><option></option></select> �ؼ���
    <select id="s3" class="fu3"><option>�С��ؼ��С���</option></select> �С��ؼ��С���
    	<script type="text/javascript"  language ="javascript" > 
<!--
    	    //** Power by Fason(2004-3-11) 
    	    //** Email:fason_pfx@hotmail.com
    	    var s = ["s1", "s2", "s3"];
    	    var opt0 = ["ʡ��", "�ؼ���", "�С��ؼ��С���"];
    	    for (i = 0; i < s.length - 1; i++)
    	        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
    	    change(0);
//--> 
</script> 
</div>
	<% foreach(System.Data.DataRow row in dt_fxsxx.Rows){%>
    <div class="fxs2">
       <ul>
          <li class="fxsa">������:</li>
          <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
          <li>������<%=row["��Ӧ��"].ToString()%></li>
          <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
          <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
          </a>
       </ul>
    </div>
	<%}%>
    
</div></div>
<%foreach(System.Data.DataRow row in dt_image.Rows){%>
<div class="xx10">
  <div class="xx11"><img src="<%=row["��ŵ�ַ"].ToString()%>" /></div>
</div>
<%}%>

    
<% if (cl_id.Equals("74")) { %>
<div class="xx10">
    <div class="xx11">������Ƶ</div>
    <embed src="http://tv.people.com.cn/img/2010tv_flash/outplayer.swf?xml=/pvservice/xml/2011/10/6/12d1c210-dd85-4872-8eb2-33b224fb0743.xml&key=�������:/150716/152576/152586/&quote=1&" quality="high" width="480" height="384" align="middle" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash"></embed>
</div>
<% } %>

</div>

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->

<script type="text/javascript">
    function NewWindow(id) {
        var url = "sccl.aspx?cl_id="+id;
        window.open(url,"","height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function changeImage(src) {
        document.getElementById("bigImage").src = src;
    }
</script>


</body>
</html>