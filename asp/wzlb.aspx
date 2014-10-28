<!--
        �����б�ҳ��
        �ļ�����wzlb.aspx
        ���������
                p    �б�ҳ��
                id    ��������
        ������:  ����
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
    <title><%=Request["id"] %>�б�</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
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
            if(string.IsNullOrEmpty(strC))//�״δ������л�ȡ�ܼ�¼��
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
        //���õ������� currentPage:��ǰҳ�� pageCount:��ҳ�� 
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

    <div class="xw">
        <% string str_id=Request["id"];%>
        <div class="xw1"><a href="index.aspx" class="p1">��ҳ</a>>&nbsp&nbsp&nbsp<%=str_id%></div>
        <!--��ҳ �����б� ��ʼ-->
        <div class="xw2">
            <dl><% foreach(System.Data.DataRow row in dt_content.Rows){%>
                <dd style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>">��<%=row["����"].ToString() %></a></dd>
                <%
                    string str_time = row["����ʱ��"].ToString();
                    string[] str_times = str_time.Split(' ');
                    string str_fbtime = str_times[0];
                 %>
                <dt style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=str_fbtime %></a></dt>
                <% } %>
            </dl>
        </div>
        <!-- ��ҳ �����б� ����-->
        
        <!-- ҳ�뿪ʼ-->
       <div style="text-align:center"> <!--����div���Ʒ�ҳ����-->
       <div class="fy2">
            <div class="fy3">
                <% if(current_page<=1 && pageCount_page>1) {%> 
                    <font class="p" style="color:Gray">��ҳ</font>
                    <a href="wzlb.aspx?p=<%=current_page+1 %>&id=<%=str_id %>" class="p" style="color:Black">��һҳ</a>
                    <a href="wzlb.aspx?p=<%=pageCount_page %>&id=<%=str_id %>" class="p" style="color:Black">ĩҳ</a>
                <%} %>
                <% else if(current_page<=1 && pageCount_page<=1) {%>
                
                <% }%>    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="wzlb.aspx?p=<%=1 %>&id=<%=str_id %>"class="p" style="color:Black">��ҳ</a>
                    <a href="wzlb.aspx?p=<%=current_page-1 %>&id=<%=str_id %>" class="p" style="color:Black">��һҳ</a>
                    <a href="wzlb.aspx?p=<%=current_page+1 %>&id=<%=str_id %>" class="p" style="color:Black">��һҳ</a>
                     <a href="wzlb.aspx?p=<%=pageCount_page %>&id=<%=str_id %>" class="p" style="color:Black">ĩҳ</a>
                <%}%>
                <% else if(current_page == pageCount_page){ %>
                    <a href="wzlb.aspx?p=<%=1 %>&id=<%=str_id %>"class="p" style="color:Black">��ҳ</a>
                    <a href="wzlb.aspx?p=<%=current_page-1 %>&id=<%=str_id %>" class="p" style="color:Black">��һҳ</a>
                    <font class="p" style="color:Gray">ĩҳ</font> 
                <%} %>
                <font style="color:Black" >ֱ�ӵ���</font>  
                <select onchange="window.location=this.value" name="" class="p" style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>&id=<%=str_id%>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >ҳ&nbsp;&nbsp;&nbsp;�� <%=current_page %> ҳ/�� <%=pageCount_page %> ҳ</font>
            </div>
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
