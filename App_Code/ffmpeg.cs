using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;

namespace CmdDemo
{
    public class  ffmpeg
    {
         /// <summary>
    /// 轉換為Flv文件
    /// </summary>
    private static  bool RunFlv(string fullName, string path,int FlvWidth,int FlvHeight)
    {   //ffmpeg -i F:\01.wmv -ab 56 -ar 22050 -b 500 -r 15 -s 寬x高 f:\test.flv
        if (System.IO.File.Exists(fullName))
        {
            string flvName = System.IO.Path.ChangeExtension(fullName, ".flv");
            if (!String.IsNullOrEmpty(path))
            {
                string lastChar = path.Substring(path.Length - 1);
                if (lastChar == @"\" || lastChar == @"/") path = path.Substring(0, path.Length - 1);
                flvName = path + @"\" + GetFileName(flvName);
            }
            string args;
            if (FlvWidth!=0 && FlvHeight!=0)
            {
                // -ab 56 -ar 22050 -b 500 -r 15 -s
                args = String.Format("-i {0}  -y  -ab 64 -ar 22050   -s {1}*{2}  {3}", fullName, FlvWidth, FlvHeight, flvName); 
            }
            else
            {
                args = String.Format("-i {0}  -y  -ab 64 -ar 22050  {1} ", fullName, flvName); 
            }
            RunCmd(args);
        }
        return true;
    }
    /// <summary>
    /// 轉換為Jpg文件
    /// </summary>
    private void RunJpg(string fullName, string path, int ImageWidth, int ImageHeight)
    {   //ffmpeg -i F:\01.wmv -y -f image2 -t 0.001 -s  寬x高 f:\test.jpg;
        if (System.IO.File.Exists(fullName))
        {
            string jpgName = System.IO.Path.ChangeExtension(fullName, ".jpg");
            if (!String.IsNullOrEmpty(path))
            {
                string lastChar = path.Substring(path.Length - 1);
                if (lastChar == @"\" || lastChar == @"/") path = path.Substring(0, path.Length - 1);
                jpgName = path + @"\" + GetFileName(jpgName);
            }
            string args;
            if (ImageWidth!=0&&ImageHeight!=0)
            {
                args = String.Format("-i {0} -y -f image2 -t 0.001 -s {1}x{2} {3}", fullName, ImageWidth, ImageHeight, jpgName);
            }
            else
            {
                args = String.Format("-i {0} -y -f image2 -t 0.001  {1}", fullName,jpgName);
            }
            RunCmd(args);
        }
    }
    /// <summary>
    /// 從文件路徑中取得文件名
    /// </summary>
    private static string GetFileName(string fullName)
    {
        fullName = fullName.Replace(@"/", @"\");
        return fullName.Substring(fullName.LastIndexOf(@"\"));
    }
    /// <summary>
    /// 運行Dos命令
    /// </summary>
    private static bool RunCmd(string args)
    {
        string cmdFile = Path.GetFullPath(@"C:\ffmpeg\ffmpeg.exe");
        System.Diagnostics.ProcessStartInfo processInfo = new System.Diagnostics.ProcessStartInfo(cmdFile);

        processInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
        processInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
        processInfo.Arguments = args;
        processInfo.UseShellExecute = false;
        System.Diagnostics.Process.Start(processInfo);

        return true;
    }


    /// <summary>
    /// 轉換為Flv文件
    /// </summary>
    public static bool ToFlv(string fullName)
    {
        return RunFlv(HttpContext.Current.Server.MapPath(fullName), String.Empty, 0, 0);
    }
    /// <summary>
    /// 轉換為Flv文件到指定的目錄
    /// </summary>
    public static bool ToFlv(string fullName, string path)
    {
        return RunFlv(HttpContext.Current.Server.MapPath(fullName), HttpContext.Current.Server.MapPath(path), 400, 300);
    }
    /// <summary>
    /// 轉換為Jpg文件
    /// </summary>
    public void ToJpg(string fullName)
    {
        RunJpg(HttpContext.Current.Server.MapPath(fullName), String.Empty, 400, 300);
    }
    /// <summary>
    /// 轉換為Jpg文件到指定的目錄
    /// </summary>
    public void ToJpg(string fullName, string path)
    {
        RunJpg(fullName, path,400,300);
    }


    }
}
