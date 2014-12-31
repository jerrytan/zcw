<%@ WebHandler Language="C#" Class="AddclsxzHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
public class AddclsxzHandler : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string flbm = context.Request["flbm"];//分类编码
        string sxmc = context.Request["sxmc"];//属性名称
        string flsxz = context.Request["flsxz"];
        //string dwid=context.Session["dwid"].ToString();
        context.Response.Write(sxmc);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}