<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cgsgzcl.aspx.cs" Inherits="asp_static_Cgsgzcl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
    <script type="text/javascript">
        function readClxx(obj) {
//            window.parent.location.href = "clxx.aspx?cl_id=" + obj;
            window.open("clxx.aspx?cl_id=" + obj);
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
        function deleteGzcl() {
            var tb_gzcl = document.getElementById("table2");
            var chks = tb_gzcl.getElementsByTagName("input");
            var cl_ids = '';
            for (var i = 0; i < chks.length; i++) {
                if (chks[i].type == "checkbox" && chks[i].checked) {
                    cl_ids += Trim(chks[i].parentNode.parentNode.cells[0].innerHTML) + ",";

                }
            }
            if (cl_ids == "" || cl_ids==undefined)
            {
                alert("请选择需要删除的材料！");
                return;
            }
            if (confirm("是否删除选中的材料"))
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
                        var array = xmlhttp.responseText;     //接收替换返回的json字符串
                        if (array == 1)
                        {
                            alert("删除成功");
                            location.reload();
                        }
                        else
                            alert("删除失败");
                    }
                }
                xmlhttp.open("GET", "cgsgzcl_ajax.aspx?clids=" + cl_ids, true);
                xmlhttp.send();
            }
            else
            {
                return;
            }
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
            var tableid = 'table2';
            //表格的id
            var overcolor = '#fff0e9'; //鼠标经过颜色
            var color1 = '#f2f6ff'; 	//第一种颜色
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
          
    <div>
                    <div id="jiansuo2" >
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
                    </asp:DropDownList><asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid;
                        border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                        runat="server"></asp:TextBox>  
                        &nbsp; &nbsp; &nbsp;                     
                    <asp:Button ID="filter" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
                        BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                        filter Font-Names="宋体"></asp:Button>&nbsp;&nbsp;
                        <input type="button" id="btnFilter" value="删除材料" onclick="deleteGzcl()" style="height: 20px;
                            width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor: pointer;" />
                    </div>
                    <table width="755" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd"
                        class="table2" id="table2">
                        <thead>
                            <tr>
                                <th align="center">
                                    <strong>选择</strong>
                                </th>
                                <th align="center">
                                    <strong>名称</strong>
                                </th>
                                <th align="center">
                                    <strong>规格\型号</strong>
                                </th>
                                 <th align="center">
                                    <strong>品牌</strong>
                                </th>
                                <th align="center">
                                    <strong>供应商</strong>
                                </th>
                                <th align="center">
                                    <strong>地区</strong>
                                </th>
                                
                                <th align="center">
                                    <strong>收藏人</strong>
                                </th>
                                 <th align="center">
                                    <strong>QQ</strong>
                                </th>
                                <th align="center">
                                    <strong>操作</strong>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (DataRow dr in dt_topcl.Rows)
                              { %>
                            <tr>
                                <td align="center" style="display:none">
                                    <%=dr["cl_id"] %>
                                </td>
                                <td align="center">
                                    <input type="checkbox" name="checkbox" />
                                </td>
                                <td align="left">
                                    <%=dr["显示名"]%>
                                </td>
                                 <td>
                                    <%=dr["规格型号"]%>
                                </td>
                                 <td>
                                    <%=dr["品牌名称"]%>
                                </td>
                                <td align="left">
                                    <%=dr["生产厂商"]%>
                                </td>
                                <td class="gridtable">
                                   <%=dr["地区名称"] %>
                                </td>
                                <td>
                                    <%=dr["收藏人"]%>
                                </td>
                                <td>
                                    <%=dr["收藏人QQ"]%>
                                </td>
                               
                                <td align="center">
                                   <%-- <a href="clxx.aspx?cl_id=<%=dr["cl_id"] %>">--%>
                                        <input type="button" name="filter" value="查阅" id="btnRead" onclick="readClxx(<%=dr["cl_id"] %>)" class="filter" style="color: Black;
                                            border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px;
                                            cursor: pointer;" />
                                   <%-- </a>--%>
                                </td>   
                            </tr>
                            <%} %>

                            <%if (dt_topcl.Rows.Count<10)
                              { 
                                  for(int i=0;i<10-dt_topcl.Rows.Count;i++)
                                  {%>  
                                        <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                  <%}
                             }%>
                        </tbody>
                    </table>
                     <table width="100%" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="200" height="40" align="left" valign="middle">
                                共7页/当前第1页
                            </td>
                            <td align="right" valign="middle">
                                <a href="#">首页</a> <a href="#">上一页</a> <a href="#">下一页</a> <a href="#">尾页</a> 转到第
                                <input name="textfield244" type="text" class="queding_bk" size="3" />
                                页
                                <input type="submit" name="btnDocNew" value="确定" onclick="return VerifyMyIMP();"
                                    class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                                    height: 20px; width: 37px; cursor: pointer;" />
                            </td>
                            <td width="40" align="right" valign="middle">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
    </div>
    </form>
</body>
</html>
