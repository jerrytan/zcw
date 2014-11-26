<!--
        会员用户管理页面
        文件名：hyyhgl.aspx
        传入参数：
                p  列表页数
        负责人:  苑伟业
-->
<%--<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta content="IE=10.000" http-equiv="X-UA-Compatible">
    <title>会员用户管理</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="Scripts/external/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.core.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.mouse.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.draggable.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.position.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.resizable.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.dialog.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.effect.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.effect-blind.js" type="text/javascript"></script>
    <script src="Scripts/ui/jquery.ui.effect-explode.js" type="text/javascript"></script>
    <script type="text/javascript">
    $.fx.speeds._default = 1000;
//	$(function() {
//		$( "#AddDialog" ).dialog({
//			autoOpen: false,
//			show: "blind",
//			hide: "explode",
//            modal:true,
//            width:305,
//            buttons: {
//				"提交": function() {
//                    var scm;
//                    var fxm;
//                    var clm;
//                    if ($("#cbx1").attr("checked")=="checked") {
//                        scm=1;
//                    }
//                    else {
//                        scm=0;
//                        }
//                    if ($("#cbx2").attr("checked")=="checked") {
//                        fxm=1;
//                    }else{
//                        fxm=0;
//                    }
//                    if ($("#cbx3").attr("checked")=="checked") {
//                        clm=1;
//                    }else{
//                        clm=0;
//                    }
//                    
//                    var url={
//                        "action":"scsAdd",
//                        "qq":$("#newQQ").val(),
//                        "name":$("#newName").val(),
//                        "phone":$("#newPhone").val(),
//                        "email":$("#newEmail").val(),
//                        "scm":scm,
//                        "fxm":fxm,
//                        "clm":clm

//                    };
//                    $.get("Ashx/userManager.ashx",url,function(data){
//                        if (data=="true") {
//                            $( this ).dialog( "close" );
//                        }
//                        else {
//                            alert(data);
//                        }
//                    });
//					
//				},
//				"取消": function() {
//					$( this ).dialog( "close" );
//				}
//			}
//		});

//		$( "#btnDocNew" ).click(function() {
//			$( "#AddDialog" ).dialog( "open" );
//			return false;
//		});
//	});






        function deleteS() {
            alert("删除成功");
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
        function onloadEvent(func) {
            var one = window.onload
            if (typeof window.onload != 'function') {
                window.onload = func
            }
            else {
                window.onload = function () {
                    one();
                    func();
                }
            }
        }
        function showtable() {
            var tableid = 'table'; 	//表格的id
            var overcolor = '#fff0e9'; //鼠标经过颜色
            var color1 = '#f2f6ff'; //第一种颜色
            var color2 = '#fff'; 	//第二种颜色
            var tablename = document.getElementById(tableid)
            var tr = tablename.getElementsByTagName("tr")
            for (var i = 1; i < tr.length; i++) {
                tr[i].onmouseover = function () {
                    this.style.backgroundColor = overcolor;
                }
                tr[i].onmouseout = function () {
                    if (this.rowIndex % 2 == 0) {
                        this.style.backgroundColor = color1;
                    } else {
                        this.style.backgroundColor = color2;
                    }
                }
                if (i % 2 == 0) {
                    tr[i].className = "color1";
                } else {
                    tr[i].className = "color2";
                }
            }
        }
        onloadEvent(showtable);

        //刷新页面
        function refresh() {
            this.location = this.location;
        }
        //添加
        function addPage() {
        var lx= document.getElementById("lx").value;
        var gys_dw_id=document.getElementById("gys_dw_id").value;
            newwin = window.open('hyyhgl_wh.aspx?gys_dw_id='+gys_dw_id+'&lx='+lx+'&state=0', 'myWindow', 'height=300px,width=390px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }
        //修改
        function changePage(obj) {
            var tr = obj.parentNode.parentNode;
            var tds = tr.cells;
            var qq = Trim(tds[2].innerHTML);
            var name = Trim(tds[3].innerHTML);
            var phone = Trim(tds[4].innerHTML);
            var email = Trim(tds[5].innerHTML);
            var scs;var fxs;var cl;
           <%if (Request.Cookies["GYS_QQ_ID"]!=null||Session["GYS_YH_ID"] != null){ %>//Request.Cookies["GYS_QQ_ID"]改成Session["GYS_QQ_ID"]
                scs = tds[6].childNodes[1].checked;
                fxs = tds[6].childNodes[3].checked;
                cl = tds[6].childNodes[5].checked;
           <%} else{%>
                scs=false;fxs=false;cl=false;
           <%} %>
           var lx= document.getElementById("lx").value;
            newwin = window.open('hyyhgl_wh.aspx?qq=' + qq + '&name=' + name + '&phone=' + phone + '&email=' + email+'&scs='+scs+'&fxs='+fxs+'&cl='+cl + '&lx='+lx+'&state=1', 'myWindow', 'height=300px,width=390px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }

         function Checked(obj) {
            if (!obj.checked) {
                        return;
             }
              var tr = obj.parentNode.parentNode;
              var tds = tr.cells;
              document.getElementById("txt_Selected").value += Trim(tds[2].innerHTML) + ",";
          }

//          function getDelete() {
//              var trs = document.getElementById("tbody").rows;
//              for (var i = 0; i < trs.length; i++) {
//                  var tds = trs[i].cells;
//                   if (tds[0].childNodes[1].checked) { 
//                      document.getElementById("txt_Selected").value += Trim(tds[2].innerHTML) + ","; 
//                  }
//              }
//          }

    </script>
</head>
<body>
    <script runat="server">
    
        protected DataTable dtGys = new DataTable();
        protected DataConn dc = new DataConn();
        protected DataTable dt_Yh = new DataTable(); //用户名字(用户表) 
        private const int Page_Size = 10; //每页的记录数量
        public int current_page = 1;//当前默认页为第一页
        public int pageCount_page; //总页数
        protected DataTable dt_content = new DataTable();
        public DataTable dt_js = new DataTable();    //检索待分页完成后在合并DataTable 即可
        private int i_count = 0;
        public string QQ = "";
        string SQL = "";
        public int dwid;
        public string powerGys = "";
        public string yh_lx = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //*******************两种登录方式后的值
            if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null)
            {
                HttpCookie QQ_id = null;
                if (Request.Cookies["GYS_QQ_ID"] != null)
                {
                    QQ_id = Request.Cookies["GYS_QQ_ID"];
                }
                if (Request.Cookies["CGS_QQ_ID"] != null)
                {
                    QQ_id = Request.Cookies["CGS_QQ_ID"];
                }
                if (QQ_id != null)
                {
                    string str_Sql = "select 姓名,yh_id,dw_id,类型 from 用户表 where QQ_id='" + QQ_id.Value + "'";
                    dt_Yh = dc.GetDataTable(str_Sql);
                }
            }
            else
            {
                string s_yh_id = "";
                //新增的QQ登录方式
                if (Session["CGS_YH_ID"] != null)
                {
                    s_yh_id = Session["CGS_YH_ID"].ToString();
                }
                if (Session["GYS_YH_ID"] != null)
                {
                    s_yh_id = Session["GYS_YH_ID"].ToString();
                }
                string sql = "select 姓名,yh_id,dw_id,类型 from 用户表 where yh_id='" + s_yh_id + "'";
                dt_Yh = dc.GetDataTable(sql);
            }
            //*********************************************
            string sql_dwid = "0";
            if (dt_Yh != null && dt_Yh.Rows.Count > 0)
            {
                sql_dwid = dt_Yh.Rows[0]["dw_id"].ToString();
                this.lx.Value = dt_Yh.Rows[0]["类型"].ToString();
                yh_lx = dt_Yh.Rows[0]["类型"].ToString();
                this.gys_dw_id.Value = sql_dwid;
            }
            dwid = Convert.ToInt32(sql_dwid);


            string sql_js = "";
            sql_js = "select QQ号码,姓名,手机,邮箱,角色权限,yh_id from 用户表 where dw_id='" + dwid + "' and 等级<>'企业用户'";
            dt_js = dc.GetDataTable(sql_js);
            if (!IsPostBack)
            {
                createlm(dt_js);
            }

        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "描述性词语", "getDelete();", true);
            string sqlDelete = "";
            string strSelected = this.txt_Selected.Value.ToString();
            if (string.IsNullOrEmpty(strSelected))
            {
                Response.Write("<script>window.alert('请选中要删除的行')</" + "script>");
            }
            else
            {
                strSelected = strSelected.TrimEnd(',');
                string[] arrSelected = strSelected.Split(',');
                for (int i = 0; i < arrSelected.Length; i++)
                {
                    sqlDelete += "delete from 用户表 where QQ号码 = '" + arrSelected[i] + "'; ";
                }

                if (dc.RunSqlTransaction(sqlDelete))
                {
                    Response.Write("<script>window.alert('删除成功')</" + "script>");
                    this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "script", "<script>window.alert('删除成功')</" + "script>", true);
                    Response.Write("<script>window.location.href=document.URL;</" + "script>");  //刷新页面

                }
                else
                {
                    Response.Write("<script>window.alert('删除失败')</" + "script>");
                }

            }
        }

        //*****************************小张新增检索功能开始********************************* 
        protected void filter_Click(object sender, System.EventArgs e)
        {
            string strCondition = "";
            string sColumName, sTempColumnName;
            string sOperator;
            string sKeyWord;
            string sFieldType;
            string sSQL;
            DataTable objDt = null;

            sColumName = lieming.SelectedItem.Value.ToString().Trim();
            sOperator = yunsuanfu.SelectedItem.Value.ToString().Trim();
            sKeyWord = txtKeyWord.Text.ToString().Trim();
            if (sColumName == "全部")
            {
                sColumName = "";
                sOperator = "";
                sKeyWord = "";
            }
            //得到要筛选字段的类型
            string sql_js = "";
            sql_js = "select QQ号码,姓名,手机,邮箱,角色权限,yh_id from 用户表 where dw_id='" + dwid + "' and 等级<>'企业用户' ";
            if (sColumName == "" && sOperator == "" && sKeyWord == "")
            {
                strCondition = "";
            }
            else
            {
                sSQL = "select * from (" + sql_js + ")#temp where 1=0";
                objDt = dc.GetDataTable(sSQL);
                for (int i = 0; i < objDt.Columns.Count; i++)
                {
                    sTempColumnName = objDt.Columns[i].ColumnName.ToString().Trim();
                    if (sTempColumnName == sColumName)
                    {
                        sFieldType = objDt.Columns[i].DataType.Name.ToString().Trim();
                        switch (sFieldType.ToUpper().Trim())
                        {
                            case "STRING":
                                sFieldType = "字符串型";

                                if (sOperator.Trim() == "like")
                                    strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                                else
                                    strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                                break;
                            case "DATETIME":
                                sFieldType = "日期型";

                                if (sOperator.Trim() == "like")
                                    strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                                else
                                    strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                                break;
                            case "INT32":
                                sFieldType = "整型";

                                if (sOperator.Trim() == "like")
                                    strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                                else
                                    strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                                break;
                            case "DECIMAL":
                                sFieldType = "货币型";

                                if (sOperator.Trim() == "like")
                                {
                                    Response.Write("<script>alert(\"字段：" + sFieldType + " 不允许用 包含 筛选\")</" + "script>");
                                    return;
                                }
                                else
                                    strCondition = sColumName + " " + sOperator + sKeyWord;

                                break;
                            case "DOUBLE":
                                sFieldType = "浮点型";

                                if (sOperator.Trim() == "like")
                                    strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                                else
                                    strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                                break;
                            default:
                                sFieldType = "字符串型";

                                if (sOperator.Trim() == "like")
                                    strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                                else
                                    strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                                break;
                        }
                        break;
                    }
                }
            }
            if (strCondition != "")
            {
                string sql = sql_js;
                sql = "select * from (" + sql + ")#temp where " + strCondition;
                dt_js = dc.GetDataTable(sql);
            }
            else
            {
                string sql = sql_js;
                dt_js = dc.GetDataTable(sql);
            }

        }

        private void createlm(DataTable objDt)
        {
            ListItem objItem = null;
            if (objDt != null)
            {
                //----------------------旧版的检索------------------------
                for (int i = 0; i < objDt.Columns.Count; i++)
                {
                    switch (objDt.Columns[i].ColumnName)
                    {
                        case "yh_id":
                            break;
                        default:
                            objItem = null;
                            objItem = new ListItem();
                            objItem.Text = objDt.Columns[i].ColumnName;
                            lieming.Items.Add(objItem);
                            break;
                    }

                }
                objItem = null;
                objItem = new ListItem();
                objItem.Text = "全部";
                lieming.Items.Add(objItem);
            }
        }
        //*****************************小张新增检索功能结束*********************************
    </script>
    <form id="Form1" runat="server">
    <!-- 头部2开始-->
    <%-- <uc2:Header2 ID="Header2" runat="server" />--%>
    <div class="box">
        <div class="topx">
            <a href="index.aspx">
                <img src="images/topx_02.jpg" /></a>
        </div>
        <%
            HttpCookie GYS_QQ_ID = null;
            Object gys_yh_id = null;
            HttpCookie CGS_QQ_ID = null;
            Object cgs_yh_id = null;
            string gys_yh_id1 = "";
            string cgs_yh_id1 = "";
        %>
        <%if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null) %>
        <%{ %>
        <%         
            GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
            gys_yh_id = Session["GYS_YH_ID"];

            CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            cgs_yh_id = Session["CGS_YH_ID"];

            //采购商登录
            if (((GYS_QQ_ID == null) || (gys_yh_id == null)) && ((CGS_QQ_ID != null) && (cgs_yh_id != null)))
            {
        %>
        <div class="anniu">
            <a href="QQ_out.aspx" target="_self">采购商登出</a></div>
        <%
}
        //供应商登录
        else if (((CGS_QQ_ID == null) || (cgs_yh_id == null)) && ((GYS_QQ_ID != null) && (gys_yh_id != null)))
        {
        %>
        <div class="anniu">
            <a href="QQ_out.aspx" target="_self">供应商登出</a></div>
        <div class="anniu">
            <a href="gyszym.aspx" target="_self">供应商主页面</a></div>
        <%
}
        %>
        <%} %>
        <%else %>
        <%{ %>
        <%
           
            if (Session["GYS_YH_ID"] != null)
            {
                gys_yh_id1 = Session["GYS_YH_ID"].ToString();
            }
            if (Session["CGS_YH_ID"] != null)
            {
                cgs_yh_id1 = Session["CGS_YH_ID"].ToString();
            }
        %>
        <%if (gys_yh_id1 == "" && cgs_yh_id1 != "")
          { 
        %>
        <div class="anniu">
            <a href="cgsgl_2.aspx" target="_self">采购商主页面</a></div>
        <div class="anniu">
            <a href="QQ_out.aspx" target="_self">采购商登出</a></div>
        <%  }%>
        <%if (gys_yh_id1 == "" && cgs_yh_id1 == "")
          { 
        %>
        <div class="anniu">
            <a href="gysdl.aspx" target="_self">供应商登录</a></div>
        <div class="anniu">
            <a href="cgsdl.aspx" target="_self">采购商登录</a></div>
        <%  }%>
        <%if (gys_yh_id1 != "" && cgs_yh_id1 == "")
          { 
        %>
        <div class="anniu">
            <a href="QQ_out.aspx" target="_self">供应商登出</a></div>
        <div class="anniu">
            <a href="gyszym.aspx" target="_self">供应商主页面</a></div>
        <%  }%>
        <%} %>
        <div class="gyzy0">
            <div class="gyzy">
                尊敬的
                <%foreach (System.Data.DataRow row in dt_Yh.Rows)
                  {%>
                <span>
                    <%=row["姓名"].ToString() %></span>
                <%}%>
                ，欢迎来到众材网！
                <div style="float: right">
                    <span style="font-weight: bold;">
                        <%if (((CGS_QQ_ID == null) || (cgs_yh_id1 == null)) && ((GYS_QQ_ID != null) || (gys_yh_id1 != null)))
                          { %>
                        <a href="gysgly_wh.aspx">[修改完善公司信息]</a>
                        <%}
                          else
                          { %>
                        <a href="cgsgly_wh.aspx">[修改完善公司信息]</a>
                        <%} %>
                    </span>
                </div>
            </div>
        </div>
        <input type="hidden" id="lx" runat="server" />
        <!-- 头部2结束-->
        <!-- 检索 开始-->
        <div id="jiansuo">
            <asp:Label ID="shaixu" runat="server"><font style="FONT-SIZE: 9pt">&nbsp;&nbsp;检索条件：</font></asp:Label>
            <asp:DropDownList ID="lieming" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
                font-size: 9pt; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                runat="server" Width="128px">
            </asp:DropDownList>
            <asp:DropDownList ID="yunsuanfu" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
                font-size: 9pt; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                runat="server" Width="88px">
                <asp:ListItem Value="like" Selected="True">包含关键字</asp:ListItem>
                <asp:ListItem Value="=">等于</asp:ListItem>
                <asp:ListItem Value="&lt;">小于</asp:ListItem>
                <asp:ListItem Value="&gt;">大于</asp:ListItem>
                <asp:ListItem Value="&gt;=">大于等于</asp:ListItem>
                <asp:ListItem Value="&lt;=">小于等于</asp:ListItem>
            </asp:DropDownList>
            &nbsp;
            <asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
                border-left: #808080 1px solid; border-bottom: #808080 1px solid" runat="server"></asp:TextBox>
            &nbsp; &nbsp;
            <asp:Button ID="filter" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
                BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                filter Font-Names="宋体"></asp:Button>
            &nbsp;&nbsp;
            <input type="button" name="btnDocNew" value="添加" onclick="addPage();" id="btnDocNew"
                class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                height: 20px; width: 37px; cursor: pointer;" />&nbsp;&nbsp;
            <asp:Button ID="btnDelete" runat="server" Text="删除选中行" class="btnDelete1" Style="color: Black;
                border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 72px;
                cursor: pointer;" OnClick="btnDelete_Click" />
        </div>
        <!-- 检索 结束-->
        <!-- 用户信息 开始 -->
        <input type="hidden" runat="server" id="gys_dw_id" />
        <div class="yhb">
            <table border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" id="table">
                <thead>
                    <tr>
                        <th align="center">
                            <strong>选择</strong>
                        </th>
                        <th align="center">
                            <strong>序号</strong>
                        </th>
                        <th align="center">
                            <strong>QQ号码</strong>
                        </th>
                        <th align="center">
                            <strong>姓名</strong>
                        </th>
                        <th align="center">
                            <strong>手机号</strong>
                        </th>
                        <th align="center">
                            <strong>邮箱</strong>
                        </th>
                        <%if (Request.Cookies["GYS_QQ_ID"] != null || Session["GYS_YH_ID"] != null)
                          { %>
                        <th align="center">
                            <strong>角色权限</strong>
                        </th>
                        <%} %>
                        <th align="center">
                            <strong>操作</strong>
                        </th>
                    </tr>
                </thead>
                <tbody id="tbody">
                    <%if (dt_js != null) %>
                    <%{ %>
                    <%for (int i = 0; i < dt_js.Rows.Count; i++)%>
                    <% { %>
                    <tr>
                        <td align="center">
                            <input type="checkbox" onclick="Checked(this)" />
                        </td>
                        <td align="center">
                            <%=i + 1%>
                        </td>
                        <td>
                            <%=dt_js.Rows[i]["QQ号码"]%>
                        </td>
                        <td class="gridtable">
                            <%=dt_js.Rows[i]["姓名"]%>
                        </td>
                        <td>
                            <%=dt_js.Rows[i]["手机"]%>
                        </td>
                        <td>
                            <%=dt_js.Rows[i]["邮箱"]%>
                        </td>
                        <%if (gys_yh_id1 != "" || GYS_QQ_ID != null)
                          { %>
                        <td>
                            <%if (yh_lx == "生产商") %>
                            <%{ %>
                            <%powerGys = dt_js.Rows[i]["角色权限"] == "" ? "" : dt_js.Rows[i]["角色权限"].ToString(); %>
                            <%if (powerGys.Contains("管理生产商")) %>
                            <%{ %>
                            <input id="Checkbox1" type="checkbox" checked="checked" value="管理生产商" runat="server"
                                name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <%} %>
                            <%else %>
                            <%{ %>
                            <input id="Checkbox2" type="checkbox" value="管理生产商" runat="server" name="cbx1" disabled="disabled"
                                runat="server" />
                            管理生产商
                            <%} %>
                            <%if (powerGys.Contains("管理分销商")) %>
                            <%{ %>
                            <input id="Checkbox3" type="checkbox" checked="checked" value="管理分销商" runat="server"
                                name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <%} %>
                            <%else %>
                            <%{ %>
                            <input id="Checkbox4" type="checkbox" value="管理分销商" runat="server" name="cbx2" disabled="disabled"
                                runat="server" />
                            管理分销商
                            <%} %>
                            <%if (powerGys.Contains("管理材料信息")) %>
                            <%{ %>
                            <input id="Checkbox5" type="checkbox" checked="checked" value="管理材料信息" name="cbx3"
                                disabled="disabled" runat="server" />
                            管理材料信息
                            <%} %>
                            <%else %>
                            <%{ %>
                            <input id="Checkbox6" type="checkbox" value="管理材料信息" name="cbx3" disabled="disabled"
                                runat="server" />
                            管理材料信息
                            <%} %>
                            <%} %>
                            <%else if (yh_lx == "分销商") %>
                            <%{ %>
                            <%if (powerGys.Contains("管理分销商")) %>
                            <%{ %>
                            <input id="Checkbox7" type="checkbox" checked="checked" value="管理分销商" runat="server"
                                name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <%} %>
                            <%else %>
                            <%{ %>
                            <input id="Checkbox8" type="checkbox" value="管理分销商" runat="server" name="cbx2" disabled="disabled"
                                runat="server" />
                            管理分销商
                            <%} %>
                            <%if (powerGys.Contains("管理材料信息")) %>
                            <%{ %>
                            <input id="Checkbox9" type="checkbox" checked="checked" value="管理材料信息" runat="server"
                                name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                            <%} %>
                            <%else %>
                            <%{ %>
                            <input type="checkbox" value="管理材料信息" runat="server" name="cbx3" disabled="disabled"
                                runat="server" />
                            管理材料信息
                            <%} %>
                            <%} %>
                        </td>
                        <%} %>
                        <td align="center">
                            <input type="button" name="filter" value="编辑" id="Submit1" onclick="changePage(this);"
                                class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                                height: 20px; width: 37px; cursor: pointer;" />
                        </td>
                    </tr>
                    <%} %>
                    <%} %>
                </tbody>
            </table>
            <%-- <table width="100%" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td width="40" align="left" valign="middle">
                    &nbsp;
                </td>
                <td width="266" height="40" align="left" valign="middle">
                    共7页/当前第1页
                </td>
                <td align="right" valign="middle">
                    <a href="#">首页</a> <a href="#">上一页</a> <a href="#">下一页</a> <a href="#">尾页</a> 转到第
                    <input name="textfield244" type="text" class="queding_bk" size="3" />
                    页
                    <input type="submit" name="btnDocNew" value="确定" onclick="return VerifyMyIMP();"
                        class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                        height: 20px; width: 37px;" />
                </td>
                <td width="40" align="right" valign="middle">
                    &nbsp;
                </td>
            </tr>
        </table>--%>
            <!-- 页码开始-->
            <div style="text-align: center">
                <!--加入div控制分页居中-->
                <div class="fy2">
                    <div class="fy3">
                        <% if (current_page <= 1 && pageCount_page > 1)
                           {%>
                        <font class="p" style="color: Gray">首页</font> <a href="hyyhgl.aspx?p=<%=current_page+1 %>"
                            class="p" style="color: Black">下一页</a> <a href="hyyhgl.aspx?p=<%=pageCount_page %>"
                                class="p" style="color: Black">末页</a>
                        <%} %>
                        <% else if (current_page <= 1 && pageCount_page <= 1)
                            {%>
                        <% }%>
                        <% else if (!(current_page <= 1) && !(current_page == pageCount_page))
                            { %>
                        <a href="hyyhgl.aspx?p=<%=1 %>" class="p" style="color: Black">首页</a> <a href="hyyhgl.aspx?p=<%=current_page-1 %>"
                            class="p" style="color: Black">上一页</a> <a href="hyyhgl.aspx?p=<%=current_page+1 %>"
                                class="p" style="color: Black">下一页</a> <a href="hyyhgl.aspx?p=<%=pageCount_page %>"
                                    class="p" style="color: Black">末页</a>
                        <%}%>
                        <% else if (current_page == pageCount_page)
                            { %>
                        <a href="hyyhgl.aspx?p=<%=1 %>" class="p" style="color: Black">首页</a> <a href="hyyhgl.aspx?p=<%=current_page-1 %>"
                            class="p" style="color: Black">上一页</a> <font class="p" style="color: Gray">末页</font>
                        <%} %>
                        <font style="color: Black">直接到第</font>
                        <select onchange="window.location=this.value" name="" class="p" style="color: Black">
                            <%--   <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>--%>
                        </select>
                        <font style="color: Black">页&nbsp;&nbsp;&nbsp;第
                            <%=current_page %>
                            页/共
                            <%=pageCount_page %>
                            页</font>
                    </div>
                </div>
            </div>
            <!-- 页码结束-->
        </div>
        <!-- 用户信息 结束 -->
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
        <!--  footer 开始-->
        <!-- #include file="static/footer.aspx" -->
        <!-- footer 结束-->
    </form>
    <input type="hidden" id="txt_Selected" value="" runat="server" />
    <div id="AddDialog" title="添加会员" style="width: 280px; height: 230px; display: none;">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 290px; height: 150px;
            font-size: 12; color: #707070">
            <tr>
                <td>
                    QQ号码
                </td>
                <td>
                    <input type="text" id="newQQ" name="name" value="" style="border: 1px solid #707070;
                        height: 26px; width: 200px;" />
                    <lable style="color: Red; font-size: 20px;">*</lable>
                </td>
            </tr>
            <tr>
                <td>
                    姓名
                </td>
                <td>
                    <input type="text" id="newName" name="name" value="" style="border: 1px solid #707070;
                        height: 26px; width: 200px;" />
                </td>
            </tr>
            <tr>
                <td>
                    手机号码
                </td>
                <td>
                    <input type="text" id="newPhone" name="name" value="" style="border: 1px solid #707070;
                        height: 26px; width: 200px;" />
                </td>
            </tr>
            <tr>
                <td>
                    邮箱
                </td>
                <td>
                    <input type="text" id="newEmail" name="name" value="" style="border: 1px solid #707070;
                        height: 26px; width: 200px;" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 280px;">
                    <label style="width: 90px; float: left;">
                        <input type="checkbox" name="CheckboxGroup1" value="管理生产商" id="cbx1" />
                        管理生产商</label>
                    <label style="width: 90px; float: left;">
                        <input type="checkbox" name="CheckboxGroup1" value="管理分销商" id="cbx2" />
                        管理分销商</label>
                    <label style="width: 100px; float: left;">
                        <input type="checkbox" name="CheckboxGroup1" value="管理材料信息" id="cbx3" />
                        管理材料信息</label>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
