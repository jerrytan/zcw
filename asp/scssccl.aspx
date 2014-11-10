<%@ Page Language="C#"  EnableViewStateMac= "false"  %>


<script runat="server">
    DataConn Conn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string cl_id = "";
        if (Request["cl_id"]!=null&&Request["cl_id"].ToString()!="")
        {
            cl_id = Request["cl_id"];
        }
        while (cl_id.EndsWith(","))
        {
            cl_id = cl_id.Substring(0, cl_id.Length - 1);
        }        
        string  sSQL = "delete 材料表 where cl_id in ("+cl_id+") ";
        if (Conn.ExecuteSQL(sSQL,true))
        {
            Response.Write("1");
        }
        else
        {
            Response.Write("0");
        }
      //  sSQL += "delete 分销商和品牌对应关系表 where cl_id in ("+cl_id+")";
        //if (Conn.RunSqlTransaction(sSQL))
        //{
        //    Response.Write(1);
        //}
        //else
        //{
        //    Response.Write(0); 
        //}
    }
</script>

