using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_cgsdl_2 : System.Web.UI.Page
{
    public string yh_id = "";
    public string dj = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataConn objcon = new DataConn();
        string SQL = "select yh_id,QQ_id,等级, QQ号码 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        dt_yh = objcon.GetDataTable(SQL);
        if (dt_yh != null && dt_yh.Rows.Count > 0)
        {
            yh_id = dt_yh.Rows[0]["yh_id"].ToString();
            dj=dt_yh.Rows[0]["等级"].ToString();
            Session["CGS_QQ_ID"] = dt_yh.Rows[0]["QQ_id"].ToString();
            Session["CGS_YH_ID"] = yh_id;
            if (dj == "普通用户")
            {
                //Response.Write("<script>opener.opener.location.href='cgsgl_2.aspx';</" + "script>");
                Server.Transfer("cgsgl_2.aspx");
            }
            else
            {
                Server.Transfer("hyyhgl.aspx?QQ="+this.username.Value);
            }
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }  
    }
}