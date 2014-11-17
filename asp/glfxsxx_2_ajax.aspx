<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>
<script runat="server">
     DataConn obCon = new DataConn();
    string fxs_id = "";
    string sSQL = "";
    string gys_id="";
    string pp_id="";
    protected void Page_Load(object sender, EventArgs e)
    {
            fxs_id = Request["fxs_id"];
            gys_id=Request["gys_id"];
            pp_id=Request["pp_id"];
            string fxsid = fxs_id.TrimEnd(',');
            sSQL = "delete 分销商和品牌对应关系表 where fxs_id in ("+ fxsid +") and pp_id='"+pp_id+"' and 生产厂商ID='"+gys_id+"'";
            string a = sSQL;
            if (obCon.ExecuteSQL(sSQL, true))
            {
               // sSQL = "delete 材料供应商信息从表 where gys_id ='" + gys_id + "' and pp_id='" + pp_id + "'";
                //if (obCon.ExecuteSQL(sSQL, true))
                //{
                    Response.Write(1);
                //}
                //else
                //{
                //    Response.Write(0); 
                //}
            }
            else
            {
                Response.Write(0);
            }
            
    }   
</script>