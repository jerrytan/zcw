
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
        string sSQL="";
			DataConn objConn=new DataConn();
			string flsx_id = Request["id"];   //获取分类名称传过来的分类id 
            //先根据传过来的flsx_id 查出分类编码			
           sSQL="select 分类编码 from 材料分类属性值表 where flsx_id='"+flsx_id+"'";    //分类 属性
		
			DataTable dt_flsxid = objConn.GetDataTable(sSQL);	
            string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["分类编码"]);	  //获取分类编码	
         
			//以分类编码   和分类名称传过来的分类id 查询属性值 
			sSQL="select 属性值 from 材料分类属性值表 where flsx_id='"+flsx_id+"'and 分类编码='"+clflsx_id+"' ";    //分类 属性
		
			DataTable dt_flsx_id = objConn.GetDataTable(sSQL);
            string clflsx_id1 = Convert.ToString(dt_flsx_id.Rows[0]["属性值"]);	  //获取分类编码
            Response.Write(clflsx_id1);
			
            //Response.Write("<input type="text">"+clflsx_id+"</input>");
            //Response.Write(clflsx_id);
	        //Response.Write("<option value=''>"+clflsx_id1+"</option>");
%>