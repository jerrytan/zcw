<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#"%>

<script runat="server">
    public DataConn Conn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        string ppid = "";
        if (Request["ppid"] != null && Request["ppid"].ToString() != "")
        {
            ppid = Request["ppid"].ToString();
        }
        string ppname = "";
        if (Request["ppname"] != null && Request["ppname"].ToString() != "")
        {
            ppname = Request["ppname"].ToString();
        }
        string fxsid="";
         if (Request["fxsid"] != null && Request["fxsid"].ToString() != "")
        {
            fxsid = Request["fxsid"].ToString();
        }
         string sSQL = "";
         string html = "";

         sSQL = "select 等级,scs_id,生产商,范围 from 品牌字典 where pp_id='" + ppid + "' and 品牌名称='" + ppname + "' and scs_id in (select 生产厂商ID from 分销商和品牌对应关系表 where pp_id='" + ppid + "' and 品牌名称='" + ppname + "' and fxs_id='"+fxsid+"' )";
             DataTable dt_pp = new DataTable();
             dt_pp = Conn.GetDataTable(sSQL);

             if (dt_pp != null && dt_pp.Rows.Count > 0)
             {
                 html = dt_pp.Rows[0]["生产商"] + "|" + dt_pp.Rows[0]["等级"] + "|" + dt_pp.Rows[0]["范围"] + "|" + dt_pp.Rows[0]["scs_id"];
             }

         
        Response.Write(html);
    }
    </script>