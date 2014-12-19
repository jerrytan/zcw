<%@ WebHandler Language="C#" Class="UploadifyHandler" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Data;
using System.Text;
public class UploadifyHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        string clid = context.Request["clid"].ToString();


        string clMsgSql = "select 材料编码,显示名 from 材料表 where cl_id='" + clid + "'";
        DataTable dt = MySqlHelper.GetTable(clMsgSql);
        string clbm = dt.Rows[0]["材料编码"].ToString();
        string cpmc = dt.Rows[0]["显示名"].ToString();


        //uploadify上传
        //+-----------------------------------上传图片开始------------------------------------------------------------------------------------------------------------------------------------------------------

        if (context.Request["action"] == "img")
        {
            string aa = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "/img");

            if (Directory.Exists(aa) == true)
            {
                if (Directory.GetFiles(aa).Length >= 5)
                {
                    //+遍历图片开始
                    string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\img\icon"));
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < files.Length; i++)
                    {
                        string filetemp = files[i].Substring(files[i].IndexOf("asp") + 4);
                        filetemp = filetemp.Replace(@"/", @"\\");
                        filetemp = filetemp.Replace(@"\", @"\\");
                        sb.Append(filetemp + ",");

                    }
                    //+遍历图片结束
                    context.Response.Write("img," + sb.ToString());//返回1上传过限
                }
                else
                {
                    HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                    string uploadPath = HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//img") + "\\";
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    file.SaveAs(uploadPath + file.FileName);//保存大图
                    string temp = ToSmallImg("..//Upload//Material//" + clid + "//img", file.FileName.ToString());//压缩图片
                    //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失

                    //插入数据库
                    string cfdz = "Upload//Material//" + clid + "//img//icon//" + file.FileName.ToString();
                    string inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','图片','" + cfdz + "',(select getdate())) ";
                    if (MySqlHelper.ExecuteNonQuery(inSql) >= 1)
                    {
                        //+遍历图片开始
                        string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\img\icon"));
                        StringBuilder sb = new StringBuilder();
                        for (int i = 0; i < files.Length; i++)
                        {
                            string filetemp = files[i].Substring(files[i].IndexOf("asp") + 4);
                            filetemp = filetemp.Replace(@"/", @"\\");
                            filetemp = filetemp.Replace(@"\", @"\\");
                            sb.Append(filetemp + ",");

                        }
                        //+遍历图片结束
                        context.Response.Write("0," + sb.ToString());
                    }
                    else
                    {
                        context.Response.Write("1");
                    }
                }
            }
            else
            {
                HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                string uploadPath = HttpContext.Current.Server.MapPath("..//Upload//Material//" + clid + "//img") + "\\";
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                file.SaveAs(uploadPath + file.FileName);//保存大图
                string temp = ToSmallImg("..//Upload//Material//" + clid + "//img", file.FileName.ToString());//压缩图片
                //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失
                //插入数据库
                string cfdz = "Upload//Material//" + clid + "//img//icon//" + file.FileName.ToString();
                string inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','图片','" + cfdz + "',(select getdate())) ";
                if (MySqlHelper.ExecuteNonQuery(inSql) >= 1)
                {
                    //+遍历图片开始
                    string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\img\icon"));
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < files.Length; i++)
                    {
                        string filetemp = files[i].Substring(files[i].IndexOf("asp") + 4);
                        filetemp = filetemp.Replace(@"/", @"\\");
                        filetemp = filetemp.Replace(@"\", @"\\");
                        sb.Append(filetemp + ",");

                    }
                    //+遍历图片结束
                    context.Response.Write("0," + sb.ToString());
                }
                else
                {
                    context.Response.Write("1");
                }
            }
        }
        //+-----------------------------------上传图片结束------------------------------------------------------------------------------------------------------------------------------------------------------
        //+-----------------------------------上传视频开始------------------------------------------------------------------------------------------------------------------------------------------------------
        else if (context.Request["action"] == "vdo")
        {
            string videoName = context.Request["name"];
            string videoMsg = context.Request["msg"] == null ? "" : context.Request["msg"];
            string aa = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\video");
            if (Directory.Exists(aa) == true)
            {
                if (Directory.GetFiles(aa).Length >= 1)
                {
                    context.Response.Write("video");//返回1上传过限
                }
                else
                {
                    HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                    string newName = getNameFiles() + Path.GetExtension(file.FileName);
                    string uploadPath = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\video") + "\\";
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    file.SaveAs(uploadPath + newName);//保存视频
                    //开始转换视频
                    if (CmdDemo.ffmpeg.ToFlv("..\\Upload\\Material\\" + clid + "\\video\\" + newName) == true)
                    {
                        //插入数据库
                        string cfdz = "..//..//Upload//Material//" + clid + "//video//" + Path.ChangeExtension(newName, ".flv");
                        //生成xml播放文件
                        CreateXML("..\\Upload\\Material\\" + clid + "\\video", Path.ChangeExtension(newName, "flv"));
                        string inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题,说明) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','视频','" + cfdz + "',(select getdate()),'" + videoName + "','" + videoMsg + "') ";
                        if (MySqlHelper.ExecuteNonQuery(inSql) >= 1)
                        {
                            context.Response.Write("0," + Path.ChangeExtension(newName, "flv"));
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
            else
            {
                HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                string newName = getNameFiles() + Path.GetExtension(file.FileName);
                string uploadPath = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\video") + "\\";
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                file.SaveAs(uploadPath + newName);//保存视频
                //开始转换视频
                //CmdDemo.ffmpeg ff = new CmdDemo.ffmpeg();
                //ff.ToFlv("..\\Upload\\Material\\" + clid + "\\video\\" + file.FileName);
                if (CmdDemo.ffmpeg.ToFlv("..\\Upload\\Material\\" + clid + "\\video\\" + newName) == true)
                {
                    //插入数据库
                    string cfdz = "..//..//Upload//Material//" + clid + "//video//" + Path.ChangeExtension(newName, "flv");
                    //生成xml播放文件
                    CreateXML("..\\Upload\\Material\\" + clid + "\\video", Path.ChangeExtension(newName, "flv"));
                    string inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题,说明) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','视频','" + cfdz + "',(select getdate()),'" + videoName + "','" + videoMsg + "') ";
                    if (MySqlHelper.ExecuteNonQuery(inSql) >= 1)
                    {
                        context.Response.Write("0," + Path.ChangeExtension(newName, "flv"));
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
        //+-----------------------------------上传视频结束------------------------------------------------------------------------------------------------------------------------------------------------------
        //+-----------------------------------上传文档开始------------------------------------------------------------------------------------------------------------------------------------------------------
        else if (context.Request["action"] == "dom")
        {
            string domName = context.Request["name"];
            string domMsg = context.Request["msg"] == null ? "" : context.Request["msg"];
            //context.Response.Write(domName+","+domMsg);
            string aa = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\dom");
            if (Directory.Exists(aa) == true)
            {
                if (Directory.GetFiles(aa).Length >= 1)
                {
                    context.Response.Write("dom");//返回1上传过限
                }
                else
                {
                    HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                    string newName = getNameFiles() + Path.GetExtension(file.FileName);
                    string uploadPath = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\dom") + "\\";
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    file.SaveAs(uploadPath + newName);//保存文档
                    string cfdz = "Upload//Material//" + clid + "//dom//" + newName;
                    ////++转换PDF开始
                    //if (Path.GetExtension(newName)==".doc"||Path.GetExtension(newName)==".docx")
                    //{
                    //    OfficeToPDF.WordToPDF(HttpContext.Current.Server.MapPath(cfdz), HttpContext.Current.Server.MapPath("Upload//Material//" + clid + "//dom//") + Path.ChangeExtension(newName, ".pdf"), Microsoft.Office.Interop.Word.WdExportFormat.wdExportFormatPDF);
                    //}
                    ////++转换PDF结束
                    //插入数据库
                    string inSql;
                    if (domMsg == "")
                    {
                        inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','文档','" + cfdz + "',(select getdate()),'" + domName + "') ";
                    }
                    else
                    {
                        inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题,说明) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','文档','" + cfdz + "',(select getdate()),'" + domName + "','" + domMsg + "') ";
                    }
                    //context.Response.Write(inSql);
                    int i = MySqlHelper.ExecuteNonQuery(inSql, null);
                    if (i >= 1)
                    {
                        context.Response.Write("0," + newName);
                    }
                    else
                    {
                        context.Response.Write("1");
                    }


                }
            }
            else
            {
                HttpPostedFile file = context.Request.Files["Filedata"];//uploadify上传
                string newName = getNameFiles() + Path.GetExtension(file.FileName);
                string uploadPath = HttpContext.Current.Server.MapPath("..\\Upload\\Material\\" + clid + "\\dom") + "\\";
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                file.SaveAs(uploadPath + newName);//保存视频

                //插入数据库
                string cfdz = "Upload//Material//" + clid + "//dom//" + newName;
                ////++转换PDF开始
                //if (Path.GetExtension(newName) == ".doc" || Path.GetExtension(newName) == ".docx")
                //{
                //    OfficeToPDF.WordToPDF(HttpContext.Current.Server.MapPath(cfdz), HttpContext.Current.Server.MapPath("Upload//Material//" + clid + "//dom//") + Path.ChangeExtension(newName, ".pdf"), Microsoft.Office.Interop.Word.WdExportFormat.wdExportFormatPDF);
                //}
                ////++转换PDF结束

                string inSql;

                if (domMsg == "")
                {
                    inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','文档','" + cfdz + "',(select getdate()),'" + domName + "') ";
                }
                else
                {
                    inSql = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,存放地址,updatetime,标题,说明) values('" + clid + "' ,'" + clbm + "','" + cpmc + "','是','文档','" + cfdz + "',(select getdate()),'" + domName + "','" + domMsg + "') ";
                }
                int i = MySqlHelper.ExecuteNonQuery(inSql, null);
                if (i >= 1)
                {
                    context.Response.Write("0," + newName);
                }
                else
                {
                    context.Response.Write("1");
                }
            }
        }
        //+-----------------------------------上传文档结束------------------------------------------------------------------------------------------------------------------------------------------------------
        //+--------------删除图片开始-------------------------------------------------
        else if (context.Request["action"] == "imgdel")
        {
            string file = context.Request["file"];
            file = file.Replace("url(", "");
            file = file.Replace(")", "");
            int a = file.IndexOf("asp");
            file = file.Substring(a + 4);
            file = file.Replace("\"", "");
            file = file.Replace(@"\", @"//");
            file = file.Replace(@"/", @"//");

            string delSql = "delete from 材料多媒体信息表 where 存放地址='" + file + "'";
            int secc = MySqlHelper.ExecuteNonQuery(delSql);
            if (secc >= 1)
            {
                File.Delete(HttpContext.Current.Server.MapPath("..\\" + file));
                file = file.Replace(@"icon//", "");
                File.Delete(HttpContext.Current.Server.MapPath("..\\" + file));
                //+遍历图片开始
                string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\img\icon"));
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < files.Length; i++)
                {
                    string filetemp = files[i].Substring(files[i].IndexOf("asp") + 4);
                    filetemp = filetemp.Replace(@"/", @"\\");
                    filetemp = filetemp.Replace(@"\", @"\\");
                    sb.Append(filetemp + ",");

                }
                //+遍历图片结束
                context.Response.Write("0," + sb.ToString());
            }
            else
            {
                context.Response.Write(delSql);
            }
        }
        //+--------------删除图片结束-------------------------------------------------
        //+--------------删除文档开始-------------------------------------------------
        else if (context.Request["action"] == "domdel")
        {
            string file = context.Request["url"];
            file = @"Upload//Material//" + clid + "//dom//" + file;

            string delSql = "delete from 材料多媒体信息表 where 存放地址='" + file + "'";
            int secc = MySqlHelper.ExecuteNonQuery(delSql);
            if (secc >= 1)
            {
                string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\dom"));
                for (int i = 0; i < files.Length; i++)
                {
                    File.Delete(files[i]);
                }
                context.Response.Write("0");
            }
            else
            {
                context.Response.Write(delSql);
            }
        }
        //+--------------删除文档结束-------------------------------------------------
        //+--------------删除视频开始-------------------------------------------------
        else if (context.Request["action"] == "videodel")
        {
            string file = context.Request["url"];
            file = @"..//..//Upload//Material//" + clid + "//video//" + file;

            string delSql = "delete from 材料多媒体信息表 where 存放地址='" + file + "'";
            int secc = MySqlHelper.ExecuteNonQuery(delSql);
            if (secc >= 1)
            {
                string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath(@"..\Upload\Material\" + clid + @"\video"));
                for (int i = 0; i < files.Length; i++)
                {
                    File.Delete(files[i]);
                }
                context.Response.Write("0");
            }
            else
            {
                context.Response.Write(delSql);
            }
        }

        //+--------------删除视频结束-------------------------------------------------
    }
    /// <summary>
    /// 获取文件名
    /// </summary>
    /// <returns></returns>
    string getNameFiles()
    {
        Random random = new Random(DateTime.Now.Millisecond);
        string filename = DateTime.Now.ToString("yyyyMMddhhmmss").ToString() + random.Next(10000);
        return filename;
    }
    /// <summary>
    /// 图片压缩
    /// </summary>
    /// <param name="path">大图路径</param>
    /// <param name="name">图片名称</param>
    /// <returns></returns>
    public static string ToSmallImg(string path, string name)
    {
        string ImgPath = HttpContext.Current.Server.MapPath(path);
        string MakePath = HttpContext.Current.Server.MapPath(path + "\\icon");

        if (!Directory.Exists(MakePath))
        {
            Directory.CreateDirectory(MakePath);
        }

        string newSourcePath = ImgPath;//源图存放目录
        string newNewDir = MakePath;   //新图存放目录

        string sourceFile = Path.Combine(ImgPath, name); //获取原图路径
        string newFile = string.Empty; //新图路径

        newFile = Path.Combine(newNewDir, name);
        ImgThumbnail iz = new ImgThumbnail();
        Action<ImgThumbnail.ImgThumbnailType> Thumbnail = (type =>
        {
            //压缩图片
            iz.Thumbnail(sourceFile, newFile, 150, 150, 60, type);
        });
        Thumbnail(ImgThumbnail.ImgThumbnailType.WH);
        return newFile;
    }
    /// <summary>
    /// 创建视频相关xml
    /// </summary>
    /// <param name="path"></param>
    /// <param name="name"></param>
    /// <returns></returns>
    public bool CreateXML(string path, string name)
    {
        StringBuilder xml = new StringBuilder();
        xml.Append("<?xml version='1.0' encoding='utf-8'?>\n");
        xml.Append("<vcaster>\n");
        xml.Append("<itm item_url='" + path + "\\" + name + "' item_title='" + name + "' />\n");
        xml.Append("</vcaster>");
        if (!Directory.Exists(HttpContext.Current.Server.MapPath(path) + "vcastr.xml"))
        {
            using (StreamWriter f = new StreamWriter(HttpContext.Current.Server.MapPath(path) + "\\vcastr.xml"))
            {
                f.Write(xml.ToString());
            }
        }
        return true;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}