<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Page Language="C#" EnableViewStateMac= "false" %>

<script runat="server">
    /// <summary>
    /// 属性值
    /// </summary>
    public DataTable dt_sx = new DataTable();
    public DataTable dt_sxz = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        DataConn Conn = new DataConn();
        //获取属性 属性值 页面
        string flbm = "";
        if (Request["flbm"] != null && Request["flbm"].ToString() != "")
        {
            flbm = Request["flbm"].ToString();
        }
        string flmc="";
        if (Request["flmc"] != null && Request["flmc"].ToString() != "")
        {
            flmc = Request["flmc"].ToString();
        }
        if (flbm != "")
        {
           // string sql_sx = "select 属性名称,属性编码 from 材料分类属性表 where 分类编码='" + Request["flbm"].ToString() + "' and 分类名称='" + flmc + "' order by 分类编码";

            string sql_sx = "select 显示 as 属性名称,属性编码 from 材料分类属性表 where 分类编码='" + Request["flbm"].ToString() + "' and 分类名称='" + flmc + "' order by 分类编码,属性编码";
            dt_sx = Conn.GetDataTable(sql_sx);
        }
        if (dt_sx != null && dt_sx.Rows.Count > 0)
        {
            string html = "";
            html = "<table width='740' border='0' cellpadding='0' cellspacing='1' bgcolor='#dddddd' style='table-layout：fixed ;word-wrap：break-word'>"
                + " <thead>"
                + "   <tr>"
                + "    <th width='70' height='30' align='center' bgcolor='#E3ECFF'><strong>属性名称</strong></th>"
                + " <th align='center' bgcolor='#E3ECFF'><strong>规格\\型号</strong></th>"
                + " <th width='80' align='center' bgcolor='#E3ECFF'><strong>选中项</strong></th>"
                + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>编码</strong></th>"
                  + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>SQL语句</strong></th>"
                + " </tr>"
                + " </thead>"
                + " <tbody id='sx'>";

            foreach (DataRow drsx in dt_sx.Rows)
            {
                string sql_sx = "select 属性名称,属性值,属性编码,编号,flsx_id,flsxz_id,fl_id from 材料分类属性值表  where 属性名称='" + drsx["属性名称"] + "' and 分类编码='" + flbm+"' order by 编号";
                dt_sxz = Conn.GetDataTable(sql_sx);
                string sxmc = Convert.ToString(drsx["属性名称"]);
                sxmc = sxmc.Replace("\r", " ");
                sxmc = sxmc.Replace("\n", " ");
                html += " <tr style='line-height:24px;'>"
               + " <td align='center' bgcolor='#FFFFFF'>" + sxmc + "</td>"
                + " <td align='left' bgcolor='#FFFFFF'> ";
                if (dt_sxz != null && dt_sxz.Rows.Count > 0)
                {
                    foreach (DataRow drsxz in dt_sxz.Rows)
                    {        
                        string value = "";
                        value = drsxz["属性名称"] + "," + drsxz["属性编码"] + "," + drsxz["flsx_id"] + "," + drsxz["属性值"] + "," + drsxz["编号"] + "," + drsxz["flsx_id"]
                            + "," + drsxz["属性编码"] + drsxz["编号"] + "," + drsxz["fl_id"] + "," + flmc + ",clid,clmc,clbm";
                        string sxbm = Convert.ToString(drsxz["属性编码"]);
                        string sxz = Convert.ToString(drsxz["属性值"]);
                        string bh = Convert.ToString(drsxz["编号"]);
                        sxbm = sxbm.Replace("\r", " ");
                        sxbm = sxbm.Replace("\n", " ");
                        sxz = sxz.Replace("\r", " ");
                        sxz = sxz.Replace("\n", " ");
                        bh = bh.Replace("\r", " ");
                        bh = bh.Replace("\n", " ");
              
                        html += "<a href='javascript:void(0)' onclick=\"AddSXZ(this,'" + sxbm +
                            "','" + bh + "','" + sxz + "','"+value+"')\">" + sxz + "&nbsp;&nbsp;</a>";
                    }
                }
                html += "</td>"
                    + " <td align='center' bgcolor='#FFFFFF'></td>"
                    + " <td style='display:none;'></td>"
                    + " <td style='display:none;'></td>"
                    + "</tr>";
            }
            html += " </tbody> "
                    + " <tfoot>"
                    + "        <tr>"
                    + "        <td width='120' height='32' align='right' bgcolor='#FFFFFF'>名称及规则：</td>"
                    + "        <td align='left' bgcolor='#FFFFFF'><input type='text' id='clmcjgg' style=' width: 293px; '/></td>"
                    + "        <td width='80' align='center' bgcolor='#FFFFFF'>"
                    + "        <input type='Button' name='btnDocNew' value='确定' onClick='AddValue()'  class='filter' style='color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;' /></td>"
                    + "      </tr>"
                    + "       </tfoot>"
                    + " </table>";
            Response.Write(html);
        }
        else
        {
            Response.Write("");
        }
    }   
</script>

