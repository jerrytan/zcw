<!--
        ��������Ϣ��ҳ
        �ļ�����scsxx.ascx
        ���������gys_id    ��Ӧ�̱��
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��������Ϣҳ</title>
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
        protected DataTable dt = new DataTable();
		protected DataTable dt1 = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt2 = new DataTable(); //��˾����Ʒ��(Ʒ���ֵ�)
		protected DataTable dt3 = new DataTable(); //�Ĺ�˾�µķ�����(��Ӧ�̺ͷ�������ر�)
        string gys_id;
        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                SqlConnection conn = new SqlConnection(constr);
                conn.Open();          
		        gys_id = Request["gys_id"];  //��ȡgys_id
                
                //��ȡ��������Ϣ
			    SqlDataAdapter da1 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where gys_id='"+gys_id+"'", conn);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1, "���Ϲ�Ӧ����Ϣ��");            
                dt1 = ds1.Tables[0];
			
			
			
			    //��ȡƷ����Ϣ
			    SqlDataAdapter da2 = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ����� = '1' and scs_id='"+gys_id+"'", conn);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2, "Ʒ���ֵ�");            
                dt2 = ds2.Tables[0];
			
                //��ȡ��������Ϣ
			    //�Ӳ�ѯǶ�� �ȸ��ݴ�������gys_id��Ʒ������  �ٴ�Ʒ���ֵ���鸴��������gys_id �����ݸ���������gys_id���������Ϣ
			    SqlDataAdapter da3 = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )", conn);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3, "���Ϲ�Ӧ����Ϣ��");            
                dt3 = ds3.Tables[0];
			
			
             }		
        }
    </script>



    <!-- ��������Ϣ��ҳ ��ʼ-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp 

            <% foreach(System.Data.DataRow row in dt1.Rows){%>
            <a href="#"><%=row["��Ӧ��"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt1.Rows){%>
                <p>������<%=row["��Ӧ��"].ToString() %></p>
                <p>��ַ��<%=row["��ϵ��ַ"].ToString() %></p>
                <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                <p>��ϵ�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="#">������δ���죬������ǵ����������챾�꣬����֮�����ά�������Ϣ</a></div>
            <div class="gyan1"><a href="" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>
        </div>

        <!-- ��������Ϣ��ҳ ����-->



        <!-- ��˾����Ʒ�� ��ʼ-->

        <div class="gydl">
            <div class="dlpp">��˾����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt2.Rows){%>
            <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">

            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["Ʒ������"].ToString()%></div>
            </a>
            <%}%>
        </div>

        <!-- ��˾����Ʒ�� ����-->


        <!-- ������ҳ ��ʼ-->

        <div class="gydl">
            <div class="dlpp">������</div>
            <div class="fxs1">
                <select name="" class="fu1">
                    <option>����</option>
                </select>
                <select name="" class="fu2">
                    <option>����</option>
                </select>ʡ���У�
    <select name="" class="fu3">
        <option>ʯ��ׯ</option>
    </select>
                ����<select name="" class="fu4"><option>����</option>
                </select>
                �����أ�
            </div>

            <%foreach(System.Data.DataRow row in dt3.Rows){%>
            <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">

            <div class="fxs2">
                <ul>
                    <li class="fxsa"><%=row["��Ӧ��"].ToString() %></li>
                    <li>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></li>
                    <li>�绰��<%=row["��ϵ���ֻ�"].ToString() %></li>
                    <li>��ַ��<%=row["��ϵ��ַ"].ToString() %></li>
                </ul>
            </div>
                </a>
            <%}%>
        </div>



    </div>

    <!-- ������ҳ ����-->



    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->


    <script>function NewWindow(id) {
    var url = "scgys.aspx?gys_id=" + id;
    window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
}
</script>
</body>
</html>
