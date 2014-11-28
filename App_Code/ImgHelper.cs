using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Web.UI;
using System.Drawing.Drawing2D;

/// <summary>
/// 改变图片像素和大小
/// </summary>
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

    }
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

/// <summary>
/// 图片压缩
/// </summary>
public class ImgThumbnail
{
    /// <summary>
    /// 指定缩放类型
    /// </summary>
    public enum ImgThumbnailType
    {
        /// <summary>
        /// 指定高宽缩放（可能变形）
        /// </summary>
        WH = 0,
        /// <summary>
        /// 指定宽，高按比例
        /// </summary>
        W = 1,
        /// <summary>
        /// 指定高，宽按比例
        /// </summary>
        H = 2,
        /// <summary>
        /// 指定高宽裁减（不变形）
        /// </summary>
        Cut = 3
    }
    #region Thumbnail
    /// <summary>
    /// 无损压缩图片
    /// </summary>
    /// <param name="sFile">原图片</param>
    /// <param name="dFile">压缩后保存位置</param>
    /// <param name="height">高度</param>
    /// <param name="width"></param>
    /// <param name="flag">压缩质量 1-100</param>
    /// <param name="type">压缩缩放类型</param>
    /// <returns></returns>
    public bool Thumbnail(string sFile, string dFile, int height, int width, int flag, ImgThumbnailType type)
    {
        System.Drawing.Image iSource = System.Drawing.Image.FromFile(sFile);
        ImageFormat tFormat = iSource.RawFormat;

        //缩放后的宽度和高度
        int towidth = width;
        int toheight = height;
        //
        int x = 0;
        int y = 0;
        int ow = iSource.Width;
        int oh = iSource.Height;

        switch (type)
        {
            case ImgThumbnailType.WH://指定高宽缩放（可能变形）           
                {
                    break;
                }
            case ImgThumbnailType.W://指定宽，高按比例     
                {
                    toheight = iSource.Height * width / iSource.Width;
                    break;
                }
            case ImgThumbnailType.H://指定高，宽按比例
                {
                    towidth = iSource.Width * height / iSource.Height;
                    break;
                }
            case ImgThumbnailType.Cut://指定高宽裁减（不变形）     
                {
                    if ((double)iSource.Width / (double)iSource.Height > (double)towidth / (double)toheight)
                    {
                        oh = iSource.Height;
                        ow = iSource.Height * towidth / toheight;
                        y = 0;
                        x = (iSource.Width - ow) / 2;
                    }
                    else
                    {
                        ow = iSource.Width;
                        oh = iSource.Width * height / towidth;
                        x = 0;
                        y = (iSource.Height - oh) / 2;
                    }
                    break;
                }
            default:
                break;
        }

        Bitmap ob = new Bitmap(towidth, toheight);
        Graphics g = Graphics.FromImage(ob);
        g.Clear(System.Drawing.Color.WhiteSmoke);
        g.CompositingQuality = CompositingQuality.HighQuality;
        g.SmoothingMode = SmoothingMode.HighQuality;
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
        g.DrawImage(iSource
          , new Rectangle(x, y, towidth, toheight)
          , new Rectangle(0, 0, iSource.Width, iSource.Height)
          , GraphicsUnit.Pixel);
        g.Dispose();
        //以下代码为保存图片时，设置压缩质量
        EncoderParameters ep = new EncoderParameters();
        long[] qy = new long[1];
        qy[0] = flag;//设置压缩的比例1-100
        EncoderParameter eParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, qy);
        ep.Param[0] = eParam;
        try
        {
            ImageCodecInfo[] arrayICI = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegICIinfo = null;
            for (int i = 0; i < arrayICI.Length; i++)
            {
                if (arrayICI[i].FormatDescription.Equals("JPEG"))
                {
                    jpegICIinfo = arrayICI[i];
                    break;
                }
            }
            if (jpegICIinfo != null)
            {
                ob.Save(dFile, jpegICIinfo, ep);//dFile是压缩后的新路径
            }
            else
            {
                ob.Save(dFile, tFormat);
            }
            return true;
        }
        catch
        {
            return false;
        }
        finally
        {
            iSource.Dispose();

            ob.Dispose();

        }
    }
    #endregion
}





