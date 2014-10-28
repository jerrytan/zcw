
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title></title>
    <script runat="server"> 
       protected DataConn dc_obj = new DataConn();//工具类  
       protected void Page_Load(object sender, EventArgs e)
        {
         
        }

         protected void btnCreatIndex_Click(object sender, EventArgs e)
        {          
             string indexPath = Server.MapPath("lucenedir\\");
			 if (!System.IO.Directory.Exists(indexPath))
            {
                System.IO.Directory.CreateDirectory(indexPath);
            }
            FSDirectory directory = FSDirectory.Open(new DirectoryInfo(indexPath), new NativeFSLockFactory());
            bool isUpdate = IndexReader.IndexExists(directory);
            if (isUpdate)
            {                
                if (IndexWriter.IsLocked(directory))
                {
                    IndexWriter.Unlock(directory);
                }
            }
            IndexWriter writer = new IndexWriter(directory, new PanGuAnalyzer(), !isUpdate, Lucene.Net.Index.IndexWriter.MaxFieldLength.UNLIMITED);//向索引库中写索引。这时在这里加锁。

             List<Clxx> list=GetDataList();
            foreach (Clxx entity in list)
            {
                writer.DeleteDocuments(new Term("id", entity.myID.ToString()));
                Document document = new Document();               
                document.Add(new Field("id", entity.myID.ToString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
                document.Add(new Field("updatetime", entity.updatetime.ToString(), Field.Store.YES, Field.Index.NOT_ANALYZED));               
                document.Add(new Field("材料名称",entity.材料名称, Field.Store.YES, Field.Index.ANALYZED, Lucene.Net.Documents.Field.TermVector.WITH_POSITIONS_OFFSETS));
                document.Add(new Field("分类属性值", entity.分类属性值, Field.Store.YES, Field.Index.ANALYZED, Lucene.Net.Documents.Field.TermVector.WITH_POSITIONS_OFFSETS));
                document.Add(new Field("分类名称", entity.分类名称, Field.Store.YES, Field.Index.ANALYZED, Lucene.Net.Documents.Field.TermVector.WITH_POSITIONS_OFFSETS));
                document.Add(new Field("分类编码", entity.分类编码, Field.Store.YES, Field.Index.NOT_ANALYZED));
                document.Add(new Field("cl_id", entity.cl_id, Field.Store.YES, Field.Index.NOT_ANALYZED));
                document.Add(new Field("材料编码", entity.材料编码, Field.Store.YES, Field.Index.NOT_ANALYZED));
                writer.AddDocument(document);
            }
            writer.Close();
            directory.Close();
            Response.Write("索引创建成功！！");     
         
        }

        

       //获取材料列表
        private  List<Clxx> GetDataList()
        {
            List<Clxx> list = new List<Clxx>();
            string sql = "select myID,cl_id, 分类编码, 分类名称, 材料编码, 材料名称, 分类属性值, updatetime from 材料属性表";
            DataTable dt = dc_obj.GetDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    Clxx entity = new Clxx();
                    entity.myID = Convert.ToInt32(item["myID"]);
                    entity.分类编码 = item["分类编码"].ToString();
                    entity.分类名称 = item["分类名称"].ToString();
                    entity.材料编码 = item["材料编码"].ToString();
                    entity.材料名称 = item["材料名称"].ToString();
                    entity.分类属性值 = item["分类属性值"].ToString();                  
                    entity.cl_id = item["cl_id"].ToString();
                    if (item["updatetime"] != DBNull.Value)
                    {
                        entity.updatetime = Convert.ToDateTime(item["updatetime"]);
                    }
                    else
                    {
                        entity.updatetime = DateTime.Now;
                    }
                    list.Add(entity);
                }
            }
            return list;
        }

    public class Clxx
    {
        public int myID { get; set; }
        public string 分类编码 { get; set; }
        public string 分类名称 { get; set; }
        public string 材料编码 { get; set; }
        public string 材料名称 { get; set; }
        public string 分类属性值 { get; set; }
        public DateTime updatetime { get; set; }
        public string cl_id { get; set; }
    }
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Button ID="btnCreatIndex" runat="server" Text="创建索引" 
            onclick="btnCreatIndex_Click" />
    </div>
    </form>
</body>
</html>
