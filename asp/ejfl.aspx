<!--
        ���϶��������б�ҳ��
        �ļ�����ejfl.ascx
        ���������name [�������]
        owner:������
               
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
                var v = $(this).attr("checked");//��ȡ"ȫѡ��ѡ��"                
                $(":checkbox.ck").attr("checked", v);//����class=ck�ĸ�ѡ���Ƿ�ѡ��
            });
            $(":checkbox.ck").click(function () {
                var a = $(":checkbox.ck").size(); //��ȡ���е�class=ck�ĸ�ѡ������                
                var b = $(":checkbox.ck:checked").size();//��ȡ���е�class=ck,���ұ�ѡ�е� ��ѡ������
                var c = a == b;
                $("#ckAll").attr("checked", c);
            });
        });
    </script>
    <title>����������ϸҳ��</title>
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
         
        protected DataTable dt_yjflmc = new DataTable();   //һ����������
        protected DataTable dt_ejflmc = new DataTable();  //������������ 
		protected DataTable dt_ejflpp = new DataTable();  //Ʒ��(�Ͷ���������ص�Ʒ��) ���Ϸ������fl_id Ʒ���ֵ��й�ϵû�ж�Ӧ
		protected DataTable dt_ejflcl = new DataTable();  //�������������µĲ���(���������ʯ��)
		protected DataTable dt_clmcpage = new DataTable();  //�������Ʒ�ҳ (��С���е����в��Ͻ��з�ҳ)
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ�������(���±�)
        protected DataConn dc_obj = new DataConn();

		private const int Page_Size = 8; //ÿҳ�ļ�¼����
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
			string name1=name.ToString().Substring(0, 2); //ȡ�����λ�ַ���
            string str_sqlclmc = "select ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name1+"' and len(�������)='2' "; 
            dt_yjflmc = dc_obj.GetDataTable(str_sqlclmc);

			string str_sqlclmz = "select ��ʾ���� from ���Ϸ���� where �������='"+name+"' ";
            dt_ejflmc = dc_obj.GetDataTable(str_sqlclmz);
			
			string str_sqlppmc = "select distinct Ʒ������ from Ʒ���ֵ� where  fl_id in(select fl_id from ���Ϸ���� where �������='"+name+"') "; 
            dt_ejflpp = dc_obj.GetDataTable(str_sqlppmc);
           		
			
            string str_sqlcl = "select top 10 ��ʾ��,����ͺ�,�������,cl_id from ���ϱ� where �������='"+name+"' order by ���ʼ��� ";
            dt_ejflcl = dc_obj.GetDataTable(str_sqlcl);
			
			string str_sqltop4 = "select top 4 ����,ժҪ,wz_id from ���±� where left(�������,4)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_sqltop4);
			
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
			//string name1 = name.ToString().Substring(0, 4);    //���������ഫ�����Ĳ��ϱ���ȡǰ��λ��Ϊ����ִ�д洢����
            dt_clmcpage = this.GetProductFormDB(begin, end,name);
            this.SetNavLink(p, c,name);   
		} 
		      
        private void SetNavLink(int currentPage, int pageCount,string name)
        {
            this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)  //�����б�ѭ���ܵ�ҳ��
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
                new SqlParameter("@���ϱ���",name)
            };
            return dt_clmcpage = dc_obj.ExecuteProcForTable("ej_cl_Paging",spt); 
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {
            try
            {
                string sql = "select * from ���ϱ� where left(���ϱ���,4)='"+name+"'";
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
        <!-- ���ӵ����� ��ʼ-->
        <div class="sc1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="yjfl.aspx?name=<%=row["�������"]%>"><%=row["��ʾ����"].ToString() %></a>
            <% } %>> 
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a href="#"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>
        <!-- ���ӵ����� ����-->

        <!-- ���������ժҪ ��ʼ-->
        <div class="sc3">
            <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["ժҪ"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����"].ToString() %></a></div>
                <div class="rh2" style="overflow"><%=resume %></div>
            </div>
			<%}%>		   
        </div>
        <!-- ���������ժҪ ����-->

        <!-- ɸѡ ��ʼ -->
        <div class="xzss">
            <div class="ppxz">
                <div class="ppxz1">Ʒ�ƣ�</div>
                <div class="ppxz2">
                    <a href="#"><img src="images/qwez.jpg" /></a>
                    <% foreach(System.Data.DataRow row in dt_ejflpp.Rows){%>
                    <a href="#"><%=row["Ʒ������"].ToString() %></a>
                    <% } %>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">����</div>
                <div class="ppxz2"><a href="#">
                    <img alt="" src="images/qwez.jpg" /></a> <a href="#">������</a> <a href="#">������</a> <a href="#">��̨��</a>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">���ϣ�</div>
                <div class="ppxz2">
                    <a href="#"><img alt="" src="images/qwez.jpg" /></a>
                    <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>"><%=row["��ʾ��"].ToString() %></a>
                    <%}%>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">���ࣺ</div>
                <div class="ppxz2"> 
                    <a href="#">����1</a> <a href="#">����2</a> <a href="#">����3</a>
                </div>
            </div>
            <!-- ��������ɸѡ ��ʼ-->
            <div class="dlspx">
                <span class="dlspx1">����</span>
                <span class="dlspx2"><a href="#">Ĭ��</a></span>
                <span class="dlspx3"><a href="#">����<img src="images/qweqw_03.jpg" /></a></span>
                <span class="dlspx3"><a href="#">����<img src="images/qweqw_03.jpg" /></a></span>
                <span class="dlspx3">
                    <input name="" type="checkbox" value="" id="ckAll" class="fx" /><a href="#">ȫѡ</a>
                </span>
                <span class="dlspx4"><a href="#">���ղأ����ڲ���</a></span>
            </div>
            <!-- ��������ɸѡ ����-->
        </div>
         <!-- ɸѡ ���� -->

        <!-- ������ʾ�б� ��ʼ-->
        <div class="dlspxl" style="background-color:Green">
            <% foreach(System.Data.DataRow row in dt_clmcpage.Rows){%>
            <div class="dlspxt" style="background-color:Orange">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
                    <%
                    string str_sqltop1 = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'";
                    string imgsrc= "images/222_03.jpg";
                   
                    object result = dc_obj.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
				    %>
                    
                    <div class="dlspxt1" style="overflow:hidden;background-color:Green">
                        <span class="dlsl" style="overflow:hidden;background-color:Yellow"><%=row["��ʾ��"].ToString() %></span>
                        <span class="dlspx3" style="background-color:Blue">
                            <input name="" type="checkbox" value="" class="ck" />�ղ�
                        </span>
                        <span class="dlsgg" style="background-color:Red">���<%=row["����ͺ�"].ToString() %></span>
                    </div>
                 </a>
            </div>
            <% } %>
        </div>
        <!-- ������ʾ�б� ����-->

        <!-- ���������ʯ�� ��ʼ -->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString() %></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2"><a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
        </div>
        <!-- ���������ʯ�� ����-->
    </div>

    <!-- ��ҳ ��ʼ -->
    <div class="fy2">
        <div class="fy3">
                 <% if(current_page<=1 && pageCount_page >1) {%> 
                    <font style="color:Gray">��ҳ</font>
                    <a href="ejfl.aspx?p=<%=current_page+1 %>&name=<%=name %>" class="p" style="color:Black">��һҳ</a>
                    <a href="ejfl.aspx?p=<%=pageCount_page %>&name=<%=name %>" class="p" style="color:Black">ĩҳ</a>
                <%} %>
                <%else if(current_page <=1 && pageCount_page <=1 ){ %>

                <%} %>
                    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="ejfl.aspx?p=<%=1 %>&name=<%=name %>"class="p" style="color:Black">��ҳ</a>
                    <a href="ejfl.aspx?p=<%=current_page-1 %>&name=<%=name %>" class="p" style="color:Black">��һҳ</a>
                    <a href="ejfl.aspx?p=<%=current_page+1 %>&name=<%=name %>" class="p" style="color:Black">��һҳ</a>
                     <a href="ejfl.aspx?p=<%=pageCount_page %>&name=<%=name %>" class="p" style="color:Black">ĩҳ</a>
                <%}%>
                <% else if( current_page !=1 && current_page == pageCount_page){ %>
                    <a href="ejfl.aspx?p=<%=1 %>&name=<%=name %>"class="p" style="color:Black">��ҳ</a>
                    <a href="ejfl.aspx?p=<%=current_page-1 %>&name=<%=name %>" class="p" style="color:Black">��һҳ</a>
                    <font style="color:Gray">ĩҳ</font>
                <%} %>             
                  <font style="color:Black" >ֱ�ӵ���</font>  
                <select onchange="window.location=this.value" name="" class="p" style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >ҳ&nbsp;&nbsp;&nbsp;�� <%=current_page %> ҳ/�� <%=pageCount_page %> ҳ</font>
        </div>
    </div>
    <!-- ��ҳ ����-->

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
