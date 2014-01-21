<!--
      供应商主页面 管理认领厂商页面 管理供应商 管理分销商页面 供应商管理材料页面 
	  文件名:  gyszym.aspx   
      传入参数:无	  
         
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>供应商主页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->


    <% 
        String QQid = Request.Cookies["QQ_id"].Value;   //首先获取cookie中的QQ_id
		
        string yh_id = "";
        String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
        String str_checkuserexist = "select count(*) from 用户表 where QQ_id = '" + QQid + "'";
        SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
        conn.Open();
        Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();

        if (obj_checkuserexist != null)
        {
            int count = Convert.ToInt32(obj_checkuserexist);
            if (count == 0)  //qq_id 不存在，需要增加用户表
            {

                String str_insertuser = "insert into 用户表 (QQ_id) VALUES ('" + QQid + "')";
                SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);
                cmd_insertuser.ExecuteNonQuery();
                String str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + QQid + "')"
				+",updatetime=(select getdate()),注册时间=(select getdate())where QQ_id = '" + QQid + "'";
                SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);
                cmd_updateuser.ExecuteNonQuery();

            }

        }
        SqlDataAdapter da = new SqlDataAdapter("select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='" + QQid + "'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "用户表");
        DataTable dt = ds.Tables[0];
        yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
        Session["yh_id"] = yh_id;
        String passed = Convert.ToString(dt.Rows[0]["是否验证通过"]);
        String name = Convert.ToString(dt.Rows[0]["姓名"]);
        
        //(供应商申请)的yh_id 是在认领厂商之后更新的
       
        
        string str_gyssq = "select count(*) from 供应商认领申请表 where yh_id='" + yh_id + "'";
        SqlCommand cmd_select = new SqlCommand(str_gyssq, conn);
        Object obj_checkexist_yhid = cmd_select.ExecuteScalar();
        conn.Close();
        String passed_gys = "";
        if (obj_checkexist_yhid != null)
        {
            int count = Convert.ToInt32(obj_checkexist_yhid);
            if (count != 0)  //如果(供应商申请)不更新 就没有yh_id 往下不执行
            {

                SqlDataAdapter da_gyssq = new SqlDataAdapter("select 审批结果 from 供应商认领申请表 where yh_id='" + yh_id + "' ", conn);
                DataSet ds_gyssq = new DataSet();
                DataTable dt_gyssq = new DataTable();
                da_gyssq.Fill(ds_gyssq, "供应商申请");
                dt_gyssq = ds_gyssq.Tables[0];
                passed_gys = Convert.ToString(dt_gyssq.Rows[0]["审批结果"]);
            }
        }	
    %>

    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp 身份信息经过我方工作人员确认后，您可以认领已有的供应商，或者增加新的供应商信息，还可以添加新产品信息（图1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
		    foreach(System.Data.DataRow row in dt.Rows)
			{	    
                  if(passed_gys.Equals("通过"))  
                  {
				     Response.Write("恭喜您!厂商已认领成功,可以进行管理.");					 
				  }	
				  if(!passed_gys.Equals("通过"))
				  {
				  if(Convert.ToString(row["是否验证通过"])=="通过")
				  {
				     Response.Write("恭喜您!审核已通过,可以对生产厂商进行认领.");
				  }	
                  }				  
			} 
		%>
		</span>
		</span>
        
		
		<span class="zy2">
            <img src="images/aaa_06.jpg" />图1</span> <span class="zy2">
                <img src="images/aaa_06.jpg" />图2</span>
			
    </div>
	
		
		

    <%                   
		    if (!passed.Equals("通过"))
            {
    %>

    <div class="gyzy2">
        <span class="zyy1"><a href="gysbtxx.aspx">认领厂商</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">管理生厂商信息</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">管理分销商信息</a></span>
        <span class="zyy1"><a href="gysbtxx.aspx">管理材料信息</a></span>
        
    </div>
    <% }%>

		<%
	        
	             if (passed_gys==""&passed.Equals("通过")||passed_gys.Equals("待审核")){	
	     %>
	     <div class="gyzy2">
             <span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>
             <span class="zyy1"><a href="gyszym.aspx">管理生厂商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx">管理分销商信息</a></span>
             <span class="zyy1"><a href="gyszym.aspx">管理材料信息</a></span>
        
         </div>
	    <%}
	   if (passed_gys.Equals("通过")){ %>
        <div class="gyzy2">
            <span class="zyy1"><a href="rlcs.aspx">认领厂商</a></span>
            <span class="zyy1"><a href="glscsxx.aspx">管理生厂商信息</a></span>
            <span class="zyy1"><a href="glfxsxx.aspx">管理分销商信息</a></span>
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
