<!--      
	   删除品牌
       文件名：scpp.aspx 
       传入参数：
                 fxs_id  分销商 id
                 pp_id   品牌id
       author:张新颖  
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>
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
            string lx="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                yh_id =Session["GYS_YH_ID"].ToString();
            }       
            if(Request["fxs_id"]!=null&&Request["fxs_id"].ToString()!="")
            {
                fxs_id=Request["fxs_id"].ToString();
            }
           if(Request["lx"]!=null&&Request["lx"].ToString()!="")
            {
                lx=Request["lx"].ToString();
            }
             string sSQL="";
            //删除品牌  生产商 删除的是品牌字典表  分销商 删除分销商和品牌对应关系表
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
                 if(lx=="1")  //lx=1为生产商  2分销商为
                 {         
                   
                    if(ppid_str.Contains(","))
                    { 
                        ppid_list=ppid_str.Split(',');
                        for(int i=0;i<ppid_list.Length;i++)
                        {
                              sSQL="delete 品牌字典 where scs_id='"+fxs_id+"' and pp_id ='"+ ppid_list[i]+"'";                
                             ret = objConn.ExecuteSQLForCount(sSQL,true);	
                        }
                    }
                    else
                    {
                        ppid=ppid_str;
                          sSQL="delete 品牌字典 where scs_id='"+fxs_id+"' and pp_id = '"+ ppid+"'";                 
                         ret = objConn.ExecuteSQLForCount(sSQL,true);	
                    } 		
                }
                else
                {
                     if(ppid_str.Contains(","))
                    { 
                        ppid_list=ppid_str.Split(',');
                        for(int i=0;i<ppid_list.Length;i++)
                        {
                             sSQL="delete 分销商和品牌对应关系表 where fxs_id='"+fxs_id+"' and pp_id ='"+ ppid_list[i]+"'";              
                             ret = objConn.ExecuteSQLForCount(sSQL,true);	
                        }
                    }
                    else
                    {
                        ppid=ppid_str;
                         sSQL="delete 分销商和品牌对应关系表 where fxs_id='"+fxs_id+"' and pp_id = '"+ ppid+"'";               
                         ret = objConn.ExecuteSQLForCount(sSQL,true);	
                    } 		
                }
     }     
    </script>
    <p></p>
    <p></p>
    <%if(ret!=0){ %>

        <a style="color: Red" onclick="clickMe()">恭喜您，删除品牌成功，请点击我返回。 </a>
    <% }
    else
    {%>
        <a style="color: Red" onclick="clickMe()">删除品牌失败，请返回重试。 </a>
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
