<!--
        页面名称：	采购商信息页面
        文件名：	cgsgl_3.ascx
        传入参数：	QQid 用于根据QQid取相关信息
               
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>采购商信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="js/cgsgl_3.js" type="text/javascript"></script>
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
	  public string s_yh_id="";
    public string sSQL = "";
    public DataConn objConn = new DataConn();
	protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
        if (!IsPostBack)
        {           
            sSQL = "select * from 用户表 where yh_id='" + s_yh_id + "'";

            DataTable dt_userInfo = new DataTable();
            dt_userInfo = objConn.GetDataTable(sSQL);
            if (dt_userInfo != null && dt_userInfo.Rows.Count > 0)
            {
                this.companyname.Value = dt_userInfo.Rows[0]["公司名称"].ToString();
                this.companytel.Value = dt_userInfo.Rows[0]["公司地址"].ToString();
                this.companyaddress.Value = dt_userInfo.Rows[0]["公司电话"].ToString();
                this.contactorname.Value = dt_userInfo.Rows[0]["姓名"].ToString();
                this.contactortel.Value = dt_userInfo.Rows[0]["手机"].ToString();
                this.QQ_id.Value = dt_userInfo.Rows[0]["QQ号码"].ToString();
            } 
        }
}
    protected void updateUserInfo(object sender, EventArgs e)
    {
        if (Session["yh_id"]!=null&&Session["yh_id"].ToString()!="")
        {
            s_yh_id = Session["yh_id"].ToString();
        }
        sSQL   = " update 用户表 " +
                " set 手机='" +this.contactortel.Value + "', " +
                " 姓名='" +this.contactorname.Value + "',  " +
                " 公司名称='"+this.companyname.Value+"',"+
                " 公司地址='"+this.companyaddress.Value+"',"+
                " 公司电话='"+this.companytel.Value+"',"+
                " QQ号码='"+this.QQ_id.Value+"'"+
                " where yh_id='" + s_yh_id + "'";
        objConn.ExecuteSQL(sSQL,true);
    }
	</script>
	<form runat="server">
	    <div class="cgdlqq">
		    <div class="cgdlex">
			    <div class="cgdlex2">
				    <span class="cgdlex3">您的信息如下，如需更改请单击更改按钮</span>
				    <dl>						
					    <dd>公司名称：</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>公司地址：</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>公司电话：</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
					    <dd>您的姓名：</dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>您的电话：</dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>您的QQ号：</dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>
					    <dd style="width:800px">您的执照：</dd><dt style="height:auto"><img src="images/qqqq_03.jpg" /></dt>
					    <dd style="width:800px">您的资质：</dd><dt style="height:auto"><img src="images/qqqq_03.jpg" /></dt>
				    </dl>
				    <asp:Label ID="label1" runat="server" Text="" />
				    <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
			    </div>
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
