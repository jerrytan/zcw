
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
<script runat="server">
    public  DataConn objConn=new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string s_yh_id = "";
        string sSQL = "";
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        string fxs_id = Request["fxsid"];
        string dwlx = Request["lx"];             //��λ���� 
        string pp_id = Request["ppid"];	    //Ʒ��id	
        string pp_name = Request["ppmc"];   //Ʒ������   
        string scsid = Request["scsid"];

        sSQL = "select count(*) from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='" + pp_id + "' and Ʒ������='" + pp_name + "' and �Ƿ�����='1' and fxs_id='" + fxs_id + "' and ��������ID='" + scsid + "'";
        string count = objConn.DBLook(sSQL);
        if (count == "0")
        {
            //sSQL = "insert into  �����̺�Ʒ�ƶ�Ӧ��ϵ�� (pp_id, Ʒ������, �Ƿ�����,fxs_id,������,������ID,yh_id,updatetime) values('" +
            //    pp_id + "','" + pp_name + "', 1,'" + fxs_id + "',(select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id='"+fxs_id+"'),'"+scsid+"','" + s_yh_id + "',(select getdate()) ) ";
            //objConn.ExecuteSQL(sSQL, true);
            //Response.Write(" <a style='color: Red' onclick=\"clickMe()\">��ϲ������������Ʒ�Ƴɹ��������ҷ��ء�</a>");
            Response.Write(" <a style='color: Red' onclick=\"clickMe()\">���������Ʒ�ơ�</a>");
        }
        else
        {
            sSQL = "update �����̺�Ʒ�ƶ�Ӧ��ϵ�� set �Ƿ�����='1' where ������ID='" + scsid + "' and fxs_id='" + fxs_id + "' and Ʒ������='" + pp_name + "' and pp_id='" + pp_id + "' ";
            objConn.ExecuteSQL(sSQL, true);
            Response.Write(" <a style='color: Red' onclick=\"clickMe()\">�ɹ�����Ʒ�ƣ�</a>");
        }
    }
</script>
 
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
                 window.close();
                 opener.location.reload();                  
             }
             setTimeout("doload()", 1000);
        </script>
    </body>

</html>
