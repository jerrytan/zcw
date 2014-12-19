<%@ WebHandler Language="C#" Class="DetailsHandler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
public class DetailsHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/x-www-form-urlencoded; charset=UTF-8"; //"text/plain";

        //Upload\Material\100

        string xhData = context.Request.Params["filedata"].ToString();
        string clid = context.Request["clid"].ToString();
        string path = "..\\Upload\\Material\\" + clid + "\\";
        string html = clid + ".html";
        try
        {
            if (!Directory.Exists(HttpContext.Current.Server.MapPath(path)))
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath(path));
                using (StreamWriter f = new StreamWriter(HttpContext.Current.Server.MapPath(path) + html))
                {
                    f.Write(xhData.ToString());
                }
                context.Response.Write("1");
            }
            else
            {
                using (StreamWriter f = new StreamWriter(HttpContext.Current.Server.MapPath(path) + html))
                {
                    f.Write(xhData.ToString());
                }
                context.Response.Write("1");
            }
        }
        catch (Exception)
        {
            context.Response.Write("2");
            throw;
        }
    }
    public bool CreateXML(string path, string name)
    {
        StringBuilder xml = new StringBuilder();
        xml.Append("<?xml version='1.0' encoding='utf-8'?>\n");
        xml.Append("<vcaster>\n");
        xml.Append("<itm item_url='" + path + "\\" + name + "' item_title='" + name + "' />\n");
        xml.Append("</vcaster>");
        if (!Directory.Exists(HttpContext.Current.Server.MapPath(path) + "vcastr.xml"))
        {
            using (StreamWriter f = new StreamWriter(HttpContext.Current.Server.MapPath(path) + "\\vcastr.xml", false, Encoding.UTF8))
            {
                f.Write(xml.ToString());
            }
        }
        return true;
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}