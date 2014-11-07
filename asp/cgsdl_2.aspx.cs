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
        string SQL = "select yh_id,等级, QQ号码 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        
        if (dt_yh.Rows.Count > 0)
        {
            dt_yh = objcon.GetDataTable(SQL);
            yh_id = dt_yh.Rows[0]["yh_id"].ToString();
            dj=dt_yh.Rows[0]["等级"].ToString();
            Session["CGS_YH_ID"] = yh_id;
            if (dj == "普通用户")
            {
                Server.Transfer("cgsgl_2.aspx");
            }
            else
            {
                Server.Transfer("hyyhgl.aspx");
            }
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }  
    }
}