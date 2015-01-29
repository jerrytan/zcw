<%@ WebHandler Language="C#" Class="ResettingNavigation" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.IO;
public class ResettingNavigation : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string oneSql;
        oneSql = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=2";
        DataTable onedt = MySqlHelper.GetTable(oneSql);
        StringBuilder sbHtml = new StringBuilder();
        //开头begin
        sbHtml.Append("<div class='dlqqz2' style=' width:200px; float:left; height:100%'>");
        sbHtml.Append("<div id='menu_lb'>");
        //结尾end
        //内容begin
        //一级分类
        int numone = 0;
        foreach (DataRow one in onedt.Rows)
        {
            sbHtml.Append("<h1 onclick=\"javascript:ShowMenu(this," + numone + ")\" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='" + one["显示名字"] + "'>" + one["显示名字"] + "</p></a></h1>");
            //二级分类
            numone++;
            string twoSql = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=4 and SUBSTRING(分类编码,1,2)='" + one["分类编码"] + "'";
            DataTable twodt = MySqlHelper.GetTable(twoSql);
            sbHtml.Append("<span class='no'>");
            int numtwo = 0;
            foreach (DataRow two in twodt.Rows)
            {
                //三级分类
                string threeSql = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=6 and SUBSTRING(分类编码,1,4)='" + two["分类编码"] + "'";
                DataTable threedt = MySqlHelper.GetTable(threeSql);
                if (threedt.Rows.Count > 0)
                {
                    sbHtml.Append("<h2 onclick='javascript:ShowMenu(this," + numtwo + ")' class='h2'><a href='javascript:void(0)'>" + two["显示名字"] + "</a></h2>");
                    sbHtml.Append("<ul class='no'>");
                    foreach (DataRow three in threedt.Rows)
                    {
                        sbHtml.Append("<li><a href='javascript:void(0)' onclick=\"lbs(this,'" + three["分类编码"] + "','" + three["显示名字"] + "','')\">" + three["显示名字"] + "</a></li>");
                    }
                    sbHtml.Append("</ul>");
                }
                else
                {
                    sbHtml.Append("<h2><a href='javascript:void(0)' onclick=\"lbs(this,'" + two["分类编码"] + "','" + two["显示名字"] + "','t')\">" + two["显示名字"] + "</a></h2>");
                    sbHtml.Append("<ul class='no'></ul>");
                }
                numtwo++;
            }
            sbHtml.Append("</span>");
        }
        //内容end
        //结尾begin
        sbHtml.Append("</div></div>");
        //结尾end
        string str = sbHtml.ToString();
        string[] oldHtmls = File.ReadAllText(HttpContext.Current.Server.MapPath("../admin/CreateMaterialModel.aspx")).Split(new string[] { "**********" }, StringSplitOptions.RemoveEmptyEntries);
        string newHtml = oldHtmls[0] + str + oldHtmls[1];
        File.WriteAllText(HttpContext.Current.Server.MapPath("../asp/scsxzcl.aspx"), newHtml, Encoding.UTF8);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}