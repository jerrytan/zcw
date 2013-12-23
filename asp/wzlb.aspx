<!--
        文章列表页面
        文件名：wzlb.ascx
        传入参数：p     列表页数
                  id    文章类型
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Register Src="include/pages.ascx" TagName="pages1" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <style type="text/css">
        .p {
            font-size: 12px;
            color: Black;
            font-weight: bold;
            text-decoration: none;
        }

        .p1 {
            font-size: 15px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
    <title><%=Request["id"] %>列表</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
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



    <!-- 首页 文章列表开始-->


    <script runat="server">

        
        private const int Page_Size = 10; //每页的记录数量
        private int current_page=1;
	    int pageCount_page;
        protected DataTable dt = new DataTable();
	    //protected DataTable dt1 = new DataTable();
        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }      
       
        }
       	public List<OptionItem> Items { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {            

           //从查询字符串中获取"页号"参数
            string strP = Request.QueryString["p"];
            if (string.IsNullOrEmpty(strP))
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
            if (string.IsNullOrEmpty(strC))
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
			String type = Request["id"];   //获取传过来的文档类型参数
            dt = this.GetProductFormDB(begin, end,type);
            this.SetNavLink(p, c);     
                  
        }
         

       
        protected string LinkPrev = "";
        protected string LinkNext = "";
        protected string LinkLast = "";       
        private void SetNavLink(int currentPage, int pageCount)
        {
          string path = Request.Path;
          var output = new StringBuilder();         
          if(currentPage>1)
           { 
             LinkPrev = currentPage != 1 ? string.Format("p={0}",currentPage - 1) : "";                          
           }
          if(currentPage<pageCount)
           {
            LinkNext = currentPage != pageCount ? string.Format("p={0}",
                currentPage + 1) : "";
           }
            LinkLast = currentPage != pageCount ? string.Format("p={0}",
                 pageCount) : "";  
  
           
           this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)
            {
               
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString =
                    i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("wzlb.aspx?p={0}",
               i);                
                this.Items.Add(item);
            }
      
        }

        private DataTable GetProductFormDB(int begin, int end ,string type)
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;         
            SqlCommand cmd = new SqlCommand("wz_Paging");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@begin", SqlDbType.Int).Value = begin;  //开始页第一条记录
            cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;      //开始页最后一条记录
			cmd.Parameters.Add("@文档类型", SqlDbType.VarChar,20).Value = type;      //传材料编码给材料表,执行存储过程

            SqlDataAdapter sda = new SqlDataAdapter(cmd);            
            using (SqlConnection conn = new SqlConnection(connString))
            {
                cmd.Connection = conn;
                conn.Open();
                sda.Fill(dt);
                conn.Close();
            }
            return dt;
        }

        //从数据库获取记录的总数量
        private int GetProductCount()
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            String type = Request["id"];   //获取传过来的文档类型参数
            string sql = "select count(wz_Id) from 文章表 where 文档类型='"+type+"' ";
            SqlCommand cmd = new SqlCommand(sql);
            using (SqlConnection conn = new SqlConnection(connString))
            {
                cmd.Connection = conn;
                conn.Open();
                object obj = cmd.ExecuteScalar();
                conn.Close();
                int count = (int)obj;
                return count;
            }
        }
         
    </script>



    <div class="xw">
        <% string id=Request["id"];%>
        <div class="xw1"><a href="index.aspx" class="p1">首页></a>&nbsp&nbsp&nbsp<%=id%></div>
        <div class="xw2">
            <dl>



                <% foreach(System.Data.DataRow row in dt.Rows){%>
                <dd><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>">·<%=row["标题"].ToString() %></a></dd>
                <dt><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["发表时间"].ToString() %></a></dt>
                <% } %>
            </dl>

        </div>


        <!-- 首页 文章列表 结束-->


        <!-- 页码开始-->

        <div class="fy2">
            <div class="fy3">

                <% if(current_page!=1) { %>
                <a href="wzlb.aspx?<%=LinkPrev%>&id=<%=id%>" class="p">上一页</a>
                <% } %>
                <a href="wzlb.aspx?p=1&id=<%=id%>" class="p">1</a>
                <% if(pageCount_page>1) { %>
                <a href="wzlb.aspx?p=2&id=<%=id%>" class="p">2</a>
                <% } %>
                <% if(pageCount_page>2) { %>
                <a href="wzlb.aspx?p=3&id=<%=id%>" class="p">3···</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="wzlb.aspx?<%=LinkNext %>&id=<%=id%>" class="p">下一页</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="wzlb.aspx?<%=LinkLast %>&id=<%=id%>" class="p">尾页</a>
                <% } %>
直接到第  
    <select onchange="window.location=this.value" name="" class="p">
        <% foreach (var v in this.Items)
   { %>
        <option value="<%=v.Value %>&id=<%=id%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>
                页


            </div>
        </div>
    </div>

    <!-- 页码结束-->




    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->






    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->



</body>
</html>
