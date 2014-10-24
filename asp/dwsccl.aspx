<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Page Language="C#"%>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        DataConn Conn = new DataConn();
        //获取收藏材料页面
        string flbm = "";
        if (Request["flbm"] != null && Request["flbm"].ToString() != "")
        {
            flbm = Request["flbm"].ToString();
        }
        string DW_id = "";
        if (Request["DWID"] != null && Request["DWID"].ToString() != "")
        {
            DW_id = Request["DWID"].ToString();
        }
        string sSQL = " select distinct d.材料编码,d.材料名称,d.规格型号,d.品牌名称,a.单位 from 材料分类表 as a ,(select distinct b.材料编码,b.材料名称,c.品牌名称,c.规格型号 from 采购商关注的材料表 as b ,材料表 as c where  b.cl_id=c.cl_id and b.材料编码=c.材料编码 and b.dw_id='" +
            DW_id + "') as  d where a.分类编码='" +
            flbm + "' and SUBSTRING(d.材料编码,1," + flbm.Length + ")='" + flbm + "' ";
        DataTable dt = Conn.GetDataTable(sSQL);
        if (dt != null && dt.Rows.Count > 0)
        {
            string html = "";
            html = "<table  width='740' border='0' align='left' cellpadding='0' cellspacing='1' bgcolor='#dddddd'  style=' table-layout：fixed ;word-wrap：break-word'>"
                + "    <thead>"
                + "      <tr>"
                + "        <th width='42' height='30' align='center' bgcolor='#E3ECFF'><strong>序 号</strong></th>"
                + "        <th width='125' height='24' align='center' bgcolor='#E3ECFF'><strong>材料编码</strong></th>"
                + "        <th width='150' align='center' bgcolor='#E3ECFF'><strong>材料名称</strong></th>"
                + "        <th width='100' align='center' bgcolor='#E3ECFF'><strong>规格\\型号</strong></th>"
                + "        <th width='55' align='center' bgcolor='#E3ECFF'><strong>单 位</strong></th>"
                + "        <th width='80' align='center' bgcolor='#E3ECFF'><strong>品 牌</strong></th>"
                + "        <th width='50' align='center' bgcolor='#E3ECFF'>选 项</th>"
                + "      </tr>"
                + "    </thead>    "
                + "    <tbody id='scclxq'>     ";
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                i++;
                html += "<tr>"
                      + " <td align='center' bgcolor='#FFFFFF'>" + i + "</td>"
                      + " <td height='24' align='center' bgcolor='#FFFFFF'>" + dr["材料编码"] + "</td>"
                      + " <td align='left' bgcolor='#FFFFFF'>" + dr["材料名称"] + "</td>"
                      + " <td bgcolor='#FFFFFF'>" + dr["规格型号"] + "</td>"
                      + " <td align='center' bgcolor='#FFFFFF'>" + dr["单位"] + "</td>"
                      + " <td align='center' bgcolor='#FFFFFF'>" + dr["品牌名称"] + "</td>"
                      + " <td align='center' bgcolor='#FFFFFF'><input type='checkbox' name='checkbox'  />"
                      + " <label for='checkbox11'></label></td>"
                      + " </tr>";
            }
            html += "    </tbody>"
                + "     <tfoot>"
                + "     <tr>"
                + "        <td  height='40' align='right' bgcolor='#FFFFFF' colspan='7' style='padding-right:20px;'>"
                + "            <input type='button' id='btnFilter2' value='确定' onClick='qd_Click()' style='height: 20px;"
                + "                width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;' />"
                + "         </td>"
                + "      </tr>"
                + "     </tfoot>"
                + "</table>";
            Response.Write(html);
        }
        else
        {
            Response.Write("");
        }
    }
    
    </script>