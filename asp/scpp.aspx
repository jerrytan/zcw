<!--      
	   ɾ��Ʒ��
       �ļ�����scpp.aspx 
       ���������
                 fxs_id  ������ id
                 pp_id   Ʒ��id
       author:����ӱ  
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head></head>
<body>
 <script runat="server">
    public DataConn objConn=new DataConn(); 
    public int ret=0;
    protected void Page_Load(object sender, EventArgs e)
    {
            string yh_id ="";
            string fxs_id="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                yh_id =Session["GYS_YH_ID"].ToString();
            }       
            if(Request["fxs_id"]!=null&&Request["fxs_id"].ToString()!="")
            {
                fxs_id=Request["fxs_id"].ToString();
            }
            if (Request.Cookies["GYS_YH_ID"]!=null && Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
            {
                 yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
            }
            //ɾ��Ʒ��
                          
                string ppid_str="";
                if(Request["pp_id"]!=null&&Request["pp_id"].ToString()!="")
                {
                     ppid_str = Request["pp_id"].ToString();
                }
                ppid_str = ppid_str.Trim();
                while (ppid_str.EndsWith(","))
                {
                      ppid_str = ppid_str.Substring(0, ppid_str.Length - 1);
                }               
                string[] ppid_list=new string[ppid_str.Length];
                string ppid="";
                if(ppid_str.Contains(","))
                { 
                    ppid_list=ppid_str.Split(',');
                    for(int i=0;i<ppid_list.Length;i++)
                    {
                        //    �����̺�Ʒ�ƶ�Ӧ��ϵ��
                        string sSQL="delete Ʒ���ֵ� where scs_id='"+fxs_id+"' and pp_id ='("+ ppid_list[i]+")'";
                        //  string str_update = "delete from  Ʒ���ֵ� where pp_id in ("+ ppid_list[i]+")";                 
                         ret = objConn.ExecuteSQLForCount(sSQL,true);	
                    }
                }
                else
                {
                    ppid=ppid_str;
                    string sSQL="delete Ʒ���ֵ� where scs_id='"+fxs_id+"' and pp_id = '"+ ppid+"'";
                    //  string str_update = "delete from  Ʒ���ֵ� where pp_id in '"+ ppid+"'";                 
                     ret = objConn.ExecuteSQLForCount(sSQL,true);	
                       Response.Write(sSQL);
                } 		
         
     }     
    </script>
    <p></p>
    <p></p>
    <%if(ret!=0){ %>

        <a style="color: Red" onclick="clickMe()">��ϲ����ɾ��Ʒ�Ƴɹ��������ҷ��ء� </a>
    <% }
    else
    {%>
        <a style="color: Red" onclick="clickMe()">ɾ��Ʒ��ʧ�ܣ��뷵�����ԡ� </a>
   <% }%>
   <script language="javascript">
       function clickMe()
       {
           window.close();
           opener.location.reload();

       }
   </script>
    <script language="javascript" defer="defer">
        function doload()
        {
            window.close();
            opener.location.reload();
        }
        setTimeout("doload()", 2000);
    </script>
</body>
</html>
