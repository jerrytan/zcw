<!--
        �����б�ҳ��
        �ļ�����wzlb.ascx
        ���������
                p    �б�ҳ��
                id    ��������
        ������:  ����
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
<!DOCTYPE html PUBLIC "-//W3C//dtD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/dtD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title><%=Request["id"] %>�б�</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
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

    <script runat="server">        
        private DataConn dc_obj = new DataConn();
        private const int Page_Size = 5; //ÿҳ�ļ�¼����
        private int current_page=1;//��ǰĬ��ҳΪ��һҳ
        int pageCount_page; //��ҳ��
        protected DataTable dt_content = new DataTable();
        private int i_count=0;
        public List<OptionItem> Items { get; set; }//������תҳ��

        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }      
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {            
            //�Ӳ�ѯ�ַ����л�ȡ"ҳ��"����
            string strP = Request.QueryString["p"];
            if(string.IsNullOrEmpty(strP))//�жϴ������Ĳ����Ƿ�Ϊ��  
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

            //�Ӳ�ѯ�ַ����л�ȡ"��ҳ��"����
            string strC = Request.QueryString["c"];
            if(string.IsNullOrEmpty(strC))
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
            //����/��ѯ��ҳ����
            int begin = (p - 1) * Page_Size + 1;
            int end = p * Page_Size;
	        string type = Request["id"];   //��ȡ���������ĵ����Ͳ���
            dt_content = this.GetProductFormDB(begin,end,type);
            this.SetNavLink(p, c);              
        }
       
        protected string LinkFirst= ""; //��ҳ
        protected string LinkPrev = ""; //��ҳ
        protected string LinkNext = ""; //��ҳ
        protected string LinkLast = ""; //βҳ     

        //���õ������� currentPage:��ǰҳ�� pageCount:��ҳ�� 
        private void SetNavLink(int currentPage, int pageCount)
        {
            string path = Request.Path;   
            LinkFirst = "1";
            LinkPrev = string.Format("p={0}",currentPage - 1);
            LinkNext = string.Format("p={0}",currentPage + 1);
            LinkLast = string.Format("p={0}",pageCount);
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
        //���ݲ���,��ȡ���ݿ��з�ҳ�洢���̵Ľ��
        private DataTable GetProductFormDB(int begin, int end ,string type)
        {         
            SqlParameter [] spt = new SqlParameter[]
            {
                new SqlParameter("@begin",begin),
                new SqlParameter("@end",end),
                new SqlParameter("@�ĵ�����",type)
            };
            return dt_content = dc_obj.ExecuteProcForTable("wz_Paging",spt);
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {
            try
            {
                string str_type = Request["id"];   //��ȡ���������ĵ����Ͳ���
                //string str_sql = "select count(wz_Id) from ���±� where �ĵ�����='"+str_type+"' ";
                //i_count = Convert.ToInt32(dc_obj.DBLook(str_sql));  //����sql���õ����¼����
                string str_sql = "select wz_Id from ���±� where �ĵ�����='"+str_type+"' order by ����ʱ�� ";
                i_count = dc_obj.GetRowCount(str_sql);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 
    </script>

    <div class="xw">
        <% string str_id=Request["id"];%>
        <div class="xw1"><a href="index.aspx" class="p1">��ҳ</a>>&nbsp&nbsp&nbsp<%=str_id%></div>
        <!--��ҳ �����б� ��ʼ-->
        <div class="xw2">
            <dl><% foreach(System.Data.DataRow row in dt_content.Rows){%>
                <dd><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>">��<%=row["����"].ToString() %></a></dd>
                <dt><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����ʱ��"].ToString() %></a></dt>
                <% } %>
            </dl>
        </div>
        <!-- ��ҳ �����б� ����-->
        
        <!-- ҳ�뿪ʼ-->
       <div class="fy2">
            <div class="fy3">
               <%-- <%if(current_page==1){%>
                <a href="wzlb.aspx?<%=LinkFirst %>&id=<%=str_id %>"class="p">��ҳ</a>
                <%} %>
                <% else if(current_page>1 && current_page< pageCount_page) {%>
                <a href="wzlb.aspx?<%=LinkPrev %>&id=<%=str_id %>" class="p">��һҳ</a>
                <a href="wzlb.aspx?<%=LinkNext %>&id=<%=str_id %>" class="p">��һҳ</a>
                <% }else if(current_page == pageCount_page){ %>
                <a href="wzlb.aspx?<%=LinkLast %>&id=<%=str_id %>" class="p">ĩҳ</a>
                <%} %>
                ֱ�ӵ���  
                <select onchange="window.location=this.value" name="" class="p">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>&id=<%=str_id%>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                ҳ--%>
            </div>
        </div>
        <!-- ҳ�����-->
    </div>

    <!-- �������� ������ Ͷ�߽��� ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- �������� ������ Ͷ�߽��� ����-->

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->
</body>
</html>
