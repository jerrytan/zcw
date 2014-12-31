<%@ WebHandler Language="C#" Class="zcHandler" %>

using System;
using System.Web;

public class zcHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"];
        if (action == "gysgsmc")
        {
            string gsmc=context.Request["gsmc"];
            string sqlIsExistGs = "select * from 材料供应商信息表 where 供应商='" +gsmc + "' ";
            if (MySqlHelper.ExecuteNonQuery(sqlIsExistGs)>0)
            {
                context.Response.Write("0");
            }
            else
            {
                context.Response.Write("1");
            }
        }
        else if (action=="gysqq")
        {
            string gysqq=context.Request["gysqq"];
            string sqlIsExistQQ = "select * from 用户表 where QQ号码='" + gysqq + "' ";
            if (MySqlHelper.ExecuteNonQuery(sqlIsExistQQ)>0)
            {
                context.Response.Write("1");
            }
        }

        else if (action == "gystjhy")
        {
            string qq=context.Request["qq"];
            string sqlIsExistQQ = "select * from 用户表 where QQ号码='" + qq + "' "; //查询QQ是否存在
            if (MySqlHelper.ExecuteNonQuery(sqlIsExistQQ)!=0)
            {
                context.Response.Write("false");
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}