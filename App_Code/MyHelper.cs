using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Data;
using System.Collections;
using System.Reflection;
using System.ComponentModel;
/// <summary>
///MyHelper 的摘要说明
/// </summary>
public static class MyHelper
{
    public static string GetCrossDomainServer(string xmlPath)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(HttpContext.Current.Server.MapPath(xmlPath));
        XmlNodeList nodeList = xmlDoc.SelectSingleNode("cross-domain").ChildNodes;//获取cross-domain节点的所有子节点
        string re = string.Empty;
        foreach (var item in nodeList)
        {
            XmlElement xe = (XmlElement)item;//将子节点类型转换为XmlElement类型 
            if (xe.Name == "serverIp")
            {
                re = xe.Attributes["serverAddress"].Value;
                break;
            }
        }
        return re;
    }
    public static bool InsertCrossDomainServer(string ip, string xmlPath)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(HttpContext.Current.Server.MapPath(xmlPath));

        XmlNodeList nodeList = xmlDoc.SelectSingleNode("cross-domain").ChildNodes;//获取cross-domain节点的所有子节点

        foreach (XmlNode xn in nodeList)//遍历所有子节点 
        {
            XmlElement xe = (XmlElement)xn;//将子节点类型转换为XmlElement类型 
            if (xe.Name == "serverIp")
            {
                xe.SetAttribute("serverAddress", ip);//则修改该属性为“update张三”  
                break;
            }

        }
        xmlDoc.Save(HttpContext.Current.Server.MapPath(xmlPath));//保存。
        return true;
    }


    public static string GetCrossDomainClient(string xmlPath)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(HttpContext.Current.Server.MapPath(xmlPath));
        XmlNodeList nodeList = xmlDoc.SelectSingleNode("cross-domain").ChildNodes;//获取cross-domain节点的所有子节点
        string re = string.Empty;
        foreach (var item in nodeList)
        {
            XmlElement xe = (XmlElement)item;//将子节点类型转换为XmlElement类型 
            if (xe.Name == "clientIp")
            {
                re = xe.Attributes["clientAddress"].Value;
                break;
            }

        }
        return re;
    }
    public static bool InsertCrossDomainClient(string ip, string xmlPath)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(HttpContext.Current.Server.MapPath(xmlPath));

        XmlNodeList nodeList = xmlDoc.SelectSingleNode("cross-domain").ChildNodes;//获取cross-domain节点的所有子节点

        foreach (XmlNode xn in nodeList)//遍历所有子节点 
        {
            XmlElement xe = (XmlElement)xn;//将子节点类型转换为XmlElement类型 
            if (xe.Name == "clientIp")
            {
                xe.SetAttribute("clientAddress", ip);//则修改该属性为“update张三”   
                break;
            }
        }
        xmlDoc.Save(HttpContext.Current.Server.MapPath(xmlPath));//保存。
        return true;
    }


    //将IEnumerable<T>类型的集合转换为DataTable类型 
    public static DataTable LINQToDataTable<T>(IEnumerable<T> varlist)
    {   //定义要返回的DataTable对象
        DataTable dtReturn = new DataTable();
        // 保存列集合的属性信息数组
        PropertyInfo[] oProps = null;
        if (varlist == null) return dtReturn;//安全性检查
        //循环遍历集合，使用反射获取类型的属性信息
        foreach (T rec in varlist)
        {
            //使用反射获取T类型的属性信息，返回一个PropertyInfo类型的集合
            if (oProps == null)
            {
                oProps = ((Type)rec.GetType()).GetProperties();
                //循环PropertyInfo数组
                foreach (PropertyInfo pi in oProps)
                {
                    Type colType = pi.PropertyType;//得到属性的类型
                    //如果属性为泛型类型
                    if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition()
                    == typeof(Nullable<>)))
                    {   //获取泛型类型的参数
                        colType = colType.GetGenericArguments()[0];
                    }
                    //将类型的属性名称与属性类型作为DataTable的列数据
                    dtReturn.Columns.Add(new DataColumn(pi.Name, colType));
                }
            }
            //新建一个用于添加到DataTable中的DataRow对象
            DataRow dr = dtReturn.NewRow();
            //循环遍历属性集合
            foreach (PropertyInfo pi in oProps)
            {   //为DataRow中的指定列赋值
                dr[pi.Name] = pi.GetValue(rec, null) == null ?
                    DBNull.Value : pi.GetValue(rec, null);
            }
            //将具有结果值的DataRow添加到DataTable集合中
            dtReturn.Rows.Add(dr);
        }
        return dtReturn;//返回DataTable对象
    }

}