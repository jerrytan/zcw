<!--  
	    管理分销商信息页面   对分销商信息进行修改保存 增加新的分销商
        文件名：glfxsxx2.aspx
        传入参数：gys_id    
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
<title>分销商信息页</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

             
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			string gys_id = Request["gys_id"];          
			if (Request.Form["companyname"] != null)  //修改后写入
            {
                conn.Open();
                string companyname = Request["companyname"];   //公司名字
                string address = Request["address"];            //地址
                string tel = Request.Form["tel"];               //电话
                string homepage = Request.Form["homepage"];     //主页
                string fax = Request["fax"];                    //传真              
                string description = Request.Form["description"];  //公司简介
                string name = Request.Form["name"];                //联系人
                string phone = Request.Form["phone"];              //联系人手机
                
                if (gys_id != "")
                {
                    string sql = "update  材料供应商信息表 set 供应商='" + companyname + "',地址='" + address + "',电话='" + tel + "',主页='" + homepage + "',传真='" + fax + "',联系人='" + name + "',联系人手机='" + phone + "' where gys_id in (select fxs_id from 分销商和品牌对应关系表 where  pp_id  in (select   pp_id from 材料供应商信息从表 where gys_id='"+gys_id+"')) ";
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				if (gys_id == "")
				{
                string sql1 = "insert into  材料供应商信息表( 供应商,地址,电话,主页,传真,联系人,联系人手机,单位类型) values('" + companyname + "','" + address + "','" + tel + "','" + homepage + "','" + fax + "','" + name + "','" + phone + "','分销商' )  ";
                SqlCommand cmd3 = new SqlCommand(sql1, conn);
                int ret1 = (int)cmd3.ExecuteNonQuery();
				//会插入两条数据,错原因int ret2 = (int)cmd3.ExecuteNonQuery();  还执行cmd3
                string sql2 = "update 材料供应商信息表 set gys_id=(select myId from 材料供应商信息表 where 供应商='"+companyname+" ') where 供应商='"+companyname+" '";               
				SqlCommand cmd4 = new SqlCommand(sql2, conn);
                int ret2 = (int)cmd4.ExecuteNonQuery();
                
                }
				conn.Close();
            }

            //下拉框 供应商名字和供应商id
            SqlDataAdapter da = new SqlDataAdapter("select 供应商,gys_id,dq_id from 材料供应商信息表 where gys_id in (select fxs_id from 分销商和品牌对应关系表 where  pp_id  in (select   pp_id from 材料供应商信息从表 where gys_id='"+gys_id+"'))  ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料供应商信息表");
            dt = ds.Tables[0];
            this.Items = new List<ScsInformotion>();
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];
                ScsInformotion item = new ScsInformotion();
                item.ScsName = Convert.ToString(dr["供应商"]);
                item.GysCode = Convert.ToString(dr["gys_id"]);
				item.Dq_id = Convert.ToString(dr["dq_id"]);
                this.Items.Add(item);  //把供应商名字和供应商id 和地区id加入集合
            }
			
			SqlDataAdapter da1 = new SqlDataAdapter("select 品牌名称 from 品牌字典 where  pp_id  in (select   pp_id from 材料供应商信息从表 where gys_id='67') ", conn); //分销商代理的品牌 调试用
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "品牌字典");
            dt1 = ds1.Tables[0];
			
			//获取下拉框传过来的参数供应商id
            string strP = Request.QueryString["bm"];
            
            SqlDataAdapter da2 = new SqlDataAdapter("select distinct 所属区域名称,所属区域编号 from 地区地域字典" , conn); //分销商所在区域信息
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "地区地域字典");
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select distinct 省市地区名称,所属区域编号 from 地区地域字典 where LEN(省市地区编号)='2'" , conn); //分销商所在省市
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "地区地域字典");
            dt3 = ds3.Tables[0];
			
			SqlDataAdapter da4 = new SqlDataAdapter("select distinct 省市地区名称,省市地区编号 from 地区地域字典 where LEN(省市地区编号)='4'" , conn); //分销商所在省市
            DataSet ds4 = new DataSet();
            da4.Fill(ds4, "地区地域字典");
            dt4 = ds4.Tables[0];
			
			this.Selects1 = new List<DqInformotion>();
			this.Selects2 = new List<DqInformotion>();
			this.Selects3 = new List<DqInformotion>();
            for (int x = 0; x < dt2.Rows.Count; x++)
            {			   
                DataRow dr = dt2.Rows[x];
                DqInformotion item = new DqInformotion();
                item.DqName = Convert.ToString(dr["所属区域名称"]);               
                this.Selects1.Add(item);  //把所属区域名称加入集合
				
               
            }
			 for (int x = 0; x < dt3.Rows.Count; x++)
             {	                  
				  DataRow dr1 = dt3.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["省市地区名称"]);               
                  this.Selects2.Add(item1);  //把所属省分入集合				
             }
			for (int x = 0; x < dt4.Rows.Count; x++)
             {	                  
				  DataRow dr1 = dt4.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["省市地区名称"]);               
                  this.Selects3.Add(item1);  //把所属省分入集合				
             }
			
			
           
			if(strP!=null)
			{
			SqlDataAdapter da5 = new SqlDataAdapter("select 省市地区名称,所属区域名称,所属区域编号,省市地区编号 from 地区地域字典 where dq_id in(select dq_id from 材料供应商信息表 where gys_id='"+strP+"') ", conn); //分销商所在区域信息
            DataSet ds5 = new DataSet();
            da5.Fill(ds5, "地区地域字典");
            dt5 = ds5.Tables[0];
			this.Selects1 = new List<DqInformotion>();
			this.Selects2 = new List<DqInformotion>();
			this.Selects3 = new List<DqInformotion>();
            for (int x = 0; x < dt5.Rows.Count; x++)
            {			   
                DataRow dr = dt5.Rows[x];
                DqInformotion item = new DqInformotion();
                item.DqName = Convert.ToString(dr["所属区域名称"]);               
                this.Selects1.Add(item);  //把所属区域名称加入集合
				
               if(Convert.ToString(dr["省市地区编号"]).Length ==2)
			    {
				  DataRow dr1 = dt5.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["省市地区名称"]);               
                  this.Selects2.Add(item1);  //把所属省分入集合
				}
				if(Convert.ToString(dr["省市地区编号"]).Length ==4)
				 {
				  DataRow dr2 = dt5.Rows[x];
                  DqInformotion item2 = new DqInformotion();
                  item2.DqName = Convert.ToString(dr2["省市地区名称"]);               
                  this.Selects3.Add(item2);  //把所属地级市加入集合
				 }
           }
           }
            
            if (strP == null )  //根据传过来的供应商id进行查询分销商信息
            {
                string strr = "select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机 from 材料供应商信息表  where gys_id in (select fxs_id from 分销商和品牌对应关系表 where  pp_id  in (select   pp_id from 材料供应商信息从表 where gys_id='"+gys_id+"')) ";
                SqlCommand cmd = new SqlCommand(strr, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    this.companyname.Value = reader["供应商"].ToString();
                    this.address.Value = reader["地址"].ToString();
                    this.tel.Value = reader["电话"].ToString();
                    this.homepage.Value = reader["主页"].ToString();
                    this.fax.Value = reader["传真"].ToString();
                    this.name.Value = reader["联系人"].ToString();
                    this.phone.Value = reader["联系人手机"].ToString();
                }
                conn.Close();
            }
            if (strP != null) 
            {
                string str = "select 供应商,gys_id,dq_id from 材料供应商信息表 where gys_id in (select fxs_id from 分销商和品牌对应关系表 where  pp_id  in (select   pp_id from 材料供应商信息从表 where gys_id='"+strP+"')) ";
                SqlCommand cmd1 = new SqlCommand(str, conn);
                conn.Open();
                SqlDataReader reader1 = cmd1.ExecuteReader();
                while (reader1.Read())  //读取
                {                  
                    this.companyname.Value = reader1["供应商"].ToString();   //value对应的是表单中id的属性  
                    this.address.Value = reader1["地址"].ToString();
                    this.tel.Value = reader1["电话"].ToString();
					this.homepage.Value = reader1["主页"].ToString();
					this.fax.Value = reader1["传真"].ToString();					
					this.name.Value = reader1["联系人"].ToString();
					this.phone.Value = reader1["联系人手机"].ToString();
                }
                conn.Close();
            }
            
        }
    </script>

<body>

<!-- 头部开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部结束-->

<%string gys_id = Request["gys_id"];%>
<form id="login" name="login" action="glfxsxx.aspx?gys_id=<%=gys_id%>" method="post">

<div class="fxsxx">
<span class="fxsxx1">贵公司的分销信息如下</span>
<div class="zjgxs">
 
<select name=""  id="selectbox" class="fug"  onchange="javascript:location.href='glfxsxx.aspx?bm='+this.value">
<%foreach (var v in this.Items)
  { %>
<option name="" onclick="TextSelect()" id=""  value="<%=v.GysCode%>"><%=v.ScsName%></option>
<%} %>
</select>


<span class="zjgxs1"><a onclick="ClearAllTextBox()"  href="glfxsxx.aspx">增加新的供销商</a></span></div>
<div class="fxsxx2">
 <dl>
    <dd>公司名称：</dd>
    <dt><input runat="server" name="companyname" id="companyname" type="text" class="fxsxx3"/></dt>
     <dd>公司地址：</dd>
    <dt><input runat="server" name="address" id="address" type="text" class="fxsxx3"/></dt>
     <dd>公司电话：</dd>
    <dt><input runat="server" name="tel" id="tel" type="text" class="fxsxx3"/></dt>
     <dd>公司主页：</dd>
    <dt><input runat="server" name="homepage" id="homepage" type="text" class="fxsxx3"/></dt>
     <dd>公司传真：</dd>
    <dt><input runat="server" name="fax" id="fax" type="text" class="fxsxx3"/></dt>
	
	
    <dd>分销区域：</dd>
    <dt><div class="fxs1">
	<select name="" class="fu1">
	<%foreach (var v in this.Selects1) { %>
    <option><%=v.DqName%></option>
    <%} %>	
	</select> 
	
	<select name="" class="fu2">	
	<%foreach (var v in this.Selects2) { %>
    <option><%=v.DqName%></option>
    <%} %>
	</select>
	省（市）
	
    <select name="" class="fu3">
	<%foreach (var v in this.Selects3) { %>
    <option><%=v.DqName%></option>
    <%} %>
	</select>
	地区
	<select name="" class="fu4"><option>市区</option></select> 区（县） 
	</div></dt>
     
	 
	 
	 <dd>代理品牌：</dd>
    <dt>
	<%foreach(System.Data.DataRow row in dt1.Rows){%>
	<span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" /><%=row["品牌名称"].ToString() %></span>
     <%}%>
	</dt>
		
		
     <dd>公司简介：</dd>
    <dt><textarea name="" cols="" rows="" class="fgsjj"></textarea></dt>
	
	
	
	<!--
     <dd>公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     -->
	 
	 
	 
	 <dd>联系人姓名：</dd>
    <dt><input runat="server" name="name" id="name" type="text" class="fxsxx3"/></dt>
     <dd>联系人电话：</dd>
    <dt><input runat="server" name="phone" id="phone" type="text" class="fxsxx3"/></dt>
    
 </dl>

<span class="fxsbc"><a href="#"><input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg" ></a></span></div>
</div>
</div>
</form>



<!--  footer 开始-->
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
</body>
</html>
