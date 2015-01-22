<%@ WebHandler Language="C#" Class="AddFxsPrice" %>

using System;
using System.Web;

public class AddFxsPrice : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string clid = context.Request["clid"];
        string gysid = context.Request["gysid"];
        int fxsid = 0;
        if (context.Request["fxsid"] != null)
        {
            fxsid = Convert.ToInt32(context.Request["fxsid"]);
        }
        string gysPrice = string.Empty;
        if (context.Request["gysPrice"] != null)
        {
            gysPrice = context.Request["gysPrice"].ToString().Trim();
        }
        float fxsPrice=0;
        if (context.Request["newPrice"]!=null)
        {
            fxsPrice = float.Parse(context.Request["newPrice"]); 
        }

        if (clid != null && gysid != null )
        {
            string sqlFxs = "insert into PriceFxs(FxsPriceClid, GysId, FxsId, GysPrice, FxsPrice)values('" + clid + "','" + gysid + "','" + fxsid + "','"+(gysPrice==""?" ":gysPrice)+"','" + fxsPrice + "')";
            int num = MySqlHelper.ExecuteNonQuery(sqlFxs);
            if (num > 0)
            {
                string clSql = "update 供应商材料表 set price=" + fxsPrice + " where cl_id='" + clid + "' and gys_id='" + gysid + "' and fxs_id ='" + fxsid + "'";
                if (MySqlHelper.ExecuteNonQuery(clSql) > 0)
                {
                    context.Response.Write("0");
                }
                else
                {
                    context.Response.Write("1");
                }
            }
            else
            {
                context.Response.Write("1");
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}