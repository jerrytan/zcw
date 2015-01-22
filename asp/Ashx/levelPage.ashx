<%@ WebHandler Language="C#" Class="levelPage" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Collections.Generic;

public class levelPage : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = Encoding.UTF8;
        string action = context.Request["action"].ToString();
        if (action == "levelonefl")
        {
            string flbm = context.Request["flbm"].ToString();

            string sql = "select distinct 分类编码,分类名称 from 材料分类属性值表 where SUBSTRING(分类编码,1,2)='" + flbm + "'";
            DataTable dt = MySqlHelper.GetTable(sql);
            StringBuilder sb = new StringBuilder();
            int num = 0;
            sb.Append("<dl class='lanmu-list'>");
            foreach (DataRow item in dt.Rows)
            {
                if (num < 5)
                {
                    sb.Append(getA(item, num));
                    num++;
                }
                else
                {
                    num = 0;
                    sb.Append(getA(item, num));
                    num++;
                }

            }
            sb.Append("</dl>");
            context.Response.Write(sb.ToString() + "<a class='listmore' style='display: none; margin-top:7px; ' href='javascript:;'>查看更多 ↓</a>");


        }
        //获取材料信息
        else if (action == "getClxx")
        {
            string flbm = context.Request["flbm"].ToString();
            //获取当前页和每页多少条
            string orderby=context.Request.Params["orderby"]==""?"cl_id":context.Request.Params["orderby"].ToString();
            orderby=orderby == "js" ? "访问计数" : orderby;
            int pageIndex = context.Request["pageIndex"] == null ? 1 : int.Parse(context.Request["pageIndex"]);
            int pageSize = context.Request["pageSize"] == null ? 8 : int.Parse(context.Request["pageSize"]);
            //总条数
            int total = Convert.ToInt32(MySqlHelper.ExecuteScalar("select count(*) from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "'"));

            string pageHtml = PagingHelper.ShowPageNavigate(pageIndex, pageSize, total);

            string clSql = " select top " + pageSize + @" cl_id ,显示名,品牌名称,规格型号,pp_id from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "' and cl_id not in ( select top " + (pageIndex - 1) * pageSize + @" cl_id  from 材料表 where SUBSTRING(分类编码,1,2)='" + flbm + "' order by "+orderby+" desc )order by " + orderby + " desc";

            DataTable cldt = MySqlHelper.GetTable(clSql);
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
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string listJson = jss.Serialize(list);
            var jsons = new { NavStr = pageHtml, clList = list };
            var json = jss.Serialize(jsons);
            context.Response.Write(json);
        }
        //二级页面获取列表分页====================================================================
        else if (action == "leveltwogetList")
        {
            string flbm = context.Request["flbm"].ToString();
            bool bopp = flbm.Contains("*");
            //筛选内容
            var reallbm=context.Request["allbm"];
            string ppid = string.Empty;
            string[] allbm = { };
            if (reallbm!=null)
            {
                if (!reallbm.Contains("*"))
                {
                    allbm = reallbm.ToString().Trim('|').Split('|');
                }
                else
                {
                    ppid = reallbm.ToString().Split('*')[0];
                    if (reallbm.ToString().Split('*')[1]!="")
                    {
                        allbm = reallbm.ToString().Split('*')[1].Trim('|').Split('|'); 
                    }
                }
            }
            if (ppid!="")
            {
                ppid = "and pp_id="+ppid;
            }



            //获取当前页和每页多少条
            string orderby = context.Request["orderby"] == "" ? "cl_id" : context.Request["orderby"].ToString();
            orderby = orderby == "js" ? "访问计数" : orderby;
            int pageIndex = context.Request["pageIndex"] == null ? 1 : int.Parse(context.Request["pageIndex"]);
            int pageSize = context.Request["pageSize"] == null ? 8 : int.Parse(context.Request["pageSize"]);
            //总条数
            int total = Convert.ToInt32(MySqlHelper.ExecuteScalar("select count(*) from 材料表 where 分类编码='" + flbm + "'" + GetFilter(allbm) +ppid));

            string clSql = " select top " + pageSize + @" cl_id ,显示名,品牌名称,规格型号,pp_id from 材料表 where 分类编码='" + flbm + "' and  cl_id not in ( select top " + (pageIndex - 1) * pageSize + @" cl_id  from 材料表 where 分类编码='" + flbm + "' " + GetFilter(allbm) +ppid+ " order by "+orderby+" desc ) "+GetFilter(allbm)+ppid+" order by "+orderby+" desc";

            string pageHtml = PagingHelper.ShowPageNavigate(pageIndex, pageSize, total);
            DataTable cldt = MySqlHelper.GetTable(clSql);
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
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string listJson = jss.Serialize(list);
            var jsons = new { NavStr = pageHtml, clList = list };
            var json = jss.Serialize(jsons);
            context.Response.Write(json);
        }
    }
    /// <summary>
    /// 获取一级分类折叠html
    /// </summary>
    /// <param name="item"></param>
    /// <param name="num"></param>
    /// <returns></returns>
    protected string getA(DataRow item, int num)
    {
        StringBuilder sb = new StringBuilder();
        if (num == 0)
        {
            sb.Append("<dd style='height:30px;'><a style='margin-top:5px;margin-bottom:5px;' href='levetwol.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a> ");
        }
        else if (num == 4)
        {
            sb.Append("<a style='margin-top:5px;margin-bottom:5px;'  href='levetwol.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a> </dd>");
        }
        else
        {
            sb.Append("<a style='margin-top:5px;margin-bottom:5px;'  href='leveltwo.aspx?flbm=" + item["分类编码"].ToString() + "&flmc=" + item["分类名称"].ToString() + "'>" + SubStrings.GetWidth(5, item["分类名称"].ToString(), item["分类名称"].ToString()) + "</a>");
        }
        return sb.ToString();
    }
    protected string GetFilter(string[] allbm)
    {
        StringBuilder sb = new StringBuilder();
        if (allbm.Length > 0&&allbm[0]!=""&&allbm[0]!=null)
        {
            for (int i = 0; i < allbm.Length; i++)
            {
                sb.Append(" and 材料编码 like '%" + allbm[i] + "%' ");
            }
            return sb.ToString();
        }
        else
        {
            return "";
        }

    }
    /// <summary>
    /// 判断材料是否包含分类属性值
    /// </summary>
    /// <param name="allbm"></param>
    /// <param name="clbm"></param>
    /// <returns></returns>
    protected bool Filter(string[] allbm, string clbm)
    {
        List<bool> list = new List<bool>();
        bool flter = true;
        for (int i = 0; i < allbm.Length; i++)
        {
            list.Add(clbm.Contains(allbm[i]));
            flter = flter && clbm.Contains(allbm[i]);
        }

        return flter;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
