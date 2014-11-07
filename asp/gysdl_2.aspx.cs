using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class asp_gysdl_2 : System.Web.UI.Page
{
    string QQ = "";
    //string gys_id = "";
    Object gys_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }
   
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataConn objcon = new DataConn();
        string SQL = "select dw_id, QQ号码 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        dt_yh = objcon.GetDataTable(SQL);
        QQ=dt_yh.Rows[0]["QQ号码"].ToString();
        gys_id = dt_yh.Rows[0]["dw_id"].ToString();
        Session["GYS_YH_ID"]= gys_id  ;//蒋，11月07号添加
        if (dt_yh!=null&&dt_yh.Rows.Count>0)
        {
            Response.Redirect("gyszym.aspx?QQ=" + this.username.Value + "&GYS_ID=" + gys_id);
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }
    }
}