using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asp_hyyhgl_wh : System.Web.UI.Page
{
    int State = 0; //状态标识（0-添加，1-修改）
    protected void Page_Load(object sender, EventArgs e)
    {
        State = Convert.ToInt32(Request.QueryString["state"]);
        if (State == 1)
        {
            this.txt_QQ.Value = Request.QueryString["qq"];
            this.txt_name.Value = Request.QueryString["name"];
            this.txt_phone.Value = Request.QueryString["phone"];
            this.txt_Email.Value = Request.QueryString["email"];
        }
  
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (State == 0)
        {
            Add();
        }
        else
        {
            Update();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Write("<script>window.close();</script>");
    }

    /// <summary>
    /// 添加
    /// </summary>
    public void Add()
    {
        string power = "";
        if (this.cbx1.Checked == true)
        {
            power += this.cbx1.Value + ",";
        }
        if (this.cbx2.Checked == true)
        {
            power += this.cbx2.Value + ",";
        }
        if (this.cbx3.Checked == true)
        {
            power += this.cbx3.Value + ",";
        }
        power = power.TrimEnd(',');


        DataConn dc = new DataConn();

        //单位id
        //string sql_Get_dw_id = "select yh_id from 用户表 where QQ_id = '' ";

        string sql_Add = "insert into 用户表 (QQ号码,姓名,手机,等级,角色权限) values ('" + this.txt_QQ.Value + "'"
        + ",'" + this.txt_name.Value + "','" + this.txt_phone.Value + "','二级','" + power + "')";
        string sql_AddYh_id = "update 用户表 set yh_id=myID where QQ号码='" + this.txt_QQ.Value + "';";
        string sqlAll = sql_Add + sql_AddYh_id;

        if (dc.RunSqlTransaction(sqlAll))
        {
            Response.Write("添加成功");
        }
        else
        {
            Response.Write("添加失败");
        }
    }

    /// <summary>
    ///  编辑
    /// </summary>
    public void Update()
    {
        string power = "";
        if (this.cbx1.Checked == true)
        {
            power += this.cbx1.Value + ",";
        }
        if (this.cbx2.Checked == true)
        {
            power += this.cbx2.Value + ",";
        }
        if (this.cbx3.Checked == true)
        {
            power += this.cbx3.Value + ",";
        }
        power = power.TrimEnd(',');


        DataConn dc = new DataConn();

        //单位id
        //string sql_Get_dw_id = "select yh_id from 用户表 where QQ_id = '' ";


        string sql_Update = "update 用户表 set QQ号码='" + this.txt_QQ.Value + "',姓名='" + this.txt_name.Value + "',"
        + "手机='" + this.txt_phone.Value + "',角色权限='" + power + "' where yh_id = ''";

        if (dc.RunSqlTransaction(sql_Update))
        {
            Response.Write("修改成功");
        }
        else
        {
            Response.Write("修改失败");
        }
    }



}