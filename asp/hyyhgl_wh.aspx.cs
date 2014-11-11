using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asp_hyyhgl_wh : System.Web.UI.Page
{
    DataConn dc = new DataConn();
    int State = 0; //状态标识（0-添加，1-编辑）
    public string lx = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        State = Convert.ToInt32(Request.QueryString["state"]);
        lx = Request.QueryString["lx"];
        if (State == 1)
        {
            if (!IsPostBack)
            {
                if (lx == "生产商")
                {
                    this.txt_QQ.Value = Request.QueryString["qq"].Trim();
                    this.txt_name.Value = Request.QueryString["name"].Trim();
                    this.txt_phone.Value = Request.QueryString["phone"].Trim();
                    this.txt_Email.Value = Request.QueryString["email"].Trim();
                    this.cbx1.Checked = Convert.ToBoolean(Request.QueryString["scs"].Trim());
                    this.cbx2.Checked = Convert.ToBoolean(Request.QueryString["fxs"].Trim());
                    this.cbx3.Checked = Convert.ToBoolean(Request.QueryString["cl"].Trim());
                    this.txt_QQ.Disabled = true;
                }
                else
                {
                    this.txt_QQ.Value = Request.QueryString["qq"].Trim();
                    this.txt_name.Value = Request.QueryString["name"].Trim();
                    this.txt_phone.Value = Request.QueryString["phone"].Trim();
                    this.txt_Email.Value = Request.QueryString["email"].Trim();
                    this.Checkbox1.Checked = Convert.ToBoolean(Request.QueryString["fxs"].Trim());
                    this.Checkbox2.Checked = Convert.ToBoolean(Request.QueryString["cl"].Trim());
                    this.txt_QQ.Disabled = true;
                }
            }
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
        //string gys_QQ_id;
        //string cgs_QQ_id;
        string sql_Add;
        string power = "";
        if(lx=="生产商")
        {
            if (cbx1.Checked == false && cbx2.Checked == false && cbx3.Checked == false)
            {
                Response.Write("<script>alert('请选择角色权限')</script>");
                return;
            }
            else
            {
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
            }
        }
        else
        {
            if (Checkbox1.Checked == false && Checkbox2.Checked == false)
            {
                Response.Write("<script>alert('请选择角色权限')</script>");
                return;
            }
            else
            {
                if (this.Checkbox1.Checked == true)
                {
                    power += this.Checkbox1.Value + ",";
                }
                if (this.Checkbox2.Checked == true)
                {
                    power += this.Checkbox2.Value + ",";
                }
                power = power.TrimEnd(',');
            }
        }
            string sqlIsExistQQ = "select * from 用户表 where QQ号码='" + this.txt_QQ.Value + "' "; //查询QQ是否存在
            string dw_id = Request.QueryString["gys_dw_id"];
            if (Session["GYS_QQ_ID"] != null)//更换Request.Cookies["GYS_QQ_ID"]为Session["GYS_QQ_ID"]
            {
                sql_Add = "insert into 用户表 (QQ号码,姓名,手机,邮箱,等级,角色权限,dw_id,类型,注册时间,updatetime) values ('" + this.txt_QQ.Value + "'"
                + ",'" + this.txt_name.Value + "','" + this.txt_phone.Value + "','" + this.txt_Email.Value + "','普通用户','" + power + "',"
                + "'"+dw_id+"','"+lx+"',getdate(),getdate())";
            }
            else
            {
                sql_Add = "insert into 用户表 (QQ号码,姓名,手机,邮箱,等级,角色权限,dw_id,类型,注册时间,updatetime) values ('" + this.txt_QQ.Value + "'"
               + ",'" + this.txt_name.Value + "','" + this.txt_phone.Value + "','" + this.txt_Email.Value + "','普通用户','" + power + "',"
               + "'"+dw_id+"','"+lx+"',getdate(),getdate())";
            }

            string sql_AddYh_id = "update 用户表 set yh_id=myID where QQ号码='" + this.txt_QQ.Value + "';";
            string sqlAll = sql_Add + sql_AddYh_id;

            if (dc.GetRowCount(sqlIsExistQQ) > 0)
            {
                Response.Write("<script>window.alert('该QQ已注册');</script>");
                return;
            }
            if (dc.RunSqlTransaction(sqlAll))
            {
                Response.Write("<script>window.alert('添加成功');</script>");
                Response.Write("<script>window.opener.refresh();window.focus();window.opener=null;window.close();</script>");
            }
            else
            {
                Response.Write("添加失败");
            }
    }

    /// <summary>
    ///  编辑
    /// </summary>
    /// 
    public void Update()
    {
        string power = "";
        if (lx == "生产商")
        {
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
        }
        else
        {
            if (this.Checkbox1.Checked == true)
            {
                power += this.Checkbox1.Value + ",";
            }
            if (this.Checkbox2.Checked == true)
            {
                power += this.Checkbox2.Value + ",";
            }
            power = power.TrimEnd(',');
        }

     

        string sql_Update = "update 用户表 set 姓名='" + this.txt_name.Value + "',"
        + "手机='" + this.txt_phone.Value + "',邮箱 = '" + this.txt_Email.Value + "',角色权限='" + power + "' where QQ号码='" + this.txt_QQ.Value + "'";

        if (dc.RunSqlTransaction(sql_Update))
        {
            Response.Write("<script>window.alert('修改成功');</script>");
            Response.Write("<script>window.opener.refresh();window.focus();window.opener=null;window.close();</script>");
        }
        else
        {
            Response.Write("修改失败");
        }
    }
}