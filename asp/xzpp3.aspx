<!--
      ����������Ʒ��
	  �ļ���:  xzpp3.aspx   
      �������:�û�id 
	  author:����ӱ         
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<%
            DataConn objConn=new DataConn();
            //����Ʒ��д�����ݿ�
             string yh_id="";
        
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
                {
                    yh_id =Session["GYS_YH_ID"].ToString();   //��ȡ�û�id
                }  

                  string  source=Request.Form["source"];
             
                string gys_id = Request.Form["gys_id"]; 				
                string brandname = Request.Form["brandname"];            //Ʒ������
                string yjflname = Request.Form["yjflname"];              //�󼶷�������               
                string ejflname = Request.Form["ejflname"];              //������������
                string grade = Request.Form["grade"];               //�ȼ�
                string scope = Request.Form["scope"];                    //��Χ       
                string flname = Request.Form["ejflname"];
                if (flname.Equals("0"))  flname = Request.Form["yjflname"];
               
                string str_insert = "insert into  Ʒ���ֵ� (Ʒ������,�Ƿ�����,scs_id,�������,�ȼ�,��Χ,yh_id) values('" + brandname + "',1,'"+gys_id+"','" + flname + "','" + grade + "','" + scope + "','"+yh_id+"' ) ";
            
                objConn.ExecuteSQL(str_insert,false);
                string str_update = "update Ʒ���ֵ� set pp_id= (select myID from Ʒ���ֵ� where Ʒ������='"+brandname+"'),"  
                    +" fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"')," 
                    +" ������ = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
                    +" �������� = (select ��ʾ���� from ���Ϸ���� where ������� = '"+flname+"')"
                    +" where Ʒ������='"+brandname+"'";
              
                int ret = 	objConn.ExecuteSQLForCount(str_update,true);	
                if (ret==0)
                {
                    string sql="delete Ʒ���ֵ� where Ʒ������='"+brandname+"' and �Ƿ�����=1 and scs_id='"+gys_id+"' and �������='"+flname+"' and yh_id='"+yh_id+"'";
                    objConn.ExecuteSQL(sql, true);
                }
    
                               
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       <%if(ret!=0) {%>
        <a style="color: Red" onclick="clickMe()">��ϲ��������Ʒ�Ƴɹ����뷵��; </a>
        <%}else{ %>
         <a style="color: Red" onclick="clickMe()">����Ʒ��ʧ�ܣ�ҳ�潫��ת����ҳ��</a>
             
        <%} %>
        <script defer="defer" type="text/javascript">
            function doload()
            {
            <%if(source=="xzym") {%>
              window.close();
                opener.location.href="gyszym.aspx";
            <%} else{%>
                window.close();
                opener.location.reload();
                <%} %>
            }
            setTimeout("doload()", 1000);
        </script>
        <script type="text/javascript">
            function clickMe() {

                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





