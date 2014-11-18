<!--      
	   管理分销商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glfxsxx.aspx 
       传入参数：s_yh_id  用户id  session
       author:张新颖  
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>管理分销商信息</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #homepage
        {
            margin-bottom: 0px;
        }
        #homepage0
        {
            margin-bottom: 0px;
        }
        .style11
        {
            width: 111px;
        }
        .style12
        {
            width: 108px;
        }
        .style13
        {
            width: 104px;
        }
        .style14
        {
            width: 107px;
        }
    </style>
</head>

<script type="text/javascript" language="javascript">
    function Update_CS(id, pp_name) {
        document.getElementById("pp_name").value = pp_name;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById("fxsxx").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "glfxsxx4.aspx?id=" + id + "&lx=pp", true);
        xmlhttp.send();
    }
    function Update_gys(id) {
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var array = new Array();           //声明数组
                array = xmlhttp.responseText;     //接收替换返回的json字符串
                var json = array;
                var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 			
                if (myobj.length == 0) {
                    document.getElementById('companyname').value = "";       //供应商
                    document.getElementById('address').value = "";        //地址
                    document.getElementById('tel').value = "";                //电话  			 
                    document.getElementById('homepage').value = "";       //主页
                    document.getElementById('fax').value = "";                 //传真
                    document.getElementById('area').value = "";               //地区名称
                    document.getElementById('name').value = "";               //联系人
                    document.getElementById('phone').value = "";        //联系人电话 
                    document.getElementById('sh').style.visibility = "hidden";
                    if (id != "0") {
                        if (confirm("该分销商尚未填写详细信息,是否补填？")) {
                            window.location.href = "grxx.aspx?gys_id=" + id + "&lx=fxs";
                        }
                    }
                }
                for (var i = 0; i < myobj.length; i++) {  //遍历,将ajax返回的数据填充到文本框中				

                    document.getElementById('companyname').value = myobj[i].gys_name;       //供应商
                    document.getElementById('address').value = myobj[i].gys_address;        //地址
                    document.getElementById('tel').value = myobj[i].gys_tel;                //电话  			 
                    document.getElementById('homepage').value = myobj[i].gys_homepage;       //主页
                    document.getElementById('fax').value = myobj[i].gys_fax;                 //传真
                    document.getElementById('area').value = myobj[i].gys_area;               //地区名称
                    document.getElementById('name').value = myobj[i].gys_user;               //联系人
                    document.getElementById('phone').value = myobj[i].gys_user_phone;        //联系人电话 	
                    if (myobj[i].sh == "待审核") {
                        document.getElementById('sh').style.visibility = "visible";
                    }
                    else {
                        document.getElementById('sh').style.visibility = "hidden";
                    }
                }

            }
        }
        xmlhttp.open("GET", "glfxsxx3.aspx?id=" + id, true);
        xmlhttp.send();

        if (window.XMLHttpRequest) {
            xmlhttp1 = new XMLHttpRequest();
        }
        else {
            xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp1.onreadystatechange = function () {
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                var array1 = new Array();           //声明数组
                array1 = xmlhttp1.responseText;     //接收替换返回的json字符串
                var json1 = array1;
                var myobj1 = eval(json1);              //将返回的JSON字符串转成JavaScript对象 	
                var s = "";
                for (var j = 0; j < myobj1.length; j++) {  //遍历,将ajax返回的数据填充到文本框中				

                    s += " <div class='fgstp'><image src='images/wwwq_03.jpg'/>";
                    s += "  <span class='fdlpp1'>";
                    s += " <a href='ppxx.aspx?pp_id=" + myobj1[j].pp_id + "' class='fxsfxk'>" + myobj1[j].ppmc + "</a></span></div>";
                }
                document.getElementById("ppxx").innerHTML = s;
            }
        }
        xmlhttp1.open("GET", "glfxsxx3.aspx?id=" + id + "&lx=ppxx", true);
        xmlhttp1.send();
    }
    function AddNewBrand(id) {
        var url;
        var type = '<%=s_gys_type%>';
        if (type == "生产商") {
            url = "xzpp.aspx?gys_id=" + id;
        }
        else {
            url = "xzfxpp.aspx?gys_id=" + id;
        }
        window.open(url, "", "height=400,width=500,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function DeleteBrand(id) {
        var lx = '<%=s_gys_type %>';
        var r = confirm("请确认您将取消分销此品牌!");
        if (r == true) {
            var brands = document.getElementsByName("brand");
            var ppid;
            ppid = "";
            for (var i = 0; i < brands.length; i++) {
                if (brands[i].checked) {
                    ppid += brands[i].value + ",";
                    //                    brand_str = brand_str + "," + brands[i].value;
                }

            }
            var url;
            if (lx == "生产商") {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=1";
            }
            else {
                url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=2";
            }
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
    }

    function Update_gysxx() {
        alert("您更新的信息已提交,等待审核,请返回!");
    }

    function tel_onclick() {

    }

    function scs_onclick() {

    }

    function companyname_onclick() {

    }
    function Trim(str) {
        str = str.replace(/^(\s|\u00A0)+/, '');
        for (var i = str.length - 1; i >= 0; i--) {
            if (/\S/.test(str.charAt(i))) {
                str = str.substring(0, i + 1);
                break;
            }
        }
        return str;
    }
    function Add(obj) {
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        var cl_mc = Trim(tds[1].innerHTML);
        document.getElementById("cl_mc").value = cl_mc;
    }
    function CZ_P(obj,pp_mc,pp_id)
    {
        var h = obj.parentNode.parentNode;
        var a = h.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.color = "#707070";
        }
        obj.style.color = "#4876FF";
        var g;
        g = document.getElementById("lblgys_id").value;
        document.getElementById("frame1").src = "glfxsxx_2.aspx?gys_id=" + g + "&pp_mc=" + pp_mc+"&pp_id="+pp_id; 
    }
</script>
	
<script runat="server">
    protected DataTable dt_gysxx = new DataTable();  //分销商信息(材料供应商信息表)
    protected DataTable dt_ppxx = new DataTable();  //品牌信息(品牌字典)
    public string gys_id="";
    public string s_yh_id="";   //用户id
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    public string sp_result = "";        //首先声明审批结果变量
    public string s_gys_type = "";         //单位类型
    public DataTable dt_pp_id = new DataTable();
    public string[] pplb;
    public DataTable dt_fxs;//分销商与品牌对应关系表
    public DataTable dt_DLPP=null;
    public string ppid = "";
    public string pp_mc="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        gys_id = Request["gys_id"].ToString();
        this.lblgys_id.Value = gys_id;
        sSQL = "select 单位类型 from 材料供应商信息表 where gys_id='"+gys_id+"'";
        DataTable dt_type = objConn.GetDataTable(sSQL);
        if (dt_type != null && dt_type.Rows.Count > 0)
        {
            s_gys_type = dt_type.Rows[0]["单位类型"].ToString();
        }
        if (s_gys_type == "生产商")
        {
            sSQL = "select pp_id,品牌名称 from 品牌字典 where isnull(是否启用,'')='1' and scs_id='" + gys_id + "' order by scs_id "; //查询品牌id
            dt_pp_id = objConn.GetDataTable(sSQL);
            if (dt_pp_id != null && dt_pp_id.Rows.Count > 0)
            {
                pplb=new string[dt_pp_id.Rows.Count];
                ppid = dt_pp_id.Rows[0]["pp_id"].ToString(); //获取品牌id
                pp_mc = dt_pp_id.Rows[0]["品牌名称"].ToString();
            }
            sSQL = "select fxs_id,分销商 from 分销商和品牌对应关系表 where pp_id='" + ppid + "' ";//查询分销商id
            dt_fxs = objConn.GetDataTable(sSQL);
            string str_fxsid = "";
            if (dt_fxs!=null&&dt_fxs.Rows.Count>0)
            {
                str_fxsid = dt_fxs.Rows[0]["fxs_id"].ToString();
            }
            //根据不同的分销商id 查询不同的分销商信息
            sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,注册日期,注册资金,经营范围,gys_id from 材料供应商信息表 where  gys_id='" + str_fxsid + "' order by gys_id ";
            dt_gysxx = objConn.GetDataTable(sSQL);

            sSQL = "select 品牌名称,pp_id from 分销商和品牌对应关系表 where 是否启用='1' and fxs_id='" + str_fxsid + "'  order by fxs_id ";
            dt_ppxx = objConn.GetDataTable(sSQL);
        }
        if (s_gys_type.Equals("分销商"))
        {
            //如果是分销商信息 直接根据yh_id 查询供应商信息 
            //蒋，26日
            //sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  yh_id='" + s_yh_id + "' ";
            sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围 from 材料供应商信息表 where gys_id='" + gys_id+ "' ";
            dt_gysxx = objConn.GetDataTable(sSQL);
            sSQL = "select 品牌名称,pp_id from 分销商和品牌对应关系表 where 是否启用='1' and fxs_id='" + gys_id + "' order by myID ";
            dt_ppxx = objConn.GetDataTable(sSQL);
            if (dt_gysxx.Rows.Count == 0)
            {
                Response.Redirect("grxx.aspx");
            }
        }

             //获取glfxsxx2页面返回的供应商id
            string id = "";
        //蒋，2014年8月27日更改了中括号里的id为gys_id
            if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
            {
                id = Request["gys_id"].ToString();//324
            }   
            #region
            if (id != "")
            {              
                DWLX(s_gys_type, id, gys_id);
            }
             #endregion

    }
    public void DWLX(string str_gysid_type, string id, string str_gysid)
    {
        #region
        str_gysid = id;
        if (str_gysid_type.Equals("生产商"))
        {
            sSQL = "select pp_id,品牌名称 from 品牌字典 where isnull(是否启用,'')='1' and scs_id='" + str_gysid + "' order by myID "; //查询品牌id		
            string str_ppid="";
             dt_pp_id = objConn.GetDataTable(sSQL);
            if(dt_pp_id!=null&&dt_pp_id.Rows.Count>0)
            {
                str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //获取品牌id	
            }
            sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id in "    //139
            + "(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='" + str_ppid + "')";
            int count = objConn.ExecuteSQLForCount(sSQL, false);
            if (count != 0)
            {  //如果 供应商自己修改待审核表 有记录 查询审批结果
                sSQL = "select 审批结果,gys_id from 供应商自己修改待审核表 where gys_id in "  //139
                + "(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='" + str_ppid + "')";
                 //string gysid ="";
                DataTable dt_select = objConn.GetDataTable(sSQL);
                if(dt_select!=null&&dt_select.Rows.Count>0)
                {
                     sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);   //通过
                    //蒋，2014年8月27日
                     //gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
                }
                //spjg(gysid, gysid);蒋，2014年8月27日
                spjg(gys_id, gys_id);
                
            }
        }
        #endregion
        #region
        else  if (str_gysid_type.Equals("分销商"))
        {
            sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id='" + str_gysid + "' ";
            Object obj_check_gys_exist = objConn.DBLook(sSQL);
           
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)
                {  //如果 供应商自己修改待审核表 有记录 查询审批结果df
                    sSQL = "select 审批结果,gys_id from 供应商自己修改待审核表 where gys_id='" + str_gysid + "' ";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);   //通过
                    string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139蒋，2014年8月27日
                    //蒋，2014年8月27日
                    spjg(gysid, gysid);
                    //spjg(gys_id, gys_id);
                }
            
        }
        #endregion
        #region
        else
        {
            sSQL = "select count(*) from 供应商自己修改待审核表 where gys_id='" + id + "' ";
            Object obj_check_gys_exist = objConn.DBLook(sSQL);
            if (obj_check_gys_exist != null)
            {
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)
                {  //如果 供应商自己修改待审核表 有记录 查询审批结果
                    sSQL = "select 审批结果 from 供应商自己修改待审核表 where gys_id='" + id + "' ";

                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);
                    spjg(gys_id, id);
                }
            }
        }
        #endregion
    }
    public void spjg(string gysid,string id)
    {
        if (sp_result != "")
        {
            if (sp_result.Equals("通过"))
            {

                //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                sSQL = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='" + id + "'),"
                + "联系地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='" + id + "'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='" + id + "'),"
                + "主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='" + id + "'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='" + id + "'),"
                + "联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='" + id + "'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='" + id + "'),"
                + "经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='" + id + "') where gys_id ='" + id + "'";
                int ret = objConn.ExecuteSQLForCount(sSQL, false);

                sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='" + id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);
                //this.lblfile.Text = "恭喜您!您修改的数据已经保存,更新!";
                //Response.Write("恭喜您!您修改的数据已经保存,更新!");
            }
            else if (sp_result.Equals("不通过"))
            {
                sSQL = "delete  供应商自己修改待审核表 where gys_id ='" + gys_id + "' ";
                int ret = objConn.ExecuteSQLForCount(sSQL, true);

                Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
            }
            else if (sp_result.Equals("待审核"))
            {
                //修改提交后 页面上显示的是 供应商自己修改待审核表 的信息
                sSQL = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
                + "经营范围,gys_id  from 供应商自己修改待审核表 where  gys_id ='" + id + "' ";
                dt_gysxx = objConn.GetDataTable(sSQL);
                //this.lblfile.Text = "审核当中";
            }
        }

    }
    protected void CY_Click(object sender, EventArgs e)
    {
        this.gg.Visible = true;
        
    }
    protected void AddCL(object sender, EventArgs e)
    {
        Response.Redirect("xzgxs.aspx"); 
    } 

</script>

<body>
	  <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <form id="Form1" runat="server" name="update_fxs" action="glfxsxx2.aspx?gys_id=<%=gys_id %>" method="post">
    <input type="hidden" id="lblgys_id" runat="server" /> 
     <%if (s_gys_type.Equals("生产商"))
       {%>
        <div class="dlqqz5"  style="border:1px solid #ddd; padding-top:10px; margin: 10px 0 0 0;">
    <div class="dlqqz2">
      <div id="menu">
        <div class="dlqqz1">您的品牌列表</div>
        <h2 id="h2">
        <ul>
        <%foreach (System.Data.DataRow PP_MC in dt_pp_id.Rows)
          {%>
        <li><a href="javascript:void(0)" onclick="CZ_P(this,'<%=PP_MC["品牌名称"].ToString() %>','<%=PP_MC["pp_id"].ToString() %>')"><img src="images/biao2.jpg" />&nbsp;&nbsp;<%=PP_MC["品牌名称"].ToString()%></a></li>
         <%} %></ul></h2>
      </div>
 <div id="cgs_lb" style="width:795px; margin-left:182px;">
<div id="divtable" runat="server">
      <iframe id="frame1" src="glfxsxx_2.aspx?gys_id=<%=gys_id %>" frameborder="0" marginheight="0"  style=" width:100%; height:450px; padding:0px; margin:0px; border:0px; " > 
    </iframe> 
     </div>
     </div>
    </div>
  </div>
         <%} %> 
          <%-- //分销商身份的操作权限--%>
     <%  else
       { %>
             <div class="gysgybtr">
            <% if (sp_result == "待审核")
                { %>
				   <table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;贵公司的信息正在审核中</td>
    </tr>
    <tr>
      <td height="20" colspan="6" align="right"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td class="style11">公司名称：</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" id="companyname" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司名称"] %>" onclick="return companyname_onclick()" /></td>
      <td width="50" align="right"></td>
      <td class="style12">公司地址：</td>
      <td width="329"><input name="address" type="text" id="address" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地址"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">公司电话：</td>
      <td><input name="tel" type="text" id="tel" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["贵公司电话"] %>"/></td>
      <td>&nbsp;</td>
      <td class="style12">公司主页：</td>
      <td><input name="homepage" type="text" id="homepage" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["贵公司主页"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">公司传真：</td>
      <td><input name="fax" type="text" id="fax" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["贵公司传真"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">公司地区：</td>
      <td><input name="area" type="text" id="area" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["贵公司地区"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">联系人姓名：</td>
      <td><input name="name" type="text" id="name" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["联系人姓名"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">联系人电话：</td>
      <td><input name="phone" type="text" id="phone" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["联系人电话"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td class="style11">经验范围：</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
         <input name="Business_Scope" readonly style="height:70px; width:795px;" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></td>
    </tr>
  </table>
  </div>
			<%}
                else
                { %>
				<div runat="server" id="gg"><table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;贵公司详情信息如下:</td>
    </tr>
    <tr>
      <td height="20" colspan="6" align="right"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td class="style13">公司名称：</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" readonly id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" /></td>
      <td width="50" align="right"></td>
      <td class="style14">公司地址：</td>
      <td width="329"><input name="address" type="text" readonly id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">公司电话：</td>
      <td><input name="tel" type="text" id="tel" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["电话"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">公司主页：</td>
      <td><input name="homepage" type="text" id="homepage" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">公司传真：</td>
      <td><input name="fax" type="text" id="fax" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["传真"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">公司地区：</td>
      <td><input name="area" type="text" id="area" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["地区名称"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style13">联系人姓名：</td>
      <td><input name="name" type="text" id="name" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["联系人"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style14">联系人电话：</td>
      <td><input name="phone" type="text" id="phone" class="fxsxx3" readonly value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td class="style13">经验范围：</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
        <input name="Business_Scope" readonly style="height:70px; width:795px;" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></td>
    </tr>
  </table></div>
			<%}    %>

                   <%-- <div class="fxsxx2">             
                    <span class="fxsbc" >
                            <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                            <asp:Label runat="server" ID="lblfile"  ForeColor="red" Width="200px" Text=""></asp:Label>
                            <input type="submit" class="fxsbc2" value="更改" onclick="Update_gysxx()" style="cursor:pointer;" />
                   </span>
                    </div>--%>
                    <div class="ggspp" runat="server" id="ggspp">
                        <div style="font-size:14px; font-weight:bold; line-height:36px; float:left; width:100%; background-color:#f7f7f7;">&nbsp;&nbsp;贵公司分销代理的品牌如下</div>
                                <%foreach (System.Data.DataRow row in dt_ppxx.Rows)
                                  {%>
                                   <div class="fgstp">
                                        <img src="images/wwwq_03.jpg" />
                                        <span class="fdlpp1">
                                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                                            <%=row["品牌名称"].ToString() %>
                                        </span>
                                    </div>
                                 <%} %>     
                    </div>	
             <span class="fxsbc1"><a onclick="DeleteBrand(<%=gys_id %>)" style="cursor:pointer;">取消选中品牌</a></span>
             <span class="fxsbc1"><a onclick="AddNewBrand(<%=gys_id %>)" style="cursor:pointer;">增加新品牌</a></span>
     <%} %>   
      </form>
     <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  
</body>
</html>



