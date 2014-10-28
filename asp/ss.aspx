<!--
           ����ҳ
           �ļ���Ϊ:ss.aspx
		   �������Ϊ: �����ı����е�ֵ
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
    <title>�������ҳ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/SearchpageBar.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="js/Searchpage.js" type="text/javascript"></script>

    
</head>
<script runat="server">

          protected DataTable dt_clss = new DataTable();   //�����Ĳ�Ʒ(���ϱ�)   
          protected DataTable dt_cl_page = new DataTable();  //�������Ĳ��Ͻ��з�ҳ
		  protected DataTable dt_clss_name = new DataTable();  //��ѯ���в��Ϸ�����е���ʾ����,������� 
          protected DataConn dc_obj = new DataConn();//������  

          protected string pageHtml = string.Empty;//ҳ����
         List<SeachResult> list = new List<SeachResult>(); 
          protected string  typeList=string.Empty;//��ȡ��������б�
          bool isEmpty=false;//�Ƿ�����������

          protected void Page_Load(object sender, EventArgs e)
          {
		     string key_ss = Request["sou"];  //��ȡ�����ı����е�ֵ            

             //�������ƥ��
             string sqlType="select  ��ʾ����,������� from ���Ϸ����";
             dt_clss_name =dc_obj.GetDataTable(sqlType);

			 foreach(System.Data.DataRow row in dt_clss_name.Rows)
			 {
			    //�ж��������Ϸ�����еķ���������ƥ����ת��һ�������ҳ��
			    if(key_ss==Convert.ToString(row["��ʾ����"])&Convert.ToString(row["�������"]).Length ==2)
				{
				   Response.Redirect("yjfl.aspx?name="+row["�������"].ToString()+" ");
				   return;
				}
			    if(key_ss==Convert.ToString(row["��ʾ����"])&Convert.ToString(row["�������"]).Length ==4)
				{
				   Response.Redirect("ejfl.aspx?name="+row["�������"].ToString()+" ");
				   return;
				}
			 }
             			
             //���ܻ�ӭ��ʮ�����
            string sqlTop10="select top 10 ��ʾ��,����ͺ�,cl_id ,���ʼ��� from ���ϱ� order by ���ʼ��� desc";
            dt_clss =dc_obj.GetDataTable(sqlTop10);

          
           SearchContent();//����
           if(key_ss!=null&&key_ss!="")//���з����б�
           {
               typeList=GetTypeList();  
           }
           
          }
            

         //��������
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
        
            //���ֶ�����
            BooleanQuery query = new BooleanQuery();            
            foreach (string word in kw)
            {  
                Query query1 = new TermQuery(new Term("��������", word));
                Query query2 = new TermQuery(new Term("��������ֵ", word));
                query.Add(query1, BooleanClause.Occur.SHOULD);
                query.Add(query2, BooleanClause.Occur.SHOULD);
            } 
            Sort sort = new Sort();//����
            string sortM = "id";//Ĭ�ϰ�id����
            if (!string.IsNullOrEmpty(Request["sort"]))
            {
                sortM =Request["sort"].ToString();
            }

            sort.SetSort(new SortField(sortM, SortField.STRING, false));    
            Filter filter = null;
            if (!string.IsNullOrEmpty(Request["type"]))//���ι���
            { 
             filter = new QueryFilter(new TermQuery(new Term("�������", Request["type"].ToString())));
            }     
            ScoreDoc[] docs = searcher.Search(query, filter, 1000, sort).scoreDocs;  //��ѯ��ȡ���ĵ��� 
                 
            int pageSize = 12;
            double count = docs.Length;//�ܼ�¼��                                 
            int pageCount = Convert.ToInt32(Math.Ceiling(count / pageSize));//��ҳ��
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
                SR.�������� = doc.Get("��������");
                SR.���ϱ��� = doc.Get("���ϱ���");             
                list.Add(SR);
            }            
         
        }

         //��ȡ��������б�
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
                Query query1 = new TermQuery(new Term("��������", word));
                Query query2 = new TermQuery(new Term("��������ֵ", word));
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
                if (!dic.ContainsKey(doc.Get("�������")))
                {
                    dic.Add(doc.Get("�������"), doc.Get("��������"));
                }
            }           
              foreach (KeyValuePair<string, string> item in dic)
            {
                sb.Append(string.Format("<a  href='ss.aspx?&page=1&sou={0}&sort={1}&type={2}'>{3}</a>", keyWord,Request["sort"],item.Key,item.Value));
            }
          return sb.ToString();
        }


        //ҳ����
        public string CreatePageBar(int currentPageIndex, int currentPageCount, string keyWord,string sort,string type)
        {
            StringBuilder sb = new StringBuilder();
            if (currentPageIndex > 1)
            {

                sb.Append(string.Format("<a  href='ss.aspx?page={0}&sou={1}&sort={2}&type={3}'>&lt;��һҳ</a>", currentPageIndex - 1, keyWord,sort,type));
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
                if (i == currentPageIndex)//����ǵ�ǰҳ���üӳ�����
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
                sb.Append(string.Format("<a  href='ss.aspx?page={0}&sou={1}&sort={2}&type={3}'>��һҳ&gt;</a>", currentPageIndex + 1, keyWord, sort, type));
            }
            sb.Append(string.Format("<span>��{0}ҳ</span>",currentPageCount));
            return sb.ToString();
        }

      
                
       //�Թؼ��ʽ��зִ�       
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

    //�������
     public class SeachResult
    {
      public string cl_id{get;set;}
      public string ��������{get;set;}
      public string ���ϱ���{get;set;}
        
    }
</script>
<body>
   
   <!-- ͷ����ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ������-->
    <!-- ������ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ��������-->
    <!-- banner��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner ����-->
    <div class="sc">
        <div class="xzss">
            <div class="ppxz">
                <div class="ppxz1">
                    ���ࣺ</div>
                <div class="ppxz2">
                     <%=typeList %>
                   </div>
            </div>            
            <div class="dlspx">
                <span class="dlspx1">����</span>
                <span class="dlspx2"><a href="ss.aspx?page=1&sou=<%=Request["sou"] %>&sort=id&type=<%=Request["type"] %>" >Ĭ��</a></span>
                 <span class="dlspx3"><a href="ss.aspx?page=1&sou=<%=Request["sou"] %>&sort=updatetime&type=<%=Request["type"]%>">����</a><img src="images/qweqw_03.jpg" /></span> 
                 <span class="dlspx3"><input type="checkbox" value="" id="ckAll" class="fx" />ȫѡ</span>
                <span class="dlspx4"><a id="collect" style="cursor:pointer">���ղأ����ڲ���</a></span>
            </div>
        </div>    
        <div class="dlspxl">
        <%if(this.list.Count>0) {%>
            <%foreach(var item in this.list){
              String  mc = item.��������.ToString();
               if (mc.Length > 6) {
                    mc = mc.Substring(0,6)+"..";
               } 
            
            %>
            <div class="dlspxt">
                <a href="clxx.aspx?cl_id=<%=item.cl_id%>" title="<%=item.��������%>">
                    <%
					string str_sqltop1dz ="select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +item.cl_id+"' and ��С='С'";
                    string str_ppid = "select pp_id from ���ϱ� where cl_id="+item.cl_id.ToString();
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
                            parm = item.���ϱ���.ToString() + "|" + ppid;
                             %>
                             <input name="item" type="checkbox" value="<%=parm%>" class="ck" />�ղ�</span>
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
        <div id="isEmpty" style="<%=style%>; font-family:����; font-size:22px; color:Red; text-align:center; padding-top:15%">
            �Բ���û���ҵ�������ѯ�Ĳ�Ʒ��
        </div>

        </div>
       
        <!-- ���ܻ�ӭ�����ֲ���-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1">
                    <ul>
                        <%foreach(System.Data.DataRow row in this.dt_clss.Rows){%>
                        <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
                            <%=row["��ʾ��"].ToString()%></a></li>
                        <%}%>
                    </ul>
                </div>
            </div>
    <div class="pxright2">
        <a href="#">
            <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
    </div> </div>
    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div> 
    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  
   <div id="type" style="display:none"><%=Request["type"] %></div>
   <div id="sort" style="display:none"><%=Request["sort"] %></div> 
   
</body>
</html>
