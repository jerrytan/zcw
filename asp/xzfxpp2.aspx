
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
             string s_yh_id="";
             string sSQL="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
            string source = Request["source"];

            //��������Ʒ��д�����ݿ�
           if(s_yh_id!="") {
                
                 string dwlx=Request["lx"];             //��λ����
                 string fxs_id = Request["fxs_id"]; 	//������id	
                 string pp_id = Request["pp_id"];	    //Ʒ��id	
                 string pp_name = Request["pp_name"];   //Ʒ������     

                if(dwlx=="������")
                {
                   string clfl=Request["clfl"];         //
                   string ppmc=Request["ppmc"];
                   string fw=Request["fw"];
                   string dj=Request["dj"];
                   sSQL = "select count(*) from Ʒ���ֵ� where Ʒ������='" + pp_name + "'";
                   string count = objConn.DBLook(sSQL);
                   if (count == "0")
                   {
                       sSQL = "insert into  Ʒ���ֵ� (Ʒ������,�Ƿ�����,scs_id,�������,�ȼ�,��Χ,yh_id) values('" +
                          pp_name + "',1,'" + fxs_id + "','" + clfl + "','" + dj + "','" + fw + "','" + s_yh_id + "' ) ";

                       objConn.ExecuteSQL(sSQL, false);
                       string str_update = "update Ʒ���ֵ� set pp_id= (select myID from Ʒ���ֵ� where Ʒ������='" + pp_name + "'),"
                           + " fl_id = (select fl_id from ���Ϸ���� where �������='" + clfl + "'),"
                           + " ������ = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '" + fxs_id + "'),"
                           + " �������� = (select ��ʾ���� from ���Ϸ���� where ������� = '" + clfl + "'),updatetime=(select getdate())"
                           + " where Ʒ������='" + pp_name + "'";

                       int ret = objConn.ExecuteSQLForCount(str_update, true);
                       Response.Write(" <a style='color: Red' onclick=\"clickMe()\">��ϲ��������Ʒ�Ƴɹ��������ҷ��ء�</a>");
                   }
                   else
                   {
                       Response.Write(" <a style='color: Red' >��Ʒ�������Ѵ��ڣ���������ӣ�</a>");
                   }
              
                }
                else
                {
                    sSQL = "select count(*) from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + pp_id + "' and Ʒ������='" + pp_name + "' and �Ƿ�����='1' and fxs_id='" + fxs_id + "' and yh_id='" + s_yh_id + "'";
                    string count = objConn.DBLook(sSQL);
                    if (count=="0")
                    {
                        sSQL = "insert into  �����̺�Ʒ�ƶ�Ӧ��ϵ�� (pp_id, Ʒ������, �Ƿ�����,fxs_id,yh_id,updatetime) values('" + pp_id + "','" + pp_name + "', 1,'" + fxs_id + "','" + s_yh_id + "',(select getdate()) ) ";
                        objConn.ExecuteSQL(sSQL, true);
                        Response.Write(" <a style='color: Red' onclick=\"clickMe()\">��ϲ������������Ʒ�Ƴɹ��������ҷ��ء�</a>");
                    }
                    else
                    {
                        Response.Write(" <a style='color: Red' onclick=\"clickMe()\">���Ѿ������˸�Ʒ�ƣ���ѡ������Ʒ�ơ�</a>");
                    }
                  
                }
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        
         <script defer="defer" type="text/javascript">
             function doload()
             {
             <%if(source=="xzym"){ %>
                  window.close();
                 opener.location.href="gyszym.aspx";
             <%}else{ %>
                 window.close();
                 opener.location.reload();
                 <%
                 } %>
             }
             setTimeout("doload()", 1000);
        </script>
    </body>

</html>
