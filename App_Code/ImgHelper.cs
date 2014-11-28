using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
public class ImgHelper
{
    /// <summary>
    /// 把一个图片压缩成小图
    /// </summary>
    /// <param name="fullPath">图片路径</param>
    /// <param name="width">压缩以后的图片宽度</param>
    /// <param name="height">压缩以后的图片高度</param>
    /// <returns></returns>
    public static bool ToSmile(string fullPath, int width, int height)
    {
        Image img = null;
        Image bmcpy = null;
        Graphics gh = null;


        string[] imgNames = fullPath.Split(new char[] { '.', '\\', '/' });
        string imgName = imgNames[imgNames.Length - 2];
        img = Image.FromFile(HttpContext.Current.Server.MapPath(fullPath));
        bmcpy = new Bitmap(width, height);
        gh = Graphics.FromImage(bmcpy);
        gh.DrawImage(img, new Rectangle(0, 0, width, height));
        string strImg = HttpContext.Current.Server.MapPath(fullPath.Substring(0, fullPath.LastIndexOf('/')));
        string ss = strImg + "\\icon\\" + imgName + "." + imgNames[imgNames.Length - 1];
        //string newPath = Directory.CreateDirectory(str+ "\\icon\\").FullName.ToString();
        bmcpy.Save(ss);
        return true;
            //if (imgNames[imgNames.Length - 1] == "jpg")
            //{
            //    bmcpy.Save(newPath + imgName + ".jpg", ImageFormat.Jpeg);
            //}
            //else if (imgNames[imgNames.Length - 1] == "png")
            //{
            //    bmcpy.Save(newPath + imgName + ".png" , ImageFormat.Png);
            //}
            //else if (imgNames[imgNames.Length - 1] == "gif")
            //{
            //    bmcpy.Save(newPath + imgName + ".gif" , ImageFormat.Gif);
            //}
            //else if (imgNames[imgNames.Length - 1] == "bmp")
            //{
            //    bmcpy.Save(newPath + imgName + ".bmp", ImageFormat.Bmp);
            //}
            gh.Dispose();
            bmcpy.Dispose();
            img.Dispose();
            return true;
        
    }
    /// <summary>
    /// 把文件夹下的图片都压缩成小图到当前文件夹下的icon文件夹下
    /// </summary>
    /// <param name="szdir">文件夹路径</param>
    /// <param name="width">压缩以后的图片宽度</param>
    /// <param name="height">压缩以后的图片高度</param>
    /// <returns></returns>
    public static bool resize_pic(string szdir, int width, int height)
    {
        int i = 0;
        Image img = null;
        Image bmcpy = null;
        Graphics gh = null;
        string szsavedir = Directory.CreateDirectory(szdir + "\\icon").FullName.ToString();
        string[] szfiles = Directory.GetFiles(szdir, "*.jpg");
        foreach (string szfile in szfiles)
        {
            string[] imgNames = szfile.Split(new char[] { '.', '\\' });
            string imgName = imgNames[imgNames.Length - 2];
            img = Image.FromFile(szfile);
            bmcpy = new Bitmap(width, height);
            gh = Graphics.FromImage(bmcpy);
            gh.DrawImage(img, new Rectangle(0, 0, width, height));
            bmcpy.Save(szsavedir + "\\" + imgName + ".jpg", ImageFormat.Jpeg);
            i++;

        }
        gh.Dispose();
        bmcpy.Dispose();
        img.Dispose();
        if (i > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    static void rebdqulity_pic(string szdir, long lqulity)
    {
        int i = 0;
        Bitmap myBitmap;
        ImageCodecInfo myImageCodecInfo;
        Encoder myEncoder;
        EncoderParameter myEncoderParameter;
        EncoderParameters myEncoderParameters;


        // Get an ImageCodecInfo object that represents the JPEG codec.
        myImageCodecInfo = GetEncoderInfo("image/jpeg");
        myEncoder = Encoder.Quality;
        myEncoderParameters = new EncoderParameters(1);

        myEncoderParameter = new EncoderParameter(myEncoder, lqulity);
        myEncoderParameters.Param[0] = myEncoderParameter;
        string szsavedir = Directory.CreateDirectory(szdir + "\\icon").FullName.ToString();
        string[] szfiles = Directory.GetFiles(szdir, "*.jpg");
        foreach (string szfile in szfiles)
        {
            myBitmap = new Bitmap(szfile);
            myBitmap.Save(szsavedir + @"\quli" + i.ToString() + ".jpg", myImageCodecInfo, myEncoderParameters);

            i++;

        }
    }
    private static ImageCodecInfo GetEncoderInfo(String mimeType)
    {
        int j;
        ImageCodecInfo[] encoders;
        encoders = ImageCodecInfo.GetImageEncoders();
        for (j = 0; j < encoders.Length; ++j)
        {
            if (encoders[j].MimeType == mimeType)
                return encoders[j];
        }
        return null;
    }
    public static void resize_pic(int width, int height)
    {
        int i = 0;
        Image img = null;
        Image bmcpy = null;
        Graphics gh = null;
        Directory.CreateDirectory("icon");

        string szcdir = Environment.CurrentDirectory;

        string[] szfiles = Directory.GetFiles(szcdir);
        foreach (string szfile in szfiles)
        {
            string sz_ex = Path.GetExtension(szfile);

            if (sz_ex == ".jpg" || sz_ex == ".bmp" || sz_ex == ".png" || sz_ex == ".gif")
            {
                img = Image.FromFile(szfile);
                bmcpy = new Bitmap(width, height);
                gh = Graphics.FromImage(bmcpy);
                gh.DrawImage(img, new Rectangle(0, 0, width, height));
                bmcpy.Save("icon\\" + i.ToString() + ".jpg", ImageFormat.Jpeg);
                i++;
            }
        }
        Console.WriteLine("{0} pictures have been resized", i);
    }

}