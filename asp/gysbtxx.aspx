<!--
        供应商补填信息页  (未做)
        文件名:  gysbuxx.aspx   
        
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>供应商补填信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script>
        function formsubmit()
        {
            //alert("shit");
            document.getElementById("gysbtxx").submit();
        }
    </script>
</head>

<script runat="server">
        protected DataTable dt_yh = new DataTable();  //供应商补填信息(用户表)            

        protected void Page_Load(object sender, EventArgs e)
        {            
			string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]); 	 //获取表单的用户id	 
			//String yh_id = "29"; 	 //获取表单的用户id	
            if(yh_id!="")
			{
              String str_gysxx = "select 公司名称,公司地址,公司电话,公司主页,手机,类型,QQ号码,姓名 from 用户表 where  yh_id='"+yh_id+"' ";
              SqlDataAdapter da_yh = new SqlDataAdapter(str_gysxx, conn);
			  DataSet ds_yh = new DataSet();
              da_yh.Fill(ds_yh, "用户表");
              dt_yh = ds_yh.Tables[0]; 
              
            }			
            	
        }
</script>

<body>

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->

<form action="gysbtxx2.aspx" method="post">

<div class="gytb">

<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>
<dd>贵公司名称：</dd>  <dt><input name="gys_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司名称"] %>"  /></dt>
<dd>贵公司地址：</dd>  <dt><input name="gys_address" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司地址"] %>"/></dt>
<dd>贵公司主页：</dd>  <dt><input name="gys_homepage" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司主页"] %>"/></dt>
<dd>贵公司电话：</dd>  <dt><input name="gys_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司电话"] %>"/></dt>

<dd>贵公司是：</dd>    
<!--
<dt><input name="gys_type" type="radio" value="scs" checked>生产商  
    <input name="gys_type" type="radio" value="fxs" />分销商 </dt>
-->	
                            <dt>
						    <select name="scs_type" id="scs_type" style="width: 120px; color: Blue">
                            <option value="生产商">生产商</option>
                            <option value="分销商">分销商</option>                        
                            </select>
							</dt>

<dd>您的姓名：</dd>    <dt><input name="user_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["姓名"] %>"/></dt>
<dd>您的手机：</dd>    <dt><input name="user_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["手机"] %>"/></dt>
<dd>您的QQ号码：</dd>  <dt><input name="user_qq" type="text" class="ggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>"/></dt>
<dd>贵公司的营业执照： </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>

</dl>
<span class="gybtan">
    
	<!--
	<%string yh_id = Convert.ToString(Session["yh_id"]);     //获取session中的用户id%>
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a>
	-->
	
	<input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
    <input type="submit" value="保存" />
	</span></div>
	
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


</body>
</html>
