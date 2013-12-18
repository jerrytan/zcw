<!--
       供应商管理材料页面 可以删除选中的材料,可也增加新的材料
	   文件名:  gysglcl.aspx   
       传入参数：gys_id  
       
-->



<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

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
<title>供应商收藏页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<style>
 #menu { width:200px; margin:auto;}
 #menu h1 { font-size:12px;margin-top:1px; font-weight:100}
 #menu h2 { padding-left:15px; font-size:12px; font-weight:100}
 #menu ul { padding-left:15px; height:100px;overflow:auto; font-weight:100}
 #menu a { display:block; padding:5px 0 3px 10px; text-decoration:none; overflow:hidden;}
 #menu a:hover{ color:#000;}
 #menu .no {display:none;}
 #menu .h1 a{color:#000;}
 #menu .h2 a{color:#000;}
 #menu  h1 a{color:#000;}
</style>
<script language="JavaScript">
<!--    //
    function ShowMenu(obj, n) {
        var Nav = obj.parentNode;
        if (!Nav.id) {
            var BName = Nav.getElementsByTagName("ul");
            var HName = Nav.getElementsByTagName("h2");
            var t = 2;
        } else {
            var BName = document.getElementById(Nav.id).getElementsByTagName("span");
            var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
            var t = 1;
        }
        for (var i = 0; i < HName.length; i++) {
            HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
            HName[i].className = "";
        }
        obj.className = "h" + t;
        for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
        if (BName[n].className == "no") {
            BName[n].className = "";
            obj.innerHTML = obj.innerHTML.replace("+", "-");
        } else {
            BName[n].className = "no";
            obj.className = "";
            obj.innerHTML = obj.innerHTML.replace("-", "+");
        }
    }
//-->
</script>

    <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
         $(document).ready(function () {        
            //删除复选框被选中的材料
            $("#btnDeleteBatch").click(function () {
                var count = $(":checkbox.ck:checked").size();
                if (count == 0) {
                    window.alert("请选择删除的材料!");
                    return;
                }
                $(":checkbox.ck:checked").each(function () {  //遍历选中的复选框
				$(this).parent().parent()remove();
  
                    
                });
            });
        });  
          
            
		

     		
    </script>

</head>

<body>


<!-- 头部开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部结束-->


<script runat="server">

        public List<FLObject> Items { get; set; }  //存放材料编码和分类编码的集合
		public class FLObject
        { //属性
        public string ClCode { get; set; }  //分类编码
        public string ClName { get; set; }  //材料名
       		
        }

        protected DataTable dt = new DataTable(); //根据供应商id查询显示名,分类编码(材料表)
        protected DataTable dt1 = new DataTable(); //取二级分类显示名称(材料分类表)
		protected DataTable dt2 = new DataTable();  //具体材料名称(材料表)
		protected DataTable dt3 = new DataTable();  //材料一级分类名称(材料表)
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);            
			string gys_id = Request["gys_id"];
            SqlDataAdapter da = new SqlDataAdapter("select  显示名,分类编码 from 材料表 where gys_id='"+gys_id+"' ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料表");           
            dt = ds.Tables[0];
			
			////数据表DataTable转集合                  
            this.Items = new List<FLObject>();
			for(int x=0;x<dt.Rows.Count;x++)
            {
			    DataRow dr2 = dt.Rows[x]; 		      
			    FLObject item = new FLObject();
                item.ClName = Convert.ToString(dr2["显示名"]);
                item.ClCode = Convert.ToString(dr2["分类编码"]); //根据供应商id查询分类编码加入类的属性(分类编码长度为4位)
                this.Items.Add(item);              				 //加入集合
		    } 
			foreach(var v in this.Items)    //遍历集合
			{
			   if(v.ClCode.ToString()!=null&Convert.ToString(v.ClCode).Length==4)
			   {
			   string code = v.ClCode.ToString().Substring(0, 2);	//取分类编码前两位再次进行查询 最终获得一级分类的名字填充到表table3		
			   SqlDataAdapter da3 = new SqlDataAdapter("select  显示名字 from 材料分类表 where 分类编码='"+code+"' ", conn);
               DataSet ds3 = new DataSet();
               da3.Fill(ds3, "材料分类表");           
               dt3 = ds3.Tables[0];
			   }
			}
			
			//取二级分类名称
			SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字 from 材料分类表 where  分类编码 in(select 分类编码 from 材料表 where gys_id='"+gys_id+"' )", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表");            
            dt1 = ds1.Tables[0];
			//取具体材料名称
			SqlDataAdapter da2 = new SqlDataAdapter("select 显示名 from 材料表 where gys_id='"+gys_id+"' ", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料表");            
            dt2 = ds2.Tables[0];                      
		
        }

  
   
</script>




<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2"><div id="menu">

 <%foreach(System.Data.DataRow row in dt3.Rows){%>
 <h1 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /><%=row["显示名字"].ToString() %> &gt;</a></h1>
 <%}%>
 
 <span class="no"> 
 
  <%foreach(System.Data.DataRow row in dt1.Rows){%>
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ <%=row["显示名字"].ToString() %></a></a></h2>
  <%}%>
  
  <ul class="no">
  <%foreach(System.Data.DataRow row in dt2.Rows){%>
   <a href="javascript:void(0)"><%=row["显示名"].ToString() %><input type="checkbox" name="" id="checkbox" class="ck" /> 选中</a>
   <%}%>
  </ul>
  
 </span>
        
 <h1 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /> 一级菜单B &gt;</a></h1>
 <span class="no">
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ 二级菜单B_1</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">三级菜单B_0 <input type="checkbox" name="checkbox" id="checkbox" class="c"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_1 <input type="checkbox" name="checkbox" id="checkbox" class="c"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_2 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_3 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_4 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
  </ul>
  <h2 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)">+ 二级菜单B_2</a></h2>
  <ul class="no">
   <a href="javascript:void(0)">三级菜单B_0 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_1 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_2 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_3 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
   <a href="javascript:void(0)">三级菜单B_4 <input type="checkbox" name="checkbox" id="checkbox" class="ck"/> 选中</a>
  </ul>
 </span>
  
</div></div>
<div class="dlqqz3">
<%string gys_id=Request["gys_id"];%>
<a href="xzclym.aspx?gys_id=<%=gys_id%>"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;&nbsp;
<a id="btnDeleteBatch" onclick="" href="#"><img src="images/scxzcl.jpg" border="0" /></a></div>
</div>


<div class="dlex">
<div class="dlex1">全部导出为EXCEL（VIP显示为选择数据进入自身内部系统）</div>

</div>


<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->



<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix() {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
<script type="text/javascript">
    var speed = 9//速度数值越大速度越慢
    var demo = document.getElementById("demo");
    var demo2 = document.getElementById("demo2");
    var demo1 = document.getElementById("demo1");
    demo2.innerHTML = demo1.innerHTML
    function Marquee() {
        if (demo2.offsetWidth - demo.scrollLeft <= 0)
            demo.scrollLeft -= demo1.offsetWidth
        else {
            demo.scrollLeft++
        }
    }
    var MyMar = setInterval(Marquee, speed)
    demo.onmouseover = function () { clearInterval(MyMar) }
    demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
</script>
<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix() {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
</body>
</html>