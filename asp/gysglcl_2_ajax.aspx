<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>
<script runat="server">
<%--文件名:  gysglcl_2.aspx   
       传入参数：cl_id  删除材料页面
       author:蒋桂娥--%>
    DataConn obCon = new DataConn();
    string cl_id = "";
    string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
    
        cl_id = Request["cl_id"];
        cl_id = cl_id.TrimEnd(',');
        sSQL = "delete 材料表 where cl_id in ("+cl_id+") ";
        sSQL += "delete 分销商和品牌对应关系表 where cl_id in ("+cl_id+")";
        if (Conn.RunSqlTransaction(sSQL);)
        {
            Response.Write(1);
        }
        else
        {
            Response.Write(0); 
        }
    }
</script>