<%-- ��Ʒ����������ҳ--%>

<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������ҳ</title>
<style type="text/css">
	.p 
{
	font-size: 12px;
	color:Black;
	font-weight:bold;
	text-decoration:none; 
}
	.p1 
{
	font-size: 15px;
	color:blue;
	font-weight:bold;
	text-decoration:none; 
}
</style>
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



<!-- ������ҳ ��ʼ-->
<script runat="server">

        public class ArticleContent
    {
        public string Text { get; set; }
        public string Content { get; set; }  
        public string Wz_id { get; set; }		
    }
       	public List<ArticleContent> Items { get; set; }

           
 	    protected DataTable dt=new DataTable();  //���±�
        protected DataTable dt1=new DataTable();
        protected DataTable dt2=new DataTable();  //���ºͳ�����ر�
        protected DataTable dt3=new DataTable();  //���ºͲ�Ʒ��ر�
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            string wz_id=Request["wz_id"];  //��ȡ����id
            SqlDataAdapter da = new SqlDataAdapter("select distinct ����,����,����, wz_id from ���±� where wz_id='"+wz_id+"'", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "���±�");        
            dt = ds.Tables[0];

            SqlDataAdapter da2 = new SqlDataAdapter("select ��������,gys_id from ���ºͳ�����ر� where wz_id='"+wz_id+"'", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���ºͳ�����ر�");        
            dt2 = ds2.Tables[0];

            SqlDataAdapter da3 = new SqlDataAdapter("select ��Ʒ����,cl_id from ���ºͲ��ϱ���ر� where wz_id='"+wz_id+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ºͲ��ϱ���ر�");        
            dt3 = ds3.Tables[0];   


                            
            string strr="select ����, wz_id from ���±� where wz_id='"+wz_id+"' ";         
            SqlCommand cmd = new SqlCommand(strr, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                string str = dr.GetString(0);
                ArticleContent item = new ArticleContent();
                this.Items = new List<ArticleContent>();  //������������
                item.Content = OutputBySize(str) ; 
			
                this.Items.Add(item);
                //item.Text=m_strPageInfo ;              
            }
            conn.Close();
            //��ҳ��δ����
        
        }
			
			
         public string OutputBySize(string p_strContent)//��ҳ����
        {
            string m_strRet = "";
            int m_intPageSize = 1500;//����ÿҳ��С
            int m_intCurrentPage = 1;//���õ�һҳΪ��ʼҳ
            int m_intTotalPage = 0; //���÷�ҳ��
            int m_intArticlelength = p_strContent.Length;//���³���
            if (m_intArticlelength > m_intPageSize)//���ÿҳ��С�������³���ʱ��ʼ��ҳ
            {
                if (m_intArticlelength % m_intPageSize == 0)//set total pages count
                {
                    m_intTotalPage = m_intArticlelength / m_intPageSize;
                }
                else
                {//if the totalsize
                    m_intTotalPage = m_intArticlelength / m_intPageSize + 1;
                }
				
                if (Request["ps"] != null)
                {//set Current page number
                    try
                    {//���������ĵ�ַ����ֵ
                        m_intCurrentPage = Convert.ToInt32(Request["ps"]);
                        if (m_intCurrentPage > m_intTotalPage)

                            m_intCurrentPage = m_intTotalPage;

                    }
                    catch
                    {
                        //m_intCurrentPage = m_intCurrentPage;
                    }
                }
                //set the page content ���û�ȡ��ǰҳ�Ĵ�С
                if (m_intCurrentPage < m_intTotalPage)
                {
                    m_intPageSize = m_intCurrentPage < m_intTotalPage ? m_intPageSize : (m_intArticlelength - m_intPageSize * (m_intCurrentPage - 1));
                    m_strRet += p_strContent.Substring(m_intPageSize * (m_intCurrentPage - 1), m_intPageSize); //���������ʱ��ҳ���ݳ���
                }
                else if (m_intCurrentPage == m_intTotalPage)
                {
                    int mm_intPageSize = m_intArticlelength - m_intPageSize * (m_intCurrentPage - 1);//���һҳǰ������
                    m_strRet += p_strContent.Substring(m_intArticlelength - mm_intPageSize); //���һҳ������
                }
                string wz_id = Request["wz_id"];  //��ȡ����id
                string m_strPageInfo = "";
                for (int i = 1; i <= m_intTotalPage; i++)
                {
                    if (i == m_intCurrentPage)
                        m_strPageInfo += "[" + i + "]";
                    else
                        m_strPageInfo += " <a href=?ps=" + i + "&wz_id="+wz_id+"  >[" + i + "]</a> ";

                }
                if (m_intCurrentPage > 1)
				    
                    m_strPageInfo = "<a href=?ps=" + (m_intCurrentPage - 1) + "&wz_id="+wz_id+" >��һҳ</a>" + m_strPageInfo;
                if (m_intCurrentPage < m_intTotalPage)
                    m_strPageInfo += "<a href=?ps=" + (m_intCurrentPage + 1) + "&wz_id="+wz_id+" >��һҳ</a>";
                //�����ʾ����ҳ��
                //this.ShowPageNumber.Text = "<p></p>" + m_strPageInfo;
                ArticleContent item = new ArticleContent();
                this.Items = new List<ArticleContent>();  //������������
                item.Text = m_strPageInfo ;    //�������·�ҳҳ��
                this.Items.Add(item);

            }
            else
            {
                m_strRet += p_strContent;
            }
            return m_strRet;
        }
	</script>



<div class="xwn">
<div class="xwn1"><a href="index.aspx" class="p1">��ҳ ></a> ����</div>
<div class="xwleft">

 <% foreach(System.Data.DataRow row in dt.Rows){%> 
<div class="xwleft1"><%=row["����"].ToString() %></div>
<div class="xwleft2">���ߣ�<%=row["����"].ToString() %></div>

 <% foreach(var v in Items){%> 
<div class="xwleft3"><%=v.Content %></div> 
<%}%>
<%--<div class="xwleft3"><%=row["����"].ToString() %></div>--%> 
<%}%>
</div>

<!-- ������ҳ ����-->




<!-- ��س����б� ��ʼ-->

<div class="xwright">
<div class="xwright1">
  <ul>
   <%foreach(System.Data.DataRow row in dt2.Rows){%>
     <li><a href="scsxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��������"].ToString()%></a></li>
 <%}%>
   
  </ul>
</div>
<!-- ��س����б� ����-->



<!-- ��ز�Ʒ�б� ��ʼ-->
<div class="xwright1">
  <ul>
     <%foreach(System.Data.DataRow row in dt3.Rows){%>
     <li><a href="#"><%=row["��Ʒ����"].ToString()%></a></li>
  <%}%>
   
  </ul>
</div>
</div>

</div>
<!-- ��ز�Ʒ�б� ����-->


<!-- ����ҳ�뿪ʼ -->
<center>
<div>
 <% foreach(var v in Items){%> 
<div class="xwleft3"><%=v.Text %></div> 
<%}%>
</div>
</center>
<!-- ����ҳ����� -->



<!-- �������� ������ ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ ����-->



<!-- footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->




<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<script type="text/javascript">
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<body>
</html>