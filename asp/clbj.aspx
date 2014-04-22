<!--
             材料编辑页面
             文件名:  clbj.aspx 
			 传入参数: cl_id
             author:张新颖
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>材料编辑页面</title>
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
	
	   //二级分类发送ajax 更新的是品牌的名称 
	   
      function updateCLFL(id) 
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
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
    }
    function SaveAll()
    {
        document.getElementById("form1").action = "xzclym4.aspx?ym=clbj";
        document.getElementById("form1").method = "post";
        document.getElementById("form1").submit();
    }
</script>	
<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix()
    {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++)
        {
            sfEls[i].onmouseover = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function ()
            {
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
    function Marquee()
    {
        if (demo2.offsetWidth - demo.scrollLeft <= 0)
            demo.scrollLeft -= demo1.offsetWidth
        else
        {
            demo.scrollLeft++
        }
    }
    var MyMar = setInterval(Marquee, speed)
    demo.onmouseover = function () { clearInterval(MyMar) }
    demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
</script>
<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix()
    {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++)
        {
            sfEls[i].onmouseover = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function ()
            {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function ()
            {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>
<script runat="server">  
         protected DataTable dt_clfl = new DataTable();  //材料分类大类   
         protected DataTable dt_clflej = new DataTable();  //材料分类大类   
         protected DataTable dt_clxx = new DataTable();    //材料信息
         protected DataTable dt_clsx = new DataTable();    //材料属性名称,属性值(材料属性表)	 
         protected DataConn objConn = new DataConn();
         protected DataTable dt_pp = new DataTable();                 //品牌名称
         public string sSQL = "";
         public string s_clmc = "";
         public string clbm = "";
         public string fl_id = "";
   
         protected void Page_Load(object sender, EventArgs e)
         {
             string cl_id = Request["cl_id"];   //获取材料id               
                 sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";
                 dt_clfl = objConn.GetDataTable(sSQL);
                 sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='4'";
                 dt_clflej = objConn.GetDataTable(sSQL);
                 sSQL = "select 显示名,分类名称,品牌名称,规格型号,计量单位,单位体积,单位重量,分类编码,说明,pp_id,fl_id,材料编码 from 材料表 where cl_id='" + cl_id + "' ";
                 dt_clxx = objConn.GetDataTable(sSQL);
                 clbm = Convert.ToString(dt_clxx.Rows[0]["材料编码"]);
                 s_clmc = Convert.ToString(dt_clxx.Rows[0]["显示名"]);
                 sSQL = "select 品牌名称,pp_id from 品牌字典 where left(分类编码,2)='" + clbm.Substring(0, 2) + "'";

                 dt_pp = objConn.GetDataTable(sSQL);
                 sSQL = "select 分类属性名称,分类属性值 from 材料属性表 where cl_id='" + cl_id + "' and 材料编码='" + clbm + "'";
                 dt_clsx = objConn.GetDataTable(sSQL);
             
         }
         protected void UploadFile(object sender, EventArgs e)
         {
             if (file1.PostedFile.FileName.ToString().Trim() == "")
             {
                 objConn.MsgBox(this.Page, "请先选择上传文件！");
                 return;
             }
            string FilePath = Server.MapPath("temp\\");
             FilePath = FilePath + "Vedio\\";
             if (!System.IO.Directory.Exists(FilePath))
             {
                 System.IO.Directory.CreateDirectory(FilePath);
             }
             string name = "";
             name = System.IO.Path.GetFileName(this.file1.PostedFile.FileName.Trim());
             if (System.IO.File.Exists(FilePath+name))
             {
                 try
                 {
                     System.IO.File.Delete(FilePath + name);
                 }
                 catch (Exception)
                 {
                 }
                
             }
             file1.PostedFile.SaveAs(FilePath+name);
             if (System.IO.File.Exists(FilePath + name))
             {
                 string ip = "";
                 ip = Page.Request.Url.ToString().Trim();
                 int iPos;
                 ip = ip.Replace("http://", "");
                 ip = ip.Replace("HTTP://", "");
                 iPos = ip.IndexOf("/");
                 if (iPos != -1)
                 {
                     ip = ip.Substring(0, iPos);
                 }
                
                 string strVD = Request.ApplicationPath.ToString().Trim().Substring(1);
                 int intPos;
                 intPos = FilePath.LastIndexOf("\\");
                 if (intPos < 0)
                     intPos = FilePath.LastIndexOf("/");
                 FilePath = FilePath.Substring(intPos + 1);
                 FilePath = strVD + "/" + FilePath + "/" + name;
                 FilePath = "http://" + ip + "/" + FilePath;
                 
                 
                 
                 
                 
                 
                 string s_mtlx = "";   //媒体类型
                 string s_fl = "";
                 s_mtlx = mtlx.Value;
                 if (this.sysm.Checked)
                 {
                     s_fl = "使用说明";
                 }
                 else if (this.cgal.Checked)
                 {
                     s_fl = "成功案例";
                 }
                 else if (this.ys.Checked)
                 {
                     s_fl = "演示";
                 }
                 else if (this.cptp.Checked)
                 {
                     s_fl = "产品图片";
                 }
                 sSQL = "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,分类,存放地址) values(" +
               "'" + Convert.ToString(Request["cl_id"]) + "','" + clbm + "','" + s_clmc + "','1','" +
               s_mtlx + "','" + s_fl + "','" + FilePath + "')";
                 Response.Write("<script>window.alert('" + sSQL + "')</" + "script>");
                 bool b = objConn.ExecuteSQL(sSQL, true);
                 if (b)
                 {
                     Response.Write("<script>window.alert('上传成功！')</" + "script>");
                 }
                 else
                 {
                     Response.Write("<script>window.alert('保存到数据库中失败，请重新上传！')</" + "script>");
                 }
                
             }
             else
             {
                 Response.Write("<script>window.alert('上传失败！')</" + "script>");
             }           
         }
 
         protected bool CheckFileType(string FileName)
         {
             bool b = false;
             System.IO.FileStream fs = new System.IO.FileStream(FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
             System.IO.BinaryReader reader = new System.IO.BinaryReader(fs);
             byte[] buff = new byte[2];
             string result = string.Empty;
             try
             {
                 fs.Read(buff, 0, 2);
                 result = buff[0].ToString() + buff[1].ToString();
             }
             catch (Exception ex)
             {
             }            
             reader.Close();
             fs.Close();
             if (result=="4838"||result=="7368"||result=="6787")
             {
                 b = true;
             }
             return b;
        }

        
</script>
<body>

 <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
 <!-- 头部结束-->

<div>
 <form runat="server" id="form1">
 <div class="fxsxx">
    <span class="fxsxx1">材料分类如下:</span>
    <div class="xz1">
    <div class="xza">

                    <span class="xz2"><a href="#">大类</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                     <option value="0">请选择大类</option>
                        <% foreach (System.Data.DataRow v in dt_clfl.Rows)
                           {
                                   if (v["分类编码"].ToString() == dt_clxx.Rows[0]["材料编码"].ToString().Substring(0, 2))
                                   {%>
                                        <option value="<%=v["分类编码"].ToString() %>" selected="selected"><%=v["显示名字"].ToString()%></option>
                                 <%}
                                   else
                                   { %>
                                   <option value="<%=v["分类编码"].ToString() %>"><%=v["显示名字"].ToString()%></option>
                                  <%}
                         }%>
                    </select>
                </div>
    <div class="xza">
                    <span class="xz2"><a href="#">小类</a></span>
                    <select id="ejflname" name="ejflname" class="fux"  onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
                        <%for (int i = 0; i < dt_clflej.Rows.Count; i++)
                          {
                              if (dt_clflej.Rows[i]["分类编码"].ToString()==dt_clxx.Rows[0]["材料编码"].ToString().Substring(0,4))
                              {%>
                                   <option value="<%=dt_clflej.Rows[i]["分类编码"].ToString() %>" selected="selected"><%=dt_clflej.Rows[i]["显示名字"].ToString()%></option>
                              <%}
                          } %>
                        <option value="0">请选择小类</option>
                    
                    </select>
                </div>           
    <div class="xzz">
<!--
<span class="xzz0">如果没有适合的小类，请联系网站管理员增加！ 联系方式是xxx@xxx.com.请使用模板。 </span>
-->
<span class="xzz1"><a href="#">模板下载地址</a></span>
</div>
</div>

    <div class="fxsxx2">
<span class="srcl">材料信息如下:</span>
 <dl>
                    <dd>材料名字：</dd>
                    <dt>
                        <input name="cl_name"  id="cl_name" type="text" class="fxsxx3" value="<%=s_clmc%>"  /></dt>
                    <dd>品    牌：</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px" >                            
                            <option value="0">请选择品牌</option>                
                            <%foreach (System.Data.DataRow row in dt_pp.Rows)
                              {%>
                                   <option value="<%=row["pp_id"] %>"><%=row["品牌名称"] %></option>                
                             <% } %>           
                        </select></dt>
  
                    <dd>属性名称：</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" >
						
                            <%foreach (System.Data.DataRow v in dt_clsx.Rows)
                              {%>                                          
                            <option value="0"><%=v["分类属性名称"].ToString()%></option>
							<%}%>
						
                        </select></dt>		
						
                    <dd>属性值：</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <%foreach (System.Data.DataRow v in dt_clsx.Rows)
                              {%>                                          
                            <option value="0"><%=v["分类属性值"].ToString()%></option>
							<%}%>
                           
                        </select></dt>
					
						
					<dd>规格型号：</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=dt_clxx.Rows[0]["规格型号"] %>" /></dt>					
						
                    <dd>计量单位：</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["计量单位"] %>" /></dt>
                    <dd>单位体积：</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["单位体积"] %>" /></dt>
				    <dd>单位重量：</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["单位重量"] %>" /></dt>
                    <dd>说明：</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["说明"] %>" /></dt>
					<dd>报价：</dd>
					<dt>
						<input name="cl_instruction" type="text" class="fxsxx3" value="" /></dt>
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
       <dd>多媒体类型：</dd>
       <dt>
           <select  id="mtlx" runat="server">
                <option value="0">选择媒体类型</option>
                <option value="视频">视频</option>
                <option value="图片">图片</option>
                <option value="文档">文档</option>
            </select>
       </dt>
       <dd>分类：</dd>
       <dt>
        <input  id="sysm" name="select" type="radio" value="使用说明" runat="server" validationgroup="select" />使用说明  
		    <input id="cgal"  runat="server" name="select"  type="radio" value="成功案例" validationgroup="select" />成功案例
            <input id="ys"  runat="server" name="select"  type="radio" value="演示" validationgroup="select" />演示
            <input id="cptp"  runat="server" name="select"  type="radio" value="产品图片" validationgroup="select" />产品图片
       </dt>
       <dd>上传文件</dd>
               <dt><input name="" id="file1" type="file" class="fxsxx3"  runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="ImageButton1" OnClick="UploadFile" /></dt>
         <%--<dd>产品视频：</dd>
        <dt><input name="" id="filesp" type="file" class="fxsxx3"  runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="UploadSP" OnClick="UploadFile" /></dt>
         <dd>成功案例：</dd>
        <dt><input name=""  id="fileAL"  type="file" class="fxsxx3" runat="server"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="uploadFileAL" OnClick="UploadFileAL" /></dt>
         <dd>更多资料：</dd>
        <dt><input name="" id="More"  runat="server" type="file" class="fxsxx3"/>&nbsp;&nbsp;<asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="uploadMore" OnClick="UploadFileMore" /></dt>                       --%>
     </dl>
     <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg"  onclick="SaveAll()"/></a></span>  
</div>

 </form>
 </div>
<div class="foot">
<span class="foot2"><a href="#">网站合作</a>  |<a href="#"> 内容监督</a> | <a href="#"> 商务咨询</a> |  <a href="#">投诉建议010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012众材网版权所有      京ICP证0000111号      京公安网备110101000005号</p>
<p>地址：北京市海淀区天雅大厦11层  联系电话：010-87654321    技术支持：京企在线</p></span>
</div>
</body>
</html>
