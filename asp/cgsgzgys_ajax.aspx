<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%

        DataConn dc = new DataConn();
        string cgs_yh_id;
        string gysids = Request.QueryString["gysids"];
        gysids = gysids.TrimEnd(',');

        //获取用户id
        if (Request.Cookies["CGS_QQ_ID"].Value.ToString() != "")
        {
           string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
           string sql = "select yh_id from 用户表 where QQ_id='" + cgs_QQ_id + "'";
           cgs_yh_id = dc.DBLook(sql);
        }
        else
        {
            cgs_yh_id = "";
        }

        string sqlDelete = "delete from 采购商关注供应商表 where gys_id in (" + gysids + ") and yh_id='" + cgs_yh_id + "'";



        if (dc.ExecuteSQL(sqlDelete,true))
        {
          Response.Write(1); //删除成功
        }
        else
        {
             Response.Write(0); //删除失败
        }


 %>
