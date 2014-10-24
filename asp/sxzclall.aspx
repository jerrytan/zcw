<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Page Language="C#"%>

<script runat="server">
    public DataTable dt_sx = new DataTable();
    public DataTable dt_sxz = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        //获取属性 属性值 页面
        string flbm = "";
        if (Request["flbm"] != null && Request["flbm"].ToString() != "")
        {
            flbm = Request["flbm"].ToString();
        }
        if (flbm != "")
        {
            string sql_sx = "select 属性名称,属性编码 from 材料分类属性值表主表 where 分类编码=" + Request["flbm"].ToString();
            dt_sx = Conn(sql_sx);
        }
        if (dt_sx != null && dt_sx.Rows.Count > 0)
        {
            string html = "";
          
            foreach (DataRow drsx in dt_sx.Rows)
            {
                string sql_sx = "select 属性名称,属性值,属性编码,编号 from 材料分类属性值表  where 属性名称='" + drsx["属性名称"] + "' and 分类编码=" + flbm;
                dt_sxz = Conn(sql_sx);
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
                            "','" + bh + "','" + sxz + "')\">" + sxz + "&nbsp;&nbsp;</a>";
                    }
                }
                html += "</td>"
                    + " <td align='center' bgcolor='#FFFFFF'></td>"
                    + " <td style='display:none;'></td>"
                    + "</tr>";
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

