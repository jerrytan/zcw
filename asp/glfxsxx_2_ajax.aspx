<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    DataConn objConn = new DataConn();
    string sSQL = "";
    string gs_mc = ""; 
    string s_yh_id = ""; 
protected void Page_Load(object sender, EventArgs e)
{
    if (Session["GYS_YH_ID"] != null)
    {
        s_yh_id = Session["GYS_YH_ID"].ToString();
    }
    gs_mc = Request.QueryString["gs_mc"].ToString();
    gs_mc = gs_mc.TrimEnd(',');
    sSQL = "update 材料供应商信息表 set 是否启用=0 where 供应商 in ('" + gs_mc + "')";
    if (objConn.ExecuteSQL(sSQL, true))
    {
        Response.Write(1);
    }
    else
    {
        Response.Write(0);
    }
   
}
</script>