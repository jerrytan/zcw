<!--
       文件名:xzclym2.aspx
	   传入参数 : 分类编码(两位)
       author:张新颖
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
           DataConn objConn=new DataConn();
            string yjfl_id = Request["id"];   //获取大类穿过来的分类编码

           string sSQL="select 显示名字,分类编码 from 材料分类表 where left(分类编码,2)='"+yjfl_id+"'and len(分类编码)='4'";
         
            DataTable dt_ejfl =objConn.GetDataTable(sSQL);       
            Response.Write("<option value='0'>选择小类</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["分类编码"]+"'>"+row["显示名字"]+"</option>");
            }

%>