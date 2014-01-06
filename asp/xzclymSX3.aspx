
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			
			string flsx_id = Request["id"];   //获取分类名称传过来的分类id 
            //先根据传过来的flsx_id 查出分类编码			
            SqlDataAdapter da_flsxid = new SqlDataAdapter("select 分类编码 from 材料分类属性值表 where flsx_id='"+flsx_id+"'",conn);    //分类 属性
			DataSet ds_flsxid = new DataSet();
			da_flsxid.Fill(ds_flsxid,"材料分类属性值表");
			DataTable dt_flsxid = ds_flsxid.Tables[0];	
            string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["分类编码"]);	  //获取分类编码	
         
			//以分类编码   和分类名称传过来的分类id 查询属性值 
			SqlDataAdapter da_flsx_id = new SqlDataAdapter("select 属性值 from 材料分类属性值表	 where flsx_id='"+flsx_id+"'and 分类编码='"+clflsx_id+"' ",conn);    //分类 属性
			DataSet ds_flsx_id = new DataSet();
			da_flsx_id.Fill(ds_flsx_id,"材料分类属性值表");
			DataTable dt_flsx_id = ds_flsx_id.Tables[0];	
            string clflsx_id1 = Convert.ToString(dt_flsx_id.Rows[0]["属性值"]);	  //获取分类编码
            Response.Write(clflsx_id1);
			
            //Response.Write("<input type="text">"+clflsx_id+"</input>");
            //Response.Write(clflsx_id);
	        //Response.Write("<option value=''>"+clflsx_id1+"</option>");
%>