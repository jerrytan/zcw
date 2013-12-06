<%-- 产品发现文章首页--%>

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
<title>文章详情页</title>
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
<!-- 头部开始-->
<!-- #include file="static/header.aspx" -->
<!-- 头部结束-->


<!-- 导航开始-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- 导航结束-->


<!-- banner开始-->
<!-- #include file="static/banner.aspx" -->
<!-- banner 结束-->



<!-- 文章首页 开始-->
<script runat="server">

        public class ArticleContent
    {
        public string Text { get; set; }
        public string Content { get; set; }  
        public string Wz_id { get; set; }		
    }
       	public List<ArticleContent> Items { get; set; }

           
 	    protected DataTable dt=new DataTable();  //文章表
        protected DataTable dt1=new DataTable();
        protected DataTable dt2=new DataTable();  //文章和厂商相关表
        protected DataTable dt3=new DataTable();  //文章和产品相关表
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            string wz_id=Request["wz_id"];  //获取文章id
            SqlDataAdapter da = new SqlDataAdapter("select distinct 标题,作者,内容, wz_id from 文章表 where wz_id='"+wz_id+"'", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "文章表");        
            dt = ds.Tables[0];

            SqlDataAdapter da2 = new SqlDataAdapter("select 厂商名称,gys_id from 文章和厂商相关表 where wz_id='"+wz_id+"'", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "文章和厂商相关表");        
            dt2 = ds2.Tables[0];

            SqlDataAdapter da3 = new SqlDataAdapter("select 产品名称,cl_id from 文章和材料表相关表 where wz_id='"+wz_id+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "文章和材料表相关表");        
            dt3 = ds3.Tables[0];   


                            
            string strr="select 内容, wz_id from 文章表 where wz_id='"+wz_id+"' ";         
            SqlCommand cmd = new SqlCommand(strr, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                string str = dr.GetString(0);
                ArticleContent item = new ArticleContent();
                this.Items = new List<ArticleContent>();  //接收文章内容
                item.Content = OutputBySize(str) ; 
			
                this.Items.Add(item);
                //item.Text=m_strPageInfo ;              
            }
            conn.Close();
            //分页还未处理
        
        }
			
			
         public string OutputBySize(string p_strContent)//分页函数
        {
            string m_strRet = "";
            int m_intPageSize = 1500;//文章每页大小
            int m_intCurrentPage = 1;//设置第一页为初始页
            int m_intTotalPage = 0; //设置分页数
            int m_intArticlelength = p_strContent.Length;//文章长度
            if (m_intArticlelength > m_intPageSize)//如果每页大小大于文章长度时开始分页
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
                    {//处理不正常的地址栏的值
                        m_intCurrentPage = Convert.ToInt32(Request["ps"]);
                        if (m_intCurrentPage > m_intTotalPage)

                            m_intCurrentPage = m_intTotalPage;

                    }
                    catch
                    {
                        //m_intCurrentPage = m_intCurrentPage;
                    }
                }
                //set the page content 设置获取当前页的大小
                if (m_intCurrentPage < m_intTotalPage)
                {
                    m_intPageSize = m_intCurrentPage < m_intTotalPage ? m_intPageSize : (m_intArticlelength - m_intPageSize * (m_intCurrentPage - 1));
                    m_strRet += p_strContent.Substring(m_intPageSize * (m_intCurrentPage - 1), m_intPageSize); //点击超链接时分页内容长度
                }
                else if (m_intCurrentPage == m_intTotalPage)
                {
                    int mm_intPageSize = m_intArticlelength - m_intPageSize * (m_intCurrentPage - 1);//最后一页前的内容
                    m_strRet += p_strContent.Substring(m_intArticlelength - mm_intPageSize); //最后一页的内容
                }
                string wz_id = Request["wz_id"];  //获取文章id
                string m_strPageInfo = "";
                for (int i = 1; i <= m_intTotalPage; i++)
                {
                    if (i == m_intCurrentPage)
                        m_strPageInfo += "[" + i + "]";
                    else
                        m_strPageInfo += " <a href=?ps=" + i + "&wz_id="+wz_id+"  >[" + i + "]</a> ";

                }
                if (m_intCurrentPage > 1)
				    
                    m_strPageInfo = "<a href=?ps=" + (m_intCurrentPage - 1) + "&wz_id="+wz_id+" >上一页</a>" + m_strPageInfo;
                if (m_intCurrentPage < m_intTotalPage)
                    m_strPageInfo += "<a href=?ps=" + (m_intCurrentPage + 1) + "&wz_id="+wz_id+" >下一页</a>";
                //输出显示各个页码
                //this.ShowPageNumber.Text = "<p></p>" + m_strPageInfo;
                ArticleContent item = new ArticleContent();
                this.Items = new List<ArticleContent>();  //接收文章内容
                item.Text = m_strPageInfo ;    //接收文章分页页码
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
<div class="xwn1"><a href="index.aspx" class="p1">首页 ></a> 正文</div>
<div class="xwleft">

 <% foreach(System.Data.DataRow row in dt.Rows){%> 
<div class="xwleft1"><%=row["标题"].ToString() %></div>
<div class="xwleft2">作者：<%=row["作者"].ToString() %></div>

 <% foreach(var v in Items){%> 
<div class="xwleft3"><%=v.Content %></div> 
<%}%>
<%--<div class="xwleft3"><%=row["内容"].ToString() %></div>--%> 
<%}%>
</div>

<!-- 文章首页 结束-->




<!-- 相关厂商列表 开始-->

<div class="xwright">
<div class="xwright1">
  <ul>
   <%foreach(System.Data.DataRow row in dt2.Rows){%>
     <li><a href="scsxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["厂商名称"].ToString()%></a></li>
 <%}%>
   
  </ul>
</div>
<!-- 相关厂商列表 结束-->



<!-- 相关产品列表 开始-->
<div class="xwright1">
  <ul>
     <%foreach(System.Data.DataRow row in dt3.Rows){%>
     <li><a href="#"><%=row["产品名称"].ToString()%></a></li>
  <%}%>
   
  </ul>
</div>
</div>

</div>
<!-- 相关产品列表 结束-->


<!-- 文章页码开始 -->
<center>
<div>
 <% foreach(var v in Items){%> 
<div class="xwleft3"><%=v.Text %></div> 
<%}%>
</div>
</center>
<!-- 文章页码结束 -->



<!-- 关于我们 广告服务 开始-->
<!-- #include file="static/aboutus.aspx" -->
<!-- 关于我们 广告服务 结束-->



<!-- footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->




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
var speed=9//速度数值越大速度越慢
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