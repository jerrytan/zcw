<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
     DataConn obCon = new DataConn();
    string gs_id = "";
    string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
            gs_id = Request["gs_id"];
            string gsid = gs_id.TrimEnd(',');
            sSQL = "update 材料供应商信息表 set 是否启用=0 where gys_id in ("+ gsid +")";
            if (obCon.ExecuteSQL(sSQL, true))
            {
                Response.Write(1);
            }
            else
            {
                Response.Write(0);
            }
    }   
</script>