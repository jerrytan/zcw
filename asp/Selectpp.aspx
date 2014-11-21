<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#"  %>
 <script runat="server">
     protected DataConn Conn = new DataConn();
     protected void Page_Load(object sender, EventArgs e)
     {
         string scs_id = "";
         if (Request["scsid"] != null && Request["scsid"].ToString() != "")
         {
             scs_id = Request["scsid"].ToString();
         }
         string sqlpp = "select 品牌名称,pp_id from 品牌字典 where scs_id='" + scs_id + "' and isnull(是否启用,'')='1'";
         DataTable dt_pp = Conn.GetDataTable(sqlpp);
         string html = "";
         html += "<select id='pinp'  name=\"gys\" style=\"width: 200px\">"
                 + "<option value='-1'>请选择品牌</option>";
         if (dt_pp != null && dt_pp.Rows.Count > 0)
         {
             for (int i = 0; i < dt_pp.Rows.Count; i++)
             {
                 html += "<option value=" + dt_pp.Rows[i]["品牌名称"] + ">" + dt_pp.Rows[i]["品牌名称"] + "</option>";
             }
         }
         html += "</select>";
         Response.Write(html);
     }
 </script>