<%@ WebHandler Language="C#" Class="clxxsHandler" %>

using System;
using System.Web;
using System.IO;
public class clxxsHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string clid = context.Request["clid"];
        if(context.Request["action"]=="des")
        {
            context.Response.Write( File.ReadAllText(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//" + clid + ".html")));
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}