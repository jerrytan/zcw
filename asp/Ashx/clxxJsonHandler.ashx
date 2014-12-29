<%@ WebHandler Language="C#" Class="clxxHandler" %>

using System;
using System.Web;
using System.Data;
using System.IO;
using System.Text;
using System.IO;
public class clxxHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //Encoding encode = System.Text.Encoding.GetEncoding("gb2312");
        context.Response.ContentType = "text/plain;charset=UTF-8;";//application/json
        string clid = context.Request["clid"];
        if (context.Request["action"] == "dv")
        {
            string domSql = "select * from 材料多媒体信息表 where cl_id='" + clid + "' and 媒体类型='文档'";
            string videoSql = "select * from 材料多媒体信息表 where cl_id='" + clid + "' and 媒体类型='视频'";
            DataTable dtDom = MySqlHelper.GetTable(domSql);
            DataTable dtVideo = MySqlHelper.GetTable(videoSql);
            clxx clxx = new clxx();
            //详情
            //clxx.domDetails = SubStrings.UTF8ToGB2312(File.ReadAllText(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//" + clid + ".html")));
            //文档
            if (dtDom.Rows.Count > 0)
            {
                clxx.domFile = dtDom.Rows[0]["存放地址"] == null ? " " : dtDom.Rows[0]["存放地址"].ToString().Replace("//", "/");
                clxx.domName = dtDom.Rows[0]["标题"] == null ? " " : dtDom.Rows[0]["标题"].ToString();
                clxx.domTime = dtDom.Rows[0]["updatetime"] == null ? " " : dtDom.Rows[0]["updatetime"].ToString();
            }
            //视频
            if (dtVideo.Rows.Count > 0)
            {
                clxx.videoFile = dtVideo.Rows[0]["存放地址"] == null ? " " : dtVideo.Rows[0]["存放地址"].ToString().Replace("//", "/");
                clxx.videoName = dtVideo.Rows[0]["标题"] == null ? " " : dtVideo.Rows[0]["标题"].ToString() ;
                clxx.videoTime = dtVideo.Rows[0]["updatetime"] == null ? " " : dtVideo.Rows[0]["updatetime"].ToString();
            }

            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string strJson = jss.Serialize(clxx).ToString();
            context.Response.Write(strJson);
        }
        else if (context.Request["action"]=="getAll")
        {
            string domSql = "select * from 材料多媒体信息表 where cl_id='" + clid + "' and 媒体类型='文档'";
            string videoSql = "select * from 材料多媒体信息表 where cl_id='" + clid + "' and 媒体类型='视频'";
            DataTable dtDom = MySqlHelper.GetTable(domSql);
            DataTable dtVideo = MySqlHelper.GetTable(videoSql);
            clxx clxx = new clxx();
            //详情
            //clxx.domDetails = SubStrings.UTF8ToGB2312(File.ReadAllText(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//" + clid + ".html")));
            //文档
            if (dtDom.Rows.Count > 0)
            {
                clxx.domFile = dtDom.Rows[0]["存放地址"] == null ? " " : dtDom.Rows[0]["存放地址"].ToString().Split('/')[dtDom.Rows[0]["存放地址"].ToString().Split('/').Length - 1];
                clxx.domName = dtDom.Rows[0]["标题"] == null ? " " : dtDom.Rows[0]["标题"].ToString();
                clxx.domTime = dtDom.Rows[0]["updatetime"] == null ? " " : dtDom.Rows[0]["updatetime"].ToString();
            }
            //视频
            if (dtVideo.Rows.Count > 0)
            {
                clxx.videoFile = dtVideo.Rows[0]["存放地址"] == null ? " " : dtVideo.Rows[0]["存放地址"].ToString().Split('/')[dtVideo.Rows[0]["存放地址"].ToString().Split('/').Length-1];
                clxx.videoName = dtVideo.Rows[0]["标题"] == null ? " " : dtVideo.Rows[0]["标题"].ToString() ;
                clxx.videoTime = dtVideo.Rows[0]["updatetime"] == null ? " " : dtVideo.Rows[0]["updatetime"].ToString();
            }
            //详情
            //图片
            string[] imgFiles = Directory.GetFiles(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//img//"));
            StringBuilder imgsfile = new StringBuilder();
            if (imgFiles.Length > 0)
            {
                foreach (string item in imgFiles)
                {
                    imgsfile.Append(item.Substring(item.IndexOf("asp") +4).Replace("\\img\\","\\img\\icon\\") + ",");
                }
                clxx.imgFiles = imgsfile.ToString().Replace(@"\\",@"\\\\");
            }
            if (File.Exists(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//" + clid + ".html")))
            {
                clxx.domDetails = SubStrings.UTF8ToGB2312(File.ReadAllText(HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//" + clid + ".html"))); 
            }
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string strJson = jss.Serialize(clxx).ToString();
            context.Response.Write(strJson);
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