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
        string sql_GetData = "select * from 用户表 where 等级 = '二级'";    //测试
        //string sql_GetData = "select * from 用户表 where dw_id = ''";  

        dtGys = dc.GetDataTable(sql_GetData);

        this.listGys = new List<UserGys>();

        foreach (DataRow dr in dtGys.Rows)
        {
            UserGys ug = new UserGys();
            ug.QQ = dr["QQ号码"].ToString();
            ug.Name = dr["姓名"].ToString();
            ug.Phone = dr["手机"].ToString();
            ug.Email = "";     //dr["邮箱"].ToString();
            ug.Power = dr["角色权限"].ToString();
            listGys.Add(ug);
        }


    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {
        
    }


}