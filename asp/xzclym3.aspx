<!--   
      �ļ���:xzclym3 
      �������: id (�����������)
      author:����ӱ
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
             DataConn objConn=new DataConn();

            string ejfl_id = Request["id"];   //��ȡС�ഩ�����ķ������
            string id = ejfl_id.ToString().Substring(0, 2);
			
			
           string sSQL="select Ʒ������,pp_id from Ʒ���ֵ� where left(�������,2)='"+id+"'";
          
            DataTable dt_pp =objConn.GetDataTable(sSQL);   
            Response.Write("<option value='0'>ѡ��Ʒ��</option>");
            foreach(System.Data.DataRow row in dt_pp.Rows) 
            {
                Response.Write("<option value='"+row["pp_id"]+"'>"+row["Ʒ������"]+"</option>");
            }			
			
		
			
		

%>