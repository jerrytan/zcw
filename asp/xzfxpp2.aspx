
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            DataConn objConn=new DataConn();
             string s_yh_id="";
             string sSQL="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
            else
            {
                if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
                {
                     s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
                }
            }

            //��������Ʒ��д�����ݿ�
           if(s_yh_id!="") {
                
                 string dwlx=Request["lx"];
                 string fxs_id = Request["fxs_id"]; 		
                 string pp_id = Request["pp_id"];		
                 string pp_name = Request["pp_name"];                
                if(dwlx=="������")
                {
                   string clfl=Request["clfl"];
                   string ppmc=Request["ppmc"];
                   string fw=Request["fw"];
                   string dj=Request["dj"];
                  sSQL="update Ʒ���ֵ� set Ʒ������=c.Ʒ������,�Ƿ�����=c.�Ƿ�����,�ȼ�=c.�ȼ�,�������=c.�������,��������=c.��������,fl_id=c.fl_id,��Χ=c.��Χ,������=c.��Ӧ��,��ע=c.��ע
from ���Ϲ�Ӧ����Ϣ�ӱ� c,Ʒ���ֵ� p where c.uid=[myid] and c.myid=p.��ʶid";
                }
                else
                {
                    
                    string str_insert = "insert into  �����̺�Ʒ�ƶ�Ӧ��ϵ�� (pp_id, Ʒ������, �Ƿ�����,fxs_id,yh_id) values('"+ pp_id + "','"+pp_name+"', 1,'"+fxs_id+"','" +s_yh_id+"' ) ";
                    objConn.ExecuteSQL(str_insert,true);
                }
                Response.Write(str_insert);
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">��ϲ������������Ʒ�Ƴɹ��������ҷ��ء�</a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





