<!--
       �ļ���:xzclym2.aspx
	   ������� : �������(��λ)
       author:����ӱ
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
           DataConn objConn=new DataConn();
            string yjfl_id = Request["id"];   //��ȡ���ഩ�����ķ������

           string sSQL="select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'";
         
            DataTable dt_ejfl =objConn.GetDataTable(sSQL);       
            Response.Write("<option value='0'>ѡ��С��</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>");
            }

%>