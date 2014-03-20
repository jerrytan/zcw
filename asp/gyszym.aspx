<!--
      供应商主页面 管理认领厂商页面 管理供应商 管理分销商页面 供应商管理材料页面 
	  文件名:  gyszym.aspx   
      传入参数:QQ_id 
	  author:张新颖
         
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
        DataConn objConn=new DataConn();
         string s_QQ_id="";
        if ( Request.Cookies["QQ_id"]!=null&& Request.Cookies["QQ_id"].Value.ToString()!="")
        {
             s_QQ_id= Request.Cookies["QQ_id"].Value.ToString();
        }
        if(s_QQ_id!="")
        {
            string s_yh_id = "";
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
                          objConn.MsgBox(this.Page,"执行SQL语句失败"+str_insertuser);
                       }
               
                    string str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + s_QQ_id + "')"
				    +",updatetime=(select getdate()),注册时间=(select getdate())where QQ_id = '" + s_QQ_id + "'";
                     if(!objConn.ExecuteSQL(str_updateuser,false))
                       {
                          objConn.MsgBox(this.Page,"执行SQL语句失败"+str_updateuser);
                       }
                }
            }
            string s_SQL="select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='" + s_QQ_id + "'";      
            DataTable dt_yh = objConn.GetDataTable(s_SQL);
             string passed="";
              string name="";
            if(dt_yh!=null&&dt_yh.Rows.Count>0)
            {
                s_yh_id =dt_yh.Rows[0]["yh_id"].ToString();
                passed = dt_yh.Rows[0]["是否验证通过"].ToString();
                name = dt_yh.Rows[0]["姓名"].ToString();
		    }
		    //need to set session value
            Session["GYS_YH_ID"] = s_yh_id;

            //(供应商申请)的yh_id 是在认领厂商之后更新的

            string str_gyssq = "select count(*) from 供应商认领申请表 where yh_id='" + s_yh_id + "'";
            string s_count="";
            s_count=objConn.DBLook(str_gyssq);
            string passed_gys = "";
            if (s_count != "")
            {
                int count = Convert.ToInt32(s_count);
                if (count != 0)  //如果(供应商申请)不更新 就没有yh_id 往下不执行
                {
                    string sSQL="select 审批结果 from 供应商认领申请表 where yh_id='" + s_yh_id + "' ";              
                    DataTable dt_gyssq = new DataTable();              
                    dt_gyssq = objConn.GetDataTable(sSQL);
                    if(dt_gyssq!=null&&dt_gyssq.Rows.Count>0)
                    {
                        passed_gys =dt_gyssq.Rows[0]["审批结果"].ToString();
                    }
                }
            }
       }
       else
       {
             objConn.MsgBox(this.Page,"QQ_ID不存在！请重新登录");
       }	
    %>

    <div class="gyzy1">
        <span class="zy1">&nbsp&nbsp &nbsp&nbsp 身份信息经过我方工作人员确认后，您可以认领已有的供应商，或者增加新的供应商信息，还可以添加新产品信息（图1)
		<p>
	    </p>
		&nbsp&nbsp &nbsp&nbsp &nbsp&nbsp  
		<span style="color: Red;font-size:16px">
		<%
		    foreach(System.Data.DataRow row in dt_yh.Rows)
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
            <img src="images/aaa_06.jpg" />图1
		</span> 
		<span class="zy2">
            <img src="images/aaa_06.jpg" />图2
		</span>
			
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
