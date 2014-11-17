<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>

<script runat="server">
    DataConn dc = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string dwid = "";
        string gys_id = "";
        if (Request["dwid"]!=null&&Request["dwid"].ToString()!="")
        {
            dwid = Request["dwid"].ToString();
        }
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            gys_id = Request["gys_id"].ToString();
        }
        while (gys_id.EndsWith(","))
        {
            gys_id = gys_id.Substring(0, gys_id.Length - 1);
        }
        string sqlDelete = "delete from 采购商关注供应商表 where gys_id in (" + gys_id + ") and dw_id='" + dwid + "'";
        if (dc.ExecuteSQL(sqlDelete, true))
        {
            Response.Write(1); //删除成功
        }
        else
        {
            Response.Write(0); //删除失败
        }

    }
</script>
 