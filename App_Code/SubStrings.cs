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
}