﻿<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<script runat="server">
    public string pp_id = "";
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string lx = "";
        if (Request["lx"] != null && Request["lx"].ToString() != "")
        {
            lx = Request["lx"].ToString();
        }
        if (lx != "")
        {
            if (Request["id"] != null && Request["id"].ToString() != "")
            {
                pp_id = Request["id"].ToString();
            }
            if (lx != "scs")
            {
                sSQL = "select fxs_id,分销商 from 分销商和品牌对应关系表 where pp_id='" + pp_id + "' "; //查询分销商id	
                DataTable dt_fxs = objConn.GetDataTable(sSQL);
                if (dt_fxs != null && dt_fxs.Rows.Count > 0)
                {
                    Response.Write("<option value = '0'>" + "请选择分销商" + "</option>");
                    foreach (DataRow row in dt_fxs.Rows)
                    {
                        Response.Write("<option value = '" + row["fxs_id"] + "'>" + row["分销商"] + "</option>");
                    }
                }
            }
            else
            {
                sSQL = "select scs_id,生产商 from 品牌字典 where pp_id='" + pp_id + "' "; //查询分销商id	
                DataTable dt_fxs = objConn.GetDataTable(sSQL);
                if (dt_fxs != null && dt_fxs.Rows.Count > 0)
                {
                    Response.Write("<option value = '0'>" + "请选择生产商" + "</option>");
                    foreach (DataRow row in dt_fxs.Rows)
                    {
                        Response.Write("<option value = '" + row["scs_id"] + "'>" + row["生产商"] + "</option>");
                    }
                }
            }

        }
    }
</script>
<body>

</body>
</html>