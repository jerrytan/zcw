using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_Cgsgzgys : System.Web.UI.Page
{
    public DataTable dt_topfxs = new DataTable();        //材料Table加载前10条数据
    public DataConn objConn = new DataConn();           //DataHelper类
    public string sSQL = "";                            //Sql语句
    //public string s_yh_id = "";                         //用户ID
    protected void Page_Load(object sender, EventArgs e)
    {
        //string s_yh_id = Request["s_yh_id"];
        string strPpmc = Request["strPpmc"];

        //Response.Write(s_yh_id);
        //Response.Write(strPpmc);

        if (string.IsNullOrEmpty(strPpmc))
        {
            string sql = @"select top 10 供应商,主页,联系地址 from 材料供应商信息表  
            left join 分销商和品牌对应关系表 on 材料供应商信息表.gys_id=分销商和品牌对应关系表.fxs_id
            where pp_id='320'";
            dt_topfxs = objConn.GetDataTable(sql);
        }
        else
        {
            string sql = @"select 供应商,主页,联系地址 from 材料供应商信息表  
            left join 分销商和品牌对应关系表 on 材料供应商信息表.gys_id=分销商和品牌对应关系表.fxs_id
            where 品牌名称='"+strPpmc+"'";
            dt_topfxs = objConn.GetDataTable(sql);
        }

    }
}