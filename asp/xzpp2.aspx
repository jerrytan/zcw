<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>

<%
 
          //����Ʒ��  (�����������µ�Ʒ��)
          //�ļ���: xzpp.aspx              
          //���������һ������id
          //author:����ӱ        
 
            DataConn objConn=new DataConn();
            string yjfl_id ="";
          if( Request["id"]!=null&& Request["id"].ToString()!="")
          {
            yjfl_id = Request["id"].ToString();   //��ȡ���ഫ�����ķ������
          }

          string sSQL="select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'";
        
            DataTable dt_ejfl = objConn.GetDataTable(sSQL);      
            string value="";
            string html = "";
            html = " <select id=\"ejflname\" name=\"ejflname\" style=\"width: 200px\">"
                + " <option value=\"\">��ѡ���������</option>";
              
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
              html+="<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>";
            }
            html += "</select>";
           // Response.Write("<option value='" + row["�������"] + "'>" + row["��ʾ����"] + "</option>");
            Response.Write(html);
%>