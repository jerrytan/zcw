
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
        string sSQL="";
			DataConn objConn=new DataConn();
			string flsx_id = Request["id"];   //��ȡ�������ƴ������ķ���id 
            //�ȸ��ݴ�������flsx_id ����������			
           sSQL="select ������� from ���Ϸ�������ֵ�� where flsx_id='"+flsx_id+"'";    //���� ����
		
			DataTable dt_flsxid = objConn.GetDataTable(sSQL);	
            string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["�������"]);	  //��ȡ�������	
         
			//�Է������   �ͷ������ƴ������ķ���id ��ѯ����ֵ 
			sSQL="select ����ֵ from ���Ϸ�������ֵ�� where flsx_id='"+flsx_id+"'and �������='"+clflsx_id+"' ";    //���� ����
		
			DataTable dt_flsx_id = objConn.GetDataTable(sSQL);
            string clflsx_id1 = Convert.ToString(dt_flsx_id.Rows[0]["����ֵ"]);	  //��ȡ�������
            Response.Write(clflsx_id1);
			
            //Response.Write("<input type="text">"+clflsx_id+"</input>");
            //Response.Write(clflsx_id);
	        //Response.Write("<option value=''>"+clflsx_id1+"</option>");
%>