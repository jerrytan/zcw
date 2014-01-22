<!--
      认领厂商页面
	  (当用户认领厂商后 把对应的用户id赋给认领的供应商(材料供应商信息表的yh_id))
	  文件名:  认领厂商.aspx        
	  传入参数:无	  
     
--> 


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
               protected DataTable dt_wrl_gys = new DataTable(); //未认领的供应商信息(材料供应商信息表) 	
               protected DataTable dt_yrl_gys= new DataTable(); //已经认领的供应商信息(材料供应商信息表) 	
			   protected DataTable dt_dsh_gys = new DataTable(); //提示用户认领的供应商

               protected void Page_Load(object sender, EventArgs e)
               {  
                    
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
					string yh_id = Convert.ToString(Session["yh_id"]);
					
					string str_yh = "select 类型 from 用户表 where yh_id ='"+ yh_id+"' ";
                    SqlDataAdapter da_yh = new SqlDataAdapter(str_yh, conn);
                    DataSet ds_yh = new DataSet();
                    da_yh.Fill(ds_yh, "材料供应商信息表");
                    DataTable dt_yh = ds_yh.Tables[0];
					string gys_type = Convert.ToString(dt_yh.Rows[0]["类型"]);
					
					//根据用户输入的类型(生产商/分销商)查询相关的供应商
                    string str_wrl_gys = "select 供应商,gys_id from 材料供应商信息表 where 单位类型='"+gys_type+"' "
					+"and yh_id is null or 单位类型='"+gys_type+"' and yh_id='' ";
                    SqlDataAdapter da_wrl_gys = new SqlDataAdapter(str_wrl_gys, conn);
                    DataSet ds_wrl_gys = new DataSet();
                    da_wrl_gys.Fill(ds_wrl_gys, "材料供应商信息表");
                    dt_wrl_gys = ds_wrl_gys.Tables[0];				                             
                    	                
               }
	           
                   
        
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
   <title>认领厂商页面</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script language ="javascript">
        function send_request() 
        {
            var gys_list = document.getElementById("gyslist");
            var gys_id = gys_list.options[gys_list.selectedIndex].value;
            //alert(gys_id);

            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    alert(xmlhttp.responseText);
                    location.reload();
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }


            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" +gys_id, true);
            xmlhttp.send();
        }
    </script>
</head>




<body>

<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->

<%                 

                    string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    //查询供应商申请表 如果审批通过,显示被认领的供应商
					string yh_id = Convert.ToString(Session["yh_id"]);
					string str_select = "select count(*) from 供应商认领申请表 where yh_id = '"+yh_id +"'";
					conn.Open();
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
					conn.Close();
					
					string gys_spjg = "";
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count !=0 )  //供应商申请有记录 直接查询 是否审批通过
                        {        
                            
                            String gyssq_select = "select gys_id, 审批结果 from 供应商认领申请表 where yh_id = '"+yh_id +"'";							
                            SqlDataAdapter da_gyssq = new SqlDataAdapter (gyssq_select,conn);
					        DataSet ds_gysxx = new DataSet();
					        da_gyssq.Fill(ds_gysxx,"供应商认领申请表");					
					        DataTable dt_gysxx = ds_gysxx.Tables[0];
					        gys_spjg = Convert.ToString(dt_gysxx.Rows[0]["审批结果"]);
							string gys_id = Convert.ToString(dt_gysxx.Rows[0]["gys_id"]);
                            if(gys_spjg.Equals("通过"))	
							{
							   //更新材料供应商信息表
                               String str_updateuser = "update 材料供应商信息表 set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
							   conn.Open();
                               SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                               cmd_updateuser.ExecuteNonQuery();
							   conn.Close();
							
							   string str_yrl_gys = "select 供应商,gys_id,联系地址 from 材料供应商信息表 where yh_id ='"+ yh_id+"'";
                               SqlDataAdapter da_yrl_gys = new SqlDataAdapter(str_yrl_gys, conn);
                               DataSet ds_yrl_gys = new DataSet();
                               da_yrl_gys.Fill(ds_yrl_gys, "材料供应商信息表");
                               dt_yrl_gys = ds_yrl_gys.Tables[0];			   						                                                    
                    
							}
                            if(gys_spjg.Equals("不通过"))	
							{
							   String str_updateuser = "update 材料供应商信息表 set yh_id = '' where gys_id = '"+gys_id+"'";
							   conn.Open();
                               SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                               cmd_updateuser.ExecuteNonQuery();
							   
							   //验证不通过,同时希望用户从新认领厂商,所以把原有的记录从供应商申请表中清除掉
							   String str_delete = "delete 供应商认领申请表  where gys_id = '"+gys_id+"'";							  
                               SqlCommand cmd_delete = new SqlCommand(str_delete, conn);         
                               cmd_delete.ExecuteNonQuery();
							   conn.Close();
							}
							if(gys_spjg.Equals("待审核"))	
							{			  							
							   string dsh_gys = "select 供应商,gys_id,联系地址 from 供应商认领申请表 where yh_id ='"+ yh_id+"'";
                               SqlDataAdapter da_dsh_gys = new SqlDataAdapter(dsh_gys, conn);
                               DataSet dsh_yrl_gys = new DataSet();
                               da_dsh_gys.Fill(dsh_yrl_gys, "供应商认领申请表");
                               dt_dsh_gys = dsh_yrl_gys.Tables[0];				                                                
                            }
                        }
					         
                    }
%>

<%
      if(gys_spjg!="")	
                  {				  
				  if(gys_spjg.Equals("通过"))
				   {
	%>				
					   <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				       <%Response.Write("恭喜您!审核已通过,可以管理生产厂商信息,管理材料信息等相关操作!!");%>
					   </span></div>     
			   
		<% }}%>
					
<%
  if(dt_yrl_gys.Rows.Count > 0)  //已经有认领的供应商了
  {
  %>
    <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">您已经在本站认领的供应商如下:</span></div>
    <%foreach (System.Data.DataRow row in dt_yrl_gys.Rows)
      { %>
        <span class="rlcszi"><a href="gysxx.aspx?gys_id=<%=row["gys_id"].ToString()%>"><%=row["供应商"].ToString() %></a></span>
		
    <%} %>
    <div class="rlcs1"></div>
  <%
  }
  
%>

<form id="form1" >
  <div class="rlcs"><span class="rlcszi">您可以认领信息已经在本站的生产厂商， 流程如下图</span><img src="images/www_03.jpg" /></div>
 
   
    
                  	
	<% 	   	      if(gys_spjg!="")	
                  {			    							     				  				    	
				    if(gys_spjg.Equals("不通过"))
				    {
	    %>			  <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				      <% Response.Write("您认领的生产厂商信息不准确!请重新认领!"); %>
					   </span></div> 
	<%				   
				    }	
			        if(gys_spjg.Equals("待审核"))
				    {
					%>
					<div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				      <% Response.Write("尊敬的用户,您好!您已在本站申请了");%>
					  <br>
					  <%  foreach (System.Data.DataRow row in dt_dsh_gys.Rows)
                    { %>                    
					<a  style="color:Blue;font-size:12px" href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["供应商"].ToString() %></a>				
		            
                    <%} %>
					</span></div>   
					
					
					
					   <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
                 	<%   Response.Write("并且您申请的信息已提交,请耐心等待,我方工作人员会尽快给您回复."); %>			
					   </span></div>
				 <%   }
				  }
		        %>
               
 


  <br>
  <br>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">查询结果</span>
       <select name="gys" id="gyslist" onchange="Select_Gys_Name(this.options[this.options.selectedIndex].value)">
      <%                 
	       foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
           { 	  
	  %>
        <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["供应商"].ToString() %></span>
      <%}%>
       </select>

   <a  onclick="send_request()" ></div> <img src="images/rl_03.jpg" /></a>
     
  </div>

   <div class="rlcs4">
    <span class="rlcs7">如果您没有找到贵公司，您可以提交贵公司资料，我方工作人员会在3个工作日内完成审核工作（流程图如下）</span>
    <span><img src="images/www_03.jpg" /></span>
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
