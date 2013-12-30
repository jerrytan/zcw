<!--   
      文件名:xzclym3 
      传入参数: id (二级分类编码)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string ejfl_id = Request["id"];   //获取小类穿过来的分类编码
            string id = ejfl_id.ToString().Substring(0, 2);
			
			
            SqlDataAdapter da_pp = new SqlDataAdapter("select 品牌名称,pp_id from 品牌字典 where left(分类编码,2)='"+id+"'", conn);
            DataSet ds_pp = new DataSet();
            da_pp.Fill(ds_pp, "品牌字典");            
            DataTable dt_pp = ds_pp.Tables[0];        
            Response.Write("<option value='0'>选择品牌</option>");
            foreach(System.Data.DataRow row in dt_pp.Rows) 
            {
                Response.Write("<option value='"+row["pp_id"]+"'>"+row["品牌名称"]+"</option>");
            }			
			
		
			
		

%>