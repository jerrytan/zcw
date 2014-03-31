<!--
        ����һ�������б�ҳ��
        �ļ�����yjfl.ascx
        ���������name
        owner:������
               
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
    <title>һ������</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
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

    <!-- ��ҳ ʯ����ҳ ��ʼ-->
    <script runat="server">
        protected DataTable dt_ejflmc = new DataTable();   //������������
        protected DataTable dt_allcl = new DataTable();  //�������Ʒ�ҳ (�����µ����в��Ϸ�ҳ)
        protected DataTable dt_yjflmc = new DataTable();  //��ҳ��ʾһ����������
        protected DataTable dt_zclmc = new DataTable();   //����������� ���������ʯ��	
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ���������(���±�)
		protected DataConn dc_obj = new DataConn();	//���߲�����
        		
        private const int Page_Size = 8; //ÿҳ�ļ�¼����
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
            name= Request["name"]; //��ȡ��ҳ��������һ���������(��λ)

            string str_sqltop10 = "select top 10 ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name+"' and len(�������)='4' ";            
            dt_ejflmc = dc_obj.GetDataTable(str_sqltop10);

            string str_sqlflname = "select  ��ʾ����,fl_id from ���Ϸ���� where  �������='"+name+"' ";                
            dt_yjflmc = dc_obj.GetDataTable(str_sqlflname);      
  
            string str_sqltop10name = "select  top 10 ��ʾ��,cl_id from ���ϱ� where left(���ϱ���,2)='"+name+"' order by ���ʼ���";              
            dt_zclmc = dc_obj.GetDataTable(str_sqltop10name); 
			
			string str_top4wz = "select top 4 ����,ժҪ,wz_id from ���±� where left(�������,2)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_top4wz);
            
			
            //�Ӳ�ѯ�ַ����л�ȡ"ҳ��"����
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
            //�Ӳ�ѯ�ַ����л�ȡ"��ҳ��"����
            string strC = Request.QueryString["c"];
            if (string.IsNullOrEmpty(strC))
            {
                double recordCount = this.GetProductCount(); //������
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
            dt_allcl = this.GetProductFormDB(begin, end,name);
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
                new SqlParameter("@���ϱ���",name)
            };
            return dt_allcl = dc_obj.ExecuteProcForTable("yj_cl_Paging",spt);
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {
            try
            {
                string sql = "select * from ���ϱ� where left(���ϱ���,2)='"+name+"'";
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
            <a href="index.aspx" class="p1">��ҳ ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="#"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc2">
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a href="ejfl.aspx?name=<%=row["�������"] %>"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc3">
		    <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               string resume = row["ժҪ"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����"].ToString() %></a></div>
                <div class="rh2" style="overflow:hidden"><%=resume %></div>
            </div>
			<%}%>			
        </div>
       
        <div class="px0">
            <div class="px">����<a href="#">����</a> <a id="zuixin" style=" cursor:pointer" onclick="doAjax()">����</a></div>
        </div>
    
        <div class="pxleft">      
           <%--����ajax���� ����ȡ�����ķ�ҳ���ݱ�dt1��updatetime�н������� 
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
					    string str_sqltop1dz = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                                                            +row["cl_id"]+"' and ��С='С'";
                        string imgsrc= "images/222_03.jpg";
                        object result = dc_obj.DBLook(str_sqltop1dz);
                        if (result != null) 
                        {
                            imgsrc = result.ToString();
                        }
                        Response.Write("<img src="+imgsrc+ " width=150px height=150px />") ;  
				    %>
                    </a>
                <span class="pxtu1" style="overflow:hidden"><%=row["��ʾ��"].ToString()%></span>
                </div>
            <%}%>
         </div>

        <!-- ���������ʯ�� ��ʼ-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_zclmc.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString()%></a></li>
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
         <!-- ���������ʯ�� ����-->
    </div>
   
    <!-- ��ҳ ʯ����ҳ ����-->

    <!-- ʯ�Ĺ��ҳ�� ��ʼ-->
    <div >
        <div class="fy2">
            <div class="fy3" style=" width:500px;height:auto; padding-left:0% !important; padding-left:23%">
                <% if(current_page<=1 && pageCount_page >1) {%> 
                    <font style="color:Gray">��ҳ</font>
                    <a href="yjfl.aspx?p=<%=current_page+1 %>&name=<%=name %>"  style="color:Black">��һҳ</a>
                    <a href="yjfl.aspx?p=<%=pageCount_page %>&name=<%=name %>"  style="color:Black">ĩҳ</a>
                <%} %>
                <%else if(current_page <=1 && pageCount_page <=1 ){ %>

                <%} %>
                    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="yjfl.aspx?p=<%=1 %>&name=<%=name %>" style="color:Black">��ҳ</a>
                    <a href="yjfl.aspx?p=<%=current_page-1 %>&name=<%=name %>"  style="color:Black">��һҳ</a>
                    <a href="yjfl.aspx?p=<%=current_page+1 %>&name=<%=name %>"  style="color:Black">��һҳ</a>
                     <a href="yjfl.aspx?p=<%=pageCount_page %>&name=<%=name %>"  style="color:Black">ĩҳ</a>
                <%}%>
                <% else if( current_page !=1 && current_page == pageCount_page){ %>
                    <a href="yjfl.aspx?p=<%=1 %>&name=<%=name %>" style="color:Black">��ҳ</a>
                    <a href="yjfl.aspx?p=<%=current_page-1 %>&name=<%=name %>"  style="color:Black">��һҳ</a>
                    <font style="color:Gray">ĩҳ</font>
                <%} %>             
                  <font style="color:Black" >ֱ�ӵ���</font>  
                <select onchange="window.location=this.value" name=""  style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >ҳ&nbsp;&nbsp;&nbsp;�� <%=current_page %> ҳ/�� <%=pageCount_page %> ҳ</font>
            </div>
        </div>
    </div>
    <!-- ʯ�Ĺ��ҳ�� ����-->

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

</body>
</html>
