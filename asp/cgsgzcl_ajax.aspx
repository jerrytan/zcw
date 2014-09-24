<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%

        DataConn dc = new DataConn();
        string cgs_yh_id;
        string clids = Request.QueryString["clids"];
        clids = clids.TrimEnd(',');

        //获取用户id
        if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
            cgs_yh_id = Session["CGS_YH_ID"].ToString();

        else
            cgs_yh_id = "";

        string sqlDelete = "delete from 采购商关注的材料表 where cl_id in (" + clids + ") and yh_id = '" + cgs_yh_id + "'";

        if (dc.ExecuteSQL(sqlDelete,true))
        {
            Response.Write(1); //删除成功
        }
        else
        {
            Response.Write(0); //删除失败
        }


 %>
