using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
/// <summary>
///PagingHelper 的摘要说明
/// </summary>
public class PagingHelper
{
    /// <summary>
    /// 分页Helper
    /// </summary>
    /// <param name="currentPage">当前页</param>
    /// <param name="pageSize">每页显示的条数</param>
    /// <param name="totalCount">总数据条数</param>
    /// <returns></returns>
    public static string ShowPageNavigate(int currentPage, int pageSize, int totalCount)
    {
        string redirectTo = "";
        pageSize = pageSize == 0 ? 3 : pageSize;
        int totalPages = Math.Max((totalCount + pageSize - 1) / pageSize, 1); //总页数
        StringBuilder output = new StringBuilder();
        if (totalPages > 1)
        {
            //if (currentPage != 1)
            {//处理首页连接
                output.AppendFormat("<a class='pageLink' href='{0}?pageIndex=1&pageSize={1}'>首页</a> ", redirectTo, pageSize);
            }
            if (currentPage > 1)
            {//处理上一页的连接
                output.AppendFormat("<a class='pageLink' href='{0}?pageIndex={1}&pageSize={2}'>上一页</a> ", redirectTo, currentPage - 1, pageSize);
            }
            else
            {
                // output.Append("<span class='pageLink'>上一页</span>");
            }

            output.Append(" ");
            int currint = 5;
            for (int i = 0; i <= 11; i++)
            {//一共最多显示10个页码，前面5个，后面5个
                if ((currentPage + i - currint) >= 1 && (currentPage + i - currint) <= totalPages)
                {
                    if (currint == i)
                    {//当前页处理
                        //output.Append(string.Format("[{0}]", currentPage));
                        output.AppendFormat("<a class='cpb' href='{0}?pageIndex={1}&pageSize={2}'>{3}</a> ", redirectTo, currentPage, pageSize, currentPage);
                    }
                    else
                    {//一般页处理
                        output.AppendFormat("<a class='pageLink' href='{0}?pageIndex={1}&pageSize={2}'>{3}</a> ", redirectTo, currentPage + i - currint, pageSize, currentPage + i - currint);
                    }
                }
                output.Append(" ");
            }
            if (currentPage < totalPages)
            {//处理下一页的链接
                output.AppendFormat("<a class='pageLink' href='{0}?pageIndex={1}&pageSize={2}'>下一页</a> ", redirectTo, currentPage + 1, pageSize);
            }
            else
            {
                //output.Append("<span class='pageLink'>下一页</span>");
            }
            output.Append(" ");
            if (currentPage != totalPages)
            {
                output.AppendFormat("<a class='pageLink' href='{0}?pageIndex={1}&pageSize={2}'>末页</a> ", redirectTo, totalPages, pageSize);
            }
            output.Append(" ");
        }
        output.AppendFormat("第{0}页 / 共{1}页", currentPage, totalPages);//这个统计加不加都行

        return output.ToString();
    }
}