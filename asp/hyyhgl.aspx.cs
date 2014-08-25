using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public class UserGys
{
    public string QQ { get; set; }
    public string Name { get; set; }
    public string Phone { get; set; }
    public string Email { get; set; }
    public string Power { get; set; }
}
public partial class asp_hyyhgl : System.Web.UI.Page
{
    public List<UserGys> listGys { get; set; }
    protected DataTable dtGys = new DataTable();
    protected DataConn dc = new DataConn();


    protected void Page_Load(object sender, EventArgs e)
    {
        string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
        string sql_GetData = "select * from 用户表 where dw_id = (select dw_id from 用户表 where QQ_id='" + gys_QQ_id + "') and 等级='普通用户' order by updatetime desc";   

        dtGys = dc.GetDataTable(sql_GetData);

        this.listGys = new List<UserGys>();

        foreach (DataRow dr in dtGys.Rows)
        {
            UserGys ug = new UserGys();
            ug.QQ = dr["QQ号码"].ToString();
            ug.Name = dr["姓名"].ToString();
            ug.Phone = dr["手机"].ToString();
            ug.Email = dr["邮箱"].ToString();
            ug.Power = dr["角色权限"].ToString();
            listGys.Add(ug);
        }


    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string sqlDelete = "";
         //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "描述性词语", "getS();", true);
        string strSelected = this.txt_Selected.Value.ToString();
        if (string.IsNullOrEmpty(strSelected))
        {
            Response.Write("<script>window.alert('请选中要删除的行')</script>");
        }
        else
        {
            strSelected=strSelected.TrimEnd(',');
            string[] arrSelected = strSelected.Split(',');
            for (int i = 0; i < arrSelected.Length; i++)
            {
                sqlDelete += "delete from 用户表 where QQ号码 = '" + arrSelected[i] + "'; ";
            }

            if (dc.RunSqlTransaction(sqlDelete))
            {
                Response.Write("<script>window.alert('删除成功')</script>");
                Response.Write("<script>window.location.href=document.URL;</script>");  //刷新页面

            }
            else
            {
                Response.Write("<script>window.alert('删除失败')</script>");
            }
            
        }
    }


}