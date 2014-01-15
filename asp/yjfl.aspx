<!--
        材料一级分类列表页面
        文件名：yjfl.ascx
        传入参数：name
               
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
        protected DataTable dt = new DataTable();   //二级分类名称
        protected DataTable dt1 = new DataTable();  //材料名称分页 (大类下的所有材料分页)
        protected DataTable dt2 = new DataTable();  //首页显示一级分类名字
        protected DataTable dt3 = new DataTable();   //具体材料名称 最具人气的石材	
		protected DataTable dt_wz = new DataTable();  //如何挑选大理石打相关文章(文章表)
        		
        private const int Page_Size = 20; //每页的记录数量
		private int current_page=1;
	    int pageCount_page;

        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }
        }
       	public List<OptionItem> Items { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
                       
            String name= Request["name"]; //获取首页传过来的一级分类编码(两位)
            SqlDataAdapter da = new SqlDataAdapter("select top 10 显示名字,分类编码 from 材料分类表 where  left(分类编码,2)='"+name+"' and len(分类编码)='4' ", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "材料分类表"); 
            dt = ds.Tables[0];

            SqlDataAdapter da2 = new SqlDataAdapter("select  显示名字,fl_id from 材料分类表 where  分类编码='"+name+"' ", conn);                
			DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料分类表"); 
            dt2 = ds2.Tables[0];      
  
            SqlDataAdapter da3 = new SqlDataAdapter("select distinct top 10 显示名,cl_id from 材料表 where left(材料编码,2)='"+name+"' ", conn);             
			DataSet ds3 = new DataSet();
            da3.Fill(ds3, "材料表"); 
            dt3 = ds3.Tables[0]; 
			
			SqlDataAdapter da_wz = new  SqlDataAdapter("select top 4 标题,摘要,wz_id from 文章表 where left(分类编码,2)='"+name+"' ",conn);
			DataSet ds_wz = new DataSet();
			da_wz.Fill(ds_wz,"文章表");
			dt_wz = ds_wz.Tables[0];
            
			

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
            dt1 = this.GetProductFormDB(begin, end,name);
            this.SetNavLink(p, c);   
            		
        }
      
        protected string cpPrev = "";
        protected string cpNext = "";
        protected string cpLast = "";       
        private void SetNavLink(int currentPage, int pageCount)
        {
            string path = Request.Path;         
            cpPrev = currentPage != 1 ? string.Format("p={0}", //连超链接上一页
                 currentPage - 1) : "";
            cpNext = currentPage != pageCount ? string.Format("p={0}", //连超链接下一页
                currentPage + 1) : "";
            cpLast = currentPage != pageCount ? string.Format("p={0}",  //连超链接尾页
                 pageCount) : "";     
           
            this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)  //下拉列表循环总得页数
            {
               
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("yjfl.aspx?p={0}", i);                
                this.Items.Add(item);
            }
      
        }

        private DataTable GetProductFormDB(int begin, int end, string name)
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;         
            SqlCommand cmd = new SqlCommand("yj_cl_Paging");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@begin", SqlDbType.Int).Value = begin;  //开始页第一条记录
            cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;      //开始页最后一条记录
			cmd.Parameters.Add("@材料编码", SqlDbType.VarChar,20).Value = name; //传材料编码给材料表,执行存储过程

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //DataTable dt1 = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                cmd.Connection = conn;
                conn.Open();
                sda.Fill(dt1);
                conn.Close();
            }
            return dt1;
        }

        //从数据库获取记录的总数量
        private int GetProductCount()
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            String name= Request["name"];
            string sql = "select count(cl_Id) from 材料表 where left(材料编码,2)='"+name+"'";
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


    <div class="sc">
        <% string name=Request["name"];%>
        <div class="sc1">
            <a href="index.aspx" class="p1">首页 ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt2.Rows){%>
            <a href="#"><%=row["显示名字"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc2">
            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="ejfl.aspx?name=<%=row["分类编码"] %>"><%=row["显示名字"].ToString() %></a>

            <% } %>
        </div>

        <div class="sc3">
		    <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["摘要"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["标题"].ToString() %></a></div>
                <div class="rh2"><%=resume %></div>
            </div>
			<%}%>			
           
        </div>

        <div class="px0">
            <div class="px">排序：  <a href="#">人气</a> <a href="#">最新</a></div>
        </div>


        <div class="pxleft">
		    
            <% foreach(System.Data.DataRow row in dt1.Rows)
               {%>
            <div class="pxtu">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
				
				<%
					string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection con = new SqlConnection(connString);
                    SqlCommand cmd = new SqlCommand("select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                        +row["cl_id"]+"' and 大小='小'", con);

                    String imgsrc= "images/222_03.jpg";
                    using (con)
                    {
                         con.Open();
                         Object result = cmd.ExecuteScalar();
                         if (result != null) {
                             imgsrc = result.ToString();
                         }
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
				</a>
                <span class="pxtu1"><%=row["显示名"].ToString()%></span>
               
            </div>
            <% } %>
        </div>


        <!-- 石材规格页码 结束-->

        <!-- 最具人气的石材 开始-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt3.Rows){%>
                        <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString()%></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2">
                <a href="#">
                    <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a>
            </div>
        </div>


    </div>
    <!-- 最具人气的石材 结束-->



    <!-- 首页 石材首页 结束-->
    <div>
        <div class="fy2">
            <div class="fy3">
                <% if(current_page!=1) { %>
                <a href="yjfl.aspx?<%=cpPrev %>&name=<%=name%>" class="p">上一页</a>
                <% } %>
                <a href="yjfl.aspx?p=1&name=<%=name%>" class="p">1</a>
                <% if(current_page>1) { %>
                <a href="yjfl.aspx?p=2&name=<%=name%>" class="p">2</a>
                <% } %>
                <% if(current_page>2) { %>
                <a href="yjfl.aspx?p=3&name=<%=name%>" class="p">3···</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="yjfl.aspx?<%=cpNext %>&name=<%=name%>" class="p">下一页</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="yjfl.aspx?<%=cpLast %>&name=<%=name%>" class="p">尾页</a>
                <% } %>


  
直接到第  
    <select onchange="window.location=this.value" name="" class="p">
        <% foreach (var v in this.Items)  { %>
        <option value="<%=v.Value %>&name=<%=name%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>
                页
            </div>
        </div>
    </div>
    <!-- 石材规格页码 开始-->


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
