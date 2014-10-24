<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
<%--文件名:  gysglcl_2.aspx   
       传入参数：cl_id
       author:蒋桂娥--%>
    DataConn obCon = new DataConn();
    string cl_id = "";
    string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cl_id = Request["cl_id"];
        cl_id = cl_id.TrimEnd(',');
        sSQL = "update 材料表 set 是否启用=0 where cl_id = ("+cl_id+")";
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