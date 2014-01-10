<!--
        材料详情页面
        文件名：clxx.ascx
        传入参数：cl_id
               
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
<title>材料信息详情页</title>
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

<script runat="server"> 

        protected DataTable dt_clxx = new DataTable();   //材料名字(材料表)
		protected DataTable dt_flxx = new DataTable();   //分类名称(材料分类表)
		protected DataTable dt_ppxx = new DataTable();   //品牌名称(品牌字典)
		protected DataTable dt_scsxx = new DataTable();   //生产商信息(材料供应商信息表)
		protected DataTable dt_fxsxx = new DataTable();  //分销商信息(材料供应商信息表)
		protected DataTable dt_image = new DataTable();  //材料大图片(材料多媒体信息表)
		protected DataTable dt_images = new DataTable();  //材料小图片(材料多媒体信息表)
        string cl_id;
        
        protected void Page_Load(object sender, EventArgs e)
        {		      
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			cl_id = Request["cl_id"];

            SqlDataAdapter da_clxx = new SqlDataAdapter("select 显示名,fl_id,材料编码 from 材料表 where cl_id='"+cl_id+"' ", conn);
            DataSet ds_clxx = new DataSet();
            da_clxx.Fill(ds_clxx, "材料表");            
            dt_clxx = ds_clxx.Tables[0];

             //材料表访问计数加1
            String str_updatecounter = "update 材料表 set 访问计数 = (select 访问计数 from 材料表 where cl_id = '"+ cl_id +"')+1 where cl_id = '"+ cl_id +"'";
            SqlCommand cmd_updatecounter = new SqlCommand(str_updatecounter, conn);         
            cmd_updatecounter.ExecuteNonQuery();
			
            String fl_id = Convert.ToString(dt_clxx.Rows[0]["fl_id"]);
			SqlDataAdapter da_flxx = new SqlDataAdapter("select 显示名字 from 材料分类表 where fl_id='"+fl_id+"' ", conn);
            DataSet ds_flxx = new DataSet();
            da_flxx.Fill(ds_flxx, "材料分类表");           
            dt_flxx = ds_flxx.Tables[0];
			
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,规格型号,材料编码 from 材料表 where cl_id='"+cl_id+"' " , conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "材料表");            
            dt_ppxx = ds_ppxx.Tables[0];
			
			SqlDataAdapter da_scsxx = new SqlDataAdapter("select 联系人手机,供应商,联系地址,gys_id from 材料供应商信息表 where 单位类型='生产商' and gys_id in (select gys_id from 材料表 where cl_id='"+cl_id+"') " , conn);
            DataSet ds_scsxx = new DataSet();
            da_scsxx.Fill(ds_scsxx, "材料供应商信息表");            
            dt_scsxx = ds_scsxx.Tables[0];
			
            String str__fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"'))";
			SqlDataAdapter da_fxsxx = new SqlDataAdapter(str__fxsxx , conn);
            DataSet ds_fxsxx = new DataSet();
            da_fxsxx.Fill(ds_fxsxx, "材料供应商信息表");            
            dt_fxsxx = ds_fxsxx.Tables[0];
			
			SqlDataAdapter da_image = new SqlDataAdapter("select top 3 存放地址,材料名称 from 材料多媒体信息表 where cl_id='"+cl_id+"' and 媒体类型 = '图片' and 大小='大'" , conn);
            DataSet ds_image = new DataSet();
            da_image.Fill(ds_image, "材料多媒体信息表");            
            dt_image = ds_image.Tables[0];
			
			SqlDataAdapter da_images = new SqlDataAdapter("select 存放地址,材料名称 from 材料多媒体信息表 where cl_id='"+cl_id+"' and 媒体类型 = '图片' and 大小='小'" , conn);
            DataSet ds_images = new DataSet();
            da_images.Fill(ds_images, "材料多媒体信息表");            
            dt_images = ds_images.Tables[0];
		   
        }		
        
</script>

<div class="sc">
<div class="sc1"><a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp

<% foreach(System.Data.DataRow row in dt_flxx.Rows){%>
 <a href="#"><%=row["显示名字"].ToString() %></a>
 <%}%>
> 
<% foreach(System.Data.DataRow row in dt_clxx.Rows){%>
 <a href="#"><%=row["显示名"].ToString() %></a>
 <%}%>

</div>
<div class="xx1">
<div class="xx2">
<div style="HEIGHT: 300px; OVERFLOW: hidden;" id=idTransformView>
<ul id=idSlider class=slider>
  <div style="POSITION: relative">
     
    <%
	foreach(System.Data.DataRow row in dt_images.Rows){
	if(dt_images.Rows[0]["存放地址"]!="")
	{%>
      <a ><img  src="<%=dt_images.Rows[0]["存放地址"].ToString()%>" width=320 height=300 id="bigImage"></a>
    <%}}%>
  </div>
  
</ul>
</div>

<div>
<ul id=idNum class=hdnum>
   
  <% for (int i=0;i< dt_images.Rows.Count;i++) {
       
      System.Data.DataRow row =dt_images.Rows[i];
  %>   
  <li>
      <img src='<%=row["存放地址"].ToString()%>' width=61px height=45px onmouseover="changeImage('<%=row["存放地址"].ToString()%>')">

  </li>
  <%}%>
  
   
</ul>

</div></div>

<div class="xx3">
 <dl>
  <% foreach(System.Data.DataRow row in dt_ppxx.Rows){%>
  <dd>品牌:</dd>
  <dt><%=row["品牌名称"].ToString() %></dt>
  <dd>型号:</dd>
  <dt><%=row["规格型号"].ToString() %></dt>
  <dd>编码:</dd>
  <dt><%=row["材料编码"].ToString() %></dt>
  <%}%>

 </dl>
 <span class="xx4" onclick="sc_login(<%=cl_id %>)"><a href="" onclick="NewWindow(<%=cl_id %>)">请收藏，便于查找</a></span></div>
</div>

<div class="xx5"><img src="images/sst_03.jpg" />
<div class="xx6">
         <ul>
          <li class="xx7">生产商信息</li>
		<% foreach(System.Data.DataRow row in dt_scsxx.Rows){%>  
          <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
          <li>厂名：<%=row["供应商"].ToString()%></li>
          <li>地址：<%=row["联系地址"].ToString()%></li>
          <li>电话：<%=row["联系人手机"].ToString()%></li>
          </a>
		<%}%>  
       </ul>
</div>
</div>

<div class="xx8">
<div class="xx9"><div class="fxs1">
<select name="" class="fu1"><option>华北</option></select>  
<select name="" class="fu2"><option>北京</option></select>省（市）
    <select name="" class="fu3"><option>石家庄</option></select> 地区
	<select name="" class="fu4"><option>市区</option></select> 区（县） </div>
	<% foreach(System.Data.DataRow row in dt_fxsxx.Rows){%>
    <div class="fxs2">
       <ul>
          <li class="fxsa">分销商:</li>
          <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
          <li>厂名：<%=row["供应商"].ToString()%></li>
          <li>地址：<%=row["联系地址"].ToString()%></li>
          <li>电话：<%=row["联系人手机"].ToString()%></li>
          </a>
       </ul>
    </div>
	<%}%>
    
</div></div>
<%foreach(System.Data.DataRow row in dt_image.Rows){%>
<div class="xx10">
  <dl>
     
  </dl>
  <div class="xx11"><img src="<%=row["存放地址"].ToString()%>" /></div>
</div>
<%}%>

    
<% if (cl_id.Equals("74")) { %>
<div class="xx10">
    <div class="xx11">介绍视频</div>
    <embed src="http://tv.people.com.cn/img/2010tv_flash/outplayer.swf?xml=/pvservice/xml/2011/10/6/12d1c210-dd85-4872-8eb2-33b224fb0743.xml&key=人民电视:/150716/152576/152586/&quote=1&" quality="high" width="480" height="384" align="middle" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash"></embed>
    
</div>
<% } %>

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
<script>function NewWindow(id) {
    var url = "sccl.aspx?cl_id="+id;
    window.open(url,"","height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
}
    function changeImage(src) {
        document.getElementById("bigImage").src = src;
        
    }
</script>


</body>
</html>