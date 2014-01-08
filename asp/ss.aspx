<!--
           搜索页
           文件名为:ss.aspx
		   传入参数为: 搜索文本框中的值
-->

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
<title>搜索结果页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script runat="server">

          protected DataTable dt_clss = new DataTable();   //搜索的产品(材料表)   
          protected DataTable dt_cl_page = new DataTable();  //对搜索的材料进行分页
		  protected DataTable dt_clss_name = new DataTable();  //查询所有材料分类表中的显示名字,分类编码
		  
		  private const int Page_Size = 4; //每页的记录数量
		  private int current_page=1;
	      int pageCount_page;

          public class OptionItem //材料分页的 类 属性
          {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }
          }
       	  public List<OptionItem> Items { get; set; }  //材料分页集合
          protected void Page_Load(object sender, EventArgs e)
          {
		     string key_ss = Request["sou"];  //获取搜索文本框中的值
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr);
			 
			 SqlDataAdapter da_clss_name = new SqlDataAdapter("select  显示名字,分类编码 from 材料分类表 " , conn);
             DataSet ds_clss_name = new DataSet();
             da_clss_name.Fill(ds_clss_name, "材料表");
             dt_clss_name = ds_clss_name.Tables[0];
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
			 
             SqlDataAdapter da_clss = new SqlDataAdapter("select top 10 显示名,规格型号,cl_id ,访问计数 from 材料表 where 显示名 like '%"+key_ss+"%'order by 访问计数 desc" , conn);
             DataSet ds_clss = new DataSet();
             da_clss.Fill(ds_clss, "材料表");
             dt_clss = ds_clss.Tables[0];  


             //从查询字符串中获取"页号"参数
            string str_page = Request.QueryString["p"];
            if (string.IsNullOrEmpty(str_page))
            {//为空时默认为1
                str_page = "1";
            }
            int p;
            bool b1 = int.TryParse(str_page, out p);  //校验 地址栏不为数字 都强转为数字
            if (b1 == false)
            {
                p = 1;
            }
            current_page = p;
			
            //从查询字符串中获取"总页数"参数
            string str_Count = Request.QueryString["c"];
            if (string.IsNullOrEmpty(str_Count))
            {
                double recordCount = this.GetProductCount(); //获得总条数
                double d1 = recordCount / Page_Size; //13.4
                double d2 = Math.Ceiling(d1); //14.0
                int pageCount = (int)d2; //14                //取整
                str_Count = pageCount.ToString();
            }
            int c;
            bool b2 = int.TryParse(str_Count,out c);
            if (b2 == false)
            {
                c = 1;
            }
            pageCount_page = c;
			
            //计算/查询分页数据
            int begin = (p - 1) * Page_Size + 1;    //开始记录数 点击第二页时(若每页10) begin 为11条
            int end = p * Page_Size;                //结束的记录数
            dt_cl_page = this.GetProductFormDB(begin, end,key_ss);
            this.SetNavLink(p, c); 	

          }
              //从数据库获取记录的总数量
              private int GetProductCount()
              {
                    string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    string key_ss = Request["sou"];  //获取搜索文本框中的值
                    string sql = "select count(cl_Id) from 材料表 where 显示名 like '%"+key_ss+"%'";
                    SqlCommand cmd = new SqlCommand(sql);
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                      cmd.Connection = conn;
                      conn.Open();
                      object obj = cmd.ExecuteScalar();
                      conn.Close();
                      int count = (int)obj;
                      return count;
                    }
              }

              private DataTable GetProductFormDB(int begin, int end, string key_ss)
              {
                     string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;         
                     SqlCommand cmd = new SqlCommand("cl_ss_Paging");     //材料搜索分页存储过程
                     cmd.CommandType = CommandType.StoredProcedure;
                     cmd.Parameters.Add("@begin", SqlDbType.Int).Value = begin;            //开始页第一条记录
                     cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;                //开始页最后一条记录
			         cmd.Parameters.Add("@显示名", SqlDbType.VarChar,20).Value = key_ss; //传材料编码给材料表,执行存储过程

                     SqlDataAdapter sda = new SqlDataAdapter(cmd);        
                     using (SqlConnection conn = new SqlConnection(connString))
                     {
                          cmd.Connection = conn;
                          conn.Open();
                          sda.Fill(dt_cl_page);
                          conn.Close();
                     }
                     return dt_cl_page;
               }

               protected string cpPrev = "";
               protected string cpNext = "";
               protected string cpLast = "";       
               private void SetNavLink(int currentPage, int pageCount)
               {
                   //string path = Request.Path;         
                   cpPrev = currentPage != 1 ? string.Format("p={0}",currentPage - 1) : "";          //连超链接上一页
                   cpNext = currentPage != pageCount ? string.Format("p={0}",currentPage + 1) : "";  //连超链接下一页
                   cpLast = currentPage != pageCount ? string.Format("p={0}",pageCount) : "";         //连超链接尾页
           
                   this.Items = new List<OptionItem>();
                   for (int i = 1; i <= pageCount; i++)  //下拉列表循环总得页数
                   {               
                       OptionItem item = new OptionItem();
                       item.Text = i.ToString();                          
                       item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                       item.Value = string.Format("ss.aspx?p={0}", i);                
                       this.Items.Add(item);
                   }
      
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
<div class="ppxz1">品牌：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">品牌1</a> <a href="#">品牌2</a> <a href="#">品牌3</a></div></div>
<div class="ppxz">
<div class="ppxz1">区域：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">朝阳区</a> <a href="#">海淀区</a> <a href="#">丰台区</a></div></div>
<div class="ppxz">
<div class="ppxz1">材料：</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">材料1</a> <a href="#">材料2</a> <a href="#">材料3</a></div></div>
<div class="ppxz">
<div class="ppxz1">更多：</div><div class="ppxz2"></a> <a href="#">属性1</a> <a href="#">属性2</a> <a href="#">属性3</a></div></div>

<div class="dlspx"><span class="dlspx1">排序：</span><span class="dlspx2"><a href="#">默认</a></span><span class="dlspx3"><a href="#">人气</a><img src="images/qweqw_03.jpg" /></span>
<span class="dlspx3"><a href="#">最新</a><img src="images/qweqw_03.jpg" /></span> <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /><a href="#">全选</a></span>
<span class="dlspx4"><a href="#">请收藏，便于查找</a></span>
</div>
</div>


<div class="dlspxl"> 

    <%foreach(System.Data.DataRow row in this.dt_cl_page.Rows){%>
    <div class="dlspxt">
    <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
     <%
					string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection con = new SqlConnection(connString);
                    SqlCommand cmd = new SqlCommand("select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                        +row["cl_id"]+"' and 大小='小'", con);

                    String imgsrc= "images/222_03.jpg";
                    using (con)
                    {
                         con.Open();
                         Object result = cmd.ExecuteScalar();
                         if (result != null) 
						 {
                             imgsrc = result.ToString();
                         }
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
    </a>
    <div class="dlspxt1">
    <span class="dlsl"><%=row["显示名"].ToString()%></span>  
    <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> 收藏</span> 
    <span class="dlsgg"><%=row["规格型号"].ToString()%></span> </div></div>
  <%}%>





<div class="fy2">
<div class="fy3">
                <%string key_ss = Request["sou"];  //获取搜索文本框中的值 %>
                <% if(current_page!=1) { %>
                <a href="ss.aspx?<%=cpPrev %>&sou=<%=key_ss%>" class="p">上一页</a>
                <% } %>
                <a href="ss.aspx?p=1&sou=<%=key_ss%>" class="p">1</a>
                <% if(current_page>1) { %>
                <a href="ss.aspx?p=2&sou=<%=key_ss%>" class="p">2</a>
                <% } %>
                <% if(current_page>2) { %>
                <a href="ss.aspx?p=3&sou=<%=key_ss%>" class="p">3···</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="ss.aspx?<%=cpNext %>&sou=<%=key_ss%>" class="p">下一页</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="ss.aspx?<%=cpLast %>&sou=<%=key_ss%>" class="p">尾页</a>
                <% } %>
				
直接到第 
         <select onchange="window.location=this.value" name="" class="p">
         <% foreach (var v in this.Items)  { %>
         <option value="<%=v.Value %>&sou=<%=key_ss%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>     
页</div></div>
</div>


<!-- 最受欢迎的这种材料-->
<div class="pxright0">
<div class="pxright">
<div class="pxright1">
<ul>

   <%foreach(System.Data.DataRow row in this.dt_clss.Rows){%>
   <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString()%></a></li>
   <%}%>

</ul>

</div> </div>
<div class="pxright2"><a href="#"><img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
</div>


</div>



<div>
<!-- 关于我们 广告服务 投诉建议 开始-->
<!-- #include file="static/aboutus.aspx" -->
<!-- 关于我们 广告服务 投诉建议 结束-->
</div>

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->




</div>


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
</body>
</html>
