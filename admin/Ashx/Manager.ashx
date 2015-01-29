<%@ WebHandler Language="C#" Class="Manager" %>

using System;
using System.Web;

public class Manager : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"];
        string ss = context.Request["jsonrpc"];
        string ss1 = context.Request["method"];
        string ss2 = context.Request["params"];
        string ss3 = context.Request["id"];
        if (action=="login")
        {
            context.Response.Write("1");
        }
        var b = new { user = "2", bb = "a" };
        System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        
        context.Response.Write(jss.Serialize(b));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}