<!--
      认领厂商页面
	  (当用户认领厂商后 把对应的用户id赋给认领的供应商(材料供应商信息表的yh_id))
	  文件名:  认领厂商.aspx        
	  传入参数:用户id	  
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
   <title>认领厂商页面</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />
 
</head>

<body>

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->

  <script runat="server">
    protected DataTable dt_wrl_gys = new DataTable(); //未认领的供应商信息(材料供应商信息表) 	
    protected DataTable dt_yrl_gys = new DataTable(); //已经认领的供应商信息(材料供应商信息表) 	
    protected DataTable dt_dsh_gys = new DataTable(); //提示用户认领的供应商
    public DataConn objConn = new DataConn();
    public string s_yh_id = "";
    public string sSQL = "";
    public string s_spjg="";   //审批结果
    public string s_gys_id="";   //供应商id
     public DataTable dt_clgys = null;     //材料供应商   查询使用
     protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
        }
        string gys_type = "";
		if(s_yh_id!="")
		{
			sSQL = "select 类型 from 用户表 where yh_id ='" + s_yh_id + "' ";
			DataTable dt_yh = objConn.GetDataTable(sSQL);
			if (dt_yh != null && dt_yh.Rows.Count > 0)
			{
				gys_type = dt_yh.Rows[0]["类型"].ToString();
			}

			//根据用户输入的类型(生产商/分销商)查询相关的供应商
			sSQL = "select 供应商,gys_id from 材料供应商信息表 where 单位类型='" + gys_type + "' and (yh_id is null or yh_id='') ";
			dt_wrl_gys = objConn.GetDataTable(sSQL);
			sSQL = "select count(*) from 供应商认领申请表 where yh_id = '" + s_yh_id + "'";
			string s_count = objConn.DBLook(sSQL);
			int count = Convert.ToInt32(s_count);
			if (count != 0)
			{
				sSQL = "select gys_id, 审批结果 from 供应商认领申请表 where yh_id = '" + s_yh_id + "'";
				DataTable dt_gysxx = objConn.GetDataTable(sSQL);
				if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
				{
					s_spjg = dt_gysxx.Rows[0]["审批结果"].ToString();
					s_gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
					if (s_spjg == "通过")
					{
						sSQL = "update 材料供应商信息表 set yh_id = '" + s_yh_id + "' where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, false);
						sSQL = "select 供应商,gys_id,联系地址 from 材料供应商信息表 where yh_id ='" + s_yh_id + "'";
						dt_yrl_gys = objConn.GetDataTable(sSQL);
					}
					else if (s_spjg == "不通过")
					{
						sSQL = "update 材料供应商信息表 set yh_id = '' where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, false);
						//验证不通过,同时希望用户从新认领厂商,所以把原有的记录从供应商申请表中清除掉
						sSQL = "delete 供应商认领申请表  where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, true);
					}
					else if (s_spjg == "待审核")
					{
						sSQL = "select 供应商,gys_id,联系地址 from 供应商认领申请表 where yh_id ='" + s_yh_id + "'";
						dt_dsh_gys = objConn.GetDataTable(sSQL);
					}
				}
			}
		}
		else
		{
			objConn.MsgBox(this.Page,"QQ_ID不存在！请重新登录");
		}
    }
     protected void CkeckCompany(object sender, EventArgs e)
    {
        if (this.company.Value!="")
        {
            string SQL = "select * from 材料供应商信息表 where 供应商 like '%" + this.company.Value + "%'";
            dt_clgys = objConn.GetDataTable(SQL);
        }
        else
        {
            dt_clgys = null;
            string SQL = "select * from 材料供应商信息表 ";
            dt_clgys = objConn.GetDataTable(SQL);
        }
    }
   </script>
    <script language ="javascript">
        function send_request()
        {
            var gys_list = document.getElementById("gyslist");
            var gys_id = gys_list.options[gys_list.selectedIndex].value;

            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    location.reload();
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" + gys_id, true);
            xmlhttp.send();
        }
        function Select_Gys_Name(gys_id)
        {
            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    alert(xmlhttp.responseText);
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "rlcs_3.aspx?gys_id=" + gys_id, true);
            xmlhttp.send();
        }
    </script>

<form runat="server">
<div style=" float:left;">

<%
        if(s_spjg!="")
        {
            if(s_spjg=="通过")
            {
%>
                    <div>                  
                         <div class="rlcs">
                             <span class="rlcszi" style="color:Blue;font-size:12px">
				                            <%Response.Write("恭喜您!审核已通过,你可以进行以下操作：");%>
                                            <br />
                                            <a href="glscsxx.aspx">管理生产厂商信息</a>
                                            <br />
                                            <a href="gysglcl.aspx">管理材料信息</a>

		                     </span>
                         </div>  
                     
<%                      if(dt_yrl_gys.Rows.Count>0)
                         {
%>
                            <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">您已经在本站认领的供应商如下:</span></div>
<%
                             foreach (System.Data.DataRow row in dt_yrl_gys.Rows)
                             { 
%>
                                <span class="rlcszi">
                                    <a href="gysxx.aspx?gys_id=<%=row["gys_id"].ToString()%>"><%=row["供应商"].ToString() %></a>
                                </span>
<%                           } 
                         }
%>
                    </div>
                    <img src="images/www_03.jpg" />
<%
             }
            else if(s_spjg=="待审核")
            {
%>  
                <div>
                    <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                       Response.Write("尊敬的用户,您好!您已在本站申请了");
%>
				         <br>
<%                      foreach (System.Data.DataRow row in dt_dsh_gys.Rows)
                        { 
%>                    
					        <a  style="color:Blue;font-size:12px" href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["供应商"].ToString() %></a>				
		            
<%                      } 
%>
				    </span>
                </div>   
				    <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                      Response.Write("并且您申请的信息已提交,请耐心等待,我方工作人员会尽快给您回复."); 
%>			
					 </span>
                </div>
                </div>
                 <img src="images/www_03.jpg" />
<%
            }
            else if(s_spjg=="不通过")
            {
%>
                <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                       Response.Write("您认领的生产厂商信息不准确!请重新认领!"); 
%>
					 </span>
                </div> 
                <div class="rlcs1">
                        <div class="rlcs2">
                            <input name="sou1" type="text" class="sou1" />
                            <a href="#">
                                <img src="images/ccc_03.jpg" />
                            </a>
                         </div>
                        <div class="rlcs3">
                            <div class="rlcs4">
                                 <span class="rlcs5">查询结果</span>
                                 <select name="gys" id="gyslist" >
<%                               foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
                                 { 
%>
                                     <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["供应商"].ToString() %></span>
<%                                }
%>
                                 </select>
                                <a  onclick="send_request()" > <img src="images/rl_03.jpg" /></a>
                            </div>
                         </div>
                         <div class="rlcs4">
                            <span class="rlcs7">如果您没有找到贵公司，您可以提交贵公司资料，我方工作人员会在3个工作日内完成审核工作（流程图如下）</span>
                            <span><img src="images/www_03.jpg" /></span>
                        </div>
                   </div>
<%
            }
         }
         else
         {
%>               <div class="rlcs1">
                    <div class="rlcs2">
                        <input name="sou1" id="company" type="text" class="sou1" runat="server" />
                      <asp:ImageButton runat="server" ID="CkeckedCompany" ImageUrl="images/ccc_03.jpg"  OnClick="CkeckCompany"  />
                        </div>
                    <div class="rlcs3">
                        <div class="rlcs4">
                                <span class="rlcs5">查询结果</span>
<%
                                if (dt_clgys != null)
                                {
                                       
%>
                                    <select name="gys" id="gyslist"  style=" width:200px;">
<%
                                    foreach (System.Data.DataRow row in dt_clgys.Rows)
                                    {
%>
                                        <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["供应商"].ToString()%></span>
<%
                                    }
%>
                                    </select>                                           
 <%   
                                }
                                else
                                { 
%>
                                    <select name="gys" id="gyslist" style=" width:200px;" >
<%                                  foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
                                    { 
 %>
                                         <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["供应商"].ToString() %></span>
<%                                   }
%>
                                    </select>
<%
                                 }
%>     
                                <a  onclick="send_request()" > <img src="images/rl_03.jpg" /></a>
                        </div>
                        </div>
                        <div class="rlcs4">
                        <span class="rlcs7">如果您没有找到贵公司，您可以提交贵公司资料，我方工作人员会在3个工作日内完成审核工作（流程图如下）</span>
                        <span><img src="images/www_03.jpg" /></span>
                    </div>
                </div> 
<%
         }
%>
</div>

<div class="rlcs1"></div>
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
