
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
        string dwlx = Request["lx"];             //单位类型 
        string pp_id = Request["ppid"];	    //品牌id	
        string pp_name = Request["ppmc"];   //品牌名称   
        string scsid = Request["scsid"];

        sSQL = "select count(*) from 分销商和品牌对应关系表 where pp_id='" + pp_id + "' and 品牌名称='" + pp_name + "' and 是否启用='1' and fxs_id='" + fxs_id + "' and 生产厂商ID='" + scsid + "'";
        string count = objConn.DBLook(sSQL);
        if (count == "0")
        {
            //sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,分销商,生产商ID,yh_id,updatetime) values('" +
            //    pp_id + "','" + pp_name + "', 1,'" + fxs_id + "',(select 供应商 from 材料供应商信息表 where gys_id='"+fxs_id+"'),'"+scsid+"','" + s_yh_id + "',(select getdate()) ) ";
            //objConn.ExecuteSQL(sSQL, true);
            //Response.Write(" <a style='color: Red' onclick=\"clickMe()\">恭喜您，新增分销品牌成功，请点击我返回。</a>");
            Response.Write(" <a style='color: Red' onclick=\"clickMe()\">请申请代理品牌。</a>");
        }
        else
        {
            sSQL = "update 分销商和品牌对应关系表 set 是否启用='1' where 生产商ID='" + scsid + "' and fxs_id='" + fxs_id + "' and 品牌名称='" + pp_name + "' and pp_id='" + pp_id + "' ";
            objConn.ExecuteSQL(sSQL, true);
            Response.Write(" <a style='color: Red' onclick=\"clickMe()\">成功代理品牌！</a>");
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
