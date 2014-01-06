<!--
       供应商管理材料页面 可以删除选中的材料,可也增加新的材料
	   文件名:  gysglcl.aspx   
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

          public List<FLObject_yj> Items1 { get; set; }
          public List<FLObject_ej> Items2 { get; set; }
          public List<CLObject> Cllist { get; set; }
		  
		  public class CLObject
          { //属性
  	        public string Cl_flbm { get; set; }  //分类编码(4位)
            public string Cl_Name { get; set; }  //具体的材料名称 
            public string Cl_id { get; set; }
          }
		  
		  public class FLObject_yj
          {  //属性
  	         public string flbm { get; set; }
             public string YJfl_name { get; set; }             
          }
		  
		  public class FLObject_ej
          { //属性
  	         public string Ej_flbm { get; set; }   
             public string Ejfl_Name { get; set; }     
          }
  
          

        protected DataTable dt_cl = new DataTable();    //根据供应商id查询显示名,分类编码(材料表)
        protected DataTable dt_yjfl = new DataTable();  //取一级分类显示名称(材料分类表)
		protected DataTable dt_ejfl = new DataTable();  //取二级分类显示名称(材料分类表)
		
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);            
			//string gys_id = Request["gys_id"];
			string gys_id = "134";
            SqlDataAdapter da_cl = new SqlDataAdapter("select cl_id,显示名,分类编码 from 材料表 where gys_id='"+gys_id+"' ", conn);
            DataSet ds_cl = new DataSet();
            da_cl.Fill(ds_cl, "材料表");           
            dt_cl = ds_cl.Tables[0];
			
			////数据表DataTable转集合                   
            this.Cllist = new List<CLObject>();
			for(int x=0;x<dt_cl.Rows.Count;x++)
            {
			    DataRow dr2 = dt_cl.Rows[x]; 		      
			    CLObject item = new CLObject();
                item.Cl_Name = Convert.ToString(dr2["显示名"]);   //具体的材料名字
                item.Cl_flbm = Convert.ToString(dr2["分类编码"]); //根据供应商id查询分类编码加入类的属性(分类编码长度为4位)
				item.Cl_id = Convert.ToString(dr2["Cl_id"]);
                this.Cllist.Add(item);              				 //加入集合
		    } 
			foreach(var v in this.Cllist)    //遍历集合
			{
			   if(v.Cl_flbm.ToString()!=null&Convert.ToString(v.Cl_flbm).Length==4)
			   {
			   string code = v.Cl_flbm.ToString().Substring(0, 2);	//取分类编码前两位再次进行查询 最终获得一级分类的名字填充到表table3		
			   SqlDataAdapter da_yjfl = new SqlDataAdapter("select  显示名字 from 材料分类表 where 分类编码='"+code+"' ", conn);
               DataSet ds_yjfl = new DataSet();
               da_yjfl.Fill(ds_yjfl, "材料分类表");           
               dt_yjfl = ds_yjfl.Tables[0];
			   }
			}
			this.Items1 = new List<FLObject_yj>();
			for(int x=0;x<dt_yjfl.Rows.Count;x++)
            {
			    DataRow dr = dt_yjfl.Rows[x]; 		      
			    FLObject_yj item = new FLObject_yj();
                item.YJfl_name = Convert.ToString(dr["显示名字"]);   //一级分类名称                
                this.Items1.Add(item);              				 //加入集合
		    } 
			
			//取二级分类名称
			SqlDataAdapter da_ejfl = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where  分类编码 in(select 分类编码 from 材料表 where gys_id='"+gys_id+"' )", conn);
            DataSet ds_ejfl = new DataSet();
            da_ejfl.Fill(ds_ejfl, "材料分类表");            
            dt_ejfl = ds_ejfl.Tables[0];
			
			this.Items2 = new List<FLObject_ej>();
			for(int x=0;x<dt_ejfl.Rows.Count;x++)
            {
			    DataRow dr = dt_ejfl.Rows[x]; 		      
			    FLObject_ej item = new FLObject_ej();
                item.Ejfl_Name = Convert.ToString(dr["显示名字"]);   //二级分类名称 
                item.Ej_flbm = Convert.ToString(dr["分类编码"]);     //二级分类编码 				
                this.Items2.Add(item);              				 //加入集合
		    }		                    
		
        }

  
   
</script>




<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2">
<div id="menu">

 <% 
 	   int firstlevel = 0;
     foreach (var menu1 in this.Items1){
                    %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
                        <img src="images/biao2.jpg" /><%=menu1.YJfl_name%> &gt;</a></h1>
                    <span class="no">
                        <% 
 	    int secondlevel = 0;
 		  foreach (var menu2 in this.Items2){
 	   	  
                        %>
                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=menu2.Ejfl_Name%></a></h2>
                        <ul class="no">
                          <!--  	
                            protected DataTable dt_cls = new DataTable(); 							
							string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                            SqlConnection conn = new SqlConnection(constr);            
			                //string gys_id = Request["gys_id"];
			                string gys_id = "134";
                            SqlDataAdapter da_cls = new SqlDataAdapter("select cl_id,显示名,分类编码 from 材料表 where gys_id='134' ", conn);
                            DataSet ds_cls = new DataSet();
                            da_cls.Fill(ds_cls, "材料表");           
                            dt_cls = ds_cls.Tables[0];
							
							-->
							<%
                            foreach (var me in this.Cllist){
      	        
                            %>
                            <a href="javascript:void(0)"><input type="checkbox" name="clid" value="" />选中</a>
                            <% 	
   			    
   		    }
   		    secondlevel++;
                            %>
                        </ul>
                        <% 	
         
  	}
                        %>
                    </span>
                    <% 
 		firstlevel++;
   } 
                    %>

        
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
<a href="xzclym.aspx"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;&nbsp;
<a id="btnDeleteBatch" onclick="" href="#"><img src="images/scxzcl.jpg" border="0" /></a></div>
</div>


<div class="dlex">
<div class="dlex1">全部导出为EXCEL（VIP显示为选择数据进入自身内部系统）</div>

</div>


<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->



</body>
</html>