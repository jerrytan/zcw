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
	public userInfoObject userInfo;
	protected void Page_Load(object sender, EventArgs e){
	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
  SqlConnection conn = new SqlConnection(constr);
  conn.Open();
  string yh_id ;
  //yh_id= Session["yh_id"].ToString();
  yh_id="20";
  string queryUserInfo = "select * from 用户表 where yh_id='" + yh_id + "'";
  SqlDataAdapter da = new SqlDataAdapter(queryUserInfo, conn);
  DataSet ds = new DataSet();
  da.Fill(ds, "用户表");
  DataTable userInfoDS = new DataTable();
  userInfoDS = ds.Tables[0];
  if (userInfoDS.Rows.Count > 0){
  	DataRow dr2 = userInfoDS.Rows[0];   
    userInfo = new userInfoObject();
  //userInfo.companyname = Convert.ToString(userInfoDS["显示名"]);
  //userInfo.companyaddress = Convert.ToString(userInfoDS["分类编码"]);
  //userInfo.companytel = Convert.ToString(userInfoDS["手机"]);
    userInfo.contactorname = Convert.ToString(dr2["姓名"]);
    userInfo.contactortel = Convert.ToString(dr2["手机"]);
  //userInfo.contactqqid = Session["qq_id"].ToString();
   // contactorname.Text = userInfo.contactorname;
   // contactortel.Text = userInfo.contactortel;
    conn.Close();
  }
}
  

  public class userInfoObject
  { //属性
  	public string companyname { get; set; }
    public string companyaddress { get; set; }
    public string companytel { get; set; }
    public string contactortel { get; set; }
    public string contactorname { get; set; }
    public string contactqqid { get; set; }
    //public string Uid { get; set; }   
  }
</script>

<form runat="server">
	<script runat="server">
	protected void updateUserInfo(object sender, EventArgs e)
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
  	string yh_id;// = Session["yh_id"].ToString();
  	yh_id = Session["yh_id"].ToString();
  	//yh_id = "20";
  	
  //userInfo.companyname = Convert.ToString(userInfoDS["显示名"]);
  //userInfo.companyaddress = Convert.ToString(userInfoDS["分类编码"]);
  //userInfo.companytel = Convert.ToString(userInfoDS["手机"]);
  	
  	string updateUserinfoString = " update 用户表 " +
  	                              "    set 手机='" + Request.Form["contactortel"]  + "', " +
  	                              "        姓名='" + Request.Form["contactorname"] + "'  " + 
  	                              "  where yh_id='" + yh_id + "'" ;
  	SqlCommand cmd_updateUserinfo = new SqlCommand(updateUserinfoString, conn);         
    cmd_updateUserinfo.ExecuteNonQuery();
    //label1.Text=str_cancelfollow;
  	conn.Close();
  	//label1.Text = updateUserinfoString;
  	userInfo.contactorname =Request.Form["contactorname"];
    userInfo.contactortel =  Request.Form["contactortel"];
  }
	</script>
	
<div class="dlqq">
    <div class="dlex">
        <div class="dlex2">
            <span class="dlex3">您的信息如下，如需更改请单击更改按钮</span>
            <dl>
							<dd>公司名称：</dd><dt><input name="companyname" type="text"  value="北京京企在线"/></dt>
							<dd>公司地址：</dd><dt><input name="companyaddress" type="text"  value="北京京企在线"/></dt>
							<dd>公司电话：</dd><dt><input name="companytel" type="text"  value="北京京企在线"/></dt>
     					<dd>您的姓名：</dd><dt><input name="contactorname" value="<%= userInfo.contactorname %>"/></dt>
     					<dd>您的电话：</dd><dt><input name="contactortel" value="<%= userInfo.contactortel %>" /></dt>
     					<dd>您的QQ号：</dd><dt><%=userInfo.contactqqid %></dt>
     					<dd>您的执照：</dd><dt><img src="images/qqqq_03.jpg" /></dt>
     					<dd>您的资质：</dd><dt><img src="images/qqqq_03.jpg" /></dt>
            </dl>
            <asp:Label ID="label1" runat="server" Text="" />
            <span class="gg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
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
var speed=9//速度数值越大速度越慢
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
