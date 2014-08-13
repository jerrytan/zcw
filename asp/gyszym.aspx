<!--
        页面名称：	供应商主页面
        文件名：	gyszym.ascx
        传入参数：	QQid 用于根据QQid取相关信息
         author：张新颖      
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>供应商主页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script  runat="server">
    public DataTable dt_yh=new  DataTable();
    public DataConn objConn=new DataConn();
    public string s_QQ_id="";
    public string passed="";
    public string name="";
    public string passed_gys = "";
    public string s_yh_id = "";
    public string lx="";
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (Request.Cookies["GYS_QQ_ID"]!=null&& Request.Cookies["GYS_QQ_ID"].Value.ToString()!="")
        {
             s_QQ_id= Request.Cookies["GYS_QQ_ID"].Value.ToString();
        }
        if(s_QQ_id!="")
        {            
            string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '" + s_QQ_id + "'";
            string s_Count=objConn.DBLook(str_checkuserexist);    
            if (s_Count != "")
            {
                int count = Convert.ToInt32(s_Count);
                if (count == 0)  //qq_id 不存在，需要增加用户表
                {
                    string str_insertuser = "insert into 用户表 (QQ_id) VALUES ('" + s_QQ_id + "')";
                     if(!objConn.ExecuteSQL(str_insertuser,false))
                       {
                         // objConn.MsgBox(this.Page,"执行SQL语句失败"+str_insertuser);
                       }
               
                    string str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + s_QQ_id + "')"
				    +",updatetime=(select getdate()),注册时间=(select getdate())where QQ_id = '" + s_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          //objConn.MsgBox(this.Page,"执行SQL语句失败"+str_updateuser);
                       }
                } 
            }
            string s_SQL="select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='" + s_QQ_id + "'";      
             dt_yh = objConn.GetDataTable(s_SQL);
             
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {

                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                passed = dt_yh.Rows[0]["是否验证通过"].ToString();
                name = dt_yh.Rows[0]["姓名"].ToString();
                lx= dt_yh.Rows[0]["类型"].ToString();
		    }
            if (lx == "采购商")
            {
              
                string cookieName = "";
                cookieName = "GYS_QQ_ID";
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }
                foreach (string cookiename in  Request.Cookies.AllKeys)
				{
					HttpCookie cookies = Request.Cookies[cookiename];
					if (cookies != null)
					{
					   cookies.Expires = DateTime.Today.AddDays(-1);
					   Response.Cookies.Add(cookies);
					   Request.Cookies.Remove(cookiename);
					}
				}    
				Response.Write("<script>window.alert('您是采购商，不能用供销商身份登录！');window.location.href='index.aspx';</" + "script>");
            }
                
            else
            {

                //need to set session value

                Session["GYS_YH_ID"] = s_yh_id;

                //(供应商申请)的yh_id 是在认领厂商之后更新的
                ////蒋，2014年8月8日，注释认领模块的功能
                //string sSQL = "select 审批结果 from 供应商认领申请表 where yh_id='" + s_yh_id + "' ";
                //DataTable dt_gyssq = new DataTable();
                //dt_gyssq = objConn.GetDataTable(sSQL);
                //if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                //{
                //    passed_gys = dt_gyssq.Rows[0]["审批结果"].ToString();
                //}
                ////蒋，2014年8月8日，加供应商用户登录后，填补完个人信息后，判断用户类型
                string sSQL = "select 类型 from 用户表 where yh_id='" + s_yh_id + "'";
                DataTable dt_gyssq = new DataTable();
                dt_gyssq = objConn.GetDataTable(sSQL);
                if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                {
                    passed_gys = dt_gyssq.Rows[0]["类型"].ToString();
                }
            }
       }
     else
      {
             objConn.MsgBox(this.Page,"QQ_ID不存在！请重新登录");
       }

    }
    </script>

<body>
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->
    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp 身份信息经过我方工作人员确认后，您可以进行管理生产商、管理分销商以及管理材料信息等（图1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
                if (passed == "待审核")
                {
                    Response.Write("请耐心等候,您更新的个人资料已提交,正在审核当中,我方工作人员会尽快给您答复!");
                }
                else if (passed == "通过")
                {
                    //蒋，2014年8月8日，注释if-else，加输入语句
                    //if (passed_gys == "通过")
                    //{
                    //    Response.Write("恭喜您!厂商已认领成功,可以进行管理");
                    //}
                    //else if (passed_gys != "通过")
                    //{
                    //    Response.Write("恭喜您!审核已通过,可以对生产厂商进行认领");
                    //}
                    Response.Write("恭喜您！审核已通过，可以对生产商，分销商和材料进行管理");
                }
                else
                {
                    Response.Write("您尚未补充个人信息，请填写个人信息");
                }    
                  //if(passed_gys.Equals("通过")&&Convert.ToString(row["是否验证通过"])=="通过")  
                  //{
                  //   Response.Write("恭喜您!厂商已认领成功,可以进行管理.");					 
                  //}	
                  //else if(passed_gys.Equals("通过")&&Convert.ToString(row["是否验证通过"])!="通过")
                  //{
                  //    Response.Write("请耐心等候,您更新的个人资料已提交,正在审核当中,我方工作人员会尽快给您答复!");  
                  //}
                  //else if(!passed_gys.Equals("通过"))
                  //{
                  //    if(Convert.ToString(row["是否验证通过"])=="通过")
                  //    {
                  //       Response.Write("恭喜您!审核已通过,可以对生产厂商进行认领.");
                  //    }	
                  //}				  
		%>
        <%
            if (passed != "待审核"&&passed != "通过")
            {%>
               <span class="zyy1"><a href="gysbtxx.aspx">补填个人信息</a></span>
            <%}  %>
		</span>
		</span>
		<span class="zy2">
            <img src="images/aaa_06.jpg" />图1
		</span> 
		<span class="zy2">
            <img src="images/aaa_06.jpg" />图2
		</span>
			
    </div>	

      <%                   
		    if (passed!="通过")
            {
    %>

    <div class="gyzy2">
    <%----蒋，2014年8月8日
    删除认领部分，注释认领厂商--%>
        <%--<span class="zyy1"><a href="gysbtxx.aspx">认领厂商</a></span>--%>
        <span class="zyy1" style="margin-left:180px;"><a href="gysbtxx.aspx">管理生厂商信息</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">管理分销商信息</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">管理材料信息</a></span>
        
    </div>
    <% }%>

		<%
            //蒋，2014年8月8日
                 //if (passed.Equals("通过")&&(passed_gys==""||passed_gys.Equals("待审核"))){
		if(passed.Equals("通过")&&(passed_gys=="生产商")) {   	
	     %>
	     <div class="gyzy2">
         <%--蒋，2014年8月8日
         删除认领部分，注释认领厂商，--%>
            <%-- <span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>--%>
            <%-- <span class="zyy1" style="margin-left:180px;"><a href="gyszym.aspx" onclick="window.alert('请完善个人信息')">管理生产商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('请完善个人信息')">管理分销商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('请完善个人信息')">管理材料信息</a></span>--%>
              <span class="zyy1" style="margin-left:180px;"><a href="glscsxx.aspx">管理生产商信息</a></span>
            <span class="zyy1"><a href="glfxsxx.aspx">管理分销商信息</a></span>
            <span class="zyy1"><a href="gysglcl.aspx">管理材料信息</a></span>    
         </div>
	    <%}
        //蒋，2014年8月8日，注释if，新改一个if语句  
       //if (passed_gys.Equals("通过")&&passed=="通过"){ 
            if (passed.Equals("通过")&&(passed_gys=="分销商"))
            {   %>
        <div class="gyzy2">
        <%----蒋，2014年8月8日
        删除认领部分，注释认领厂商和管理生产商信息--%>
            <%--<span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>--%>
            <%--<span class="zyy1" style="margin-left:180px;"><a href="glscsxx.aspx">管理生产商信息</a></span>--%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx">管理分销商信息</a></span>
            <span class="zyy1"><a href="gysglcl.aspx">管理材料信息</a></span>        
        </div>	
    <%} %>
   
   
   

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
