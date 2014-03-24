<!--
          新增品牌  (生产商增加新的品牌)
		  文件名: xzpp.aspx              
		  传入参数：一级分类id
		  author:张新颖
         
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            DataConn objConn=new DataConn();
            string yjfl_id ="";
          if( Request["id"]!=null&& Request["id"].ToString()!="")
          {
            yjfl_id = Request["id"].ToString();   //获取大类传过来的分类编码
          }

          string sSQL="select 显示名字,分类编码 from 材料分类表 where left(分类编码,2)='"+yjfl_id+"'and len(分类编码)='4'";
        
            DataTable dt_ejfl = objConn.GetDataTable(sSQL);      
            string value="";; 
            for(int i=0;i<dt_ejfl.Rows.Count;i++)
            {
                value+=dt_ejfl.Rows[i]["分类编码"].ToString()+"|"+dt_ejfl.Rows[i]["显示名字"].ToString()+"#";
            }
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
            //  value+= "<option value='"+row["分类编码"]+"'>"+row["显示名字"]+"</option>");
            }

             Response.Write(value);
%>