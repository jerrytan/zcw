using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using System.Drawing;
public partial class asp_gysdl_2 : System.Web.UI.Page
{
    string QQ = "";
    //string gys_id = "";
    Object gys_id = "";
    public string dj = "";
    protected void Page_Load(object sender, EventArgs e)
    {
    }  
    protected void Button1_Click(object sender, EventArgs e)
    {
       DataConn objcon = new DataConn();
        string SQL = "select dw_id,QQ号码,QQ_id,等级 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        dt_yh = objcon.GetDataTable(SQL);
        if (dt_yh != null && dt_yh.Rows.Count > 0)
        {
            dj = dt_yh.Rows[0]["等级"].ToString();
            QQ = dt_yh.Rows[0]["QQ号码"].ToString();
            gys_id = dt_yh.Rows[0]["dw_id"].ToString();
            Session["GYS_QQ_ID"] = dt_yh.Rows[0]["QQ_id"].ToString();
            Session["GYS_YH_ID"] = gys_id;//蒋，11月07号添加
            
            if (dj == "普通用户")
            {
                Response.Write("<script> window.open('gyszym.aspx?QQ=" + this.username.Value + "&GYS_ID="+gys_id+"');window.close();</" + "script>");
            }
            else
            {
                Response.Write("<script> window.open('hyyhgl.aspx?QQ=" + this.username.Value + "&dw_id="+gys_id+"');window.close();</" + "script>");
            }
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }
    }
}