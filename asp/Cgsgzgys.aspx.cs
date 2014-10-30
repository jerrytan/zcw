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
    public string strScr;
    public string strScrQQ;
    //public string s_yh_id = "";                         //用户ID
    protected void Page_Load(object sender, EventArgs e)
    {
        string s_yh_id = Request["s_yh_id"];
        string sql_dwid = "select dw_id from 采购商关注的材料表 where yh_id='" + s_yh_id + "'";
        string dwid = objConn.DBLook(sql_dwid);
        string ppid = "";
        strScr = Request["scr"];
        strScrQQ= Request["scrQQ"];
        if (Request["ppid"]!=null&&Request["ppid"].ToString()!="")
        {
            ppid = Request["ppid"].ToString();
        }
        //Response.Write(strScr);
        //Response.Write(strScrQQ);
        string sSQL = "";
        if (string.IsNullOrEmpty(ppid))
        {
            sSQL = "select top 10 gys_id,供应商,主页,联系地址 from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where yh_id='"+s_yh_id+"')";
            dt_topfxs = objConn.GetDataTable(sSQL);
//            string sql = @"select top 10 gys_id,供应商,主页,联系地址 from 材料供应商信息表  
//            left join 分销商和品牌对应关系表 on 材料供应商信息表.gys_id=分销商和品牌对应关系表.fxs_id
//            where pp_id='320'";
//            dt_topfxs = objConn.GetDataTable(sql);
        }
        else
        {
            sSQL = "select gys_id,供应商,主页,联系地址 from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id='" + ppid + "')";
            dt_topfxs = objConn.GetDataTable(sSQL);
//            string sql = @"select gys_id,供应商,主页,联系地址 from 材料供应商信息表  
//            left join 分销商和品牌对应关系表 on 材料供应商信息表.gys_id=分销商和品牌对应关系表.fxs_id
//            where 品牌名称='" + strPpmc + "'";
//            dt_topfxs = objConn.GetDataTable(sql);
        }
        //Response.Write(sSQL);
    }
}