<!--
        材料一级分类列表页面
        文件名：yjfl.ascx
        传入参数：name
        owner:丁传宇
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections"%>

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
            font-size: 16px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
    <title>一级分类</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
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

    <!-- 首页 石材首页 开始-->
    <script runat="server">
        protected DataTable dt_ejflmc = new DataTable();   //二级分类名称
        protected DataTable dt_allcl = new DataTable();  //材料名称分页 (大类下的所有材料分页)
        protected DataTable dt_yjflmc = new DataTable();  //首页显示一级分类名字
        protected DataTable dt_zclmc = new DataTable();   //具体材料名称 最具人气的石材	
		protected DataTable dt_wz = new DataTable();  //如何挑选大理石打相关文章(文章表)
		protected DataConn dc_obj = new DataConn();	//工具操作类
        		
        private const int Page_Size = 8; //每页的记录数量
		private int current_page=1;
	    int pageCount_page;
        private int i_count=0;
        private string name="";
        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }
        }
       	public List<OptionItem> Items { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            name= Request["name"]; //获取首页传过来的一级分类编码(两位)

            string str_sqltop10 = "select top 10 显示名字,分类编码 from 材料分类表 where  left(分类编码,2)='"+name+"' and len(分类编码)='4' ";            
            dt_ejflmc = dc_obj.GetDataTable(str_sqltop10);

            string str_sqlflname = "select  显示名字,fl_id from 材料分类表 where  分类编码='"+name+"' ";                
            dt_yjflmc = dc_obj.GetDataTable(str_sqlflname);      
  
            string str_sqltop10name = "select  top 10 显示名,cl_id from 材料表 where left(材料编码,2)='"+name+"' order by 访问计数";              
            dt_zclmc = dc_obj.GetDataTable(str_sqltop10name); 
			
			string str_top4wz = "select top 4 标题,摘要,wz_id from 文章表 where left(分类编码,2)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_top4wz);
            
			
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
                double recordCount = this.GetProductCount(); //总条数
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
            dt_allcl = this.GetProductFormDB(begin, end,name);
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
                item.Value = string.Format("yjfl.aspx?p={0}&name={1}",i,name);                
                this.Items.Add(item);
            }
      
        }

        private DataTable GetProductFormDB(int begin, int end, string name)
        {
             SqlParameter [] spt = new SqlParameter[]
            {
                new SqlParameter("@begin",begin),
                new SqlParameter("@end",end),
                new SqlParameter("@材料编码",name)
            };
            return dt_allcl = dc_obj.ExecuteProcForTable("yj_cl_Paging",spt);
        }

        //从数据库获取记录的总数量
        private int GetProductCount()
        {
            try
            {
                string sql = "select * from 材料表 where left(材料编码,2)='"+name+"'";
                i_count = dc_obj.GetRowCount(sql);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        }
    </script>

    <div class="sc">
        <% string name=Request["name"];%>
        <div class="sc1">
            <a href="index.aspx" class="p1">首页 ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="#"><%=row["显示名字"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc2">
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a href="ejfl.aspx?name=<%=row["分类编码"] %>"><%=row["显示名字"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc3">
		    <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               string resume = row["摘要"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["标题"].ToString() %></a></div>
                <div class="rh2" style="overflow:hidden"><%=resume %></div>
            </div>
			<%}%>			
        </div>
       
        <div class="px0">
            <div class="px">排序：<a href="#">人气</a> <a id="zuixin" style=" cursor:pointer" onclick="doAjax()">最新</a></div>
        </div>
    
        <div class="pxleft">      
           <%--根据ajax请求 对已取出来的分页数据表dt1按updatetime列降序排列 
            Boolean b_isLatest=false;
            string s_isLatest=Request["isLatest"];
            if(!string.IsNullOrEmpty(s_isLatest))
            {
                Response.Write("ok");
                b_isLatest=Convert.ToBoolean(s_isLatest);
            }
            if(b_isLatest=true)
            {
                DataView dv=dt1.DefaultView;
                dv.Sort="updatetime DESC";
                dt1=dv.ToTable();
            }--%>

            <% foreach(System.Data.DataRow row in dt_allcl.Rows)
               {%>
                <div class="pxtu">
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
				    <%
					    string str_sqltop1dz = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                                                            +row["cl_id"]+"' and 大小='小'";
                        string imgsrc= "images/222_03.jpg";
                        object result = dc_obj.DBLook(str_sqltop1dz);
                        if (result != null) 
                        {
                            imgsrc = result.ToString();
                        }
                        Response.Write("<img src="+imgsrc+ " width=150px height=150px />") ;  
				    %>
                    </a>
                <span class="pxtu1" style="overflow:hidden"><%=row["显示名"].ToString()%></span>
                </div>
            <%}%>
         </div>

        <!-- 最具人气的石材 开始-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_zclmc.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString()%></a></li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <div class="pxright2">
                <a href="#">
                    <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" />
                </a>
            </div>
        </div>
         <!-- 最具人气的石材 结束-->
    </div>
   
    <!-- 首页 石材首页 结束-->

    <!-- 石材规格页码 开始-->
    <div >
        <div class="fy2">
            <div class="fy3" style=" width:500px;height:auto; padding-left:0% !important; padding-left:23%">
                <% if(current_page<=1 && pageCount_page >1) {%> 
                    <font style="color:Gray">首页</font>
                    <a href="yjfl.aspx?p=<%=current_page+1 %>&name=<%=name %>"  style="color:Black">下一页</a>
                    <a href="yjfl.aspx?p=<%=pageCount_page %>&name=<%=name %>"  style="color:Black">末页</a>
                <%} %>
                <%else if(current_page <=1 && pageCount_page <=1 ){ %>

                <%} %>
                    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="yjfl.aspx?p=<%=1 %>&name=<%=name %>" style="color:Black">首页</a>
                    <a href="yjfl.aspx?p=<%=current_page-1 %>&name=<%=name %>"  style="color:Black">上一页</a>
                    <a href="yjfl.aspx?p=<%=current_page+1 %>&name=<%=name %>"  style="color:Black">下一页</a>
                     <a href="yjfl.aspx?p=<%=pageCount_page %>&name=<%=name %>"  style="color:Black">末页</a>
                <%}%>
                <% else if( current_page !=1 && current_page == pageCount_page){ %>
                    <a href="yjfl.aspx?p=<%=1 %>&name=<%=name %>" style="color:Black">首页</a>
                    <a href="yjfl.aspx?p=<%=current_page-1 %>&name=<%=name %>"  style="color:Black">上一页</a>
                    <font style="color:Gray">末页</font>
                <%} %>             
                  <font style="color:Black" >直接到第</font>  
                <select onchange="window.location=this.value" name=""  style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >页&nbsp;&nbsp;&nbsp;第 <%=current_page %> 页/共 <%=pageCount_page %> 页</font>
            </div>
        </div>
    </div>
    <!-- 石材规格页码 结束-->

    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->

</body>
</html>
