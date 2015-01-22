using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class asp_levelone : System.Web.UI.Page
{
    protected string flbm;
    protected string flmc;
    protected string pageNum;
    protected DataTable dtcl;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Request["flbm"] != null && Request["flmc"] != null)
            {
                flbm = Request["flbm"].ToString();
                flmc = Request["flmc"].ToString();
                getClList(flbm);
                pageNum=GetPageNumber(flbm);

                dtcl = MySqlHelper.GetTable("select top 10 显示名,规格型号,分类编码,cl_id from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "' order by 访问计数 desc");
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
    }
    /// <summary>
    /// 获取二级分类
    /// </summary>
    /// <param name="flbm"></param>
    /// <returns></returns>
    protected string Getlevetwo(string flbm)
    {
        string sql = "select distinct 分类编码,分类名称 from 材料分类属性值表 where SUBSTRING(分类编码,1,2)='"+flbm+"'";
        DataTable dt = MySqlHelper.GetTable(sql);
        StringBuilder sb = new StringBuilder();
        //int num = 0;
        //sb.Append("<dl class='lanmu-list'>");
        sb.Append("<div style='width:980px; height:auto; float:left; margin-top:10px;' >");
        foreach (DataRow item in dt.Rows)
        {
            //if (num < 5)
            //{
            //    sb.Append(getA(item, num));
            //    num++;
            //}
            //else
            //{
            //    num = 0;
            //    sb.Append(getA(item, num));
            //    num++;
            //}
            sb.Append("<a style='margin-right:20px; font-size:12px;margin:3px 13px 3px 0px;line-height:25px;  float:left'  href='leveltwo.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + item["分类名称"].ToString() + "&nbsp;&nbsp;|</a>");
        }
        //sb.Append("</dl>");
        sb.Append("</div>");
        return sb.ToString();// +"<a  class='listmore' style='display: none; margin-top:7px; ' href='javascript:;'>查看更多 ↓</a>";
    }
    /// <summary>
    /// 二级分类html
    /// </summary>
    /// <param name="item"></param>
    /// <param name="num"></param>
    /// <returns></returns>
    protected string getA(DataRow item, int num)
    {
        StringBuilder sb = new StringBuilder();
        if (num == 0)
        {
            sb.Append("<dd style='height:30px;'><a style='margin-top:5px;margin-bottom:5px;' href='leveltwo.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a> ");
        }
        else if (num == 4)
        {
            sb.Append("<a style='margin-top:5px;margin-bottom:5px;'  href='leveltwo.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a> </dd>");
        }
        else
        {
            sb.Append("<a style='margin-top:5px;margin-bottom:5px;'  href='leveltwo.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a>");
        }
        return sb.ToString();
    }
    /// <summary>
    /// 一级分类材料列表
    /// </summary>
    /// <param name="flbm"></param>
    /// <returns></returns>
    protected string getClList(string flbm)
    {
        string getSql = "select top 8 *  from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "' order by cl_id asc";
        DataTable cldt = MySqlHelper.GetTable(getSql);



        List<searchcl> list = new List<searchcl>();
        foreach (DataRow item in cldt.Rows)
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
            sb.Append("<div class='dlspxt'><a  href='clxx.aspx?cl_id=" + item.clid + "' target ='_blanck'><img class='dlspxtimg' width='150' height='150' src='" + MyHelper.GetCrossDomainServer("../App_Code/config.xml") + @"/" + item.存放地址 + "' /></a><div class='dlspxt1'><span class='dlsl'><a  href='clxx.aspx?cl_id=" + item.clid + "' target ='_blanck'>" + item.显示名 + "</a></span> <span class='dlsgg'>" + SubStrings.GetWidth(12, "规格:" + item.规格型号, "规格:" + item.规格型号) + "</span> <span class='dlsgg'>品牌:<a href='ppxx.aspx?pp_id=" + item.ppid + "'>" + item.品牌名称 + "</a></span> <span class='dlsgg2'><img src='images/yanzheng_1.gif' width='16' height='16' /><img src='images/yanzheng_2.gif' width='16' height='16' /><img src='images/yanzheng_3.gif' alt='' width='16' height='16' /></span> </div> </div>");
        }
        return sb.ToString();
    }
    protected string GetPageNumber(string flbm)
    {
        int total = Convert.ToInt32(MySqlHelper.ExecuteScalar("select count(*) from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "'"));
        return PagingHelper.ShowPageNavigate(1, 8, total);
    }
}


