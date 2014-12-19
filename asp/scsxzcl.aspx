<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Page Language="C#" EnableViewStateMac="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <meta content="IE=9.0000" http-equiv="X-UA-Compatible" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>供应商产品列表</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/cllb.css" rel="stylesheet" type="text/css" />
    <meta name="GENERATOR" content="MSHTML 11.00.9600.17239" />
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="js/jquery.form.js" type="text/javascript"></script>
    <%--<script src="http://malsup.github.io/jquery.form.js"></script>--%>

    <link href="Scripts/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
    <!--+upload引用-->
    <link href="css/houtai.css" rel="stylesheet" />
    <script src="Scripts/xheditor/xheditor-1.2.1.min.js" type="text/javascript"></script>
    <script src="Scripts/xheditor/xheditor_lang/zh-cn.js" charset="utf-8" type="text/javascript"></script>
    <script src="Scripts/ui/jquery-ui.custom.js" type="text/javascript"></script>
    <script src="Scripts/XheditorUpload.js" type="text/javascript"></script>
    <script src="Scripts/DomUpload.js" type="text/javascript"></script>
    <style type="text/css">
        .save {
            background: transparent url(Scripts/xheditor/save.gif) no-repeat 18px 50px;
            background-position: 1px 1px;
            width: 50px;
            height: 18px;
            border: 0px;
        }

        .close {
            background: transparent url(Scripts/xheditor/small.gif) no-repeat 18px 50px;
            background-position: 1px 1px;
            width: 50px;
            height: 18px;
            border: 0px;
        }
    </style>
    <script src="Scripts/uploadify/jquery.uploadify3.1.js?ver=<%=(new Random()).Next(0, 99999).ToString() %>" type="text/javascript"></script>
    <script src="Scripts/zcwUpload.js" type="text/javascript"></script>

    <script type="text/javascript">
        function setTab(name, cursel, n) {
            for (i = 1; i <= n; i++) {
                var menu = document.getElementById(name + i);
                var con = document.getElementById("con_" + name + "_" + i);
                menu.className = i == cursel ? "hover" : "";
                con.style.display = i == cursel ? "block" : "none";
            }
        }
        //    $(document).ready(function () {
        //        //$("#uoloadAll").showLoading();
        //        //去除遮罩
        //                   // $(".add_test_img").hideLoading();
        //    }); 
        //列表数
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
    </script>

    <script type="text/javascript">
        var value;
        //点击选择属性值
        function AddSXZ(obj, sxbm, bh, sxz, sql) {
            var td = obj.parentNode;
            var a = td.getElementsByTagName("a");
            for (var i = 0; i < a.length; i++) {
                a[i].style.backgroundColor = "#FFFFFF";
                a[i].style.color = "#707070";
            }
            obj.style.backgroundColor = "#4876FF";
            obj.style.color = "#FFFFFF";
            var flbm_cl = document.getElementById("flbm").value;
            var tr = obj.parentNode.parentNode;
            var tds = tr.cells;
            tds[2].innerHTML = sxz;         //属性值
            // tds[3].innerHTML = sxbm + bh;   //属性编码+编号
            tds[3].innerHTML = bh;   //编号
            tds[4].innerHTML = sql;  //SQL语句
            var table = document.getElementById("sx");
            var tr = table.getElementsByTagName("tr");
            var ggxh = "";
            var clbh = flbm_cl.toString();
            var sxmc;
            for (var i = 0; i < tr.length; i++) {
                if (tr[i].cells[0].innerHTML == "品种") {
                    document.getElementById("clmc").value = tr[i].cells[2].innerHTML;
                }
                var tds = tr[i];
                ggxh = ggxh + tr[i].cells[2].innerHTML;
                clbh += tr[i].cells[3].innerHTML.toString();
            }
            document.getElementById("clbm").value = clbh;
            document.getElementById("clmcjgg").value = ggxh;
            document.getElementById("gg_xh").value = ggxh;
        }
        //将组合的属性属性值 和对应材料信息 添加到材料列表中
        function AddValue() {
            var clbm = document.getElementById("clbm").value;
            var clm = document.getElementById("clmc").value;
            document.getElementById("mcgz").value = clm;
            var ggjxh = document.getElementById("clmcjgg").value;
            document.getElementById("gg_xh").value = ggjxh;
            if (ggjxh == "" || ggjxh == undefined) {
                alert("请重新选择规格");
                return;
            }
            document.getElementById("cpbh").value = clbm;
            //拼写SQL语句
            var table = document.getElementById("sx");
            var tr = table.getElementsByTagName("tr");
            var sSQL = "";
            for (var i = 0; i < tr.length; i++) {
                sSQL = sSQL + tr[i].cells[4].innerHTML + "◣";
            }
            document.getElementById("SQL").value = sSQL;
        }
        function AddValue1() {
            var clbm = document.getElementById("clbm").value;

            var ggjxh = document.getElementById("clmcjgg").value;
            document.getElementById("gg_xh").value = ggjxh;

            if (ggjxh == "" || ggjxh == undefined) {
                alert("请重新选择规格");
                return;
            }
            document.getElementById("cpbh").value = clbm;
            //拼写SQL语句
            var table = document.getElementById("sx");
            var tr = table.getElementsByTagName("tr");
            var sSQL = "";
            for (var i = 0; i < tr.length; i++) {
                sSQL = sSQL + tr[i].cells[4].innerHTML + "◣";
            }
            document.getElementById("SQL").value = sSQL;
        }
    </script>
    <script type="text/javascript">
        //点击左侧列表数
        function lbs(obj, flbm, mc, dw) {
            var h = obj.parentNode.parentNode;
            var a = h.getElementsByTagName("a");
            for (var i = 0; i < a.length; i++) {
                a[i].style.color = "#707070";
            }
            obj.style.color = "#4876FF";
            document.getElementById("gg_xh").value = "";
            document.getElementById("clmcjgg").value = "";
            document.getElementById("flbm").value = flbm;
            document.getElementById("flmc").value = mc;
            document.getElementById("dw").value = dw;
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText != "" && xmlhttp.responseText != undefined) {
                        document.getElementById("allcl").innerHTML = xmlhttp.responseText;
                    }
                }
            }
            var url = "scsxzclxzsx.aspx?flbm=" + flbm + "&flmc=" + mc;
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
        }


        function saveReport() {
            //   document.getElementById("dmt").value = document.frames['frame1'].document.getElementById("dmtz").value;
            var scsid = document.getElementById("scsid").value;
            // jquery 表单提交
            $("#form1").ajaxSubmit(function (message) {
                // 对于表单提交成功后处理，message为提交页面saveReport.htm的返回内容 

                var clid = message.split(',')[1];
                if (message.split(',')[0] == "1") {
                    alert("提交成功!现在您能可以添加该材料的多媒体信息！");
                    //window.opener.location.reload();
                    $("#myclid").val(clid);
                    $("#ceng").fadeOut(200);
                    getXheditor();
                    $("#xhe0_iframearea").attr("style", "height:100%");
                    $("#xhe0_container").children().attr("style", "height:100%");
                    SetBtn();//设置设置保存按钮
                    Draggable();//拖动
                    DomUpload();
                    //                window.close();
                    //   window.location.href = "gysglcl.aspx?gys_id=" + scsid; 
                }
                else {
                    alert(message);
                }
            });
            return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转    onsubmit="return saveReport();"
        }
    </script>

</head>
<body>
    <input type="hidden" name="mySecc" id="mySecc" value="" />
    <input type="hidden" name="myclid" id="myclid" value="" runat="server" />
    <input type="hidden" name="myTypeExts" id="myTypeExts" value="*.jpg;*.jpeg;*.png;*.gif" runat="server" />
    <input type="hidden" name="myCount" id="myCount" value="5" runat="server" />
    <input type="hidden" name="myAction" id="myAction" value="img" runat="server" />
    <input type="hidden" name="myRo" id="myRo" value="1" runat="server" />
    <form runat="server" id="form1" action="scsxzcl_save.aspx" method="post" onsubmit="return saveReport();">
        <script runat="server">
            public DataTable dt_sx = new DataTable();
            public DataTable dt_sxz = new DataTable();
            public DataTable dt_cl = new DataTable();
            public string DWID = "";
            public string DWLX = "";
            public DataConn Conn = new DataConn();
            public string cpbhsjk = "";
            public string ggxzsjk = "";
            public string jldwsjk = "";
            public string dwzlsjk = "";
            public string dwtjsjk = "";
            public string smsjk = "";
            public string pricesjk = "";
            public string ggjxh = "";
            protected void Page_Load(object sender, EventArgs e)
            {
                string scs_id = "";  //营业注册号
                string ppid = "";
                string flbm = "";
                string flmc = "";
                string clid = "";
                //scs_id = "300";
                //ppid = "300";
                //flbm = "030107";
                //flmc = "膨胀螺栓";
                //clid = "331";
                //this.lx.Value = "bj";
                if (Request["scs_id"] != null && Request["scs_id"].ToString() != "")
                {
                    scs_id = Request["scs_id"].ToString();
                    
                    
                }


                if (Request["ppid"] != null && Request["ppid"].ToString() != "")
                {
                    ppid = Request["ppid"].ToString();
                }
                if (Request["cl_id"] != null && Request["cl_id"].ToString() != "")
                {
                    clid = Request["cl_id"].ToString();
                    this.lx.Value = "bj";
                    this.myclid.Value = clid;
                    this.clid.Value = clid;
                }
                this.scsid.Value = scs_id;
                this.ppid.Value = ppid;

                if (scs_id != "" && ppid != "" && clid != "")
                {
                    if (Request["flbm"] != null && Request["flbm"].ToString() != "")
                    {
                        flbm = Request["flbm"].ToString();
                    }

                    if (Request["flmc"] != null && Request["flmc"].ToString() != "")
                    {
                        flmc = Request["flmc"].ToString();
                    }
                    this.flbm.Value = flbm;
                    this.flmc.Value = flmc;

                    string SQL = "";
                    SQL = "select 显示名,规格型号,计量单位,单位重量,单位体积,说明,price,材料编码 from 材料表 where cl_id=" + clid;
                    dt_cl = Conn.GetDataTable(SQL);
                    if (dt_cl != null && dt_cl.Rows.Count > 0)
                    {
                        cpbhsjk = Convert.ToString(dt_cl.Rows[0]["材料编码"]);
                        ggxzsjk = Convert.ToString(dt_cl.Rows[0]["显示名"]);
                        jldwsjk = Convert.ToString(dt_cl.Rows[0]["计量单位"]);
                        dwzlsjk = Convert.ToString(dt_cl.Rows[0]["单位重量"]);
                        dwtjsjk = Convert.ToString(dt_cl.Rows[0]["单位体积"]);
                        smsjk = Convert.ToString(dt_cl.Rows[0]["说明"]);
                        pricesjk = Convert.ToString(dt_cl.Rows[0]["price"]) == "0" ? "" : Convert.ToString(dt_cl.Rows[0]["price"]);
                        ggjxh = Convert.ToString(dt_cl.Rows[0]["规格型号"]);
                        this.gg_xh.Value = Convert.ToString(dt_cl.Rows[0]["规格型号"]);
                        this.cpbh.Value = cpbhsjk;
                        this.clbm.Value = cpbhsjk;
                        this.mcgz.Value = ggxzsjk;
                        this.jldw.Value = jldwsjk;
                        this.dwtj.Value = dwtjsjk;
                        this.dwzl.Value = dwzlsjk;
                        this.cpjg.Value = pricesjk;
                        this.yyfw.Value = smsjk;
                        this.clmcjgg.Value = ggjxh;
                    }
                    Addsx(flbm, flmc, clid, ggjxh);
                }
            }
            protected void Addsx(string flbm, string flmc, string clid, string ggxh)
            {
                this.SQL.Value = "1";
                string html = "";
                if (flbm != "")
                {
                    string sql_sx = "";
                    sql_sx = "select 显示 as 属性名称,属性编码 from 材料分类属性表 where 分类编码='" + flbm + "' and 分类名称='" + flmc + "' order by 分类编码,属性编码";
                    dt_sx = Conn.GetDataTable(sql_sx);
                }
                if (dt_sx != null && dt_sx.Rows.Count > 0)
                {

                    html = "<table width='740' border='0' cellpadding='0' cellspacing='1' bgcolor='#dddddd' style='table-layout：fixed ;word-wrap：break-word'>"
                        + " <thead>"
                        + "   <tr>"
                        + "    <th width='70' height='30' align='center' bgcolor='#E3ECFF'><strong>属性名称</strong></th>"
                        + " <th align='center' bgcolor='#E3ECFF'><strong>规格\\型号</strong></th>"
                        + " <th width='80' align='center' bgcolor='#E3ECFF'><strong>选中项</strong></th>"
                        + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>编码</strong></th>"
                          + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>SQL语句</strong></th>"
                        + " </tr>"
                        + " </thead>"
                        + " <tbody id='sx'>";

                    foreach (DataRow drsx in dt_sx.Rows)
                    {
                        string sql_sx = "select 属性名称,属性值,属性编码,编号,flsx_id,flsxz_id,fl_id from 材料分类属性值表  where 属性名称='" + drsx["属性名称"] + "' and 分类编码=" + flbm;
                        dt_sxz = Conn.GetDataTable(sql_sx);
                        string sxmc = Convert.ToString(drsx["属性名称"]);
                        sxmc = sxmc.Replace("\r", " ");
                        sxmc = sxmc.Replace("\n", " ");
                        html += " <tr style='line-height:24px;'>"
                       + " <td align='center' bgcolor='#FFFFFF'>" + sxmc + "</td>"
                        + " <td align='left' bgcolor='#FFFFFF'> ";
                        if (dt_sxz != null && dt_sxz.Rows.Count > 0)
                        {
                            foreach (DataRow drsxz in dt_sxz.Rows)
                            {
                                string value = "";
                                string sxsxzbm = Convert.ToString(drsxz["属性编码"]) + Convert.ToString(drsxz["编号"]);
                                value = drsxz["属性名称"] + "," + drsxz["属性编码"] + "," + drsxz["flsx_id"] + "," + drsxz["属性值"] + "," + drsxz["编号"] + "," + drsxz["flsx_id"]
                                    + "," + sxsxzbm + "," + drsxz["fl_id"] + "," + flmc + ",clid,clmc,clbm";
                                string sxbm = Convert.ToString(drsxz["属性编码"]);
                                string sxz = Convert.ToString(drsxz["属性值"]);
                                string bh = Convert.ToString(drsxz["编号"]);
                                sxbm = sxbm.Replace("\r", " ");
                                sxbm = sxbm.Replace("\n", " ");
                                sxz = sxz.Replace("\r", " ");
                                sxz = sxz.Replace("\n", " ");
                                bh = bh.Replace("\r", " ");
                                bh = bh.Replace("\n", " ");

                                html += "<a href='javascript:void(0)' onclick=\"AddSXZ(this,'" + sxbm +
                                    "','" + bh + "','" + sxz + "','" + value + "')\">" + sxz + "&nbsp;&nbsp;</a>";
                            }
                        }
                        html += "</td>"
                            + " <td align='center' bgcolor='#FFFFFF'></td>"
                            + " <td style='display:none;'></td>"
                            + " <td style='display:none;'></td>"
                            + "</tr>";
                    }
                    html += " </tbody> "
                            + " <tfoot>"
                            + "        <tr>"
                            + "        <td width='120' height='32' align='right' bgcolor='#FFFFFF'>名称及规则：</td>"
                            + "        <td align='left' bgcolor='#FFFFFF'><input type='text' runat='server'  value='" + ggxh + "' id='clmcjgg' name='clmcjgg' style=' width: 293px; '/></td>"
                            + "        <td width='80' align='center' bgcolor='#FFFFFF'>"
                            + "        <input type='Button' name='btnDocNew' value='确定' onClick='AddValue1()'  class='filter' style='color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;' /></td>"
                            + "      </tr>"
                            + "       </tfoot>"
                            + " </table>";
                }
                if (html != "")
                {
                    this.allcl.InnerHtml = "";
                    this.allcl.InnerHtml = html;
                }
                //}
            }
        </script>

        <div class="box" id="cllbb">
            <!-- 头部结束-->
            <div class="dlqqz5" style="border: 1px solid #4ea6ee; padding-top: 10px; margin: -2px 0 0 0;">
                <div class="dlqqz2">
                    <!--  列表数开始-->
                    <div id="menu_lb">

                        <%string sSQL = ""; %>
                        <% sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=2";%>
                        <%DataTable dt1 = new DataTable();%>
                        <%dt1 = Conn.GetDataTable(sSQL); %>
                        <%if (dt1 != null && dt1.Rows.Count > 0) %>
                        <%{ %>
                        <%int firstlevel = 0; %>
                        <%foreach (DataRow dryj in dt1.Rows)%>
                        <%{%>
                        <%sSQL = ""; %>
                        <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=4 and  SUBSTRING(分类编码,1,2)=" + dryj["分类编码"]; %>
                        <%DataTable dt2 = new DataTable(); %>
                        <%dt2 = Conn.GetDataTable(sSQL); %>
                        <%if (dt2 != null && dt2.Rows.Count > 0) %>
                        <%{ %>
                        <% int secondlevel = 0; %>
                        <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
                            <img src="images/biao2.jpg" alt="" />
                            <%=dryj["显示名字"]%></a></h1>

                        <span class="no">
                            <%foreach (DataRow drej in dt2.Rows)%>
                            <%{%>
                            <%sSQL = ""; %>
                            <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=6 and SUBSTRING(分类编码,1,4)=" + drej["分类编码"]; %>
                            <%DataTable dt3 = new DataTable(); %>
                            <%dt3 = Conn.GetDataTable(sSQL); %>
                            <%if (dt3 != null && dt3.Rows.Count > 0) %>
                            <%{ %>
                            <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %>)"><a href="javascript:void(0)"><%=drej["显示名字"]%></a></h2>
                            <ul class="no">
                                <%  foreach (DataRow drsj in dt3.Rows)%>
                                <%  {%>
                                <li><a href="javascript:void(0)" onclick="lbs(this,'<%=drsj["分类编码"]%>','<%=(drsj["显示名字"])%>','<%=drsj["单位"]%>')"><%=drsj["显示名字"]%></a></li>
                                <%  } %>
                            </ul>
                            <%} %>
                            <%else %>
                            <%{ %>
                            <h2><a href="javascript:void(0)" onclick="lbs(this,'<%=drej["分类编码"]%>','<%=(drej["显示名字"])%>','<%=drej["单位"]%>')"><%=drej["显示名字"]%></a></h2>
                            <ul class="no"></ul>
                            <%} %>
                            <%secondlevel++; %>
                            <%} %>
                        </span>
                        <%} %>
                        <%else %>
                        <%{ %>
                        <h1><a href="javascript:void(0)" onclick="lbs(this,'<%=dryj["分类编码"]%>','<%=(dryj["显示名字"])%>','<%=dryj["单位"]%>')"><%=dryj["显示名字"]%></a></h1>
                        <span class="no"></span>
                        <%} %>
                        <% firstlevel++;  %>
                        <%} %>
                        <%} %>
                    </div>
                    <!--列表数结束-->

                    <div id="Div3" style="width: 775px; min-height: 400px; margin-left: 202px;">
                        <div id="allcl" runat="server">
                            <table width="740" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" style="table-layout：fixed; word-wrap：break-word">
                                <thead>
                                    <tr>
                                        <th width="70" height="30" align="center" bgcolor="#E3ECFF"><strong>属性名称</strong></th>
                                        <th align="center" bgcolor="#E3ECFF"><strong>规格\型号</strong></th>
                                        <th width="80" align="center" bgcolor="#E3ECFF"><strong>选中项</strong></th>
                                    </tr>
                                </thead>
                                <tbody id="sx">
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td width="120" height="32" align="right" bgcolor="#FFFFFF">名称及规则：</td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <input type="text" runat="server" id="clmcjgg" name="clmcjgg" style="width: 293px;" /></td>
                                        <td width="80" align="center" bgcolor="#FFFFFF">
                                            <input type="Button" name="btnDocNew" value="确定" onclick="AddValue()" class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px; cursor: pointer;" /></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <div id="Div1">
                            <table id="Table1" width="740" border="0" align="left" cellpadding="0" cellspacing="0" style="table-layout：fixed; word-wrap：break-word; margin-top: 10px; border: 1px solid #ddd; padding: 10px 0;">
                                <tbody id="Tbody1">
                                    <tr>
                                        <td width="100" height="36" align="right" bgcolor="#FFFFFF">产品编号：</td>
                                        <td height="24" colspan="3" align="left" bgcolor="#FFFFFF">
                                            <label for="textfield"></label>
                                            <input name="cl_name4" type="text" runat="server" id="cpbh" class="hyzhc_shrk9" readonly="readonly" /></td>
                                        <td width="100" align="right" bgcolor="#FFFFFF">产品名称：</td>
                                        <td colspan="3" align="left" bgcolor="#FFFFFF">
                                            <input type="text" runat="server" id="mcgz" name="mcgz" class="hyzhc_shrk9" /></td>
                                    </tr>
                                    <tr>
                                        <td width="100" height="36" align="right" bgcolor="#FFFFFF">计量单位：</td>
                                        <td width="80" height="24" align="center" bgcolor="#FFFFFF">
                                            <input type="text" runat="server" name="jldw" id="jldw" class="hyzhc_shrk8" /></td>
                                        <td width="80" align="right" bgcolor="#FFFFFF">单位重量：</td>
                                        <td width="80" align="left" bgcolor="#FFFFFF">
                                            <input type="text" name="dwzl" runat="server" id="dwzl" class="hyzhc_shrk8" /></td>

                                        <td width="100" align="right" bgcolor="#FFFFFF">单位体积：</td>
                                        <td width="80" align="left" bgcolor="#FFFFFF">
                                            <input type="text" id="dwtj" runat="server" name="dwtj" class="hyzhc_shrk8" /></td>
                                        <td width="80" align="right" bgcolor="#FFFFFF">产品价格：</td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <input type="text" id="cpjg" name="cpjg" runat="server" class="hyzhc_shrk8" /></td>
                                    </tr>
                                    <tr>
                                        <td height="80" align="right" bgcolor="#FFFFFF">产品说明：</td>
                                        <td height="80" colspan="7" align="center" bgcolor="#FFFFFF">
                                            <textarea class="hyzhc_shrk2_2" runat="server" cols="40" id="yyfw" name="yyfw" rows="6" style="100%"> </textarea></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 20px; background: #FFFFFF" colspan="8">
                                            <dd style="text-align: center; float: right; margin-right: 20px;">
                                                <input type="submit" class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px; cursor: pointer;" value="保存" /></dd>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div class="cpdt_2" style="width: 740px; float: left;">


                                <!--+图片上传 高度240px; 宽度：740px；--------------------------------------------------------------------------------------------------------------------->
                                <!--position:absolute; width:100%; height:100%; background:#000; opacity:0.7; z-index:99;-->
                                <div id="ceng" style="width: 744px; height: 240px; float: left; position: absolute; background: #000; opacity: 0.2; z-index: 99; font-size: 15px; text-align: center; line-height: 240px; filter: alpha(opacity=20); color: White;">
                                    请先保存资料！
                                </div>
                                <div class="lib_yeqian">
                                    <ul>
                                        <li id="two1" onclick="setTab('two',1,4)" class="hover">产品图片</li>
                                        <li id="two2" onclick="setTab('two',2,4)">商品详情</li>
                                        <li id="two3" onclick="setTab('two',3,4)">相关文档</li>
                                        <li id="two4" onclick="setTab('two',4,4)">相关视频</li>
                                    </ul>
                                </div>
                                <div class="yeqian" id="con_two_1" style="border: #4ea6ee 1px solid;">
                                    <div class="yeqian1">
                                        <div class="yq_img">

                                            <div id="imgQ" style="float: left; width: 322px; height: 90px; border: 1px solid #DDDDDD;">
                                               <%-- <div style="width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;">
                                                    <div style="background-image: url(Images/1.jpg); background-size: 60px 60px; width: 60px; height: 60px; float: left;">
                                                        <a href="#" style="background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;"></a>
                                                    </div>
                                                    <div style="width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;">图片1</div>
                                                </div>
                                                <div style="width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;">
                                                    <div style="background-image: url(Images/1.jpg); background-size: 60px 60px; width: 60px; height: 60px; float: left;">
                                                        <a href="#" style="background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;"></a>
                                                    </div>
                                                    <div style="width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;">图片1</div>
                                                </div>
                                                <div style="width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;">
                                                    <div style="background-image: url(Images/1.jpg); background-size: 60px 60px; width: 60px; height: 60px; float: left;">
                                                        <a href="#" style="background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;"></a>
                                                    </div>
                                                    <div style="width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;">图片1</div>
                                                </div>
                                                <div style="width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;">
                                                    <div style="background-image: url(Images/1.jpg); background-size: 60px 60px; width: 60px; height: 60px; float: left;">
                                                        <a href="#" style="background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;"></a>
                                                    </div>
                                                    <div style="width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;">图片1</div>
                                                </div>
                                                <div style="width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;">
                                                    <div style="background-image: url(Images/1.jpg); background-size: 60px 60px; width: 60px; height: 60px; float: left;">
                                                        <a href="#" style="background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;"></a>
                                                    </div>
                                                    <div style="width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;">图片1</div>
                                                </div>--%>
                                            </div>

                                            <div class="anniu_sc">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr style="width: 100px">
                                                            <td height="30" align="center">请选择图片： </td>
                                                            <td align="left">
                                                                <input name="imgUploadify" id="imgUploadify" type="button" />
                                                            </td>
                                                        </tr>
                                                        <tr style="width: 100px">
                                                            <td height="20" align="center"></td>
                                                            <td align="left">
                                                                <input id="btnImgUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none; color: black; border-right-style: none; width: 72px" type="button" value="上传图片" />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div id="imgQueue" class="yq_img2">
                                            <%--<img src="images/schjd_pic.jpg" width="354" height="157" />--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="yeqian" id="con_two_2" style="border: 1px solid #4ea6ee; padding-top: 10px; display: none;">
                                    <div class="yeqian_cont">
                                        <!--+编辑器开始------------------------------------------------------------------>
                                        <input type="hidden" name="show" value="0" id="show" />
                                        <div id="divXh" style="width: 700px; height: 195px;">
                                            <textarea id="elm" name="elm" rows="12" cols="80" style="height: 100%; width: 100%;"></textarea>
                                            <div id="drag" style="width: 405px; height: 25px; position: absolute; top: 0px; left: 489px;"></div>
                                        </div>
                                        <!--+编辑器结束------------------------------------------------------------------>
                                    </div>
                                </div>
                                <div class="yeqian" id="con_two_3" style="border: 1px solid #4ea6ee; padding-top: 10px; display: none;">

                                    <table width="700" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
                                        <tr>
                                            <td width="90" height="30" align="center">标 题：</td>
                                            <td colspan="5" align="left">
                                                <input name="domName" type="text" class="shr_wenzi400" id="domName" style="border: 1px solid #ddd;" value="" maxlength="200"></td>
                                            <td width="80" align="center">上传人：</td>
                                            <td width="70" align="left">谭刚</td>
                                        </tr>
                                        <tr>
                                            <td height="54" width="90" align="center">说 明：</td>
                                            <td colspan="7" align="left">
                                                <input name="domMsg" type="text" class="shr_wenzi590" id="domMsg" style="border: 1px solid #ddd;" value=""></td>
                                        </tr>
                                    </table>
                                    <table width="700" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="30" align="right">请选择文档： </td>
                                            <td align="left">
                                                <input type="button" name="domUploadify" id="domUploadify" value="" />
                                            </td>
                                            <td width="355" align="left">
                                                <div id="domQueue" class="shc_jindu">
                                                    <%--<img src="images/schjd_pic2.jpg" width="354" height="33">--%>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="15">&nbsp;</td>
                                            <td align="left">
                                                <input id="btnDomUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none; color: black; border-right-style: none; width: 72px" type="button" value="上传文档"></td>
                                            <td align="left">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td height="40" align="right">已上传文档：</td>
                                            <td colspan="2"><label id="domDelName" style=" width:auto; height:auto;">您还未上传文档！</label>
              <input id="btnDelNewDom" class="filter" style="border-top-style: none; cursor: pointer; font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none; color: black; border-right-style: none; width: 37px" type="button" value="删除" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="yeqian" id="con_two_4" style="border: 1px solid #4ea6ee; padding-top: 10px; display: none;">
                                    <table width="700" border="0" cellspacing="0" cellpadding="0" style="margin_top: 10px; padding-top: 10px;">
                                        <tr>
                                            <td width="90" height="30" align="center">标 题：</td>
                                            <td colspan="5" align="left">
                                                <input name="videoName" type="text" class="shr_wenzi400" id="videoName" style="border: 1px solid #ddd;" value="" maxlength="200" /></td>
                                            <td width="80" align="center">上传人：</td>
                                            <td width="70" align="left">谭刚</td>
                                        </tr>
                                        <tr>
                                            <td height="54" align="center">说 明：</td>
                                            <td colspan="7" align="left">
                                                <input name="videoMsg" type="text" class="shr_wenzi590" id="videoMsg" style="border: 1px solid #ddd;" value="" /></td>
                                        </tr>
                                    </table>
                                    <table width="700" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="30" align="right">请选择视频： </td>
                                            <td align="left">
                                                <input name="videoUploadify" id="videoUploadify" style="float: left; width: 200px"
                                                    type="file">
                                            </td>
                                            <td width="355" align="left">
                                                <div id="videoQueue" class="shc_jindu">
                                                    <%--<img src="images/schjd_pic2.jpg" width="354" height="33">--%>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="15">&nbsp;</td>
                                            <td align="left">
                                                <input id="btnVideoUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none; color: black; border-right-style: none; width: 72px" type="button" value="上传视频"></td>
                                            <td align="left">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td height="40" align="right">已上传视频：</td>
                                            <td colspan="2"><label id="videoDelName" style="width:auto; height:auto;">您还未上传视频</label>
              <input id="btnDelNewVideo" class="filter" style="border-top-style: none; cursor: pointer; font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none; color: black; border-right-style: none; width: 37px" type="button" value="删除" /></td>
                                        </tr>
                                    </table>
                                </div>


                                <!-- <div id="uoloadAll" style="width: 744px; height: 240px; float: left;">
                                    <div id="ceng" style="width: 744px; height: 240px; float: left; position: absolute; background: #000; opacity: 0.2; z-index: 99; font-size: 15px; text-align: center; line-height: 240px; filter: alpha(opacity=20); color: White;">
                                        请先保存资料！
                                    </div>
                                    <div style="width: 280px; height: 240px; float: left;">
                                        <table style="width: 280px; height: 200px; font-size: 13px; margin-top: 20px; margin-bottom: 20px;" border="0" cellpadding="0"
                                            cellspacing="0">
                                            <tr>
                                                <td style="width: 100px;" align="center">多媒体类型：
                                                </td>
                                                <td>
                                                    <select style="width: 100px;">
                                                        <option value="图片">图片</option>
                                                        <option value="视频">视频</option>
                                                        <option value="文档">文档</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr style="width: 100px;">
                                                <td align="center">分类：
                                                </td>
                                                <td>
                                                    <input type="radio" name="r1" value="1" /><label name="r1">使用说明</label>
                                                    <input type="radio" name="r2" value="2" /><label name="r2">成功案例</label><br />
                                                    <input type="radio" name="r3" value="3" /><label name="r3">演示</label>
                                                    <input type="radio" name="r4" value="4" style="margin-left: 30px;" /><label name="r4">图片</label>
                                                </td>
                                            </tr>
                                            <tr style="width: 100px;">
                                                <td align="center">选择图片：
                                                </td>
                                                <td>
                                                    <input type="file" name="uploadify" id="uploadify" style="width: 200px; float: left;" />
                                                </td>
                                            </tr>
                                            <tr style="width: 100px;">
                                                <td align="center">开始上传：
                                                </td>
                                                <td>
                                                    <input type="button" name="uploadfy" id="btnUploadfy" value="上传" style="width: 80px; height: 25px; font-size: 13px;" />
                                                    <input type="button" name="uploadfy" id="btnClear" value="取消上传" style="width: 80px; height: 25px; font-size: 13px;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="fileQueue" style="width: 460px; height: 240px; float: left; line-height: 10px;" align="center">
                                    </div>
                                </div>-->


                                <!--+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cgdlqq"></div>
        </div>

        <input type="hidden" runat="server" id="flbm" />
        <%--分类编码  --%>
        <input type="hidden" runat="server" id="clbm" />
        <%--  材料编码--%>
        <input type="hidden" runat="server" id="gg_xh" />
        <%--规格型号  --%>
        <input type="hidden" runat="server" id="clmc" />
        <%--材料名称  --%>
        <input type="hidden" runat="server" id="dw" />
        <%--单位  材料    --%>
        <input type="hidden" runat="server" id="SQL" />
        <%-- SQL语句  --%>
        <input type="hidden" runat="server" id="DW_ID" />
        <%-- 单位id   --%>
        <input type="hidden" runat="server" id="flmc" />
        <%-- 分类名称   --%>
        <input type="hidden" runat="server" id="dmt" />
        <%-- 图片地址   --%>
        <input type="hidden" runat="server" id="scsid" />
        <%-- 生产商ID   --%>
        <input type="hidden" runat="server" id="ppid" />
        <%-- 品牌id   --%>
        <input type="hidden" runat="server" id="lx" />
        <%-- 是新增还是编辑   --%>
        <input type="hidden" runat="server" id="clid" />
        <%-- 材料id   --%>
    </form>
</body>
</html>
