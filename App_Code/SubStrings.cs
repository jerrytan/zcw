using System;
using System.Collections.Generic;
using System.Web;
using System.Text;

/// <summary>
///SubString 的摘要说明
/// </summary>
public class SubStrings
{
    /// <summary>
    /// 获取大图片路径
    /// </summary>
    /// <param name="path"></param>
    /// <returns></returns>
    public static string SubImgPath(string path)
    {
        string[] temp = path.Split('\\', '/', '.');

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < temp.Length; i++)
        {
            if (temp.Length != i && temp.Length - 3 != i && temp.Length - 1 != i && temp.Length - 2 != i)
            {
                sb.Append(temp[i]+"\\");
            }
            else if(temp.Length-1==i)
            {
                sb.Append("."+temp[i]);
            }
            else if (temp.Length-2==i)
            {
                sb.Append(temp[i]);
            }
        }
        return sb.ToString();
    }
    /// <summary>
    /// 把字符串截取成固定长度，多余的用...
    /// </summary>
    /// <param name="width">要截取的宽度（多少个汉子的宽度）</param>
    /// <param name="strs">要截取的字符串</param>
    /// <param name="strs">鼠标放到"..."中显示的全称（title属性）</param>
    /// <returns></returns>
    public static string GetWidth( int width, string strs,string title)
    {
        StringBuilder sb = new StringBuilder();
        int temp = 0;
        for (int i = 0; i < strs.Length; i++)
        {
            if ((int)strs[i] > 127 && temp < width*2)
            {
                sb.Append(strs[i]);
                temp = temp + 2;
            }
            else if ((int)strs[i] < 127 && temp < width*2)
            {
                sb.Append(strs[i]);
                temp = temp + 1;
            }
            else
            {
                sb.Append("<a href='javascript:;' onclick='return false;' style='font-weight:bold' title='"+title+"'>...</a>");
                break;
            }
        }
        return sb.ToString();
    }
    /// <summary>
    /// UTF8转换GB2312
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static string UTF8ToGB2312(string str)
    {
        try
        {
            Encoding utf8 = Encoding.UTF8;
            Encoding gb2312 = Encoding.GetEncoding("gb2312");//Encoding.Default ,936
            byte[] temp = utf8.GetBytes(str);
            byte[] temp1 = Encoding.Convert(utf8, gb2312, temp);
            string result = gb2312.GetString(temp1);
            return result;
        }
        catch
        {
            return null;
        }
    }

    /// <summary>
    /// GB2312转换UTF8
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static string GB2312ToUTF8(string str)
    {
        try
        {
            Encoding utf8 = Encoding.UTF8;
            Encoding gb2312 = Encoding.GetEncoding("GB2312");
            byte[] unicodeBytes = gb2312.GetBytes(str);
            byte[] asciiBytes = Encoding.Convert(gb2312, utf8, unicodeBytes);
            char[] asciiChars = new char[utf8.GetCharCount(asciiBytes, 0, asciiBytes.Length)];
            utf8.GetChars(asciiBytes, 0, asciiBytes.Length, asciiChars, 0);
            string result = new string(asciiChars);
            return result;
        }
        catch
        {
            return "";
        }
    }
    
}