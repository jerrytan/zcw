<%@ WebHandler Language="C#" Class="UploadifyHandler" %>

using System;
using System.Web;
using System.IO;
public class UploadifyHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
        HttpFileCollection webUploader = context.Request.Files;//webuploader上传
        
        string uploadPath = HttpContext.Current.Server.MapPath(@context.Request["path"]) + "\\";
        //uploadify上传
        if (file != null)
        {
            if (!Directory.Exists(uploadPath))
            {
                Directory.CreateDirectory(uploadPath);
            }
            file.SaveAs(uploadPath + file.FileName);
            //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失
            context.Response.Write("1");
        }
        //webuploader上传
        else if (webUploader.Count > 0)
        {
            HttpPostedFile fileWeb = webUploader.Get(0);
            if (!Directory.Exists(uploadPath))
            {
                Directory.CreateDirectory(uploadPath);
            }
            fileWeb.SaveAs(uploadPath + fileWeb.FileName);
            //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失
            context.Response.Write("1");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}