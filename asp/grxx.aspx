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
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
<title>供应商补填信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />  
</head>
<script type="text/javascript" language="javascipt">
    function aa() {
        alert("adsfh");
    }
    function isPhone(str) {
        var reg = /^0?1[358]\d{9}$/;
        if (!reg.test(str.value) && document.getElementById("user_phone").value != "") {
            alert("手机号格式错误，请重新输入");
            document.getElementById("user_phone").focus();
        }
    }
    function yxCheck(str) {
        var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        if (!reg.test(str.value) && document.getElementById("user_email").value != "") {
            alert("请输入有效的邮箱地址");
            document.getElementById("user_email").focus();
        }
    }
</script>

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
            sSQL="select 姓名,手机,QQ号码,邮箱,类型,是否验证通过 from 用户表 where yh_id='"+s_yh_id+"'";
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
        if(this.user_phone.Value!="")
        {
            if(this.user_email.Value=="")
            {
                
                sSQL = "update 用户表 set 手机='" + this.user_phone.Value + "', 邮箱=''  where yh_id='" + s_yh_id + "'";
                objConn.ExecuteSQLForCount(sSQL, true);
                Response.Write("<script>window.alert('信息已保存成功,请返回！');window.location.href='gyszym.aspx';</"+"script>"); 
            }
            else
            {
                sSQL = "update 用户表 set 手机='" + this.user_phone.Value + "', 邮箱='"+ this.user_email.Value +"'  where yh_id='" + s_yh_id + "'";
                objConn.ExecuteSQLForCount(sSQL, true);
                Response.Write("<script>window.alert('信息已保存成功,请返回！');window.location.href='gyszym.aspx';</"+"script>"); 
            }
        }
       else
       {
           Response.Write("<script>window.alert('请输入手机号码！');</"+"script>"); 
       }
     }
</script>

<body>
<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->
<form name="form1" runat="server">
<%--<div class="gysgytb">--%>
<div class="gysgybtr2">
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
			      Response.Write("<br>");								 
			      Response.Write("<dd>");
			      Response.Write("您的信息如下:");
			      Response.Write("</dd>");
			      Response.Write("<dt>");
			      Response.Write("</dt>");
                }
                else
                {			 
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
               <%if(dt_yh!=null&&dt_yh.Rows.Count>0)
                { %>

	            <dd>您的姓名：</dd>    <dt><input  name="user_name" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["姓名"] %>" disabled/><font color="red"><strong></strong></font></dt>
	            <dd>您的手机：</dd>    <dt><input id="user_phone"   name="user_phone" type="text" class="gysggg" onblur="isPhone(this)" value="<%=dt_yh.Rows[0]["手机"] %>"/><font color="red"><strong>*</strong></font></dt>
                <dd>邮箱：</dd><dt><input id="user_email" name="user_email" class="gysggg" type="text" onblur="yxCheck(this)" value="<%=dt_yh.Rows[0]["邮箱"] %>" /></dt>
	            <dd>您的QQ号码：</dd><dt><input  name="user_qq" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>" disabled/></dt>

           <%} 
        else
        {%>
	            <dd>姓名：</dd>    <dt><input name="user_name" class="gysggg" value="<%=dt_yh.Rows[0]["姓名"]%>" disabled="disabled" type="text"/><font color="red"><strong></strong></font></dt>
	            <dd>手机：</dd>    <dt><input id="user_phone" runat="server" name="user_phone" class="gysggg" value="" type="text" onblur="isPhone(this)"/><font color="red"/><strong>*</strong></font></dt>
                <dd>邮箱：</dd><dt><input id="user_email" runat="server" name="user_email" class="gysggg" value="" type="text" onblur="yxCheck(this)"/></dt>
	            <dd>QQ号码：</dd><dt><input name="user_qq" class="gysggg" value="<%=dt_yh.Rows[0]["QQ号码"] %>" disabled="disabled" type="text"/></dt>
                <% } %> 
                <dd style="width:300px; color:Red">注意：*号的为必填项,不能为空!</dd>
		<dt style="width:80%; text-align:center;">
        <asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="~/asp/images/aaaa_03.jpg"  Width="60px" Height="20px"  onclick="ImageButton3_Click"/></dt>
	</dl>
</div>
<%--</div>--%>
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
