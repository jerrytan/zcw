<!--      
	   管理生产商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glscsxx.aspx 
       传入参数：无    
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
   <script type="text/javascript" language="javascript">
       $(document).ready(function () {
           $("#ckAll").click(function () {
               var v = $(this).attr("checked");  //获取"全选复选框"是否被选中的值                 
               $(":checkbox.fxsfxk").attr("checked", v); //设置class=ck的复选框是否被选中
           });
           $(":checkbox.fxsfxk").click(function () {
               var a = $(":checkbox.fxsfxk").size(); //获取所有的class=ck的复选框数量                
               var b = $(":checkbox.fxsfxk:checked").size();
               var c = a == b;
               $("#ckAll").attr("checked", c);
           });

           //根据选择地复选框批量删除
           $("#btnDeleteBatch").click(function () {
               var count = $(":checkbox.fxsfxk:checked").size();
               if (count == 0) {
                   window.alert("请选择删除的品牌!");
                   return;
               }


               $(":checkbox.fxsfxk:checked").each(function () {
                   var tr = $(this).parent().parent();
                   $(tr).remove();


                   $("#btnDeleteBatch").val("0"); //设置值
                   var str = $("#btnDeleteBatch").val(); //获取值
                   //var data = { "str": str };
                   //window.alert(str);

                   // $.post("glsccsxxym.aspx/GetArray", str, function (answer) //ajax  没成功
                   //{
                   // if (answer == "ok") 
                   //{
                   //window.alert("修改删除成功!");
                   // }
                   //}, "json");
               });
           });
       });  
          
   
        		
   </script>
</head>


<script runat="server" >

        public class ScsInformotion
        {
            public string ScsName { get; set; }  //属性 供应商名字
            public string GysCode { get; set; }   //属性 供应商Id           
        }
        public List<ScsInformotion> Items { get; set; }
        protected DataTable dt = new DataTable();  //分销商信息(材料供应商信息表)

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			string gys_id = Request["gys_id"];
            String yh_id = Convert.ToString(Session["yh_id"]);
			if (Request.Form["companyname"] != null)
            {
                conn.Open();				
                string companyname = Request["companyname"];
                string address = Request["address"];
                string tel = Request.Form["tel"];
                string homepage = Request.Form["homepage"];
                string fax = Request["fax"];
                string area = Request["area"];
                string description = Request.Form["description"];
                string name = Request.Form["name"];
                string phone = Request.Form["phone"];                
                string sql = "update  材料供应商信息表 set 供应商='" + companyname + "',地址='" + address + "',电话='" + tel + "',主页='" + homepage + "',传真='" + fax + "',地区名称='" + area + "',联系人='" + name + "',联系人手机='" + phone + "' where gys_id='"+gys_id+"' ";
                SqlCommand cmd2 = new SqlCommand(sql, conn);
                int ret = (int)cmd2.ExecuteNonQuery();
                conn.Close();

            }
            string str = "select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机 from 材料供应商信息表 where  yh_id='"+yh_id+"' ";
            SqlCommand cmd1 = new SqlCommand(str, conn);
            conn.Open();
			SqlDataReader reader1 = cmd1.ExecuteReader();
            while (reader1.Read())
            {
                this.companyname.Value = reader1["供应商"].ToString();
                this.address.Value = reader1["地址"].ToString();
                this.tel.Value = reader1["电话"].ToString();
                this.homepage.Value = reader1["主页"].ToString();
                this.fax.Value = reader1["传真"].ToString();
                this.area.Value = reader1["地区名称"].ToString();
                this.name.Value = reader1["联系人"].ToString();
                this.phone.Value = reader1["联系人手机"].ToString();

            }
            conn.Close();
							
			SqlDataAdapter adapter = new SqlDataAdapter("select 品牌名称,scs_id from 品牌字典 where 是否启用='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "品牌字典");
            dt = ds.Tables[0];       
			return;
          
           
             
            
        }

        protected string CsharpVoid1(string str) //删除 发送ajax调用方法 待处理
        {
		    string str1 = str ;
			
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);      			
            conn.Open();			
			string sql2 = "update  品牌字典 set 是否启用='0' where  pp_id='"+str1+"' ";
           
            SqlCommand cmd3 = new SqlCommand(sql2, conn);
            int ret = (int)cmd3.ExecuteNonQuery();			
            str = "你好,修改成功!" ;
			return str;
        }
		
	
</script>

<body>

<!-- 头部开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部结束-->


<%string gys_id = Request["gys_id"];%>
<form id="login" name="login" action="glscsxx.aspx?gys_id=<%=gys_id%>" method="post">
<div class="fxsxx">
<span class="fxsxx1">贵公司的详细信息如下</span>

<div class="fxsxx2">
 <dl>
       <dd>贵公司名称：</dd>
    <dt><input runat="server" name="companyname" type="text" id="companyname" class="fxsxx3"  /></dt>
     <dd>贵公司地址：</dd>
    <dt><input runat="server" name="address" type="text" id="address" class="fxsxx3" /></dt>
     <dd>贵公司电话：</dd>
    <dt><input runat="server" name="tel" type="text" id="tel" class="fxsxx3" /></dt>
     <dd>贵公司主页：</dd>
    <dt><input runat="server" name="homepage" type="text" id="homepage" class="fxsxx3" /></dt>
     <dd>贵公司传真：</dd>
    <dt><input runat="server" name="fax" type="text" id="fax" class="fxsxx3" /></dt>
     <dd>贵公司地区：</dd>
    <dt><input runat="server" name="area" type="text" id="area" class="fxsxx3" /></dt>           
     <dd>贵公司简介：</dd>
    <dt><textarea name="description" cols="" rows="" class="fgsjj" value="<%=Request.Form["description"] %>"></textarea></dt>
	
	
	<!--
     <dd>贵公司logo：</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>贵公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
    
    -->



	<dd>联系人姓名：</dd>
    <dt><input runat="server" name="name" type="text" id="name" class="fxsxx3" /></dt>
     <dd>联系人电话：</dd>
    <dt><input runat="server" name="phone" type="text" id="phone" class="fxsxx3" /></dt>

    
 </dl>
<span  class="fxsbc"><a href="#"><input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg" ></a></span>

<div class="ggspp">
<span class="ggspp1">贵公司品牌如下</span>
   <div><span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" id="ckAll" />全选</span></div>
		
		<% foreach (System.Data.DataRow row in dt.Rows){%> 
           <div class="fgstp"><img src="images/wwwq_03.jpg" /> 
           <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" /><%=row["品牌名称"].ToString() %></span></div>

<%} %>
        
</div> 
</div>
</div>
</form>

</div>

	  <a runat="server" id="btnDeleteBatch" onclick="GetArray(124)" href="#">删除选中品牌</a>
	  
      <span class="ggspp1" ><a href="xzpp.aspx?gys_id=61"  style="color:Red">增加品牌</a></span>


<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->




</div>



</body>
</html>
