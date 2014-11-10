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
        string SQL = "select dw_id, QQ号码,等级 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        dt_yh = objcon.GetDataTable(SQL);

        if (dt_yh != null && dt_yh.Rows.Count > 0)
        {
            dj = dt_yh.Rows[0]["等级"].ToString();
            QQ = dt_yh.Rows[0]["QQ号码"].ToString();
            gys_id = dt_yh.Rows[0]["dw_id"].ToString();
            Session["GYS_YH_ID"] = gys_id;//蒋，11月07号添加
            if (dj == "普通用户")
            {
                //window.screen.height

                //Server.Transfer("gyszym.aspx?QQ=" + this.username.Value + "&GYS_ID=" + gys_id);
               // //?QQ='"+this.username.Value+"&GYS_ID="+gys_id+"
                Response.Write("<script type='text/javascript'>window.open ('gyszym.aspx?QQ=" + this.username.Value + "&GYS_ID=" + gys_id + "','newwindow','height='+window.screen.height+',width='+window.screen.width+',top=0,left=0,alwaysRaised=no,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;</" + "script>");
              
            }
            else
            {
                //Response.Write("<script type='text/javascript'>window.open('hyzcsf.aspx');</" + "script>");
                //Server.Transfer("hyyhgl.aspx?QQ="+this.username.Value);
                //Response.Redirect("hyzcsf.aspx");
                Response.Write("<script type='text/javascript'>window.open ('hyyhgl.aspx?QQ=" + this.username.Value + "','newwindow','height='+window.screen.height+',width='+window.screen.width+',top=0,left=0,alwaysRaised=no,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;</" + "script>");
            }
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }
    }
}