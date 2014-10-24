<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Page Language="C#"%>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
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
        DataTable dt = Conn(sSQL);
        if (dt != null && dt.Rows.Count > 0)
        {
            string html = "";
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
            Response.Write(html);
        }
        else
        {
            Response.Write("");
        }
    }
    public DataTable Conn(string sql)
    {
        DataTable dt = new DataTable();
        SqlConnection _con = new SqlConnection("server=192.168.1.32; database=mywt_mis_ZhongCaiWang01;uid=mywtadmin; pwd=admin");
        using (SqlCommand _cmd = new SqlCommand(sql, _con))
        {
            _con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            sda.SelectCommand = _cmd;
            sda.Fill(dt);
            _con.Close();
        }
        return dt;
    }
    </script>