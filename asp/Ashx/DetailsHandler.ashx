<%@ WebHandler Language="C#" Class="DetailsHandler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using System.Net;
public class DetailsHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/x-www-form-urlencoded; charset=UTF-8"; //"text/plain";

        
        string xhData = context.Request.Params["filedata"].ToString();
        string clid = context.Request["clid"].ToString();
        string path = "..\\Upload\\Material\\" + clid + "\\";

        //当前页面地址


        string url = MyHelper.GetCrossDomainServer("../../App_Code/config.xml")+"/Ashx/DetailsHandler.ashx?clid=" + clid;   //发送到的页面的地址

        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);


        string byte64 = string.Empty;
        //读取一个文件
        //using (FileStream fs = new FileStream(Server.MapPath("程序更新说明书.doc"), System.IO.FileMode.Open, System.IO.FileAccess.Read))
        //{
        //    byte[] filecontent = new byte[fs.Length];
        //    fs.Read(filecontent, 0, filecontent.Length);
        //    //将图片转换成base64编码的流
        //    byte64= Convert.ToBase64String(filecontent);
        //}
        byte[] bt = Encoding.Default.GetBytes(xhData);
        byte64 = Convert.ToBase64String(bt);




        //读取base64编码流，发送
        byte[] requestBytes = System.Text.Encoding.Default.GetBytes(byte64);



        req.Method = "POST";

        req.ContentType = "application/x-www-form-urlencoded";

        req.ContentLength = requestBytes.Length;

        using (Stream requestStream = req.GetRequestStream())
        {
            requestStream.Write(requestBytes, 0, requestBytes.Length);
        }



        //接收返回参数，到string backstr
        string backstr = string.Empty;
        using (HttpWebResponse res = (HttpWebResponse)req.GetResponse())
        {

            using (StreamReader sr = new StreamReader(res.GetResponseStream(), System.Text.Encoding.Default))
            {
                backstr = sr.ReadToEnd();
            }
        }

        //输出参数

        context.Response.Write(backstr);
    }
    
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}