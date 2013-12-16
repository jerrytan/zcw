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
<script type=text/javascript src="js/lrtk.js"></script>
<script type=text/javascript src="js/jquery-1.4.2.min.js"></script>
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
         protected DataTable dt = new DataTable();   //材料名字(材料表)
		 protected DataTable dt1 = new DataTable();   //一级分类名称(材料分类表)
		 protected DataTable dt2 = new DataTable();   //品牌名称,规格型号(品牌字典)
		 protected DataTable dt3 = new DataTable();   //生产商信息(材料供应商信息表)
		 protected DataTable dt4 = new DataTable();  //分销商信息(材料供应商信息表)
        string cl_id;
        protected void Page_Load(object sender, EventArgs e)
        {		      
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
			cl_id = Request["cl_id"];
            SqlDataAdapter da = new SqlDataAdapter("select 显示名,fl_id,材料编码 from 材料表 where cl_id='"+cl_id+"' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料表");            
            dt = ds.Tables[0];

             //访问计数加1
            String str_updatecounter = "update 材料表 set 访问计数 = (select 访问计数 from 材料表 where cl_id = '"+ cl_id +"')+1 where cl_id = '"+ cl_id +"'";
            SqlCommand cmd_updatecounter = new SqlCommand(str_updatecounter, conn);         
            cmd_updatecounter.ExecuteNonQuery();
			
			string fl_id = Request["fl_id"];//获取传过来的一级分类编码
			SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字 from 材料分类表 where 分类编码='"+fl_id+"' ", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表");           
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select 品牌名称,规格型号 from 材料表 where cl_id='"+cl_id+"' " , conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料表");            
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select 联系人手机,供应商,联系地址,gys_id from 材料供应商信息表 where 单位类型='生产商' and gys_id in (select gys_id from 材料表 where cl_id='"+cl_id+"') " , conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "材料供应商信息表");            
            dt3 = ds3.Tables[0];
			
            String sql_str = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"'))";
			SqlDataAdapter da4 = new SqlDataAdapter(sql_str , conn);
            DataSet ds4 = new DataSet();
            da4.Fill(ds4, "材料供应商信息表");            
            dt4 = ds4.Tables[0];
		   
        }		
        
</script>

<div class="sc">
<div class="sc1"><a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp

<% foreach(System.Data.DataRow row in dt1.Rows){%>
 <a href="#"><%=row["显示名字"].ToString() %></a>
 <%}%>
> 
<% foreach(System.Data.DataRow row in dt.Rows){%>
 <a href="#"><%=row["显示名"].ToString() %></a>
 <%}%>

</div>
<div class="xx1">
<div class="xx2">
<div style="HEIGHT: 300px; OVERFLOW: hidden;" id=idTransformView>
<ul id=idSlider class=slider>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="2013年宜宾市规划设计成果求意见" src="images/01.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="宜宾县16日起限制部分车辆同行" src="images/02.jpg" width=320 height=300></a>
  </div>
  
  <div style="POSITION: relative">
   
   
    <a href="http://www.lanrentuku.com/" target="_blank"><img alt="网络“神兽”到宜宾了！" src="images/03.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
      
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="客人吃醉了!宜宾星乐迪小伙伴拾“金”归还" src="images/04.jpg" width=320 height=300></a>
  </div>
  <div style="POSITION: relative">
     
     
      <a href="http://www.lanrentuku.com/" target="_blank"><img alt="宜宾翠柏大道又发生惨烈车祸，别克车被压变" src="images/05.jpg" width=320 height=300></a>
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
  <dd>品牌:</dd>
  <dt><%=row["品牌名称"].ToString() %></dt>
  <dd>型号:</dd>
  <dt><%=row["规格型号"].ToString() %></dt>
  <%}%>

 </dl>
 <span class="xx4" onclick="sc_login(<%=cl_id %>)"><a href="" onclick="NewWindow(<%=cl_id %>)">请收藏，便于查找</a></span></div>
</div>

<div class="xx5"><img src="images/sst_03.jpg" />
<div class="xx6">
         <ul>
          <li class="xx7">生产商信息</li>
		<% foreach(System.Data.DataRow row in dt3.Rows){%>  
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
	<% foreach(System.Data.DataRow row in dt4.Rows){%>
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

<div class="xx10"><img src="images/231_03.jpg" />
  <dl>
     
  </dl>
  <div class="xx11"><img src="images/231_03.jpg" /></div>
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
<script>function NewWindow(id) {
    var url = "sccl.aspx?cl_id="+id;
    window.open(url,"","height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
}
</script>

</body>
</html>
