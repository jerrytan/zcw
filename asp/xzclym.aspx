<!--
          
       供应商新增材料页面	   
       文件名：czclym.aspx 
       传入参数:gys_id	 
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
    <title>新增材料页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //一级分类发送ajax 更新的是小类的名称 文件名是:xzclym2.aspx
    function updateFL(id)
    {

        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();

    }


    //二级分类发送ajax 更新的是品牌的名称 和材料属性的名称
    //文件名是xzclym3.aspx 和 xzclymSX.aspx
    //小类（二级分类）
    function updateCLFL(id) {
        var xmlhttp1;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp1 = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
//        xmlhttp.onreadystatechange = function ()
//        {

//            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//            {

//                document.getElementById("brand").innerHTML = xmlhttp.responseText;

//            }
//        }
//        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
//        xmlhttp.send();


        xmlhttp1.open("GET", "xzclymSX.aspx?id=" + id, true);
        xmlhttp1.send();
        xmlhttp1.onreadystatechange = function ()
        {

            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
            {

                //document.getElementById("sx_name").innerHTML = xmlhttp1.responseText;				


                var array = new Array();           //声明数组
                array = xmlhttp1.responseText;     //接收返回的json字符串

                var json = array;
                var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 
                for (var i = 0; i < myobj.length; i++)
                {  //遍历			

                    var json = document.getElementById('sx_names');
                    json.options.add(new Option(myobj[i].SX_name, myobj[i].SX_id));  //下拉框显示属性名称

                    var json_code = document.getElementById('sx_codes');     //下拉框显示属性编码
                    json_code.options.add(new Option(myobj[i].SX_code, myobj[i].SX_code));

                    var json_id = document.getElementById('sx_id');       //下拉框显示属性id
                    json_id.options.add(new Option(myobj[i].SX_id, myobj[i].SX_id));
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
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
            xmlhttp1 = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }

        xmlhttp.open("GET", "xzclymSX2.aspx?id=" + id, true);
        xmlhttp.send();
        xmlhttp.onreadystatechange = function ()
        {

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {

                //document.getElementById("cl_value").innerHTML = xmlhttp.responseText;

                var array = new Array();           //声明数组
                array = xmlhttp.responseText;     //接收替换返回的json字符串

                var json = array;
                var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 			


                for (var i = 0; i < myobj.length; i++)
                {  //遍历			
                    var json = document.getElementById('cl_value');
                    json.options.add(new Option(myobj[i].SXZ_name, myobj[i].SXZ_name));  //下拉框显示属性值

                    var json_code = document.getElementById('cl_number');     //下拉框显示属性编号
                    json_code.options.add(new Option(myobj[i].SXZ_code, myobj[i].SXZ_code));

                    var json_id = document.getElementById('cl_ids');       //下拉框显示属性值id
                    json_id.options.add(new Option(myobj[i].SXZ_id, myobj[i].SXZ_id));
                }
            }
        }

        xmlhttp1.open("GET", "xzclymSX3.aspx?id=" + id, true);
        xmlhttp1.send();
        xmlhttp1.onreadystatechange = function ()
        {
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
            {
                var ggxh_value = xmlhttp1.responseText;

                document.getElementById("cl_type").value = ggxh_value;
            }
        }

    }
    function AddNewBrand(id)
    {
        var url;
        var type = '<%=lx%>';
        if (type == "生产商")
        {
            url = "xzpp.aspx?gys_id=" + id;
        }
        else
        {
            url = "xzfxpp.aspx?gys_id=" + id;
        }
        window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function onload() {
        var ej_name = document.getElementById("ej_name").value;
        if (ej_name != "" && ej_name != undefined) {
            updateCLFL(ej_name);
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
    public DataConn objConn=new DataConn();
    public string gys_id = "";
    protected string sSQL = "";
    protected DataTable dt_pp = new DataTable();
    protected string lx = "";
    public string clbm = "";
    public string s_clmc = "";
    public string ejcl = "";
    public string yicl = "";
    protected DataTable dt_clxx = new DataTable();//材料表
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
        {
            gys_id = Request["gys_id"].ToString();
        }
        if (gys_id != "")
        {
            sSQL = "select 单位类型 from 材料供应商信息表 where gys_id='" + gys_id + "'";
            lx = objConn.DBLook(sSQL);
        }

        if (lx == "生产商")
        {
            sSQL = "select 品牌名称,pp_id from 品牌字典 where scs_id='" + gys_id + "'";
            dt_pp = objConn.GetDataTable(sSQL);
        }
        else
        {
            sSQL = "select 品牌名称,pp_id from 分销商和品牌对应关系表 where fxs_id='" + gys_id + "'";
            dt_pp = objConn.GetDataTable(sSQL);
        }
        s_clmc = Request["ej"];
        if (s_clmc =="")
        {
            this.yjfl.Visible = false;
            this.ejfl.Visible = false;
            this.xl.Visible = true;
            this.dl.Visible = true;
            sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";
            dt_clfl = objConn.GetDataTable(sSQL);
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
        else
        {
            sSQL = "select 显示名字 from 材料分类表 where 分类编码='" + s_clmc + "'";
            dt_clfl = objConn.GetDataTable(sSQL);
            ejcl=dt_clfl.Rows[0]["显示名字"].ToString();
            string yi = s_clmc.Substring(0, 2);
            sSQL = "select 显示名字 from 材料分类表 where 分类编码='" + yi + "'";
            dt_clfl = objConn.GetDataTable(sSQL);
            yicl=dt_clfl.Rows[0]["显示名字"].ToString();
            this.yjfl.Visible = true;
            this.ejfl.Visible = true;
            this.xl.Visible = false;
            this.dl.Visible = false;
        }
    }
   
</script>

<body onload="onload()">

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <div class="fxsxx">
        <span class="fxsxx1">请选择您要添加的材料信息</span>
        <%string gys_id = Request["gys_id"];%>
        <input id="ej_name" value="<%=s_clmc %>"  type="hidden" />
  <form name="form1" action = "xzclym4.aspx?ejcl=<%=s_clmc%>&gys_id=<%=gys_id %>" method = "post">
  <table width="998" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;材料分类如下:</td>
    </tr>
    <tr>
      <td width="100" height="70"></td>
      <td width="180" colspan="2">
      <div  runat="server" id="yjfl">一级材料：
      <input disabled value="<%=yicl %>" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
      </div>
<div class="xza" runat="server" id="dl">
                    <span class="xz2"><a href="#">大类</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                <% foreach(var v  in Items1)
                    {%>
                <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                <%}%>      
                    </select>
                </div>
      </td>
      <td width="180" colspan="2" align="right">
      <div runat="server" id="ejfl">二级材料：
      <input  readonly="readonly" value="<%=ejcl %>" type="text" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
      </div>
      <div class="xza" runat="server" id="xl">
                    <span class="xz2"><a href="#">小类</a></span>
                    <select id="ejflname" name="ejflname" class="fux" onchange="updateCLFL(this.options[this.options.selectedIndex].value)"> 
                        <option value="0">请选择小类</option>
                    </select>
                </div>
      </td>
      <td width="490">
      <span class="xzz1"><a href="#">模板下载地址</a></span>
      </td>
    </tr>
  </table> 
            <%--蒋，2014年8月19日，改div原有样式“fxsxx2”改为“gysgybtr”--%>
            <div class="gysgybtr">
                <span class="fxsxx1">请输入材料信息</span>
                <table width="998" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
      <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;材料信息如下:</td>
    </tr>
    <tr>
      <td height="20" colspan="6"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td width="120">材料名字：</td>
      <td width="329"><label for="textfield"></label>
        <input name="cl_name" type="text" class="fxsxx3" value="<%=Request.Form["cl_name"] %>" /></td>
      <td width="50" align="right"></td>
      <td width="120">品    牌：</td>
      <td width="329"><select name="brand"  style="width: 300px">
        <option value="0">请选择品牌</option>
        <%if (dt_pp.Rows.Count > 0)
          {
              foreach (System.Data.DataRow row in dt_pp.Rows)
              {%>
            <option value="<%=row["pp_id"].ToString() %>"><%=row["品牌名称"].ToString()%></option>
            <% }
          }%>
      </select>
      <%if (dt_pp.Rows.Count == 0)
        {
            if (lx == "分销商")
            {%>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新分销品牌</a></span>
        <%}
            else
            { %>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新品牌</a></span>
        <%}
        }%>
      </td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>属性名称：</td>
      <td><select name="sx_names" id="sx_names" style="width: 300px" onchange="update_clsx(this.options[this.options.selectedIndex].value)">
        <option value="0">请选择属性名称</option>
      </select></td>
      <td>&nbsp;</td>
      <td>属性编码：</td>
      <td><select name="sx_codes" id="sx_codes" style="width: 300px">
        <option value="0">请选择属性编码</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>属性id：</td>
      <td><select name="sx_id" id="sx_id" style="width: 300px">
        <option value="0">属性id</option>
      </select></td>
      <td>&nbsp;</td>
      <td>属性值：</td>
      <td><select name="cl_value" id="cl_value" style="width: 300px">
        <option value="0">请选择属性值</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>属性值编号：</td>
      <td><select name="cl_number" id="cl_number" style="width: 300px">
        <option value="0">编号</option>
      </select></td>
      <td>&nbsp;</td>
      <td>属性值ID号：</td>
      <td><select name="cl_ids" id="cl_ids" style="width: 300px">
        <option value="0">属性值id</option>
      </select></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>规格型号：</td>
      <td><label for="textfield21">
        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=Request.Form["cl_type"] %>" onclick="return cl_type_onclick()" />
      </label></td>
      <td>&nbsp;</td>
      <td>计量单位：</td>
      <td><input name="cl_bit" id="cl_bit" type="text" class="fxsxx3" value="<%=Request.Form["cl_bit"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>单位体积：</td>
      <td><input name="cl_volumetric"  type="text" class="fxsxx3"  value="<%=Request.Form["cl_volumetric"] %>" /></td>
      <td>&nbsp;</td>
      <td>单位重量：</td>
      <td><input name="cl_height" type="text" class="fxsxx3" value="<%=Request.Form["cl_height"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>说明：</td>
      <td><input name="cl_instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
        <tr>
      <td height="20" colspan="6"></td>
    </tr>
</table>
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


<div class="cpdt" style="border:0px">
 <span class="fxsbc"><a href="#" style="padding-left:120px">
 <input type="image" name="Submit" value="Submit" src="images/queding.jpg"/></a></span>
 <span class="fxsbc"><a href="" style="padding-left:280px" >
 <input type="image" name="quxiao" value="quxiao" src="images/quxiao.jpg" /></a>
 </span>
</div>

</form>
    </div>
 

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->

</body>
</html>
