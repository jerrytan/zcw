<%@ Import Namespace="System.Data" %>
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
    public string pp_id = "";//接收从glfxsxx页面中传过来的品牌id
    public string sSQL = "";
    public string s_yh_id="";//蒋，2014年8月21日，用户id字段
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        //蒋，2014年8月21日，添加if
         if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
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
                Response.Write(pp_id+","+lx);
            }
            //蒋，2014年8月21日，注释if(lx!="scs"),改为if(lx=="scs")
            //if (lx != "scs")//分销商
            if(lx=="scs")
            {
                //蒋，21日
                //string fxs_mc = "select 供应商 from 材料供应商信息表 where gys_id='" + s_yh_id + "' ";
                sSQL = "select fxs_id,分销商 from 分销商和品牌对应关系表 where pp_id='" + pp_id + "' "; //查询分销商id	
                DataTable dt_fxs = objConn.GetDataTable(sSQL);
                if (dt_fxs != null && dt_fxs.Rows.Count > 0)
                {
                    Response.Write("<option value = '0'>" + "请选择分销商" + "</option>");
                    foreach (DataRow row in dt_fxs.Rows)
                    {
                        Response.Write("<option value = '" + row["fxs_id"].ToString() + "'>" + row["分销商"].ToString() + "</option>");
                    }
                }
            }
            //蒋，2014年8月21日，注释
            //else
            //{
            //    sSQL = "select scs_id,生产商 from 品牌字典 where pp_id='" + pp_id + "' "; //查询分销商id	
            //    DataTable dt_fxs = objConn.GetDataTable(sSQL);
            //    if (dt_fxs != null && dt_fxs.Rows.Count > 0)
            //    {
            //        Response.Write("<option value = '0'>" + "请选择生产商" + "</option>");
            //        foreach (DataRow row in dt_fxs.Rows)
            //        {
            //            Response.Write("<option value = '" + row["scs_id"].ToString() + "'>" + row["生产商"].ToString() + "</option>");
            //        }
            //    }
            //}

        }
    }
</script>
<body>

</body>
</html>
