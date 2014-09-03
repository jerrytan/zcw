<!--
        供应商补填信息页  
        文件名:  gysbtxx.aspx   
		传入参数：s_yh_id  用户id
        author:张新颖
-->
<!-- 
蒋，2014年8月13日，118行添加if-else判断用户类型
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" EnableEventValidation="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>供应商补填信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
   
</head>

<script runat="server">
	protected DataTable dt_yh = new DataTable();  //供应商补填信息(用户表)  
	public string s_yh_id="";// <%--用户id--%>
	public string sSQL=""; 
	public DataConn objConn = new DataConn();      
	protected void Page_Load(object sender, EventArgs e)
	 {    
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
		{
			s_yh_id = Session["GYS_YH_ID"].ToString();
		}
		if(s_yh_id!="")
		{
            sSQL="select 姓名,手机,QQ号码,类型,是否验证通过 from 用户表 where yh_id='"+s_yh_id+"'";
		    dt_yh = objConn.GetDataTable(sSQL); 	              
		}		         
      
	}
   // <%--蒋，2014年9月2日--%>
    protected void ImageButton3_Click(object sender, EventArgs e)	
    {
       if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
	    {
			s_yh_id = Session["GYS_YH_ID"].ToString();
		}
       sSQL = "update 用户表 set 手机='" + this.user_phone.Value + "' where yh_id='" + s_yh_id + "'";
       objConn.ExecuteSQLForCount(sSQL, true);
       Response.Write("<script>window.alert('信息已保存成功,请返回！');window.location.href='gyszym.aspx';</"+"script>"); 
     }
</script>

<script language="javascript">
//    var phone = "";
//    function Form_submit() {
//        document.getElementById("phone").value = phone;
//	     if (document.form1.gys_name.value == "") {
//	         alert("贵公司名称不能为空,请填写!");
//	         document.form1.gys_name.focus();
//	         return false;
//	     }
//	     else if (document.form1.gys_address.value == "") {
//	         alert("贵公司地址不能为空,请填写!");
//	         document.form1.gys_address.focus();
//	         return false;
//	     }
//	     else if (document.form1.gys_phone.value == "") {
//	         alert("贵公司电话不能为空,请填写!");
//	         document.form1.gys_phone.focus();
//	         return false;
//	     }
//         //蒋，2014年8月13日，添加单位类型验证，以便后面判断类型（生产商/分销商）
//	     else if (document.form1.scs_type.value == "") {
//	         alert("请选择贵公司的单位类型!");
//	         document.form1.scs_type.focus();
//	         return false;
//         }
//	     else if (document.form1.user_name.value == "") {
//	         alert("您的姓名不能为空,请填写!");
//	         document.form1.user_name.focus();
//	         return false;
//	     }
//	     else if (document.form1.user_phone.value == "") {
//	         alert("你的手机号码不能为空,请填写");
//	         document.form1.user_phone.focus();
//	         return false;
//	     }
//	 }
</script>


<body>
<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->
<form name="form1" runat="server">

<div class="gysgytb">

<div class="gysgybtl"><img src="images/www_03.jpg" /></div>
<div class="gysgybtr">
	<dl>

		<span id="msg" style=" font-size:14px;font-weight: 600; line-height:20px;">
		<%
		   if(dt_yh.Rows[0]["是否验证通过"].ToString()=="待审核")
            {
                Response.Write("<font color='red'>请耐心等候,您的资料已提交,正在审核当中···");
			    Response.Write("<br>");
			    Response.Write("我方工作人员会尽快给您答复!</font>");
			    Response.Write("<br>");
			    Response.Write("<dd>");
			    Response.Write("您的信息如下:");
			    Response.Write("</dd>");
			    Response.Write("<dt>");
			    Response.Write("</dt>");
            }
            else if(dt_yh.Rows[0]["是否验证通过"].ToString()=="通过")
            {
               if(dt_yh.Rows[0]["类型"].ToString()=="生产商")
               {
                  Response.Write("<font color='green'>恭喜您!审核已通过,可以对生产厂商、分销商以及材料信息进行管理.</font>");				 
			      Response.Write("<br>");								 
			      Response.Write("<dd>");
			      Response.Write("您的信息如下:");
			      Response.Write("</dd>");
			      Response.Write("<dt>");
			      Response.Write("</dt>");
                }
                else
                {
                   Response.Write("<font color='green'>恭喜您!审核已通过,可以对分销商和材料信息进行管理.</font>");				 
			       Response.Write("<br>");								 
			       Response.Write("<dd>");
			       Response.Write("您的信息如下:");
			       Response.Write("</dd>");
			       Response.Write("<dt>");
			       Response.Write("</dt>");
                }
            }
            else if(dt_yh.Rows[0]["是否验证通过"].ToString()=="不通过")
            {
                Response.Write(">审核未通过,请继续完善信息!");
			    Response.Write("<br>");								 
			    Response.Write("<dd>");
			    Response.Write("您的信息如下:");
			    Response.Write("</dd>");
			    Response.Write("<dt>");
			    Response.Write("</dt>");
            }                   
					 
		%>
		</span>
        <%if(dt_yh!=null&&dt_yh.Rows.Count>0) { %>
                <%--<dd>贵公司名称：</dd> <dt><input name="gys_name" id="Text1" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["公司名称"] %>"  /><font color="red"><strong>*</strong></font></dt>
	            <dd>贵公司地址：</dd>	<dt><input name="gys_address" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["公司地址"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>贵公司电话：</dd> <dt><input name="gys_phone" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["公司电话"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>&nbsp;贵公司主页：</dd>  <dt><input name="gys_homepage" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["公司主页"] %>"/></dt>

	            <dd>&nbsp;贵公司是：</dd>    
								            <dt>
									            <select name="scs_type" id="Select1" style="width: 120px; color: Blue">
                                                <%if(dt_yh.Rows[0]["类型"].ToString()=="生产商" ){ %>
                                               
										            <option value="生产商" selected="selected">生产商</option>
										            <option value="分销商">分销商</option>      
                                               <%  }else if(dt_yh.Rows[0]["类型"].ToString()=="分销商" ){%>   
                                                    <option value="生产商">生产商</option>
										            <option value="分销商" selected="selected">分销商</option>
                                              <%}else{ %>
                                                <option value="" selected="selected">--请选择单位类型--</option>
                                                 <option value="生产商">生产商</option>
										         <option value="分销商">分销商</option>
                                              <%} %>               
									            </select>
								            </dt>
--%>
	            <dd>您的姓名：</dd>    <dt><input  name="user_name" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["姓名"] %>" disabled/><font color="red"><strong>*</strong></font></dt>
	            <dd>您的手机：</dd>    <dt><input  name="user_phone" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["手机"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>&nbsp;您的QQ号码：</dd><dt><input  name="user_qq" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>" disabled/></dt>

        <%} 
        else
        {%>
	     <%--   <dd>贵公司名称：</dd>  <dt><input name="gys_name" id="gys_name" type="text" class="gysggg" value=""  /><font color="red"><strong>*</strong></font></dt>
	        <dd>贵公司地址：</dd>  <dt><input name="gys_address" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>贵公司电话：</dd>  <dt><input name="gys_phone" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>&nbsp;贵公司主页：</dd>  <dt><input name="gys_homepage" type="text" class="gysggg" value=""/></dt>


	        <dd>&nbsp;贵公司是：</dd>    
								        <dt>
									        <select name="scs_type" id="scs_type" style="width: 120px; color: Blue">
										        <option value="生产商">生产商</option>
										        <option value="分销商">分销商</option>                        
									        </select>
								        </dt>--%>
	        <dd>您的姓名：</dd>    <dt><input name="user_name" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["姓名"]%>" disabled/><font color="red"><strong>*</strong></font></dt>
	        <dd>您的手机：</dd>    <dt><input runat="server" name="user_phone" id="user_phone" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>&nbsp;您的QQ号码：</dd>  <dt><input name="user_qq" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>" disabled/></dt>
      <% } %> 
      
	<!--
	<dd>贵公司的营业执照： </dd><dt><input name="gys_license" type="file" class="ggg" /> 
		<a href=""><img src="images/sc_03.jpg" /></a></dt>
	-->
    
		<input name="gysgys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
		<dd style="width:300px; color:Red">注意：*号的为必填项,不能为空!</dd>
		<dt style="width:80%; text-align:center;">
        <asp:ImageButton runat="server" ID="ImageButton3" ImageUrl="~/asp/images/aaaa_03.jpg"  Width="60px" Height="20px" onclick="ImageButton3_Click"/></dt>
	</dl>
</div>
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
</body>
</html>
