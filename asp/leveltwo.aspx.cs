using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class asp_leveltwo : System.Web.UI.Page
{
    protected string flbm;
    protected string flmc;
    protected string leveloneflmc;
    protected string leveloneflbm;
    protected DataTable dt_ejflcl = new DataTable();  //二级分类名称下的材料(最具人气的石材)
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["flbm"] != null)
            {
                flbm = Request["flbm"].ToString();
                string str_sqlcl = "select top 10 显示名,规格型号,分类编码,cl_id from 材料表 where 分类编码='" + flbm + "' order by 访问计数 desc";
                dt_ejflcl = MySqlHelper.GetTable(str_sqlcl);
                flmc=Request["flmc"].ToString();
                DataTable dt = MySqlHelper.GetTable("select 分类编码,显示名字 from 材料分类表 where 分类编码='" + flbm.Substring(0, 2) + "'");
                leveloneflmc = dt.Rows[0]["显示名字"].ToString();
                leveloneflbm = dt.Rows[0]["分类编码"].ToString();
                
            }
        }
    }
    /// <summary>
    /// 获取分类属性值id的分类属性值
    /// </summary>
    /// <param name="flbm"></param>
    /// <returns></returns>
    protected string GetAttribute(string flbm)
    {
        StringBuilder sb = new StringBuilder();
        //=========================添加品牌
        string ppSql = "select distinct pp_id ,品牌名称 from 材料表 where 分类编码='"+flbm+"' ";
        DataTable dt = MySqlHelper.GetTable(ppSql);
        sb.Append("<div class='ppxz'><div class='ppxz1'  ppid=''> 品牌：</div><div class='ppxz2' ><a href='javascript:void(0)'  onclick='liveColor(this)' ppid='all' class='now' style='background-color:#0081CC;color:#FFFFFF;'>全部</a>");
        foreach (DataRow pp in dt.Rows)
        {
            sb.Append("<a href='javascript:void(0)' ppid='" + pp["pp_id"] + "'  onclick='liveColor(this)' >" + pp["品牌名称"] + "</a>");
        }
        sb.Append("</div></div>");
        //=========================添加规格型号
        string flsx = "select 显示,flsx_id from 材料分类属性表 where SUBSTRING(分类编码,1,4)='" + flbm + "' and 是否启用='1'";
        DataTable flsxdt = MySqlHelper.GetTable(flsx);
        foreach (DataRow item in flsxdt.Rows)
        {
            sb.Append(" <div class='ppxz'><div class='ppxz1'  flsxid='" + item["flsx_id"].ToString() + "'> " + item["显示"].ToString() + "：</div><div class='ppxz2' ><a href='javascript:void(0)'  onclick='liveColor(this)' flsxzid='all' class='now' style='background-color:#0081CC;color:#FFFFFF;'>全部</a>");
            string flsxzSql = "select 编号,属性值 from 材料分类属性值表 where  flsx_id='" + item["flsx_id"].ToString() + "'";
            DataTable flsxzdt = MySqlHelper.GetTable(flsxzSql);
            foreach (DataRow sxz in flsxzdt.Rows)
            {
                sb.Append("<a href='javascript:void(0)' flsxzid='" + sxz["编号"] + "'  onclick='liveColor(this)' >" + sxz["属性值"] + "</a>");
            }
            sb.Append("</div></div>");
        }
        return sb.ToString();
    }
    protected string GetList(string flbm)
    {
        string clxxSql = "select top 8 * from 材料表 where 分类编码='" + flbm + "' order by cl_id desc";
        DataTable clxxdt = MySqlHelper.GetTable(clxxSql);




        List<searchcl> list = new List<searchcl>();
        foreach (DataRow item in clxxdt.Rows)
        {
            searchcl scl = new searchcl();
            scl.clid = item["cl_id"].ToString();
            scl.显示名 = item["显示名"].ToString();
            scl.品牌名称 = item["品牌名称"].ToString();
            scl.规格型号 = item["规格型号"].ToString();
            scl.ppid = item["pp_id"].ToString();
            string dzSql = "select top 1 存放地址 from 材料多媒体信息表 where cl_id='" + scl.clid + "' and 媒体类型='图片'";
            var cfdz = MySqlHelper.ExecuteScalar(dzSql);
            scl.存放地址 = cfdz == null ? "" : cfdz.ToString();
            list.Add(scl);
        }


        StringBuilder sb = new StringBuilder();
        foreach (searchcl item in list)
        {
            sb.Append("<div class='dlspxt'><a href='clxx.aspx?cl_id=" + item.clid + "' target ='_blanck'><img class='dlspxtimg' width='150' height='150' src='" + MyHelper.GetCrossDomainServer("../App_Code/config.xml") + @"/" + item.存放地址 + "' /></a><div class='dlspxt1'><span class='dlsl'><a href='clxx.aspx?cl_id=" + item.clid + "' target ='_blanck'>" + item.显示名 + "</a></span> <span class='dlsgg'>" + SubStrings.GetWidth(12, "规格:" + item.规格型号, "规格:" + item.规格型号) + "</span> <span class='dlsgg'>品牌:<a href='ppxx.aspx?pp_id=" + item.ppid + "'>" + item.品牌名称 + "</a></span> <span class='dlsgg2'><img src='images/yanzheng_1.gif' width='16' height='16' /><img src='images/yanzheng_2.gif' width='16' height='16' /><img src='images/yanzheng_3.gif' alt='' width='16' height='16' /></span> </div> </div>");
        }
        return sb.ToString();
    }
    protected string GetPageNumber(string flbm)
    {
        int total = Convert.ToInt32(MySqlHelper.ExecuteScalar("select count(*) from 材料表 where 分类编码='" + flbm + "'"));
        return PagingHelper.ShowPageNavigate(1, 8, total);
    }
}