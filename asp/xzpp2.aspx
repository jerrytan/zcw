<!--
          ����Ʒ��  (�����������µ�Ʒ��)
		  �ļ���: xzpp.aspx              
		  ���������һ������id
		  author:����ӱ
         
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            DataConn objConn=new DataConn();
            string yjfl_id ="";
          if( Request["id"]!=null&& Request["id"].ToString()!="")
          {
            yjfl_id = Request["id"].ToString();   //��ȡ���ഫ�����ķ������
           // Response.Write(yjfl_id+"һ������");
          }

          string sSQL="select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'";
        
            DataTable dt_ejfl = objConn.GetDataTable(sSQL);      
            string value="";

            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
               Response.Write("<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>");
            }

%>