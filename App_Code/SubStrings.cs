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
    
}