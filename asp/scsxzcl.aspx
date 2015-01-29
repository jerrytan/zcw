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
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>供应商新增材料</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/cllb.css" rel="stylesheet" type="text/css" />
    <meta name="GENERATOR" content="MSHTML 11.00.9600.17239" />
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
    <!--!+ MyControl 加载-->
    <script src="Scripts/MyControl/MyControl.js" type="text/javascript"></script>
    <script src="Scripts/AddSXZ.js" type="text/javascript"></script>
    <script src="js/jquery.form.js" type="text/javascript"></script>
    <%--<script src="http://malsup.github.io/jquery.form.js"></script>--%>
    <!--+upload引用-->
    <link href="Scripts/xheditor/xheditor_skin/default/ui.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
    <link href="css/houtai.css" rel="stylesheet" />
    <script src="Scripts/ui/jquery-ui.custom.js" type="text/javascript"></script>
    <script src="Scripts/xheditor/xheditor-1.2.1.min.js" type="text/javascript"></script>
    <script src="Scripts/xheditor/xheditor_lang/zh-cn.js" charset="utf-8" type="text/javascript"></script>
    <script src="Scripts/XheditorUpload.js" type="text/javascript"></script>
    <script src="Scripts/uploadify/jquery.uploadify3.1.js?ver=<%=(new Random()).Next(0, 99999).ToString() %>"
        type="text/javascript"></script>
    <script src="Scripts/zcwUpload.js" type="text/javascript"></script>
    <script src="Scripts/DomUpload.js" type="text/javascript"></script>
    <style type="text/css">
        .save
        {
            background: transparent url(Scripts/xheditor/save.gif) no-repeat 18px 50px;
            background-position: 1px 1px;
            width: 50px;
            height: 18px;
            border: 0px;
        }
        
        .close
        {
            background: transparent url(Scripts/xheditor/big.gif) no-repeat 18px 50px;
            background-position: 1px 1px;
            width: 50px;
            height: 18px;
            border: 0px;
        }
        .imgUploadfy
        {
            background: transparent url(Scripts/xheditor/xheditor_skin/default/img/icons.gif) no-repeat 20px 20px;
            background-position: -440px 0px;
            width: 50px;
            height: 18px;
            border: 0px;
        }
    </style>
    <script type="text/javascript">




        function setTab(name, cursel, n) {
            SetBtn();
            for (i = 1; i <= n; i++) {
                var menu = document.getElementById(name + i);
                var con = document.getElementById("con_" + name + "_" + i);
                menu.className = i == cursel ? "hover" : "";
                con.style.display = i == cursel ? "block" : "none";
                $(".uploadify").attr("style", "");
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
            //获取分类属性id
            //begin
            var strs = sql.split(',');
            $(obj).parent().parent().children().eq(6).html(strs[2]);
            $(obj).parent().parent().children().eq(7).html(strs[7]);
            //end

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
            tds[2].children[0].value = sxz; //.innerHTML = sxz;         //属性值
            // tds[3].innerHTML = sxbm + bh;   //属性编码+编号
            tds[3].innerHTML = bh;   //编号
            tds[4].innerHTML = sql;  //SQL语句
            tds[5].innerHTML = sxz;  //SQL语句
            var table = document.getElementById("sx");
            var tr = table.getElementsByTagName("tr");
            var ggxh = "";
            var clbh = flbm_cl.toString();
            var sxmc;
            for (var i = 0; i < tr.length; i++) {
                if (tr[i].cells[0].innerHTML == "品种") {
                    document.getElementById("clmc").value = tr[i].cells[2].children[0].value; //.innerHTML;
                }
                var tds = tr[i];
                ggxh = ggxh + tr[i].cells[2].children[0].value//.innerHTML;
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
            //document.getElementById("mcgz").value = clm;
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
            //清空产品编码和产品名称
            $("#cpbh").val("");
            $("#mcgz").val("");
            $("#clbm").val("");
            $("#gg_xh").val("");
            $("#clmc").val("");
            $("#SQL").val("");
            $("#flmc").val("");

            $("#jldw").val("");
            $("#dwzl").val("");
            $("#dwtj").val("");
            $("#cpjg").val("");
            $("#yyfw").text("");
            $("#yyfw").val("");

            document.getElementById("mcgz").value = $(obj).text().replace(" ", "");
            try {
                document.getElementById("mcgz").value = $(obj).text().trim();
            } catch (e) {

            }
            //end
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
                    $("#uploadFrame").attr("src", "http://192.168.1.22:88?clid=" + $("#myclid").val());
                    $("#ceng").fadeOut(200);
                    DomUpload();
                    $("#ceng").fadeOut(200);
                    getXheditor();
                    Draggable(); //拖动
                    $("#drag").fadeOut();
                    SetBtn(); //设置设置保存按钮
                    //                    getXheditor();
                    //                    $("#xhe0_iframearea").attr("style", "height:100%");
                    //                    $("#xhe0_container").children().attr("style", "height:100%");
                    //                    SetBtn();//设置设置保存按钮
                    //                    Draggable();//拖动
                    //                    DomUpload();
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
    <input type="hidden" name="show" value="0" id="show" />
    <input type="hidden" name="changeFrame" id="changeFrame" value="false" />
    <input type="hidden" name="mySecc" id="mySecc" value="" />
    <input type="hidden" name="myclid" id="myclid" value="" runat="server" />
    <input type="hidden" name="myTypeExts" id="myTypeExts" value="*.jpg;*.jpeg;*.png;*.gif"
        runat="server" />
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

                            html += "<a href='javascript:void(0)' style='float:left;' onclick=\"AddSXZ(this,'" + sxbm +
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
                        + "        <td width='120' height='32' align='right' bgcolor='#FFFFFF'>名称及规格</td>"
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
        <div class="cl_top">
            <div class="cl_wenzi">
                <a href="index.aspx">首页</a> > <a href="gysglcl.aspx">产品列表页</a> > 新增产品页</div>
            <div class="help_anniu">
                <a href="#">帮助</a></div>
            <div class="anniu">
                <a href="QQ_out.aspx" target="_self">供应商登出</a></div>
            <div class="anniu">
                <a href="gyszym.aspx" target="_self">供应商主页面</a></div>
        </div>
        <!-- 头部结束-->
        <div class="dlqqz5" style=" padding:0px;">
            <div class='dlqqz2' style=' width:200px; float:left; height:100%'><div id='menu_lb'><h1 onclick="javascript:ShowMenu(this,0)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='黑色及有色金属'>黑色及有色金属</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0101','钢筋','t')">钢筋</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0103','钢丝','t')">钢丝</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0105','钢丝绳','t')">钢丝绳</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0107','钢绞线、钢丝束','t')">钢绞线、钢丝束</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0109','圆钢','t')">圆钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0111','方钢','t')">方钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0113','扁钢','t')">扁钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0115','六角钢','t')">六角钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0116','八角钢','t')">八角钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0117','工字钢','t')">工字钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0119','槽钢','t')">槽钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0121','角钢','t')">角钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0123','H型钢','t')">H型钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0125','Z型钢','t')">Z型钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0127','其它型钢','t')">其它型钢</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0129','钢板','t')">钢板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0131','不锈钢板','t')">不锈钢板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0133','硅钢片','t')">硅钢片</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0135','铜板','t')">铜板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0141','铜线材','t')">铜线材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0143','铝板','t')">铝板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0147','铝线材','t')">铝线材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0149','铝型材','t')">铝型材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0151','铝合金建筑型材','t')">铝合金建筑型材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0153','铅材','t')">铅材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0155','钛材','t')">钛材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0157','镍材','t')">镍材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0159','锌材','t')">锌材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0161','其它金属材料','t')">其它金属材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0163','金属原材料','t')">金属原材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0165','锻造用钢','t')">锻造用钢</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,1)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='橡胶及塑料制品'>橡胶及塑料制品</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0201','橡胶板','t')">橡胶板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0203','橡胶条','t')">橡胶条</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0205','塑料薄膜/布','t')">塑料薄膜/布</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0207','塑料板/管','t')">塑料板/管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0209','塑料带','t')">塑料带</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0211','塑料棒','t')">塑料棒</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0213','有机玻璃','t')">有机玻璃</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,2)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='五金制品'>五金制品</p></a></h1><span class='no'><h2 onclick='javascript:ShowMenu(this,0)' class='h2'><a href='javascript:void(0)'>结构五金</a></h2><ul class='no'><li><a href='javascript:void(0)' onclick="lbs(this,'030101','铆钉','')">铆钉</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030103','螺钉','')">螺钉</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030105','螺栓','')">螺栓</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030107','膨胀螺栓','')">膨胀螺栓</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030108','化学锚栓','')">化学锚栓</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030109','螺母','')">螺母</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030111','螺柱','')">螺柱</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030113','垫圈','')">垫圈</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030115','挡圈','')">挡圈</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030117','销','')">销</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030119','键','')">键</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030121','普通钉类','')">普通钉类</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030123','网、丝、布','')">网、丝、布</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030125','铁丝','')">铁丝</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030127','铁件','')">铁件</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030129','内爆','')">内爆</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030131','吊杆','')">吊杆</a></li></ul><h2 onclick='javascript:ShowMenu(this,1)' class='h2'><a href='javascript:void(0)'>门窗、幕墙五金</a></h2><ul class='no'><li><a href='javascript:void(0)' onclick="lbs(this,'030301','门锁','')">门锁</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030302','窗锁','')">窗锁</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030303','执手','')">执手</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030305','撑档','')">撑档</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030307','合页','')">合页</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030309','闭门器','')">闭门器</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030311','窗钩','')">窗钩</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030313','门吸','')">门吸</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030315','感应启动门装置','')">感应启动门装置</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030317','轨道','')">轨道</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030319','门镜','')">门镜</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030321','地弹簧','')">地弹簧</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030323','门夹','')">门夹</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030325','驳接件','')">驳接件</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030327','吊挂件','')">吊挂件</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030329','滑轮','')">滑轮</a></li></ul><h2 onclick='javascript:ShowMenu(this,2)' class='h2'><a href='javascript:void(0)'>家俱五金</a></h2><ul class='no'><li><a href='javascript:void(0)' onclick="lbs(this,'030501','铰链','')">铰链</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030503','拉手','')">拉手</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030505','抽屉锁','')">抽屉锁</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030507','脚轮','')">脚轮</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030509','插销','')">插销</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030511','其它五金','')">其它五金</a></li></ul><h2 onclick='javascript:ShowMenu(this,3)' class='h2'><a href='javascript:void(0)'>水暖及卫浴五金</a></h2><ul class='no'><li><a href='javascript:void(0)' onclick="lbs(this,'030701','水嘴（水龙头）','')">水嘴（水龙头）</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030703','淋浴器','')">淋浴器</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030705','排水栓','')">排水栓</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030707','地漏','')">地漏</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030709','扫除口','')">扫除口</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030711','存水弯','')">存水弯</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030713','检查口','')">检查口</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'030715','其它卫浴五金','')">其它卫浴五金</a></li></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0313','低值易耗品','t')">低值易耗品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0315','磨具','t')">磨具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0317','磨料','t')">磨料</a></h2><ul class='no'></ul><h2 onclick='javascript:ShowMenu(this,7)' class='h2'><a href='javascript:void(0)'>焊材及辅助用料</a></h2><ul class='no'><li><a href='javascript:void(0)' onclick="lbs(this,'031901','焊条','')">焊条</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'031903','焊丝','')">焊丝</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'031905','焊剂、焊粉','')">焊剂、焊粉</a></li><li><a href='javascript:void(0)' onclick="lbs(this,'031907','钎焊料及熔剂','')">钎焊料及熔剂</a></li></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0321','五金配件','t')">五金配件</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,3)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='水泥、砖瓦灰砂石及混凝土制品'>水泥、砖瓦灰砂石及混凝土制品</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0401','水泥','t')">水泥</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0403','砂','t')">砂</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0405','石子','t')">石子</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0407','轻骨料','t')">轻骨料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0409','灰、粉、土等掺合填充料','t')">灰、粉、土等掺合填充料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0411','石料','t')">石料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0413','砌砖','t')">砌砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0415','砌块','t')">砌块</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0417','瓦','t')">瓦</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0427','水泥及砼预制品','t')">水泥及砼预制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0429','钢筋砼预制件','t')">钢筋砼预制件</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,4)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='木及竹基层材料'>木及竹基层材料</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0501','原木','t')">原木</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0503','木皮','t')">木皮</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0505','锯材（基础木材）','t')">锯材（基础木材）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0507','胶合板','t')">胶合板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0509','纤维板','t')">纤维板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0511','细木工板','t')">细木工板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0513','空心木板','t')">空心木板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0515','刨花板','t')">刨花板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0517','竹材','t')">竹材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0519','竹板','t')">竹板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0521','欧松板','t')">欧松板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0523','落叶松板材','t')">落叶松板材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0525','红松板材','t')">红松板材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0527','白松板材','t')">白松板材</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,5)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='玻璃及玻璃制品'>玻璃及玻璃制品</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0601','浮法玻璃','t')">浮法玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0603','有色玻璃','t')">有色玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0605','钢化玻璃','t')">钢化玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0607','夹丝玻璃','t')">夹丝玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0609','夹层玻璃','t')">夹层玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0611','中空玻璃','t')">中空玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0613','镀膜玻璃','t')">镀膜玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0615','工艺装饰玻璃','t')">工艺装饰玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0617','镭射玻璃','t')">镭射玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0619','特种玻璃','t')">特种玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0620','玻璃镜','t')">玻璃镜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0621','玻璃马赛克','t')">玻璃马赛克</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0623','其它玻璃','t')">其它玻璃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0625','玻璃砖','t')">玻璃砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0627','防爆膜','t')">防爆膜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0629','玻璃膜','t')">玻璃膜</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,6)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='墙砖及地类材料'>墙砖及地类材料</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0701','陶瓷内墙砖','t')">陶瓷内墙砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0703','陶瓷外墙砖','t')">陶瓷外墙砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0705','陶瓷地砖','t')">陶瓷地砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0707','马赛克','t')">马赛克</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0709','石塑地砖','t')">石塑地砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0711','塑料地砖','t')">塑料地砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0713','实木地板','t')">实木地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0715','软木地板','t')">软木地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0717','竹地板','t')">竹地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0719','塑料地板','t')">塑料地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0721','橡胶、塑胶地板','t')">橡胶、塑胶地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0723','复合地板','t')">复合地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0725','活动、防静电地板','t')">活动、防静电地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0727','亚麻环保地板 ','t')">亚麻环保地板 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0729','地毯','t')">地毯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0731','挂毯、门毡','t')">挂毯、门毡</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0733','其它地板','t')">其它地板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0735','粘土饰面砖','t')">粘土饰面砖</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,7)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='石料及石材制品'>石料及石材制品</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0801','大理石','t')">大理石</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0803','花岗石','t')">花岗石</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0805','青石（石灰石）','t')">青石（石灰石）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0807','文化石及麻石材','t')">文化石及麻石材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0809','人造石板材','t')">人造石板材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0811','微晶玻璃板','t')">微晶玻璃板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0813','水磨石板','t')">水磨石板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0815','石材加工制品','t')">石材加工制品</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,8)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='墙面及屋面材料'>墙面及屋面材料</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'0901','石膏装饰板','t')">石膏装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0903','竹木装饰板','t')">竹木装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0905','金属装饰板','t')">金属装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0907','矿物棉装饰板','t')">矿物棉装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0909','塑料装饰板','t')">塑料装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0911','复合装饰板','t')">复合装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0913','铝塑复合板','t')">铝塑复合板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0915','纤维水泥装饰板','t')">纤维水泥装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0917','珍珠岩装饰板','t')">珍珠岩装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0919','硅酸钙装饰板','t')">硅酸钙装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0923','其它装饰板','t')">其它装饰板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0925','轻质复合墙板、屋面板','t')">轻质复合墙板、屋面板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0927','网格布/带','t')">网格布/带</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0929','壁画','t')">壁画</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0931','壁纸','t')">壁纸</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0933','壁布','t')">壁布</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0935','箔制品','t')">箔制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0937','格栅、格片/挂片','t')">格栅、格片/挂片</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0939','隔断及筒形天棚','t')">隔断及筒形天棚</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0941','石膏装饰线','t')">石膏装饰线</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0943','木装饰板/线','t')">木装饰板/线</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'0945','石膏装饰板/线','t')">石膏装饰板/线</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,9)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='龙骨及龙骨配件'>龙骨及龙骨配件</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1001','轻钢龙骨','t')">轻钢龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1003','铝合金龙骨','t')">铝合金龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1005','木龙骨','t')">木龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1007','烤漆龙骨','t')">烤漆龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1009','石膏龙骨','t')">石膏龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1011','不锈钢龙骨','t')">不锈钢龙骨</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1013','轻钢龙骨配件','t')">轻钢龙骨配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1015','铝合金龙骨配件','t')">铝合金龙骨配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1017','其它龙骨配件','t')">其它龙骨配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1019','龙骨配件','t')">龙骨配件</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,10)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='门窗及楼梯制品'>门窗及楼梯制品</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1101','木门窗','t')">木门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1103','钢门窗','t')">钢门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1105','彩钢门窗','t')">彩钢门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1107','不锈钢门窗','t')">不锈钢门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1109','铝合金门窗','t')">铝合金门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1111','塑钢门窗','t')">塑钢门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1113','塑料门窗','t')">塑料门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1115','玻璃钢门窗','t')">玻璃钢门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1117','铁艺门窗','t')">铁艺门窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1119','全玻门、自动门','t')">全玻门、自动门</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1121','纱门、纱窗','t')">纱门、纱窗</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1123','特种门 ','t')">特种门 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1125','卷帘','t')">卷帘</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1127','钢楼梯','t')">钢楼梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1129','木楼梯','t')">木楼梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1131','铁艺楼梯','t')">铁艺楼梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1133','木门','t')">木门</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,11)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='涂料及防腐防水'>涂料及防腐防水</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1301','通用涂料','t')">通用涂料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1303','建筑涂料','t')">建筑涂料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1305','功能性涂料','t')">功能性涂料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1307','木器专用涂料','t')">木器专用涂料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1309','颜料','t')">颜料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1311','沥青','t')">沥青</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1313','防水卷材','t')">防水卷材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1315','油膏、胶、粘结材料','t')">油膏、胶、粘结材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1317','止水材料','t')">止水材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1319','其它防腐防水材料','t')">其它防腐防水材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1321','油漆','t')">油漆</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,12)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='油品及化工原料'>油品及化工原料</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1401','燃料油','t')">燃料油</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1403','溶剂油、绝缘油','t')">溶剂油、绝缘油</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1405','润滑油','t')">润滑油</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1407','润滑脂 、蜡','t')">润滑脂 、蜡</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1409','无机化工原料','t')">无机化工原料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1411','有机化工原料','t')">有机化工原料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1413','化工剂类','t')">化工剂类</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1415','化工腻子粉','t')">化工腻子粉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1417','工业气体','t')">工业气体</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1419','化工胶类','t')">化工胶类</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1421','化工填料','t')">化工填料</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,13)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='绝缘保温及耐火'>绝缘保温及耐火</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1501','石棉及其制品','t')">石棉及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1503','岩棉及其制品','t')">岩棉及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1505','矿渣棉及其制品','t')">矿渣棉及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1507','玻璃棉及其制品','t')">玻璃棉及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1509','膨胀珍珠岩及其制品','t')">膨胀珍珠岩及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1511','膨胀蛭石及其制品','t')">膨胀蛭石及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1513','泡沫橡胶（塑料）及其制品','t')">泡沫橡胶（塑料）及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1515','泡沫玻璃及其制品','t')">泡沫玻璃及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1517','复合硅酸盐绝热材料','t')">复合硅酸盐绝热材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1519','硅藻土及其制品','t')">硅藻土及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1521','其它绝热材料','t')">其它绝热材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1525','粘土质耐火砖','t')">粘土质耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1527','硅质耐火砖','t')">硅质耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1529','铝质耐火砖','t')">铝质耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1531','镁质耐火砖','t')">镁质耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1533','刚玉砖','t')">刚玉砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1535','其它耐火砖','t')">其它耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1537','耐火泥、砂、石','t')">耐火泥、砂、石</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1539','不定形耐火材料','t')">不定形耐火材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1541','耐火纤维及其制品','t')">耐火纤维及其制品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1543','耐火粉、骨料','t')">耐火粉、骨料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1545','其它耐火材料','t')">其它耐火材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1547','泡沫聚苯板/管','t')">泡沫聚苯板/管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1549','挤塑板','t')">挤塑板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1551','橡塑保温材料','t')">橡塑保温材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1553','耐火砖','t')">耐火砖</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1555','保温材料','t')">保温材料</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,14)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='吸声及抗辐射'>吸声及抗辐射</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1601','木制吸音板','t')">木制吸音板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1603','复合吸音板','t')">复合吸音板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1604','金属吸音板','t')">金属吸音板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1605','隔声棉','t')">隔声棉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1607','空间吸声体','t')">空间吸声体</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1609','表面防护材料','t')">表面防护材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1611','无损探伤材料','t')">无损探伤材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1613','防辐射材料','t')">防辐射材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1615','矿棉吸音板','t')">矿棉吸音板</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,15)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='家具'>家具</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1701','柜类家具','t')">柜类家具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1703','桌类家具','t')">桌类家具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1705','坐具类家具','t')">坐具类家具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1707','床类家具','t')">床类家具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1709','箱类家具','t')">箱类家具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1711','架类家具','t')">架类家具</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,16)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='饰品类'>饰品类</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1801','窗帘','t')">窗帘</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1803','屏风','t')">屏风</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1805','装饰小品','t')">装饰小品</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,17)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='管材'>管材</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'1901','给水管材','t')">给水管材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'1902','排水管材','t')">排水管材</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,18)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='管件及法兰'>管件及法兰</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2001','铸铁管件','t')">铸铁管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2003','钢管管件','t')">钢管管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2005','不锈钢管件','t')">不锈钢管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2007','铜管件','t')">铜管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2009','塑料管件','t')">塑料管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2011','钢塑复合管件','t')">钢塑复合管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2013','铝塑复合管件','t')">铝塑复合管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2015','过滤器','t')">过滤器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2017','补偿器','t')">补偿器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2019','其它管件','t')">其它管件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2021','钢制法兰','t')">钢制法兰</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2023','不锈钢法兰','t')">不锈钢法兰</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2025','其它法兰 ','t')">其它法兰 </a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,19)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='阀门'>阀门</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2101','截止阀','t')">截止阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2103','闸阀','t')">闸阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2105','球阀','t')">球阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2107','碟阀','t')">碟阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2109','止回阀','t')">止回阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2111','安全阀','t')">安全阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2113','调节阀','t')">调节阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2115','节流阀','t')">节流阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2117','疏水阀','t')">疏水阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2119','旋塞阀','t')">旋塞阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2121','减压阀','t')">减压阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2123','电磁阀','t')">电磁阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2125','水位控制阀','t')">水位控制阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2127','平衡阀','t')">平衡阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2129','浮球阀','t')">浮球阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2131','其它阀门 ','t')">其它阀门 </a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,20)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='洁具'>洁具</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2201','浴缸、浴盘','t')">浴缸、浴盘</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2203','淋浴间、淋浴屏','t')">淋浴间、淋浴屏</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2205','洗脸盆、洗手盆','t')">洗脸盆、洗手盆</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2207','小便器','t')">小便器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2209','蹲式大便器','t')">蹲式大便器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2210','坐式大便器','t')">坐式大便器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2211','烘手器','t')">烘手器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2213','喷香机、给皂器','t')">喷香机、给皂器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2215','洗涤槽','t')">洗涤槽</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,21)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='水暖及通风器材'>水暖及通风器材</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2301','散热器','t')">散热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2303','钢制散热器','t')">钢制散热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2305','铝制散热器','t')">铝制散热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2307','铜及复合散热器','t')">铜及复合散热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2309','其它散热器及附件','t')">其它散热器及附件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2311','水箱','t')">水箱</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2313','风机盘管','t')">风机盘管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2315','风口','t')">风口</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2317','风管','t')">风管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2319','风帽','t')">风帽</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2321','风口过滤器、过滤网','t')">风口过滤器、过滤网</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2323','调节阀','t')">调节阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2324','防火阀','t')">防火阀</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2325','消声器','t')">消声器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2327','其它水暖通风器材','t')">其它水暖通风器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2329','吊风扇、壁扇','t')">吊风扇、壁扇</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2331','风机','t')">风机</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,22)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='消防器材'>消防器材</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2401','灭火器','t')">灭火器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2403','消火栓','t')">消火栓</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2405','消防水泵接合器','t')">消防水泵接合器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2407','消防箱、柜','t')">消防箱、柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2409','消防喷头','t')">消防喷头</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2411','软管卷盘、水龙带及接扣','t')">软管卷盘、水龙带及接扣</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2413','报警器','t')">报警器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2415','其它消防器材','t')">其它消防器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2417','探测器','t')">探测器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2419','模块','t')">模块</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2421','报警主机','t')">报警主机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2423','数字智能消防巡检系统','t')">数字智能消防巡检系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2425','电气火灾监控设备','t')">电气火灾监控设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,23)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='灯具、光源'>灯具、光源</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2501','光源','t')">光源</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2503','装饰花灯','t')">装饰花灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2505','吸顶灯','t')">吸顶灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2507','壁灯','t')">壁灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2509','筒灯','t')">筒灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2511','格栅灯（荧光灯盘）','t')">格栅灯（荧光灯盘）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2513','射灯','t')">射灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2515','台灯、落地灯','t')">台灯、落地灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2517','其他室内灯具','t')">其他室内灯具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2519','泛光灯、投光灯','t')">泛光灯、投光灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2521','地埋灯','t')">地埋灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2523','庭院、草坪','t')">庭院、草坪</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2525','广场、道路、景观灯','t')">广场、道路、景观灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2527','太阳能路灯','t')">太阳能路灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2529','标志、应急灯','t')">标志、应急灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2531','厂矿、场馆用灯','t')">厂矿、场馆用灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2533','医院专用灯','t')">医院专用灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2535','歌舞厅灯','t')">歌舞厅灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2537','隧道灯','t')">隧道灯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2539','灯头、灯座、灯罩','t')">灯头、灯座、灯罩</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2541','灯架','t')">灯架</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2543','灯戗、灯伞、灯臂','t')">灯戗、灯伞、灯臂</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2545','镇流器','t')">镇流器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2547','其它灯具及附件','t')">其它灯具及附件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2549','浴霸','t')">浴霸</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,24)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='电料线路及器材'>电料线路及器材</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2601','电气开关','t')">电气开关</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2603','面板、边框、盖板','t')">面板、边框、盖板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2605','开关、插座功能件','t')">开关、插座功能件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2607','电源插座','t')">电源插座</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2609','电源插头','t')">电源插头</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2611','电源插座转换器','t')">电源插座转换器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2613','保险器材','t')">保险器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2615','绝缘材料','t')">绝缘材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2617','绝缘电线','t')">绝缘电线</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2619','绝缘电力电缆','t')">绝缘电力电缆</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2621','同轴通信电缆','t')">同轴通信电缆</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2623','电缆桥架','t')">电缆桥架</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2625','桥架附件','t')">桥架附件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2627','线槽','t')">线槽</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2629','电线电缆套管','t')">电线电缆套管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2631','接线盒','t')">接线盒</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2633','信息线缆','t')">信息线缆</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,25)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='弱电及信息类'>弱电及信息类</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'2701','安防报警、出入口控制器材','t')">安防报警、出入口控制器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2703','安防检查、监控显示器材','t')">安防检查、监控显示器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2705','停车场管理系统器材','t')">停车场管理系统器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2707','电话通讯设备器材','t')">电话通讯设备器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2709','广播线路、移动通信器材','t')">广播线路、移动通信器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2711','有线电视、卫星电视器材','t')">有线电视、卫星电视器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2713','信息插座插头器材','t')">信息插座插头器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2715','计算机网络系统器材','t')">计算机网络系统器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2717','楼宇小区自控及多表远传系统','t')">楼宇小区自控及多表远传系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2719','扩声、音乐背景器材','t')">扩声、音乐背景器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'2721','其它弱电及信息类器材','t')">其它弱电及信息类器材</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,26)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='周转材料'>周转材料</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'3701','模板','t')">模板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3703','模板附件','t')">模板附件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3705','脚手架及其配件','t')">脚手架及其配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3707','围护、运输类周转材料','t')">围护、运输类周转材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3709','胎具、模具类周转材料','t')">胎具、模具类周转材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3711','活动板房','t')">活动板房</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3713','其它周转材料','t')">其它周转材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3715','钢管，卡子','t')">钢管，卡子</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,27)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='劳保及低值易耗'>劳保及低值易耗</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'3901','防护用品','t')">防护用品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3903','低值易耗品','t')">低值易耗品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'3905','标识牌','t')">标识牌</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,28)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='通风空调设备'>通风空调设备</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5001','组合式空气处理机','t')">组合式空气处理机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5003','空调器','t')">空调器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5005','冷热水机组','t')">冷热水机组</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5006','冷却塔','t')">冷却塔</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5009','压缩机','t')">压缩机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5011','空气幕','t')">空气幕</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5013','空气加热、冷却器','t')">空气加热、冷却器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5015','换热器（蒸发器、冷凝器）','t')">换热器（蒸发器、冷凝器）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5017','空调配件','t')">空调配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5019','诱导器','t')">诱导器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5023','喷雾室','t')">喷雾室</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5025','净化过滤设备','t')">净化过滤设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5027','其它','t')">其它</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5029','通风机','t')">通风机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5031','鼓风机','t')">鼓风机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5033','吊风扇、壁扇','t')">吊风扇、壁扇</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5035','排气扇、换气扇','t')">排气扇、换气扇</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5037','台扇、落地扇','t')">台扇、落地扇</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5039','变速器','t')">变速器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5041','其它','t')">其它</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,29)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='泵及供水设备'>泵及供水设备</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5101','离心泵','t')">离心泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5103','离心式油泵','t')">离心式油泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5105','离心式耐腐蚀泵','t')">离心式耐腐蚀泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5107','离心式杂质泵','t')">离心式杂质泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5109','轴流泵','t')">轴流泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5110','混流泵','t')">混流泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5111','旋涡泵','t')">旋涡泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5113','往复泵','t')">往复泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5115','转子泵','t')">转子泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5117','计量泵','t')">计量泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5119','真空泵','t')">真空泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5123','射流泵','t')">射流泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5125','气体扬水泵','t')">气体扬水泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5127','水锤泵','t')">水锤泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5129','电磁泵','t')">电磁泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5131','水轮泵','t')">水轮泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5133','其它泵','t')">其它泵</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5135','泵专用配件','t')">泵专用配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5139','供水设备','t')">供水设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5141','供水控制柜','t')">供水控制柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5143','潜水泵','t')">潜水泵</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,30)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='热水及采暖锅炉'>热水及采暖锅炉</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5201','热水器','t')">热水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5202','电开水器','t')">电开水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5203','沸水器','t')">沸水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5205','冷热水混合器','t')">冷热水混合器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5207','换热器','t')">换热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5209','采暖炉','t')">采暖炉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5211','成套水暖装置','t')">成套水暖装置</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5213','其它水暖设备','t')">其它水暖设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5221','热水锅炉','t')">热水锅炉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5223','蒸汽锅炉','t')">蒸汽锅炉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5229','其它锅炉设备','t')">其它锅炉设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,31)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='太阳能及集热'>太阳能及集热</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5301','真空管太阳能热水器','t')">真空管太阳能热水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5303','板式太阳能热水器','t')">板式太阳能热水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5305','集热器','t')">集热器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5307','集热管','t')">集热管</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5309','太阳能集热设备','t')">太阳能集热设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5311','太阳能电池板','t')">太阳能电池板</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5313','太阳能配件','t')">太阳能配件</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,32)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='水处理及环保'>水处理及环保</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5401','水处理成套设备','t')">水处理成套设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5403','格栅类拦污设备','t')">格栅类拦污设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5405','水软化设备','t')">水软化设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5407','高纯水制取设备','t')">高纯水制取设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5409','水垢处理设备','t')">水垢处理设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5411','灭菌消毒、加药装置','t')">灭菌消毒、加药装置</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5413','过滤设备','t')">过滤设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5415','膜与膜设备','t')">膜与膜设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5417','曝气设备','t')">曝气设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5419','气浮设备','t')">气浮设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5421','除气设备','t')">除气设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5423','除污除砂排泥设备','t')">除污除砂排泥设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5425','污泥处理设备','t')">污泥处理设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5427','家用净水器','t')">家用净水器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5429','干蒸自动喷水系统 ','t')">干蒸自动喷水系统 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5431','生化反应器','t')">生化反应器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5433','油水分离装置','t')">油水分离装置</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5435','毛发聚集器','t')">毛发聚集器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5437','填料','t')">填料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5439','过滤材料','t')">过滤材料</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5441','除尘设备','t')">除尘设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5443','垃圾处理设施','t')">垃圾处理设施</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5445','环保厕所','t')">环保厕所</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5447','噪音防护设施','t')">噪音防护设施</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5449','其它环保设备','t')">其它环保设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,33)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='洗浴及康体设备'>洗浴及康体设备</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5501','桑拿房','t')">桑拿房</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5503','桑拿炉','t')">桑拿炉</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5505','桑拿炉丝','t')">桑拿炉丝</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5507','桑拿炉控制器','t')">桑拿炉控制器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5509','桑拿炉石 ','t')">桑拿炉石 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5511','桑拿木桶','t')">桑拿木桶</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5513','砂漏','t')">砂漏</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5515','蒸汽机','t')">蒸汽机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5517','香蒸浴蒸汽喷头','t')">香蒸浴蒸汽喷头</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5519','水伞','t')">水伞</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5521','水床','t')">水床</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5523','打濑按摩 ','t')">打濑按摩 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5525','维其浴','t')">维其浴</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5527','水蘑菇','t')">水蘑菇</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5529','过滤沙缸','t')">过滤沙缸</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5531','造浪机  ','t')">造浪机  </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5533','SPA按摩浴缸','t')">SPA按摩浴缸</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5535','水力按摩床','t')">水力按摩床</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5537','足浴按摩椅','t')">足浴按摩椅</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5539','搓澡床','t')">搓澡床</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5541','足疗桶','t')">足疗桶</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5543','沙滩椅','t')">沙滩椅</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5545','沙滩床 ','t')">沙滩床 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5547','成套游泳池设备','t')">成套游泳池设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,34)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='厨房设备'>厨房设备</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5601','冷藏、 冷冻柜（库）','t')">冷藏、 冷冻柜（库）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5603','展示柜、保鲜柜','t')">展示柜、保鲜柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5605','餐柜','t')">餐柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5607','餐架','t')">餐架</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5609','餐车','t')">餐车</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5611','洗碗机','t')">洗碗机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5613','消毒柜','t')">消毒柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5615','洗刷台、洗涮柜','t')">洗刷台、洗涮柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5617','盆台','t')">盆台</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5619','操作台、操作柜','t')">操作台、操作柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5621','小型食品加工机械','t')">小型食品加工机械</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5623','炉具','t')">炉具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5625','灶具','t')">灶具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5627','厨房刀具','t')">厨房刀具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5629','烤箱及蒸具','t')">烤箱及蒸具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5631','餐桌、餐椅','t')">餐桌、餐椅</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5633','吸油烟机','t')">吸油烟机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5635','暖碟设备','t')">暖碟设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5637','小吃设备','t')">小吃设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5639','火锅/烧腊','t')">火锅/烧腊</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5641','吧台用品','t')">吧台用品</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5643','酒吧设备','t')">酒吧设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5645','自助餐设备','t')">自助餐设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5647','抽油烟机','t')">抽油烟机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5649','面包房设备','t')">面包房设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5651','其他排烟设备','t')">其他排烟设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5653','高压静电除油器','t')">高压静电除油器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5655','不锈钢排烟罩','t')">不锈钢排烟罩</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5657','立式不锈钢洗池','t')">立式不锈钢洗池</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,35)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='电气设备及附件'>电气设备及附件</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5701','成套配电装置','t')">成套配电装置</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5703','电气屏类','t')">电气屏类</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5705','电气柜类','t')">电气柜类</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5707','箱式变电站（预装式变电站）','t')">箱式变电站（预装式变电站）</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5709','配电箱、柜','t')">配电箱、柜</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5711','配电开关','t')">配电开关</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5713','断路器','t')">断路器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5715','互感器','t')">互感器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5717','调压器、稳压器','t')">调压器、稳压器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5719','电抗器、电容器','t')">电抗器、电容器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5721','接触器','t')">接触器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5723','起动器','t')">起动器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5725','电气控制器','t')">电气控制器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5727','继电器','t')">继电器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5729','电阻器、分流器','t')">电阻器、分流器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5731','电磁器件','t')">电磁器件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5733','电笛、电铃','t')">电笛、电铃</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5735','蓄电池及附件','t')">蓄电池及附件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5737','变压器','t')">变压器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5739','高频整流器','t')">高频整流器</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5741','电容储能式系列','t')">电容储能式系列</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5743','电动机','t')">电动机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5745','发电机','t')">发电机</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5747','其它电气设备','t')">其它电气设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,36)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='电梯'>电梯</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5801','乘客电梯','t')">乘客电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5803','载货电梯','t')">载货电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5805','杂物电梯','t')">杂物电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5807','住宅电梯','t')">住宅电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5809','客货两用电梯','t')">客货两用电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5811','病床电梯','t')">病床电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5813','观光电梯','t')">观光电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5815','船用电梯','t')">船用电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5817','汽车电梯','t')">汽车电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5819','自动扶梯','t')">自动扶梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5821','别墅电梯','t')">别墅电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5823','自动人行道','t')">自动人行道</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5825','无机房电梯','t')">无机房电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5827','其它电梯','t')">其它电梯</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5829','电梯机械配件','t')">电梯机械配件</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5831','电梯电气装置','t')">电梯电气装置</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5833','电梯安装费','t')">电梯安装费</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,37)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='安防及建筑智能'>安防及建筑智能</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'5901','入侵报警设备','t')">入侵报警设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5903','出入口控制设备','t')">出入口控制设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5905','安全检查设备','t')">安全检查设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5907','电视监控设备','t')">电视监控设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5909','终端显示设备','t')">终端显示设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5911','楼宇对讲系统','t')">楼宇对讲系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5913','电子巡更系统','t')">电子巡更系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5915','其余安防设备','t')">其余安防设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5917','楼宇多表远传系统','t')">楼宇多表远传系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5919','楼宇自控系统','t')">楼宇自控系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5921','门禁系统','t')">门禁系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5923','停车场管理系统 ','t')">停车场管理系统 </a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5925','综合布线系统','t')">综合布线系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5927','计算机网络设备','t')">计算机网络设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5929','有线电视、卫星电视系统','t')">有线电视、卫星电视系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5931','扩声、背景音乐系统','t')">扩声、背景音乐系统</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5933','微波无线接入设备','t')">微波无线接入设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5935','会议电话设备','t')">会议电话设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5937','视频会议设备','t')">视频会议设备</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5939','同声传译设备及器材','t')">同声传译设备及器材</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'5941','其它智能化设备','t')">其它智能化设备</a></h2><ul class='no'></ul></span><h1 onclick="javascript:ShowMenu(this,38)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='体育休闲设施'>体育休闲设施</p></a></h1><span class='no'></span><h1 onclick="javascript:ShowMenu(this,39)" class='h1'><a href='javascript:void(0)'><img style='float:left;' src='images/biao2.jpg' alt=''><p style=' cursor:pointer;' title='施工机械及仪表'>施工机械及仪表</p></a></h1><span class='no'><h2><a href='javascript:void(0)' onclick="lbs(this,'9801','手动工具','t')">手动工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9803','手动起重工具','t')">手动起重工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9805','气动工具','t')">气动工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9807','电动工具','t')">电动工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9809','土木工具','t')">土木工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9811','钳工工具','t')">钳工工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9813','水暖工具','t')">水暖工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9815','电工工具','t')">电工工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9817','测量工具','t')">测量工具</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9819','施工用机械','t')">施工用机械</a></h2><ul class='no'></ul><h2><a href='javascript:void(0)' onclick="lbs(this,'9821','施工用仪表','t')">施工用仪表</a></h2><ul class='no'></ul></span></div></div>
            <div id="Div3" style="width: 775px; min-height: 400px; margin-left: 227px; height: auto;">
                <div style="width: 770px; border: 0px; height: auto;">
                    <div id="allcl" runat="server" style="width: 770px; height: auto;">
                        <table width="740" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" style="table-layout：fixed;
                            word-wrap：break-word">
                            <thead>
                                <tr>
                                    <th width="70" height="30" align="center" bgcolor="#E3ECFF">
                                        <strong>属性名称</strong>
                                    </th>
                                    <th align="center" bgcolor="#E3ECFF">
                                        <strong>规格\型号</strong>
                                    </th>
                                    <th width="80" align="center" bgcolor="#E3ECFF">
                                        <strong>选中项</strong>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="sx">
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td width="120" height="32" align="right" bgcolor="#FFFFFF" style="text-align: center;">
                                        名称及规格
                                    </td>
                                    <td align="left" bgcolor="#FFFFFF">
                                        <input type="text" runat="server" id="clmcjgg" name="clmcjgg" style="width: 293px;" />
                                    </td>
                                    <td width="80" align="center" bgcolor="#FFFFFF">
                                        <input type="Button" name="btnDocNew" value="确定" onclick="AddValue()" class="filter"
                                            style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px;
                                            width: 37px; cursor: pointer;" />
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div id="Div1" style="width: 770px; height: auto;">
                        <table id="Table1" width="730" border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed;
                            word-wrap：break-word; margin-top: 10px; border: 1px solid #ddd; padding: 10px 0;">
                            <tbody id="Tbody1">
                                <tr>
                                    <td width="100" height="36" align="right" bgcolor="#FFFFFF">
                                        产品编号：
                                    </td>
                                    <td height="24" colspan="3" align="left" bgcolor="#FFFFFF">
                                        <label for="textfield">
                                        </label>
                                        <input name="cl_name4" type="text" runat="server" id="cpbh" class="hyzhc_shrk9" readonly="readonly" />
                                    </td>
                                    <td width="100" align="right" bgcolor="#FFFFFF">
                                        产品名称：
                                    </td>
                                    <td colspan="3" align="left" bgcolor="#FFFFFF">
                                        <input type="text" runat="server" id="mcgz" name="mcgz" class="hyzhc_shrk9" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100" height="36" align="right" bgcolor="#FFFFFF">
                                        计量单位：
                                    </td>
                                    <td width="80" height="24" align="center" bgcolor="#FFFFFF">
                                        <input type="text" runat="server" name="jldw" id="jldw" class="hyzhc_shrk8" />
                                    </td>
                                    <td width="80" align="right" bgcolor="#FFFFFF">
                                        单位重量：
                                    </td>
                                    <td width="80" align="left" bgcolor="#FFFFFF">
                                        <input type="text" name="dwzl" runat="server" id="dwzl" class="hyzhc_shrk8" />
                                    </td>
                                    <td width="100" align="right" bgcolor="#FFFFFF">
                                        单位体积：
                                    </td>
                                    <td width="80" align="left" bgcolor="#FFFFFF">
                                        <input type="text" id="dwtj" runat="server" name="dwtj" class="hyzhc_shrk8" />
                                    </td>
                                    <td width="80" align="right" bgcolor="#FFFFFF">
                                        指导价格：
                                    </td>
                                    <td align="left" bgcolor="#FFFFFF">
                                        <input type="text" id="cpjg" name="cpjg" runat="server" class="hyzhc_shrk8" />
                                    </td>
                                </tr>
                                <tr>
                                    <td height="80" align="right" bgcolor="#FFFFFF">
                                        产品说明：
                                    </td>
                                    <td height="80" colspan="7" align="center" bgcolor="#FFFFFF">
                                        <textarea class="hyzhc_shrk2_2" runat="server" cols="40" id="yyfw" name="yyfw" rows="6"
                                            style="100%"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 20px; background: #FFFFFF" colspan="8">
                                        <dd style="text-align: center; float: right; margin-right: 20px;">
                                            <input type="submit" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                                                font-size: 12px; height: 20px; width: 37px; cursor: pointer;" value="保存" /></dd>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="cpdt_2" style="width: 740px; height: 260px;">
                            <!--+图片上传 高度240px; 宽度：740px；--------------------------------------------------------------------------------------------------------------------->
                            <!--position:absolute; width:100%; height:100%; background:#000; opacity:0.7; z-index:99;-->
                            <div id="ceng" style="width: 740px; height: 270px; float: left; position: absolute;
                                background: #000; opacity: 0.2; z-index: 99; font-size: 15px; text-align: center;
                                line-height: 240px; filter: alpha(opacity=20); color: White;">
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
                            <div class="yeqian" id="con_two_1" style="border: #4ea6ee 1px solid; width: 700px;">
                                <div class="yeqian1">
                                    <div class="yq_img">
                                        <div id="imgQ" style="float: left; width: 322px; height: 90px; border: 1px solid #DDDDDD;">
                                            <!--图1begin-->
                                            <div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left: 2px;
                                                margin-top: 2px;'>
                                                <div style='background-image: url(images/sccptp.jpg); background-size: 60px 60px;
                                                    width: 60px; height: 60px; float: left;'>
                                                    <a class='imgDel' href='javascript:void(0);' style='background-image: url(images/shanchu.gif);
                                                        width: 11px; height: 10px; float: right;'></a>
                                                </div>
                                                <div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'>
                                                    图片名称</div>
                                            </div>
                                            <!--图1end-->
                                            <!--图1begin-->
                                            <!--图1end-->
                                            <!--图1begin-->
                                            <!--图1end-->
                                            <!--图1begin-->
                                            <!--图1end-->
                                            <!--图1begin-->
                                            <!--图1end-->
                                        </div>
                                        <div class="anniu_sc">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tbody>
                                                    <tr style="width: 100px">
                                                        <td height="30" align="center">
                                                            请选择图片：
                                                        </td>
                                                        <td align="left">
                                                            <input name="imgUploadify" id="imgUploadify" type="button" />
                                                        </td>
                                                    </tr>
                                                    <tr style="width: 100px">
                                                        <td height="20" align="center">
                                                        </td>
                                                        <td align="left">
                                                            <input id="btnImgUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px;
                                                                border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none;
                                                                color: black; border-right-style: none; width: 72px" type="button" value="上传图片" />
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
                            <div class="yeqian" id="con_two_2" style="border: 1px solid #4ea6ee; padding-top: 10px;
                                display: none; height: auto;">
                                <div class="yeqian_cont">
                                    <!--+编辑器开始------------------------------------------------------------------>
                                    <div id="divXh" style="width: 700px; height: 195px;">
                                        <textarea id="elm" name="elm" rows="12" cols="80" style="height: 100%; width: 100%;
                                            background: 'url(http://xheditor.com/img/demobg.jpg) no-repeat right bottom fixed;';"></textarea>
                                        <div id="drag" style="width: 383px; height: 28px; position: absolute; top: 0px; left: 511px;">
                                        </div>
                                    </div>
                                    <!--+编辑器结束------------------------------------------------------------------>
                                </div>
                            </div>
                            <div class="yeqian" id="con_two_3" style="border: 1px solid #4ea6ee; padding-top: 10px;
                                display: none;">
                                <table width="700" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
                                    <tr>
                                        <td width="90" height="30" align="center">
                                            标 题：
                                        </td>
                                        <td colspan="5" align="left">
                                            <input name="domName" type="text" class="shr_wenzi400" id="domName" style="border: 1px solid #ddd;"
                                                value="" maxlength="200">
                                        </td>
                                        <td width="150" colspan="2" align="center">
                                            <input type="button" id="btnSaveDomTitleAndMsg" style="background-image: url(images/ZYM_lb_an8.gif);
                                                background-repeat: no-repeat; display: none; width: 110px; height: 20px;" name="name"
                                                value="修改标题和说明" />
                                            <%-- </td>
                                        <td width="70" align="left">--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="54" width="90" align="center">
                                            说 明：
                                        </td>
                                        <td colspan="7" align="left">
                                            <input name="domMsg" type="text" class="shr_wenzi590" id="domMsg" style="border: 1px solid #ddd;"
                                                value="">
                                        </td>
                                    </tr>
                                </table>
                                <table width="700" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="30" align="right">
                                            请选择文档：
                                        </td>
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
                                        <td height="15">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <input id="btnDomUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px;
                                                border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none;
                                                color: black; border-right-style: none; width: 72px" type="button" value="上传文档">
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="right">
                                            已上传文档：
                                        </td>
                                        <td colspan="2">
                                            <label id="domDelName" style="width: auto; height: auto;">
                                                您还未上传文档！</label>
                                            <input id="btnDelNewDom" class="filter" style="border-top-style: none; cursor: pointer;
                                                font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none;
                                                color: black; border-right-style: none; width: 37px" type="button" value="删除" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="yeqian" id="con_two_4" style="border: 1px solid #4ea6ee; padding-top: 10px;
                                display: none;">
                                <table width="700" border="0" cellspacing="0" cellpadding="0" style="margin_top: 10px;
                                    padding-top: 10px;">
                                    <tr>
                                        <td width="90" height="30" align="center">
                                            标 题：
                                        </td>
                                        <td colspan="5" align="left">
                                            <input name="videoName" type="text" class="shr_wenzi400" id="videoName" style="border: 1px solid #ddd;"
                                                value="" maxlength="200" />
                                        </td>
                                        <td width="150" colspan="2" align="center">
                                            <input type="button" class="filter" id="btnSaveVideoTitleAndMsg" style="background-image: url(images/ZYM_lb_an8.gif);
                                                background-repeat: no-repeat; display: none; width: 110px; height: 20px;" name="name"
                                                value="修改标题和说明" />
                                            <%--上传人：
                                        </td>
                                        <td width="70" align="left">
                                            谭刚--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="54" align="center">
                                            说 明：
                                        </td>
                                        <td colspan="7" align="left">
                                            <input name="videoMsg" type="text" class="shr_wenzi590" id="videoMsg" style="border: 1px solid #ddd;"
                                                value="" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="700" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="30" align="right">
                                            请选择视频：
                                        </td>
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
                                        <td height="15">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <input id="btnVideoUploadfy" style="border-top-style: none; cursor: pointer; font-size: 12px;
                                                border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none;
                                                color: black; border-right-style: none; width: 72px" type="button" value="上传视频">
                                        </td>
                                        <td align="left">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="right">
                                            已上传视频：
                                        </td>
                                        <td colspan="2">
                                            <label id="videoDelName" style="width: auto; height: auto;">
                                                您还未上传视频</label>
                                            <input id="btnDelNewVideo" class="filter" style="border-top-style: none; cursor: pointer;
                                                font-size: 12px; border-left-style: none; height: 20px; font-family: 宋体; border-bottom-style: none;
                                                color: black; border-right-style: none; width: 37px" type="button" value="删除" />
                                        </td>
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
        <div class="cgdlqq">
        </div>
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
