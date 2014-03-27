<!--   
      文件名:xzclym3 
      传入参数: id (二级分类编码)
      author:张新颖
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
             DataConn objConn=new DataConn();

            string ejfl_id = Request["id"];   //获取小类穿过来的分类编码
            string id = ejfl_id.ToString().Substring(0, 2);
			
			
           string sSQL="select 品牌名称,pp_id from 品牌字典 where left(分类编码,2)='"+id+"'";
          
            DataTable dt_pp =objConn.GetDataTable(sSQL);   
            Response.Write("<option value='0'>选择品牌</option>");
            foreach(System.Data.DataRow row in dt_pp.Rows) 
            {
                Response.Write("<option value='"+row["pp_id"]+"'>"+row["品牌名称"]+"</option>");
            }			
			
		
			
		

%>