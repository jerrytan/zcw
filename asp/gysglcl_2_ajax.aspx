<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>

<script runat="server"> 
    DataConn Conn = new DataConn();
    string cl_id = "";
    string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {    
        cl_id = Request["cl_id"];
        cl_id = cl_id.TrimEnd(',');
        sSQL = "delete 材料表 where cl_id in ("+cl_id+") ";
        sSQL += "delete 分销商和品牌对应关系表 where cl_id in (" + cl_id + ")";  //生产商删除材料的同时删除分销商代理的材料
        if (Conn.RunSqlTransaction(sSQL))
        {
            Response.Write(1);
        }
        else
        {
            Response.Write(0); 
        }
    }
</script>