<!--
           搜索页
           文件名为:ss.aspx
		   传入参数为: 搜索文本框中的值
           owner:lilifeng
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="Lucene.Net.Store" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Lucene.Net.Index" %>
<%@ Import Namespace="Lucene.Net.Search" %>
<%@ Import Namespace="Lucene.Net.Documents" %>
<%@ Import Namespace="Lucene.Net.Analysis" %>
<%@ Import Namespace="Lucene.Net.Analysis.PanGu" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Configuration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>搜索结果页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/SearchpageBar.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="js/Searchpage.js" type="text/javascript"></script>

    
</head>
<script runat="server">

          protected DataTable dt_clss = new DataTable();   //搜索的产品(材料表)   
          protected DataTable dt_cl_page = new DataTable();  //对搜索的材料进行分页
		  protected DataTable dt_clss_name = new DataTable();  //查询所有材料分类表中的显示名字,分类编码 
          protected DataConn dc_obj = new DataConn();//工具类  

          protected string pageHtml = string.Empty;//页码条
         List<SeachResult> list = new List<SeachResult>(); 
          protected string  typeList=string.Empty;//获取命中类的列表
          bool isEmpty=false;//是否搜索到材料

          protected void Page_Load(object sender, EventArgs e)
          {
		     string key_ss = Request["sou"];  //获取搜索文本框中的值            

             //与类进行匹配
             string sqlType="select  显示名字,分类编码 from 材料分类表";
             dt_clss_name =dc_obj.GetDataTable(sqlType);

			 foreach(System.Data.DataRow row in dt_clss_name.Rows)
			 {
			    //判断如果与材料分类表中的分类名称相匹配跳转到一级或二级页面
			    if(key_ss==Convert.ToString(row["显示名字"])&Convert.ToString(row["分类编码"]).Length ==2)
				{
				   Response.Redirect("yjfl.aspx?name="+row["分类编码"].ToString()+" ");
				   return;
				}
			    if(key_ss==Convert.ToString(row["显示名字"])&Convert.ToString(row["分类编码"]).Length ==4)
				{
				   Response.Redirect("ejfl.aspx?name="+row["分类编码"].ToString()+" ");
				   return;
				}
			 }
             			
             //最受欢迎的十大材料
            string sqlTop10="select top 10 显示名,规格型号,cl_id ,访问计数 from 材料表 order by 访问计数 desc";
            dt_clss =dc_obj.GetDataTable(sqlTop10);

          
           SearchContent();//搜索
           if(key_ss!=null&&key_ss!="")//命中分类列表
           {
               typeList=GetTypeList();  
           }
           
          }
            

         //搜索内容
       private  void SearchContent()
        {            
            //string indexPath= ConfigurationManager.AppSettings["path"].ToString();
            string indexPath = Server.MapPath("lucenedir\\");
			 if (!System.IO.Directory.Exists(indexPath))
            {
                System.IO.Directory.CreateDirectory(indexPath);
            }
            string keyWord =Request["sou"];         
            keyWord = keyWord.ToLower();                   
            string[] kw = PanGuCut(keyWord);
            FSDirectory directory = FSDirectory.Open(new DirectoryInfo(indexPath), new NoLockFactory());
            IndexReader reader = IndexReader.Open(directory, true);
            IndexSearcher searcher = new IndexSearcher(reader);    
        
            //跨字段搜索
            BooleanQuery query = new BooleanQuery();            
            foreach (string word in kw)
            {  
                Query query1 = new TermQuery(new Term("材料名称", word));
                Query query2 = new TermQuery(new Term("分类属性值", word));
                query.Add(query1, BooleanClause.Occur.SHOULD);
                query.Add(query2, BooleanClause.Occur.SHOULD);
            } 
            Sort sort = new Sort();//排序
            string sortM = "id";//默认按id排序
            if (!string.IsNullOrEmpty(Request["sort"]))
            {
                sortM =Request["sort"].ToString();
            }

            sort.SetSort(new SortField(sortM, SortField.STRING, false));    
            Filter filter = null;
            if (!string.IsNullOrEmpty(Request["type"]))//二次过滤
            { 
             filter = new QueryFilter(new TermQuery(new Term("分类编码", Request["type"].ToString())));
            }     
            ScoreDoc[] docs = searcher.Search(query, filter, 1000, sort).scoreDocs;  //查询获取的文档集 
                 
            int pageSize = 12;
            double count = docs.Length;//总记录数                                 
            int pageCount = Convert.ToInt32(Math.Ceiling(count / pageSize));//总页数
            int pageIndex;
            if (!int.TryParse(Request.QueryString["page"], out pageIndex))
            {
                pageIndex = 1;
            }
           
            pageHtml = CreatePageBar(pageIndex, pageCount, keyWord,sortM,Request["type"]);           
            int start = (pageIndex - 1) * pageSize + 1;
            int end = pageIndex * pageSize;           
            if (end > Convert.ToInt32(count))
            {
                end = Convert.ToInt32(count);
            }
                     
            for (int i = start; i <= end; i++)
            {
                SeachResult SR = new SeachResult();              
                int docId = docs[i-1].doc;
                Document doc = searcher.Doc(docId);
                SR.cl_id =doc.Get("cl_id");
                SR.材料名称 = doc.Get("材料名称");
                SR.材料编码 = doc.Get("材料编码");             
                list.Add(SR);
            }            
         
        }

         //获取命中类的列表
        private string  GetTypeList()
        {
            StringBuilder sb = new StringBuilder();
            string indexPath = Server.MapPath("lucenedir\\");
		     if (!System.IO.Directory.Exists(indexPath))
            {
                System.IO.Directory.CreateDirectory(indexPath);
            }
            string keyWord = Request["sou"];
            keyWord = keyWord.ToLower();
            string[] kw = PanGuCut(keyWord);
            FSDirectory directory = FSDirectory.Open(new DirectoryInfo(indexPath), new NoLockFactory());
            IndexReader reader = IndexReader.Open(directory, true);
            IndexSearcher searcher = new IndexSearcher(reader);           
            BooleanQuery query = new BooleanQuery();
            foreach (string word in kw)
            {               
                Query query1 = new TermQuery(new Term("材料名称", word));
                Query query2 = new TermQuery(new Term("分类属性值", word));
                query.Add(query1, BooleanClause.Occur.SHOULD);
                query.Add(query2, BooleanClause.Occur.SHOULD);

            }
            TopScoreDocCollector collector = TopScoreDocCollector.create(1000, true);
            searcher.Search(query, null, collector);           
            ScoreDoc[] docs = collector.TopDocs(0, collector.GetTotalHits()).scoreDocs;                        
            Dictionary<string, string> dic = new Dictionary<string, string>();
            for (int i = 0; i < docs.Length; i++)
            {               
                int docId = docs[i].doc;
                Document doc = searcher.Doc(docId);
                if (!dic.ContainsKey(doc.Get("分类编码")))
                {
                    dic.Add(doc.Get("分类编码"), doc.Get("分类名称"));
                }
            }           
              foreach (KeyValuePair<string, string> item in dic)
            {
                sb.Append(string.Format("<a  href='ss.aspx?&page=1&sou={0}&sort={1}&type={2}'>{3}</a>", keyWord,Request["sort"],item.Key,item.Value));
            }
          return sb.ToString();
        }


        //页码条
        public string CreatePageBar(int currentPageIndex, int currentPageCount, string keyWord,string sort,string type)
        {
            StringBuilder sb = new StringBuilder();
            if (currentPageIndex > 1)
            {

                sb.Append(string.Format("<a  href='ss.aspx?page={0}&sou={1}&sort={2}&type={3}'>&lt;上一页</a>", currentPageIndex - 1, keyWord,sort,type));
            }
            int startPage = currentPageIndex - 5;
            if (startPage < 1)
            {
                startPage = 1;
            }
            int endPage = startPage + 9;
            if (endPage > currentPageCount)
            {
                endPage = currentPageCount;
                startPage = endPage - 9 > 0 ? endPage - 9 : 1;
            }
            for (int i = startPage; i <= endPage; i++)
            {
                if (i == currentPageIndex)//如果是当前页不用加超链接
                {
                    sb.Append(string.Format("<a href='javascript:void(0)' class='on'>{0}</a>",i));
                }
                else
                {
                    sb.Append(string.Format("<a  href='ss.aspx?page={0}&sou={1}&sort={2}&type={3}'>{0}</a>", i, keyWord, sort, type));
                }
            }
            if (currentPageIndex < currentPageCount)
            {
                sb.Append(string.Format("<a  href='ss.aspx?page={0}&sou={1}&sort={2}&type={3}'>下一页&gt;</a>", currentPageIndex + 1, keyWord, sort, type));
            }
            sb.Append(string.Format("<span>共{0}页</span>",currentPageCount));
            return sb.ToString();
        }

      
                
       //对关键词进行分词       
        public  string[] PanGuCut(string kw)
        {
            List<string> list = new List<string>();
            Analyzer analyzer = new PanGuAnalyzer();
            TokenStream tokenStream = analyzer.TokenStream("", new StringReader(kw));
            Lucene.Net.Analysis.Token token = null;
            while ((token = tokenStream.Next()) != null)
            {
                list.Add(token.TermText());
            }
            return list.ToArray();
        } 

    //搜索结果
     public class SeachResult
    {
      public string cl_id{get;set;}
      public string 材料名称{get;set;}
      public string 材料编码{get;set;}
        
    }
</script>
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
    <div class="sc">
        <div class="xzss">
            <div class="ppxz">
                <div class="ppxz1">
                    分类：</div>
                <div class="ppxz2">
                     <%=typeList %>
                   </div>
            </div>            
            <div class="dlspx">
                <span class="dlspx1">排序：</span>
                <span class="dlspx2"><a href="ss.aspx?page=1&sou=<%=Request["sou"] %>&sort=id&type=<%=Request["type"] %>" >默认</a></span>
                 <span class="dlspx3"><a href="ss.aspx?page=1&sou=<%=Request["sou"] %>&sort=updatetime&type=<%=Request["type"]%>">最新</a><img src="images/qweqw_03.jpg" /></span> 
                 <span class="dlspx3"><input type="checkbox" value="" id="ckAll" class="fx" />全选</span>
                <span class="dlspx4"><a id="collect" style="cursor:pointer">请收藏，便于查找</a></span>
            </div>
        </div>    
        <div class="dlspxl">
        <%if(this.list.Count>0) {%>
            <%foreach(var item in this.list){
              String  mc = item.材料名称.ToString();
               if (mc.Length > 6) {
                    mc = mc.Substring(0,6)+"..";
               } 
            
            %>
            <div class="dlspxt">
                <a href="clxx.aspx?cl_id=<%=item.cl_id%>" title="<%=item.材料名称%>">
                    <%
					string str_sqltop1dz ="select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                        +item.cl_id+"' and 大小='小'";
                    string str_ppid = "select pp_id from 材料表 where cl_id="+item.cl_id.ToString();
                    object result_ppid = dc_obj.DBLook(str_ppid);
                    string ppid = "";
                    if (result_ppid != null)
                    {
                        ppid = result_ppid.ToString();
                    }
                    string imgsrc= "images/222_03.jpg";
                        object result = dc_obj.DBLook(str_sqltop1dz);
                        if (result != null) 
                        {
                            imgsrc = result.ToString();
                        }
                        Response.Write("<img src="+imgsrc+ " width=150px height=150px />") ;
                    %>
                </a>
                <div class="dlspxt1">
                    <span class="dlsl">
                        <%=mc%></span> 
                        <span class="dlspx3">
                          <%string parm="";
                            parm = item.材料编码.ToString() + "|" + ppid;
                             %>
                             <input name="item" type="checkbox" value="<%=parm%>" class="ck" />收藏</span>
                </div>
            </div>
            <%}%>
            <div class="fy2">
               <div class="fy3">
                     <div class="page_nav">
                     <%=pageHtml%>
                     </div>
               </div>
            </div>
        <% } %>
        <%else{isEmpty=true;}%>
        <%
           string style=isEmpty?"visibility:visible":"visibility:hidden";
        %>
        <div id="isEmpty" style="<%=style%>; font-family:宋体; font-size:22px; color:Red; text-align:center; padding-top:15%">
            对不起，没有找到您所查询的产品！
        </div>

        </div>
       
        <!-- 最受欢迎的这种材料-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1">
                    <ul>
                        <%foreach(System.Data.DataRow row in this.dt_clss.Rows){%>
                        <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
                            <%=row["显示名"].ToString()%></a></li>
                        <%}%>
                    </ul>
                </div>
            </div>
    <div class="pxright2">
        <a href="#">
            <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
    </div> </div>
    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div> 
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  
   <div id="type" style="display:none"><%=Request["type"] %></div>
   <div id="sort" style="display:none"><%=Request["sort"] %></div> 
   
</body>
</html>
