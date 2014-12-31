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
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
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
        		
        protected string currentPageIndex=string.Empty; //自定义隐藏域，用来存放当前页码
        protected string currentPageCount = string.Empty;      
        protected string btnVisitValue = "人气↑";
        protected string btnUpdateValue = "更新日期↑";

        protected void Page_Load(object sender, EventArgs e)
        {
            string name= Request["name"]; //获取首页传过来的一级分类编码(两位)

            string str_sqltop10 = "select top 10 显示名字,分类编码 from 材料分类表 where  left(分类编码,2)='"+name+"' and len(分类编码)='4' ";            
            dt_ejflmc = dc_obj.GetDataTable(str_sqltop10);

            string str_sqlflname = "select  显示名字,fl_id from 材料分类表 where  分类编码='"+name+"' ";                
            dt_yjflmc = dc_obj.GetDataTable(str_sqlflname);      
  
            string str_sqltop10name = "select  top 10 显示名,cl_id from 材料表 where left(材料编码,2)='"+name+"' order by 访问计数 desc";              
            dt_zclmc = dc_obj.GetDataTable(str_sqltop10name); 
			
			string str_top4wz = "select top 4 标题,摘要,wz_id from 文章表 where left(分类编码,2)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_top4wz);
            
			 if(!IsPostBack)
              {
                   dt_allcl=BindProductList(1);  
              }    
                 
            //上一页
            if(!string.IsNullOrEmpty(Request.Form["HtmBtnPrePage"]))
            {
                int pageIndex = Convert.ToInt32(Request.Form["HidPageIndex"]);
                dt_allcl=BindProductList(--pageIndex);
            }
            //下一页
            if (!string.IsNullOrEmpty(Request.Form["HtmBtnNextPage"]))
            {
                int pageIndex = Convert.ToInt32(Request.Form["HidPageIndex"]);
                dt_allcl=BindProductList(++pageIndex);            
            }
         
          //按人气排序
            if (!string.IsNullOrEmpty(Request.Form["btnVisitOderBy"]))
            {
                OrderByVisit(Request.Form["btnVisitOderBy"].ToString());
            }
            else
            {
                if (ViewState["orderBy"] != null)
                {
                    if (ViewState["orderBy"].ToString() == "访问计数 asc")
                    {
                        btnVisitValue = "人气↓";
                    }
                }
            }
            //按日期排序           
            if (!string.IsNullOrEmpty(Request.Form["btnUpdateOderBy"]))
            {
                OrderByUpdateTime(Request.Form["btnUpdateOderBy"].ToString());
            }
            else
            {
                if (ViewState["orderBy"] != null)
                {
                    if (ViewState["orderBy"].ToString() == "updatetime asc")
                    {
                        btnUpdateValue = "更新日期↓";
                    }
                }
            }
        }    

         //按照人气进行排序
        private void OrderByVisit(string value)
        {
            if (value == "人气↑")
            {
                btnVisitValue = "人气↓";
                ViewState["orderBy"] = "访问计数 asc";
            }
            else
            {
                btnVisitValue = "人气↑";
                ViewState["orderBy"] = "访问计数 desc";
            }
            dt_allcl=BindProductList(1);//显示排序后的第一页
        }


        //按照更新日期进行排序
         private void OrderByUpdateTime(string value)
        {
            if (value == "更新日期↑")
            {
                btnUpdateValue = "更新日期↓";
                ViewState["orderBy"] = "updatetime asc";
            }
            else
            {
                btnUpdateValue = "更新日期↑";
                ViewState["orderBy"] = "updatetime desc";
            }
           dt_allcl=BindProductList(1);//显示排序后的第一页
        }


        //得到分页信息
        protected  DataTable GetList(int pageIndex ,int pageSize,string name,string orderBy)
        {
        string sql=@"select 显示名,材料编码,cl_id,fl_id,规格型号  from (select ROW_NUMBER() over (order by {0}) as RowId ,*from 材料表 where left(材料编码,2)=@name)t
where t.RowId between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize ";
            sql=string.Format(sql,(orderBy!=""&&orderBy!=null)?orderBy:"myID");
             SqlParameter[] parms = { 
                                   new SqlParameter("@pageIndex",SqlDbType.Int),
                                   new SqlParameter("@pageSize",SqlDbType.Int),
                                   new SqlParameter("@name",SqlDbType.VarChar)
                                };
            parms[0].Value=pageIndex;
            parms[1].Value=pageSize;
            parms[2].Value=name;
           return dc_obj.GetDataTable(sql,parms);
        
        }


         //显示当前页的信息
         private DataTable BindProductList(int pageIndex)
        {           
            int pageCount;       
            string  categoryId=string.Empty;
            if (Request.QueryString["name"]!=null) //判读是否选择了分类
            {
                categoryId =Request.QueryString["name"];
            }           
            pageCount =GetPageCount(categoryId,12);//总页数
           
            if (pageIndex < 1)
            {
                pageIndex = 1;
            }
            if (pageIndex > pageCount)
            {
                pageIndex = pageCount;
            } 
           
            currentPageIndex = pageIndex.ToString();
            currentPageCount = pageCount.ToString();

            string orderBy = string.Empty;
            if(ViewState["orderBy"]!=null)
            {
                orderBy = ViewState["orderBy"].ToString();
            }
             return GetList(pageIndex,12,categoryId,orderBy);
            }
               
        //得到总页数
         private int GetPageCount(string name,int pageSize)
        {          
             string sql = "select count(cl_Id) from 材料表 where left(材料编码,2)='"+name+"'";
             string pageStr = dc_obj.DBLook(sql);
             int recordCount =Convert.ToInt32(pageStr);
             return Convert.ToInt32(Math.Ceiling(1.0 * recordCount / pageSize));
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
        <form id="Form1" runat="server">        
        <div class="px0">
            <div class="px">排序方式： <input type="submit" value="<%=btnVisitValue %>"  name="btnVisitOderBy"/> 
            |             <input  type="submit" value="<%=btnUpdateValue %>" name="btnUpdateOderBy" /></div>
        </div>
    
        <div class="pxleft">      
           

            <% foreach(System.Data.DataRow row in dt_allcl.Rows)
               {%>
                <div class="pxtu">
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
				    <%
					    string str_sqltop1dz = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                                                            +row["cl_id"]+"'"; //and 大小='小'";
                        string imgsrc= "images/222_03.jpg";
                        object result = dc_obj.DBLook(str_sqltop1dz);
                        if (result != null) 
                        {
                            imgsrc = result.ToString();
                        }
                        Response.Write(@"<img src='http://192.168.1.22/"+imgsrc+ "' width=150px height=150px />") ;  
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
               第<%=currentPageIndex%>页&nbsp;&nbsp;共<%=currentPageCount %>页
         <input type="hidden" name="HidPageIndex" value="<%=currentPageIndex %>" />        
         <input type="submit" name="HtmBtnPrePage" value="上一页" />
          <input type="submit" name="HtmBtnNextPage" value="下一页" />
            </div>
        </div>
    </div>
    <!-- 石材规格页码 结束-->
   </form>
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
