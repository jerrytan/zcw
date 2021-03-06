<!--
        文章列表页面
        文件名：wzlb.aspx
        传入参数：
                p    列表页数
                id    文章类型
        负责人:  任武
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<!DOCTYPE html PUBLIC "-//W3C//dtD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/dtD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title><%=Request["id"] %>列表</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script runat="server">        
        private DataConn dc_obj = new DataConn();
        private const int Page_Size = 5; //每页的记录数量
        private int current_page=1;//当前默认页为第一页
        int pageCount_page; //总页数
        protected DataTable dt_content = new DataTable();
        private int i_count=0;
        public List<OptionItem> Items { get; set; }//用于跳转页面

        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }      
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {            
            //从查询字符串中获取"页号"参数
            string strP = Request.QueryString["p"];
            if(string.IsNullOrEmpty(strP))//判断传过来的参数是否为空  
            {
                strP = "1";
            }
            
            int p;
            bool b1 = int.TryParse(strP, out p);
            if (b1 == false)
            {
                p = 1;
            }
            current_page = p;

            //从查询字符串中获取"总页数"参数
            string strC = Request.QueryString["c"];
            if(string.IsNullOrEmpty(strC))//首次从数据中获取总记录数
            {
                double recordCount = this.GetProductCount(); //134
                double d1 = recordCount / Page_Size; //13.4
                double d2 = Math.Ceiling(d1); //14.0
                int pageCount = (int)d2; //14
                strC = pageCount.ToString();
            }
            int c;
            bool b2 = int.TryParse(strC,out c);
            if (b2 == false)
            {
                c = 1;
            }
            pageCount_page = c;

            //计算/查询分页数据
            int begin = (p - 1) * Page_Size + 1;
            int end = p * Page_Size;
            string type = Request["id"];   //获取传过来的文档类型参数
            dt_content = this.GetProductFormDB(begin,end,type);
            this.SetNavLink(p, c);              
        }
        //设置导航链接 currentPage:当前页号 pageCount:总页数 
        private void SetNavLink(int currentPage, int pageCount)
        {  
            this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)
            {      
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("wzlb.aspx?p={0}",i);                
                this.Items.Add(item);
            }
      
        }
        //根据参数,获取数据库中分页存储过程的结果
        private DataTable GetProductFormDB(int begin, int end ,string type)
        {         
            SqlParameter [] spt = new SqlParameter[]
            {
                new SqlParameter("@begin",begin),
                new SqlParameter("@end",end),
                new SqlParameter("@文档类型",type)
            };
            return dt_content = dc_obj.ExecuteProcForTable("wz_Paging",spt);
        }

        //从数据库获取记录的总数量
        private int GetProductCount()
        {
            try
            {
                string str_type = Request["id"];   //获取传过来的文档类型参数
                string str_sql = "select wz_Id from 文章表 where 文档类型='"+str_type+"' order by 发表时间 ";
                i_count = dc_obj.GetRowCount(str_sql);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 
    </script>
</head>
<body>
    <!-- 头部开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部结束-->

    <!-- 导航开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 导航结束-->

    <!-- banner开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner 结束-->

    <div class="xw">
        <% string str_id=Request["id"];%>
        <div class="xw1"><a href="index.aspx" class="p1">首页</a>>&nbsp&nbsp&nbsp<%=str_id%></div>
        <!--首页 文章列表 开始-->
        <div class="xw2">
            <dl><% foreach(System.Data.DataRow row in dt_content.Rows){%>
                <dd style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>">·<%=row["标题"].ToString() %></a></dd>
                <%
                    string str_time = row["发表时间"].ToString();
                    string[] str_times = str_time.Split(' ');
                    string str_fbtime = str_times[0];
                 %>
                <dt style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=str_fbtime %></a></dt>
                <% } %>
            </dl>
        </div>
        <!-- 首页 文章列表 结束-->
        
        <!-- 页码开始-->
       <div style="text-align:center"> <!--加入div控制分页居中-->
       <div class="fy2">
            <div class="fy3">
                <% if(current_page<=1 && pageCount_page>1) {%> 
                    <font class="p" style="color:Gray">首页</font>
                    <a href="wzlb.aspx?p=<%=current_page+1 %>&id=<%=str_id %>" class="p" style="color:Black">下一页</a>
                    <a href="wzlb.aspx?p=<%=pageCount_page %>&id=<%=str_id %>" class="p" style="color:Black">末页</a>
                <%} %>
                <% else if(current_page<=1 && pageCount_page<=1) {%>
                
                <% }%>    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="wzlb.aspx?p=<%=1 %>&id=<%=str_id %>"class="p" style="color:Black">首页</a>
                    <a href="wzlb.aspx?p=<%=current_page-1 %>&id=<%=str_id %>" class="p" style="color:Black">上一页</a>
                    <a href="wzlb.aspx?p=<%=current_page+1 %>&id=<%=str_id %>" class="p" style="color:Black">下一页</a>
                     <a href="wzlb.aspx?p=<%=pageCount_page %>&id=<%=str_id %>" class="p" style="color:Black">末页</a>
                <%}%>
                <% else if(current_page == pageCount_page){ %>
                    <a href="wzlb.aspx?p=<%=1 %>&id=<%=str_id %>"class="p" style="color:Black">首页</a>
                    <a href="wzlb.aspx?p=<%=current_page-1 %>&id=<%=str_id %>" class="p" style="color:Black">上一页</a>
                    <font class="p" style="color:Gray">末页</font> 
                <%} %>
                <font style="color:Black" >直接到第</font>  
                <select onchange="window.location=this.value" name="" class="p" style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>&id=<%=str_id%>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >页&nbsp;&nbsp;&nbsp;第 <%=current_page %> 页/共 <%=pageCount_page %> 页</font>
            </div>
        </div>
        </div>
        <!-- 页码结束-->
    </div>

    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
