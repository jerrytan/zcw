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
              String str_gysxx = "select 公司名称,公司地址,公司电话,公司主页,手机,类型,QQ号码,姓名,是否验证通过 from 用户表 where  yh_id='"+yh_id+"' ";
              SqlDataAdapter da_yh = new SqlDataAdapter(str_gysxx, conn);
			  DataSet ds_yh = new DataSet();
              da_yh.Fill(ds_yh, "用户表");
              dt_yh = ds_yh.Tables[0]; 	              
            }		            	
        }				   
</script>

<script language="javascript">

     function Form_submit(){
	    
        if(document.form1.gys_name.value=="")
        {
          alert("贵公司名称不能为空,请填写!");
          document.form1.gys_name.focus();
          return false;
        }
        else if(document.form1.gys_address.value=="")
        {
         alert("贵公司地址不能为空,请填写!");
         document.form1.gys_address.focus();
         return false;
        }
		//else if(document.form1.gys_homepage.value=="")
        //{
         //alert("贵公司的主页不能为空,请填写");
         //document.form1.gys_homepage.focus();
         //return false;
        //}
		else if(document.form1.gys_phone.value=="")
        {
         alert("贵公司电话不能为空,请填写!");
         document.form1.gys_phone.focus();
         return false;
        }
		else if(document.form1.user_name.value=="")
        {
         alert("您的姓名不能为空,请填写!");
         document.form1.user_name.focus();
         return false;
        }
		else if(document.form1.user_phone.value=="")
        {
         alert("你的手机号码不能为空,请填写");
         document.form1.user_phone.focus();
         return false;
        }
     }
</script>


<body>

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->

<form name="form1" action="gysbtxx2.aspx" method="post" onsubmit="return Form_submit()">

<div class="gytb">

<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>

<span>
<span id="msg" style="color:Red;font-size:14px">
<%
              foreach(System.Data.DataRow row in dt_yh.Rows)
			   {
			     if(Convert.ToString(row["公司名称"])!="")
				 {
			      if(Convert.ToString(row["是否验证通过"])==""||Convert.ToString(row["是否验证通过"])=="待审核")
				  {
				  
				     Response.Write("请耐心等候,您的资料已提交,正在审核当中,我方工作");
                     Response.Write("<br>");
					 Response.Write("人员会尽快给您答复!");
					 Response.Write("<br>");
					 Response.Write("<dd>");
					 Response.Write("您的信息如下:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  }
				  if(Convert.ToString(row["是否验证通过"])=="通过")
				  {
				     Response.Write("恭喜您!审核已通过,可以对生产厂商进行认领.");				 
					 Response.Write("<br>");								 
					 Response.Write("<dd>");
					 Response.Write("您的信息如下:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  }
				  if(Convert.ToString(row["是否验证通过"])=="不通过")
				  {
				     Response.Write("审核未通过,请继续完善信息!");
					 Response.Write("<br>");								 
					 Response.Write("<dd>");
					 Response.Write("您的信息如下:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  } 
				 }
			   }                   
			 
%>
</span>


<dd>*贵公司名称：</dd>  <dt><input name="gys_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司名称"] %>"  /></dt>
<dd>*贵公司地址：</dd>  <dt><input name="gys_address" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司地址"] %>"/></dt>
<dd>*贵公司电话：</dd>  <dt><input name="gys_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司电话"] %>"/></dt>
<dd>&nbsp贵公司主页：</dd>  <dt><input name="gys_homepage" type="text" class="ggg" value="<%=dt_yh.Rows[0]["公司主页"] %>"/></dt>


<dd>&nbsp贵公司是：</dd>    
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

<dd>*您的姓名：</dd>    <dt><input name="user_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["姓名"] %>"/></dt>
<dd>*您的手机：</dd>    <dt><input name="user_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["手机"] %>"/></dt>
<dd>&nbsp您的QQ号码：</dd>  <dt><input name="user_qq" type="text" class="ggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>"/></dt>

<!--
<dd>贵公司的营业执照： </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>
-->
	
</dl>
<span class="gybtan">
    
	<!--
	
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a>
	-->
	
	<input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
    <input type="submit" value="保存" OnClick="Form_submit()"/>
	</span></div>
	<dd><span class="gybtr">*号的为必填项,不能为空!</span></dd><dt></dt>
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
