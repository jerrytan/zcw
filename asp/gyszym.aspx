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
    //public string s_QQ_id="";
    string ppname = "";//蒋，2014年8月28日，品牌名称
    public string name="";
    //蒋，2014年8月13日，注释从供应商申请认领表中取出的审核结果字段
    //public string passed_gys = "";
    public string gys_QQ_id = "";//蒋，2014年8月21日(供应商id)
    public string power = "";//用户权限（蒋，22日）
    public string s_yh_id = "";
    public string lx="";
    public string gys_id = "";//供应商id
    protected void Page_Load(object sender, EventArgs e)
    {
            if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
            {
                //s_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
                gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();//蒋,2014年8月22日
            }
            //获取QQ_id，如果数据库不存在此id，则跳转到QQ验证页面  苑
            //string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();蒋,2014年8月21日
            string sqlExistQQ_id = "select * from 用户表 where QQ_id='" + gys_QQ_id + "'";
            string sql_Level = "select 等级 from 用户表 where QQ_id='" + gys_QQ_id + "'";
            if (objConn.GetRowCount(sqlExistQQ_id) > 0)
            {
                if (objConn.DBLook(sql_Level) == "企业用户")
                {
                    Response.Redirect("hyyhgl.aspx");
                }
            }
            else
            {
                Response.Redirect("QQ_dlyz.aspx");
            }

            //蒋，2014年8月21日
            string sql_Power = "select 角色权限 from 用户表 where QQ_id='"+gys_QQ_id+"'";
            power = objConn.DBLook(sql_Power).ToString();//21日
        

        if (gys_QQ_id != "")
        {
            //蒋，2014年8月21日          
            //string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '" + s_QQ_id + "'";
            string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '" + gys_QQ_id + "'";
            string s_Count=objConn.DBLook(str_checkuserexist);    
            if (s_Count != "")
            {
                int count = Convert.ToInt32(s_Count);
                if (count == 0)  //qq_id 不存在，需要增加用户表
                {
                    string str_insertuser = "insert into 用户表 (QQ_id) VALUES ('" + gys_QQ_id + "')";
                     if(!objConn.ExecuteSQL(str_insertuser,false))
                       {
                         // objConn.MsgBox(this.Page,"执行SQL语句失败"+str_insertuser);
                       }

                     string str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + gys_QQ_id + "')"
                    + ",updatetime=(select getdate()),注册时间=(select getdate())where QQ_id = '" + gys_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          //objConn.MsgBox(this.Page,"执行SQL语句失败"+str_updateuser);
                       }
                } 
            }
            string s_SQL = "select 姓名,yh_id,是否验证通过,类型,等级,dw_id from 用户表 where QQ_id='" + gys_QQ_id + "'";      
             dt_yh = objConn.GetDataTable(s_SQL);
             
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {
                gys_id = dt_yh.Rows[0]["dw_id"].ToString();//材料供应商信息表中的供应商id
                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                name = dt_yh.Rows[0]["姓名"].ToString();
                lx= dt_yh.Rows[0]["类型"].ToString();
		    }

            //蒋，2014年8月28日
            string exists = "select 品牌名称 from 品牌字典 where scs_id='" + gys_id + "'";
            ppname = objConn.DBLook(exists).ToString();
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
                //蒋，2014年8月13日，注释sql以下语句
                //string sSQL = "select 审批结果 from 供应商认领申请表 where yh_id='" + s_yh_id + "' ";
                //DataTable dt_gyssq = new DataTable();
                //dt_gyssq = objConn.GetDataTable(sSQL);
                //if (dt_gyssq != null && dt_gyssq.Rows.Count > 0)
                //{
                //    passed_gys = dt_gyssq.Rows[0]["审批结果"].ToString();
                //}
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
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp 身份信息经过我方工作人员确认后，您可以管理生厂商、管理分销商和管理材料信息（图1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
            //蒋，2014年8月21日    
                //if (passed == "待审核")
                //{
                //    Response.Write("请耐心等候,您更新的个人资料已提交,正在审核当中,我方工作人员会尽快给您答复!");
                //}
                //else if (passed == "通过")
                //{
                //    //蒋，2014年8月13日注释厂商认领模块，添加输出语句
                //    //if (passed_gys == "通过")
                //    //{
                //    //    Response.Write("恭喜您!厂商已认领成功,可以进行管理");
                //    //}
                //    //else if (passed_gys != "通过")
                //    //{
                //    //    Response.Write("恭喜您!审核已通过,可以对生产厂商进行认领");
                //    //}
                //   Response.Write("恭喜您!审核已通过，您可以对生厂商、分销商和材料信息的进行管理");
                //}
                //else
                //{
                //    Response.Write("您尚未补充个人信息，请填写个人信息");
                //}    
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
<%--蒋，2014年8月21日--%>
        <%--<%
            //蒋，2014年8月13更改判断语句
            //if (passed != "待审核"&&passed != "通过")
               if (passed != "待审核" && name=="")
            {%>--%>
               <span class="zyy1"><a href="grxx.aspx">补填个人信息</a></span>
           <%-- <%}  %>--%>
		</span>
		</span>
        <%if (power.Contains("管理生产商"))
          { %>
		<span class="zy2" runat="server" id="scsqx">
            <img src="images/scsqx.jpg" />
		</span>
        <%} %>
        <%else
            { %>
            <span class="zy2" runat ="server" id="Span1">
            <img src="images/fxsqx.jpg" />
		</span> 
		
			<%} %>
    </div>	
    <%--/蒋，2014年8月22日--%>
    <%--  <%                   
          if (power)//判断权限
            {
    %>--%>
     <%--/蒋，2014年8月22日--%>
   <%--<div class="gyzy2">--%>
    <%--蒋桂娥，2014年8月13日注释认领厂商
        <span class="zyy1"><a href="gysbtxx.aspx">认领厂商</a></span>--%>
        <%--<span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">管理生厂商信息</a></span>
        <span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">管理分销商信息</a></span>
        <span class="zyy1" style="margin-left:100px;"><a href="grxx.aspx">管理材料信息</a></span>
        
    </div>--%>
    <%--<% }%>--%>

		<%--<%
	        //蒋，2014年8月13日，注释了判断语句，新增了if语句
	             //if (passed.Equals("通过")&&(passed_gys==""||passed_gys.Equals("待审核"))){	
                     if(passed.Equals("通过")&&(name=="")){
	     %>--%>
	     <%--<div class="gyzy2">--%>
          <%--蒋桂娥，2014年8月13日注释认领厂商，并改<span>标签的单击事件alert（"请先认领厂商"）改为alert（"请完善个人信息"）
             <span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>--%>
             <%--<span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('请先认领厂商')">管理生产商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('请先认领厂商')">管理分销商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx" onclick="window.alert('请先认领厂商')">管理材料信息</a></span>--%>
             <%--
         </div>--%>
	  <%--  <%}--%>
          <%--//蒋桂娥，2014年8月13日,注释if语句，新增else-if语句
       //if (passed_gys.Equals("通过")&&passed=="通过"){ 
                     else if (passed.Equals("通过") && name != "")
                     { 
           %>--%>
        <div class="gyzy2">
        <%--蒋桂娥，2014年8月13日注释认领厂商，并添加了类型的判断（if-else）以及权限的显示
            <span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>--%>
            <% if (power.Contains("管理生产商"))
               {
                   //蒋，2014年8月28日，if-else判断
                   if (ppname == "")
                   { %>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">管理生产商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>" onclick="window.alert('为了您的操作方便，请在管理生产商信息中添加品牌信息！')">管理分销商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">管理材料信息</a></span>
            <%}
                   else
                   {%>
                        <span class="zyy1" style="margin-left:100px;"><a href="glscsxx.aspx?gys_id=<%=gys_id %>">管理生产商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="glfxsxx.aspx?gys_id=<%=gys_id %>">管理分销商信息</a></span>
                        <span class="zyy1" style="margin-left:100px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">管理材料信息</a></span>  
                  <% }
               }%> 
            <%else
                {%>
            <span class="zyy1" style="margin-left:180px;"><a href="glfxsxx.aspx?gys_id=<%=gys_id %>">管理分销商信息</a></span>
            <span class="zyy1" style="margin-left:180px;"><a href="gysglcl.aspx?gys_id=<%=gys_id %>">管理材料信息</a></span>       
    <%} %>
    </div>	
   
   
   

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
