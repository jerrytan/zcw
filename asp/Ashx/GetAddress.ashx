<%@ WebHandler Language="C#" Class="GetAddress" %>

using System;
using System.Web;
using System.Collections.Generic;

using System.Data;
public class GetAddress : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        RegionModel model = new RegionModel();
        string action = context.Request["action"].ToString();
        if (action == "pro")
        {
            string proSql = "select * from dbo.地区地域字典 where 省市地区简码 is not null";
            System.Data.DataTable dt = MySqlHelper.GetTable(proSql, null);
            List<RegionModel> list = DataTableToList(dt);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string listStr = jss.Serialize(list);
            context.Response.Write(listStr);
        }
        else if (action == "city")
        {
            string proId = context.Request["pro"].ToString();
            string citySql = "select * from dbo.地区地域字典 where 省市地区编号 like '" + proId + "%' and 省市地区简码 is null";
            DataTable dt = MySqlHelper.GetTable(citySql, null);
            List<RegionModel> list = DataTableToList(dt);
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            string listStr = jss.Serialize(list);
            context.Response.Write(listStr);
        }
    }
    /// <summary>
    /// 获得数据列表
    /// </summary>
    public List<RegionModel> DataTableToList(DataTable dt)
    {
        List<RegionModel> modelList = new List<RegionModel>();
        int rowsCount = dt.Rows.Count;
        if (rowsCount > 0)
        {
            RegionModel model;
            for (int n = 0; n < rowsCount; n++)
            {
                model = DataRowToModel(dt.Rows[n]);
                if (model != null)
                {
                    modelList.Add(model);
                }
            }
        }
        return modelList;
    }
    /// <summary>
    /// 得到一个对象实体
    /// </summary>
    public RegionModel DataRowToModel(DataRow row)
    {
        RegionModel model = new RegionModel();
        if (row != null)
        {
            if (row["myID"] != null && row["myID"].ToString() != "")
            {
                model.myID = int.Parse(row["myID"].ToString());
            }
            if (row["省市地区编号"] != null)
            {
                model.省市地区编号 = row["省市地区编号"].ToString();
            }
            if (row["省市地区名称"] != null)
            {
                model.省市地区名称 = row["省市地区名称"].ToString();
            }
            if (row["省市地区简码"] != null)
            {
                model.省市地区简码 = row["省市地区简码"].ToString();
            }
            if (row["所属区域编号"] != null)
            {
                model.所属区域编号 = row["所属区域编号"].ToString();
            }
            if (row["所属区域名称"] != null)
            {
                model.所属区域名称 = row["所属区域名称"].ToString();
            }
            if (row["备注"] != null)
            {
                model.备注 = row["备注"].ToString();
            }
            if (row["dq_id"] != null)
            {
                model.dq_id = row["dq_id"].ToString();
            }
            if (row["updatetime"] != null && row["updatetime"].ToString() != "")
            {
                model.updatetime = DateTime.Parse(row["updatetime"].ToString());
            }
        }
        return model;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}