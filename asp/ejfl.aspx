<!--
        材料二级分类列表页面
        文件名：ejfl.ascx
        传入参数：name [分类编码]
        owner:丁传宇
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#ckAll").click(function () {
                var v = $(this).attr("checked");//获取"全选复选框"                
                $(":checkbox.ck").attr("checked", v);//设置class=ck的复选框是否被选中
            });
            $(":checkbox.ck").click(function () {
                var a = $(":checkbox.ck").size(); //获取所有的class=ck的复选框数量                
                var b = $(":checkbox.ck:checked").size();//获取所有的class=ck,并且被选中的 复选框数量
                var c = a == b;
                $("#ckAll").attr("checked", c);
            });
        });
    </script>
    <title>二级分类详细页面</title>
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

    <script runat="server">
         
        protected DataTable dt_yjflmc = new DataTable();   //一级分类名称
        protected DataTable dt_ejflmc = new DataTable();  //二级分类名称 
		protected DataTable dt_ejflpp = new DataTable();  //品牌(和二级分类相关的品牌) 材料分类表中fl_id 品牌字典中关系没有对应
		protected DataTable dt_ejflcl = new DataTable();  //二级分类名称下的材料(最具人气的石材)
		protected DataTable dt_clmcpage = new DataTable();  //材料名称分页 (对小类中的所有材料进行分页)
		protected DataTable dt_wz = new DataTable();  //如何挑选大理石相关文章(文章表)
        protected DataConn dc_obj = new DataConn();

		private const int Page_Size = 8; //每页的记录数量
		private int current_page=1;
	    int pageCount_page;
        private string name="";
        private int i_count=0;

      public class OptionItem
    {
        public string Text { get; set; }
        public string SelectedString { get; set; }
        public string Value { get; set; }
    }
       	public List<OptionItem> Items { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            name= Request["name"];
			string name1=name.ToString().Substring(0, 2); //取左边两位字符串
            string str_sqlclmc = "select 显示名字,分类编码 from 材料分类表 where  left(分类编码,2)='"+name1+"' and len(分类编码)='2' "; 
            dt_yjflmc = dc_obj.GetDataTable(str_sqlclmc);

			string str_sqlclmz = "select 显示名字 from 材料分类表 where 分类编码='"+name+"' ";
            dt_ejflmc = dc_obj.GetDataTable(str_sqlclmz);
			
			string str_sqlppmc = "select distinct 品牌名称 from 品牌字典 where  fl_id in(select fl_id from 材料分类表 where 分类编码='"+name+"') "; 
            dt_ejflpp = dc_obj.GetDataTable(str_sqlppmc);
           		
			
            string str_sqlcl = "select top 10 显示名,规格型号,分类编码,cl_id from 材料表 where 分类编码='"+name+"' order by 访问计数 ";
            dt_ejflcl = dc_obj.GetDataTable(str_sqlcl);
			
			string str_sqltop4 = "select top 4 标题,摘要,wz_id from 文章表 where left(分类编码,4)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_sqltop4);
			
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
			//string name1 = name.ToString().Substring(0, 4);    //将二级分类传过来的材料编码取前四位作为参数执行存储过程
            dt_clmcpage = this.GetProductFormDB(begin, end,name);
            this.SetNavLink(p, c,name);   
		} 
		      
        private void SetNavLink(int currentPage, int pageCount,string name)
        {
            this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)  //下拉列表循环总得页数
            {               
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("ejfl.aspx?p={0}&name={1}", i,name);                
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
            return dt_clmcpage = dc_obj.ExecuteProcForTable("ej_cl_Paging",spt); 
        }

        //从数据库获取记录的总数量
        private int GetProductCount()
        {
            try
            {
                string sql = "select * from 材料表 where left(材料编码,4)='"+name+"'";
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
        <!-- 链接导航栏 开始-->
        <div class="sc1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="yjfl.aspx?name=<%=row["分类编码"]%>"><%=row["显示名字"].ToString() %></a>
            <% } %>> 
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a href="#"><%=row["显示名字"].ToString() %></a>
            <% } %>
        </div>
        <!-- 链接导航栏 结束-->

        <!-- 标题和内容摘要 开始-->
        <div class="sc3">
            <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["摘要"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["标题"].ToString() %></a></div>
                <div class="rh2" style="overflow"><%=resume %></div>
            </div>
			<%}%>		   
        </div>
        <!-- 标题和内容摘要 结束-->

        <!-- 筛选 开始 -->
        <div class="xzss">
            <div class="ppxz">
                <div class="ppxz1">品牌：</div>
                <div class="ppxz2">
                    <a href="#"><img src="images/qwez.jpg" /></a>
                    <% foreach(System.Data.DataRow row in dt_ejflpp.Rows){%>
                    <a href="#"><%=row["品牌名称"].ToString() %></a>
                    <% } %>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">区域：</div>
                <div class="ppxz2"><a href="#">
                    <img alt="" src="images/qwez.jpg" /></a> <a href="#">朝阳区</a> <a href="#">海淀区</a> <a href="#">丰台区</a>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">材料：</div>
                <div class="ppxz2">
                    <a href="#"><img alt="" src="images/qwez.jpg" /></a>
                    <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>"><%=row["显示名"].ToString() %></a>
                    <%}%>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">更多：</div>
                <div class="ppxz2"> 
                    <a href="#">属性1</a> <a href="#">属性2</a> <a href="#">属性3</a>
                </div>
            </div>
            <!-- 材料排序筛选 开始-->
            <div class="dlspx">
                <span class="dlspx1">排序：</span>
                <span class="dlspx2"><a href="#">默认</a></span>
                <span class="dlspx3"><a href="#">人气<img src="images/qweqw_03.jpg" /></a></span>
                <span class="dlspx3"><a href="#">最新<img src="images/qweqw_03.jpg" /></a></span>
                <span class="dlspx3">
                    <input name="" type="checkbox" value="" id="ckAll" class="fx" /><a href="#">全选</a>
                </span>
                <span class="dlspx4"><a href="#">请收藏，便于查找</a></span>
            </div>
            <!-- 材料排序筛选 结束-->
        </div>
         <!-- 筛选 结束 -->

        <!-- 材料显示列表 开始-->
        <div class="dlspxl" style="background-color:Green">
            <% foreach(System.Data.DataRow row in dt_clmcpage.Rows){%>
            <div class="dlspxt" style="background-color:Orange">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
                    <%
                    string str_sqltop1 = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                        +row["cl_id"]+"' and 大小='小'";
                    string imgsrc= "images/222_03.jpg";
                   
                    object result = dc_obj.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
				    %>
                    
                    <div class="dlspxt1" style="overflow:hidden;background-color:Green">
                        <span class="dlsl" style="overflow:hidden;background-color:Yellow"><%=row["显示名"].ToString() %></span>
                        <span class="dlspx3" style="background-color:Blue">
                            <input name="" type="checkbox" value="" class="ck" />收藏
                        </span>
                        <span class="dlsgg" style="background-color:Red">规格：<%=row["规格型号"].ToString() %></span>
                    </div>
                 </a>
            </div>
            <% } %>
        </div>
        <!-- 材料显示列表 结束-->

        <!-- 最具人气的石材 开始 -->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString() %></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2"><a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
        </div>
        <!-- 最具人气的石材 结束-->
    </div>

    <!-- 分页 开始 -->
    <div class="fy2">
        <div class="fy3">
                 <% if(current_page<=1 && pageCount_page >1) {%> 
                    <font style="color:Gray">首页</font>
                    <a href="ejfl.aspx?p=<%=current_page+1 %>&name=<%=name %>" class="p" style="color:Black">下一页</a>
                    <a href="ejfl.aspx?p=<%=pageCount_page %>&name=<%=name %>" class="p" style="color:Black">末页</a>
                <%} %>
                <%else if(current_page <=1 && pageCount_page <=1 ){ %>

                <%} %>
                    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="ejfl.aspx?p=<%=1 %>&name=<%=name %>"class="p" style="color:Black">首页</a>
                    <a href="ejfl.aspx?p=<%=current_page-1 %>&name=<%=name %>" class="p" style="color:Black">上一页</a>
                    <a href="ejfl.aspx?p=<%=current_page+1 %>&name=<%=name %>" class="p" style="color:Black">下一页</a>
                     <a href="ejfl.aspx?p=<%=pageCount_page %>&name=<%=name %>" class="p" style="color:Black">末页</a>
                <%}%>
                <% else if( current_page !=1 && current_page == pageCount_page){ %>
                    <a href="ejfl.aspx?p=<%=1 %>&name=<%=name %>"class="p" style="color:Black">首页</a>
                    <a href="ejfl.aspx?p=<%=current_page-1 %>&name=<%=name %>" class="p" style="color:Black">上一页</a>
                    <font style="color:Gray">末页</font>
                <%} %>             
                  <font style="color:Black" >直接到第</font>  
                <select onchange="window.location=this.value" name="" class="p" style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >页&nbsp;&nbsp;&nbsp;第 <%=current_page %> 页/共 <%=pageCount_page %> 页</font>
        </div>
    </div>
    <!-- 分页 结束-->

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
