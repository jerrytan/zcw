<!--
          
       供应商新增材料页面	   
       文件名：czclym.aspx 
       传入参数:无	 (应该要传入供应商id)  
	   
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
    <title>新增材料页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //一级分类发送ajax 更新的是小类的名称 文件名是:xzclym2.aspx
    function updateFL(id) 
	{

        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }
	
	
       //二级分类发送ajax 更新的是品牌的名称 和材料属性的名称
	   //文件名是xzclym3.aspx 和 xzclymSX.aspx
      function updateCLFL(id) 
	{

        var xmlhttp;
		var xmlhttp1;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
			xmlhttp1 = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;
			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
		
		
        xmlhttp1.open("GET", "xzclymSX.aspx?id=" + id, true);
        xmlhttp1.send();
		xmlhttp1.onreadystatechange = function () {
            
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                
               	//document.getElementById("sx_name").innerHTML = xmlhttp1.responseText;				
		
				
				var array = new Array();           //声明数组
		 		array = xmlhttp1.responseText;     //接收返回的json字符串
				
		        var json = array;
                var myobj=eval(json);              //将返回的JSON字符串转成JavaScript对象 
				
				
				
                for(var i=0;i<myobj.length;i++){  //遍历			
			
				 var json= document.getElementById('sx_names');
                 json.options.add(new Option(myobj[i].SX_name, myobj[i].SX_id));  //下拉框显示属性名称

                 var json_code= document.getElementById('sx_codes');     //下拉框显示属性编码
                 json_code.options.add(new Option(myobj[i].SX_code,myobj[i].SX_code));	

                 var json_id= document.getElementById('sx_id');       //下拉框显示属性id
                 json_id.options.add(new Option(myobj[i].SX_id,myobj[i].SX_id));				 
				
               
                }       
		
              } 	

           }
        }
              
    
	
	
	//属性名称ajax 更新的是属性值 文件名是:xzclymSX2.aspx
	//更新的是规格型号 文件名是:xzclymSX3.aspx  (规格型号应该是文本框才合理)
    function update_clsx(id) 
	{
	    
        var xmlhttp1;
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
			xmlhttp1 = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        
        xmlhttp.open("GET", "xzclymSX2.aspx?id=" + id, true);
        xmlhttp.send();
		xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                //document.getElementById("cl_value").innerHTML = xmlhttp.responseText;
				
				var array = new Array();           //声明数组
		 		array = xmlhttp.responseText;     //接收替换返回的json字符串
				
		        var json = array;
                var myobj=eval(json);              //将返回的JSON字符串转成JavaScript对象 			
				
				
                for(var i=0;i<myobj.length;i++){  //遍历			
			
				 var json= document.getElementById('cl_value');
                 json.options.add(new Option(myobj[i].SXZ_name,myobj[i].SXZ_name));  //下拉框显示属性值

                 var json_code= document.getElementById('cl_number');     //下拉框显示属性编号
                 json_code.options.add(new Option(myobj[i].SXZ_code,myobj[i].SXZ_code));	

                 var json_id= document.getElementById('cl_ids');       //下拉框显示属性值id
                 json_id.options.add(new Option(myobj[i].SXZ_id,myobj[i].SXZ_id));				 
				
               
                }  
            }
        }
		
		 xmlhttp1.open("GET", "xzclymSX3.aspx?id=" + id, true);
        xmlhttp1.send();
		xmlhttp1.onreadystatechange = function () {
            
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                
				var ggxh_value = xmlhttp1.responseText;
				
               	document.getElementById("cl_type").value = ggxh_value;
            }
        }
              
    }
            
		

			

</script>


<script runat="server">  
        
    public List<OptionItem> Items1 { get; set; }    
    public class OptionItem
    {
        public string Name { get; set; }  //下拉列表显示名属性
        public string GroupsCode { get; set; }  //下拉列表分类编码属性
      

    }
    protected DataTable dt_clfl = new DataTable();  //材料分类大类    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
        SqlDataAdapter da_clfl = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'", conn);
        DataSet ds_clfl = new DataSet();
        da_clfl.Fill(ds_clfl, "材料分类表");
        dt_clfl = ds_clfl.Tables[0];     
      

        this.Items1 = new List<OptionItem>();  //数据表DataTable转集合  
        
        for (int x = 0; x < dt_clfl.Rows.Count; x++)
        {
            DataRow dr = dt_clfl.Rows[x];

            if (Convert.ToString(dr["分类编码"]).Length == 2)
            {
                OptionItem item = new OptionItem();
                item.Name = Convert.ToString(dr["显示名字"]);
                item.GroupsCode = Convert.ToString(dr["分类编码"]);
                this.Items1.Add(item);   //将大类存入集合
            }
        }    

    }				
 
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <div class="fxsxx">
        <span class="fxsxx1">请选择您要添加的材料信息</span>
        <%string gys_id = Request["gys_id"];%>
          <form action="xzclym4.aspx?gys_id=134" method="post" >

            <div class="xz1">
                <div class="xza">

                    <span class="xz2"><a href="#">大类</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                        <% foreach(var v  in Items1){%>
                        <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>
                <div class="xza">
                    <span class="xz2"><a href="#">小类</a></span>
                    <select id="ejflname" name="ejflname" class="fux"  onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
                        
                        <option value="0">请选择小类</option>
                    
                    </select>
                </div>


                <div class="xzz">
                    <span class="xzz0">如果没有适合的小类，请联系网站管理员增加！ 联系方式是xxx@xxx.com.请使用模板。 </span>
                    <span class="xzz1"><a href="#">模板下载地址</a></span>
                </div>
            </div>

            <div class="fxsxx2">
                <span class="srcl">请输入材料信息</span>
                <dl>
                    <dd>材料名字：</dd>
                    <dt>
                        <input name="cl_name" type="text" class="fxsxx3" value="<%=Request.Form["cl_name"] %>" /></dt>

                    <dd>品    牌：</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px">
                            
                            <option value="0">请选择品牌</option>
                           
                        </select></dt>

                    <dd>属性名称：</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" onchange="update_clsx(this.options[this.options.selectedIndex].value)">
                                                                       
                            <option value="0">请选择属性名称</option>
						
                        </select></dt>
						
						<dd>属性编码：</dd>
                    <dt>
                        <select name="sx_codes" id="sx_codes" style="width: 300px" >
                                                                       
                            <option value="0">请选择属性编码</option>
						
                        </select></dt>
						
						<dd>属性id：</dd>
                    <dt>
                        <select name="sx_id" id="sx_id" style="width: 300px" >
                                                                       
                            <option value="0">属性id</option>
						
                        </select></dt>
						
						
                    <dd>属性值：</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <option value="0">请选择属性值</option>
                           
                        </select></dt>
						
					<dd>属性值编号：</dd>
                    <dt>
                        <select name="cl_number" id="cl_number" style="width: 300px"  >
                            
                            <option value="0">编号</option>
                           
                        </select></dt>
						
					<dd>属性值ID号：</dd>
                    <dt>
                        <select name="cl_ids" id="cl_ids" style="width: 300px"  >
                            
                            <option value="0">属性值id</option>
                           
                        </select></dt>
						
					<dd>规格型号：</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=Request.Form["cl_type"] %>" /></dt>					
						
                    <dd>计量单位：</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=Request.Form["cl_bit"] %>" /></dt>
                    <dd>单位体积：</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=Request.Form["cl_volumetric"] %>" /></dt>
				    <dd>单位重量：</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=Request.Form["cl_height"] %>" /></dt>
                    <dd>说明：</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></dt>
                </dl>
            </div>


            <!--
<div class="cpdt">
   <dl>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>
-->


            <div class="cpdt">
                <span class="dmt">多媒体信息</span>
                <dl>
                    <dd>产品视频：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>成功案例：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>更多资料：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                </dl>

                <span class="fxsbc"><a href="#">
                    <input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg"></a></span>

            </div>
        </form>
    </div>
 

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->

</body>
</html>
