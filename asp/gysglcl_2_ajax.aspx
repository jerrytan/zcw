<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    DataConn obCon = new DataConn();
    string cl_id = "";
    string s_yh_id = "";
    string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cl_id = Request.QueryString["cl_id"];
        cl_id = cl_id.TrimEnd(',');
        sSQL = "update 材料表 set 是否启用=0 where cl_id in ("+cl_id+")";
        if (obCon.ExecuteSQL(sSQL,true))
        {
            Response.Write(1);
        }
        else
        {
            Response.Write(0); 
        }
    }
</script>