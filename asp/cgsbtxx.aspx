<!--
    采购商补填信息页面
    文件名：cgsbtxx.aspx
    传入参数：Session["yh_id"]  用户id 
	author：张新颖
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>采购商补填信息页</title>
	<link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/cgsbtxx.js" type="text/javascript"></script>
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
	public string s_yh_id = "";
    public DataConn objConn = new DataConn();
    public bool b=false;
    public string s_yz = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["CGS_YH_ID"].ToString();
            }
            
            string sSQL_yh = "select * from 用户表 where yh_id='" + s_yh_id + "'";
            DataTable dt_yh = new DataTable();
            dt_yh = objConn.GetDataTable(sSQL_yh);
            if (dt_yh != null && dt_yh.Rows.Count > 0)
            {
                //this.companyname.Value = dt_yh.Rows[0]["公司名称"].ToString();
                //this.companyaddress.Value = dt_yh.Rows[0]["公司地址"].ToString();
                //this.companytel.Value = dt_yh.Rows[0]["公司电话"].ToString();
                this.contactorname.Value = dt_yh.Rows[0]["姓名"].ToString();
                this.contactortel.Value = dt_yh.Rows[0]["手机"].ToString();
                this.contactorqqid.Value = dt_yh.Rows[0]["QQ号码"].ToString();               
				s_yz=dt_yh.Rows[0]["是否验证通过"].ToString();
            }
        }      
    }

    protected void updateUserInfo(object sender, EventArgs e)
    {      
		if(Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="") 
		{
		  s_yh_id = Session["CGS_YH_ID"].ToString();
		}
     
		    if (this.contactortel.Value == "")
        {
            objConn.MsgBox(this.Page, "手机不能为空,请填写!");
            this.contactortel.Focus();
            return;
        }
        if (this.contactorname.Value == "")
        {
            objConn.MsgBox(this.Page, "姓名不能为空,请填写!");
            this.contactorname.Focus();
            return;
        }
        if (this.contactorqqid.Value == "")
        {
            objConn.MsgBox(this.Page, "QQ号码不能为空,请填写!");
            this.contactorqqid.Focus();
            return;
        }
        //if (this.companyname.Value == "")
        //{
        //    objConn.MsgBox(this.Page, "公司名称不能为空,请填写!");
        //    this.companyname.Focus();
        //    return;
        //}
        //if (this.companyaddress.Value == "")
        //{
        //    objConn.MsgBox(this.Page, "公司地址不能为空,请填写!");
        //    this.companyaddress.Focus();
        //    return;
        //}
        //if (this.companytel.Value == "")
        //{
        //    objConn.MsgBox(this.Page, "公司电话不能为空,请填写!");
        //    this.companytel.Focus();
        //    return;
        //}
        string s_updateUserinfo = " update 用户表   set 手机='" +this.contactortel.Value + "', 姓名='" +this.contactorname.Value +
                                  "',QQ号码='"+this.contactorqqid.Value+"',是否验证通过='待审核',类型='采购商' where yh_id='" + s_yh_id + "',updatetime=(select getdate()";
                                  b=objConn.ExecuteSQL(s_updateUserinfo, true);
         if(!b)
        {
            objConn.MsgBox(this.Page, "更新失败，请重试！");
        }
       
    }
		</script>

<form runat="server">   
	<div class="cggytb">
		<div class="cggybtl"><img src="images/www_03.jpg" /></div>
         <%if(s_yz=="待审核"){%>
                <span style=" color:Red">您提交的信息正在审核中，请您耐心等待!</span>
          <%}
           else if (s_yz == "不通过")
           { %>
           <span style=" color:Red">您提交的信息未通过审核，请您重新填写个人信息并提交!</span>
          <%} %>
		<div class="cggybtr">
			<dl>
				<%--<dd>贵公司名称：</dd>  	<dt><input id="companyname" name="companyname" type="text" class="cgggg" runat="server"  /></dt>
				<dd>贵公司地址：</dd>  	<dt><input id="companyaddress" name="companyaddress" type="text" class="cgggg" runat="server" /></dt>
				<dd>贵公司电话：</dd>  	<dt><input id="companytel" name="companytel" type="text" class="ggg" runat="server" /></dt>--%>
				<dd>您的姓名：</dd>    		<dt><input  id="contactorname" name="contactorname" type="text" disabled class="cgggg" runat="server"/></dt>
				<dd>您的电话：</dd>    		<dt><input id="contactortel" name="contactortel" type="text" class="cgggg"  runat="server"/></dt>			
				<dd>您的QQ号码：</dd>   	<dt><input id="contactorqqid" name="contactorqqid" type="text" disabled class="cgggg" runat="server" /></dt>
				<%--<dd>贵公司的营业执照： 	</dd><dt><input name="" type="text" class="ggg" /> <a href="#"><img src="images/sc_03.jpg" /></a></dt>--%>
				<%--<dd>贵公司的资质证书： 	</dd><dt><input name="" type="text" class="ggg" /> <a href="#"><img src="images/sc_03.jpg" /></a></dt>--%>
			</dl>
			<span class="cggybtan"><asp:ImageButton runat="server" ID="updateButtion" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
		</div>
	</div>
</form>
	<div>
	<!-- 关于我们 广告服务 投诉建议 开始-->
	<!-- #include file="static/aboutus.aspx" -->
	<!-- 关于我们 广告服务 投诉建议 结束-->
	</div>
	<div>
	<!--  footer 开始-->
	<!-- #include file="static/footer.aspx" -->
	<!-- footer 结束-->
	</div>

</body>
</html>
