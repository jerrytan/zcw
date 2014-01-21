<!--      
	   管理生产商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glscsxx.aspx 
       传入参数：无    
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理生厂商信息</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>


<script runat="server">

       
        protected DataTable dt_gysxx = new DataTable();  //分销商信息(材料供应商信息表)
        protected DataTable dt_ppxx = new DataTable();   //分销商信息(材料供应商信息表)
        protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]);         
			//认领厂商成功,根据用户id 查询认领的供应商信息
			
			String str_type = "select 单位类型 ,gys_id from  材料供应商信息表 where yh_id='"+yh_id+"' ";  //查询单位类型
			SqlDataAdapter da_type = new SqlDataAdapter(str_type, conn);
			DataSet ds_type = new DataSet();
            da_type.Fill(ds_type, "材料供应商信息表");
            DataTable dt_type = ds_type.Tables[0];
			string gys_type = Convert.ToString(dt_type.Rows[0]["单位类型"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //供应商id   141
			if (gys_type.Equals("生产商"))
			{
			 //如果是分销商信息 直接根据yh_id 查询供应商信息 
             String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  yh_id='"+yh_id+"' ";
             SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			 DataSet ds_gysxx = new DataSet();
             da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
             dt_gysxx = ds_gysxx.Tables[0];
           	}
            if (gys_type.Equals("分销商"))
			{	
              	//根据代理的品牌查fxs_id 根据fxs_id 查 pp_id 再根据 pp_id 查品牌字典 中scs_id 
				//再根据中scs_id 单位类型为生产商的 生产商信息
				
				String str_gysxxs = "select top 1 pp_id from  分销商和品牌对应关系表 where pp_id in "
				+"(select pp_id from  分销商和品牌对应关系表 where fxs_id='"+gys_type_id+"')";
                SqlDataAdapter da_gysxxs = new SqlDataAdapter(str_gysxxs, conn);
			    DataSet ds_gysxxs = new DataSet();
                da_gysxxs.Fill(ds_gysxxs, "分销商和品牌对应关系表");
                DataTable dt_gysxxs = ds_gysxxs.Tables[0];
				string gys_pp_id = Convert.ToString(dt_gysxxs.Rows[0]["pp_id"]); 
				
                String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id "
				+"from 材料供应商信息表 where  gys_id in (select scs_id from 品牌字典 where pp_id='"+gys_pp_id+"')"    //pp_id=186
				+"and 单位类型='生产商'";
                SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			    DataSet ds_gysxx = new DataSet();
                da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                dt_gysxx = ds_gysxx.Tables[0];				
				
            }
            if (dt_gysxx.Rows.Count == 0) Response.Redirect("gyszym.aspx");
			    
		

            
            gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
							
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,pp_id from 品牌字典 where 是否启用='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "品牌字典");
            dt_ppxx = ds_ppxx.Tables[0];  			                                        
        }

       		
	
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
        <div class="fxsxx">
		   <span class="fxsxx1">
		   <%
			string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            String yh_id = Convert.ToString(Session["yh_id"]);         
			
            String str_gysxx_type = "select 单位类型, gys_id from 材料供应商信息表 where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx_type = new SqlDataAdapter(str_gysxx_type, conn);
			DataSet ds_gysxx_type = new DataSet();
            da_gysxx_type.Fill(ds_gysxx_type, "材料供应商信息表");
            DataTable dt_gysxxs = ds_gysxx_type.Tables[0];
            string gysid = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	  //141
			string gys_types = Convert.ToString(dt_gysxxs.Rows[0]["单位类型"]);
			
			string sp_result="";
			if (gys_types.Equals("分销商"))
			{             				
				String str_gysxxs = "select top 1 pp_id from  分销商和品牌对应关系表 where pp_id in "
				+"(select pp_id from  分销商和品牌对应关系表 where fxs_id='"+gysid+"')";
                SqlDataAdapter da_gysxxs = new SqlDataAdapter(str_gysxxs, conn);
			    DataSet ds_gysxxs = new DataSet();
                da_gysxxs.Fill(ds_gysxxs, "分销商和品牌对应关系表");
                DataTable dt_gys_xxs = ds_gysxxs.Tables[0];
				string gys_pp_ids = Convert.ToString(dt_gys_xxs.Rows[0]["pp_id"]); 
				
                String str_gysxx_fxs = "select gys_id "
				+"from 材料供应商信息表 where  gys_id in (select scs_id from 品牌字典 where pp_id='"+gys_pp_ids+"')"    //pp_id=186
				+"and 单位类型='生产商'";
                SqlDataAdapter da_gysxx_fxs = new SqlDataAdapter(str_gysxx_fxs, conn);
			    DataSet ds_gysxx_fxs = new DataSet();
                da_gysxx_fxs.Fill(ds_gysxx_fxs, "材料供应商信息表");
                DataTable dt_gysxx_fxs = ds_gysxx_fxs.Tables[0];
                string gysids = Convert.ToString(dt_gysxx_fxs.Rows[0]["gys_id"]);	  //128	
				
				string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gysids+"' ";
		        SqlCommand cmd_checkuserexists = new SqlCommand(sql_gys_id, conn);            
                Object obj_check_gys_exist = cmd_checkuserexists.ExecuteScalar();
				if (obj_check_gys_exist != null)
            {
               int count = Convert.ToInt32(obj_check_gys_exist);
               if (count != 0)  
               {  //如果 供应商自己修改待审核表 有记录 查询审批结果
			    string str_select = "select 审批结果 from 供应商自己修改待审核表 where gys_id='"+gysids+"'";
			    SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			    DataSet ds_select = new DataSet();
			    da_select.Fill(ds_select,"供应商自己修改待审核表");
			    DataTable dt_select = ds_select.Tables[0];
			    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]); 
			    if(sp_result!="")
			    {
                  if (sp_result.Equals("通过"))
                  {  
				  
				     //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                     string sql = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+gysids+"'),"
				     +"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+gysids+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+gysids+"'),"
					 +"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+gysids+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+gysids+"'),"
				     +"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+gysids+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+gysids+"'),"
					 +"地区名称=(select 贵公司地区 from 供应商自己修改待审核表 where gys_id='"+gysids+"'),"
					 +"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+gysids+"') where gys_id ='"+gysids+"'";
                     
                     SqlCommand cmd2 = new SqlCommand(sql, conn);
                     int ret = (int)cmd2.ExecuteNonQuery();
					 
					 String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+gysids+"' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                     dt_gysxx = ds_gysxx.Tables[0];					 
				     
					 Response.Write("恭喜您!您修改的数据已经保存,更新!");
                  }
			      if (sp_result.Equals("不通过"))
                  {
                     string sql_delete = "delete  供应商自己修改待审核表 where gys_id ='"+gys_id+"' ";					
                    
                     SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                     int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					 Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
                  }
				  if (sp_result.Equals("待审核"))
                  {
                     String str_gysxx = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
					 +"经营范围,gys_id  from 供应商自己修改待审核表 where  yh_id='"+yh_id+"'and 单位类型='分销商' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "供应商自己修改待审核表");
                     dt_gysxx = ds_gysxx.Tables[0];
			         
					 Response.Write("审核当中!");
                  }
			    }
              }
			}
            }
			
			
             if (gys_types.Equals("生产商"))
			{ 
			    string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+gysid+"' ";
		        SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
                Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
				if (obj_check_gys_exist != null)
            {
               int count = Convert.ToInt32(obj_check_gys_exist);
               if (count != 0)  
               {  //如果 供应商自己修改待审核表 有记录 查询审批结果
			    string str_select = "select 审批结果 from 供应商自己修改待审核表 where gys_id='"+gysid+"'";
			    SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			    DataSet ds_select = new DataSet();
			    da_select.Fill(ds_select,"供应商自己修改待审核表");
			    DataTable dt_select = ds_select.Tables[0];
			    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]); 
			    if(sp_result!="")
			    {
                  if (sp_result.Equals("通过"))
                  {  
				  
				     //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                     string sql = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				     +"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
					 +"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				     +"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),"
					 +"地区名称=(select 贵公司地区 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),"
					 +"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";
                     
                     SqlCommand cmd2 = new SqlCommand(sql, conn);
                     int ret = (int)cmd2.ExecuteNonQuery();
				     
					 String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+gysid+"' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                     dt_gysxx = ds_gysxx.Tables[0];
					 Response.Write("恭喜您!您修改的数据已经保存,更新!");
                  }
			      if (sp_result.Equals("不通过"))
                  {
                     string sql_delete = "delete  供应商自己修改待审核表 where gys_id ='"+gys_id+"' ";
					
                    
                     SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                     int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					 Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
                  }
				   if (sp_result.Equals("待审核"))
                  {
                     String str_gysxx = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
					 +"经营范围,gys_id  from 供应商自己修改待审核表 where  yh_id='"+yh_id+"'and 单位类型='生产商' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "供应商自己修改待审核表");
                     dt_gysxx = ds_gysxx.Tables[0];
			         
					 Response.Write("审核当中!");
                  }
			    }
              }
			}
		    }
			

            
			conn.Close();
			%>
		    </span>
            <span class="fxsxx1">贵公司的详细信息如下:</span>

            <div class="fxsxx2">
                <dl>
                    <dd>贵公司名称：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司名称"] %>" />
						<%}else{%>
						<input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" />
						<%}%>
					</dt>
					
                    <dd>贵公司地址：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地址"] %>"/>
						<%}else{%>
						<input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司电话：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司电话"] %>"/>
						<%}else{%>
						<input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["电话"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司主页：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司主页"] %>" />
						<%}else{%>
						<input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" />
						<%}%>
						</dt>
						
                    <dd>贵公司传真：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司传真"] %>"/>
						<%}else{%>
						<input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["传真"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司地区：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地区"] %>"/>
						<%}else{%>
						<input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地区名称"] %>"/>
						<%}%>
						</dt>
                    

   <!--
     <dd>贵公司logo：</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>贵公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
    
    -->



                    <dd>联系人姓名：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人姓名"] %>" />
						<%}else{%>
						<input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人"] %>" />
						<%}%>
						</dt>
						
                    <dd>联系人电话：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人电话"] %>" />
                        <%}else{%>
						<input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" />
						<%}%>
                    </dt>
					
					 <dd>经营范围：</dd>
                    <dt>
					<%if (sp_result.Equals("待审核")){%>
                        <input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" />
                        <%}else{%>
						<input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" />
						<%}%>
                    </dt>


                </dl>
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["gys_id"] %>"/>
                    <input type="submit" value="保存" />

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">贵公司品牌如下</span>
                    
                    <% foreach (System.Data.DataRow row in dt_ppxx.Rows){%>
                    <div class="fgstp">
                        <img src="images/wwwq_03.jpg" />
                        <span class="fdlpp1">
                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                            <%=row["品牌名称"].ToString() %>
                        </span>
                    </div>

                    <%} %>
                    
                </div>
            </div>
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">删除选中品牌</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新品牌</a></span>
        </div>
    



	  

    <script>
        function AddNewBrand(id)
        {
             var url = "xzpp.aspx?gys_id=" + id;
             window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand()
        {
            var r = confirm("请确认您将删除此品牌!");
            if (r == true) {

                var brand_str = "?pp_id=";
                var brands = document.getElementsByName("brand");

                for (var i = 0; i < brands.length; i++) {
                    if (brands[i].checked) {

                        brand_str = brand_str + "," + brands[i].value;
                    }

                }

                var url = "scpp.aspx" + brand_str;
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
        }
    </script>


    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  



</body>
</html>
