<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"%>
<script runat="server">
public DataConn Conn = new DataConn();
public string scsid = "";       //生产商ID
public string fxsid = "";       //分销商ID
public string ppid = "";
public string ppmc = "";
public DataTable dt = new DataTable();
protected void Page_Load(object sender, EventArgs e)
{
    string cl_id="";
    if (Request["scsid"] != null && Request["scsid"].ToString() != "")
    {
        scsid = Request["scsid"].ToString();
    }
    if (Request["fxsid"] != null && Request["fxsid"].ToString() != "")
    {
        fxsid = Request["fxsid"].ToString();
    }
    if (Request["ppid"] != null && Request["ppid"].ToString() != "")
    {
        ppid = Request["ppid"].ToString();
    }
    if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
    {
        ppmc = Request["ppmc"].ToString();
    }
    if (Request["cl_id"] != null && Request["cl_id"].ToString() != "")
    {
        cl_id = Request["cl_id"].ToString();
    }
    string sValue = "";
    string sql = "";
    if (cl_id != "")
    {
        while (cl_id.EndsWith(","))
        {
            cl_id = cl_id.Substring(0, cl_id.Length - 1);
        }
       
        sql = "delete 供应商材料表 where fxs_id='" + fxsid + "' and gys_id='" + scsid + "' and pp_id='" + ppid +
            "' and 品牌名称='" + ppmc + "' and cl_id in(" + cl_id + ")";
        
        if (Conn.ExecuteSQLForCount(sql, true)>0)
        {
            sValue = "1";
        }
        else
        {
            sValue = "删除失败！";
        }
    }
    else
    {
        sValue = "未选中材料";
    }
    Response.Write(sValue);
 //   Response.Write(sValue);
}
</script>
 
