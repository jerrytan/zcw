using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///searchcl 的摘要说明
/// </summary>
public class searchcl
{
    private string Clid;
    public string clid
    {
        get { return Clid; }
        set { Clid = value; }
    }

    private string 显示名1;
    public string 显示名
    {
        get { return 显示名1; }
        set { 显示名1 = value; }
    }

    private string Ppid;

    public string ppid
    {
        get { return Ppid; }
        set { Ppid = value; }
    }

    private string 品牌名称1;
    public string 品牌名称
    {
        get { return 品牌名称1; }
        set { 品牌名称1 = value; }
    }

    private string 规格型号1;
    public string 规格型号
    {
        get { return 规格型号1; }
        set { 规格型号1 = value; }
    }

    private string 存放地址1;
    public string 存放地址
    {
        get { return 存放地址1; }
        set { 存放地址1 = value; }
    }
}