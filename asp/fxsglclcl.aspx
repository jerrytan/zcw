<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fxsglclcl.aspx.cs" Inherits="asp_fxsglclcl" validateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible">
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/gysglcl.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <link href="css/Paging.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/AddFxsPrice.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#pageDiv a").click(function () {
                var hrefStr = $(this).attr("href");
                var hrStr = hrefStr + "&fxs_id=" + $("#fxsid").val() + "&ppid=" + $("#ppid").val();
                $(this).attr("href", hrStr);
            });
        });
        function selectall1(obj, cl_id) {
            if (obj.checked) {
                var Table = document.getElementById("table4");
                var ck = Table.getElementsByTagName("input");
                for (var i = 0; i < ck.length; i++) {
                    var e = ck[i];
                    if (e.type == 'checkbox') {
                        if (e.name == 'checkbox') {
                            if (e.checked == false) {
                                document.getElementById("checkboxAll").checked = false;
                            }
                        }
                        else {
                            document.getElementById("checkboxAll").checked = true;
                        }
                    }
                }
            }
            else {
                document.getElementById("checkboxAll").checked = false;
            }
        }
        function selectall() {
            var Table = document.getElementById("table4");
            var ck = Table.getElementsByTagName("input");
            var ckb = document.getElementsByName("checkboxAll");
            if (document.getElementById("checkboxAll").checked) {
                for (var i = 0; i < ck.length; i++) {
                    var e = ck[i];
                    if (e.type == 'checkbox' && e.name == 'checkbox') {
                        e.checked = true;
                    }
                }
            }
            else {
                for (var i = 0; i < ck.length; i++) {
                    var e = ck[i];
                    if (e.type == 'checkbox' && e.name == 'checkbox') {
                        e.checked = false;
                    }
                }
            }
        }
    </script>
    <script type="text/javascript">
        //新增材料
        function btnFilter_Click() {
            var fxs_id = document.getElementById("fxsid").value;
            var ppid = document.getElementById("ppid").value;
            var ppmc = document.getElementById("ppmc").value;
            var scs = document.getElementById("scsid").value;
            if (ppid == "" || ppid == undefined) {
                alert("请选择品牌！");
                return;
            }
            else {
                var url = "fxsxzdlcl.aspx?ppid=" + ppid + "&ppmc=" + ppmc + "&scsid=" + scs + "&fxsid=" + fxs_id;
                window.open(url);
                // window.parent.location.href = url;
            }
        }
        //查阅
        function Read(cl_id) {
            var url = "clxx.aspx?cl_id=" + cl_id;
            window.parent.location.href = url;
        }
        //删除材料
        function delete_cl() {
            var fxs_id = document.getElementById("fxsid").value;
            var ppid = document.getElementById("ppid").value;
            var ppmc = document.getElementById("ppmc").value;
            var scs = document.getElementById("scsid").value;
            var table = document.getElementById("table4");
            var input = table.getElementsByTagName("input");
            var cl_id = "";
            for (var i = 0; i < input.length; i++) {
                if (input[i].type == "checkbox" && input[i].checked) {
                    var tr = input[i].parentNode.parentNode;
                    cl_id += tr.cells[1].innerHTML + ",";
                }
            }
            if (cl_id == "" || cl_id == undefined) {
                alert("请选择要删除的材料!");
                return;
            }
            else {
                alert(cl_id);
                if (confirm("是否删除选中材料？")) {
                    $.get("fxsscdlcl.aspx", { "cl_id": cl_id, "ppid": ppid, "ppmc": ppmc, "scsid": scs, "fxsid": fxs_id }, function (data) {
                        
                        if (data == "1") {
                            alert("删除成功");
                            location.reload();
                        } else {
                            alert("删除失败");
                            location.reload();
                        }
                    });

//                    var xmlhttp;
//                    if (window.XMLHttpRequest) {
//                        xmlhttp = new XMLHttpRequest();
//                    }
//                    else {
//                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//                    }
//                    xmlhttp.onreadystatechange = function () {
//                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//                            var text = xmlhttp.responseText;
//                            if (text == 1) {
//                                alert('删除成功');
//                                location.reload();
//                            }
//                            else {
//                                alert('删除失败');
//                                alert(text);
//                                location.reload();
//                            }
//                        }
//                    }
//                    xmlhttp.open("GET", "fxsscdlcl.aspx?cl_id=" + cl_id + "&ppid=" + ppid + "&ppmc=" + ppmc + "&scsid=" + scs + "&fxsid=" + fxs_id, true);
//                    xmlhttp.send();
                }
                else {
                    return;
                }
            }
        }
    </script>
</head>
<body>
    <input type="hidden" runat="server" id="scsid" />
    <input type="hidden" runat="server" id="ppid" />
    <input type="hidden" runat="server" id="ppmc" />
    <input type="hidden" runat="server" id="fxsid" />
    <form id="form1" runat="server">
    <div id="jiansuo3" class="jiansuo3">
        <asp:Label ID="shaixu" runat="server"><font style="FONT-SIZE: 9pt">检索条件：</font></asp:Label>
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
        &nbsp;
        <asp:Button ID="filter" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
            BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
            filter Font-Names="宋体"></asp:Button>
        &nbsp;
        <input type="button" class="btnFilter" value="添加材料" onclick="btnFilter_Click()" style="margin-top: 0px;
            height: 20px; width: 64px; border-style: none; font-family: 宋体; font-size: 12px;
            cursor: pointer;" />&nbsp;
        <input type="button" class="btnFilter" value="删除材料" onclick="delete_cl()" style="margin-top: 0px;
            height: 20px; width: 64px; border-style: none; font-family: 宋体; font-size: 12px;
            cursor: pointer;" />
    </div>
    <br />
    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd"
        class="table2" id="table4">
        <thead>
            <tr>
                <th align="center">
                    <input class="middle" type="checkbox" name="checkboxAll" id="checkboxAll" onclick="return selectall();" />
                </th>
                <th width="100" align="center" style="display: none;">
                    <strong>cl_id</strong>
                </th>
                <%--<th style=" width:100px; overflow:hidden;" align="center">
                    <strong>材料编码</strong>
                </th>--%>
                <th style=" width:130px; overflow:hidden;" align="center">
                    <strong>材料名称</strong>
                </th>
                <th style=" width:110px; overflow:hidden;" align="center">
                    <strong>规格/型号</strong>
                </th>
                <th style=" width:130px; overflow:hidden;"  align="center">
                    <strong>供应商</strong>
                </th>
                <th style=" width:60px; overflow:hidden;" align="center">
                    <strong>品牌</strong>
                </th>
                <th style=" width:40px; overflow:hidden;" align="center">
                    <strong>单位</strong>
                </th>
                <th style=" width110px; overflow:hidden;" align="center">
                    <strong>厂商指导价</strong>
                </th>
                <th  style=" width:90px; overflow:hidden;"  align="center">
                    <strong>实时报价</strong>
                </th>
                <th  style=" width:45px; overflow:hidden;"  align="center">
                    <strong>操作</strong>
                </th>
            </tr>
        </thead>
        <tbody>
            <%if (dtcl != null && dtcl.Rows.Count > 0) %>
            <%{ %>
            <% for (int i = 0; i < dtcl.Rows.Count; i++) %>
            <%{ %>
            <%
                   if (i % 2 == 0)
                       %>
            <%{ %>
            <tr style="background: #f2f6ff" onmouseover='this.style.backgroundColor="#fff0e9"'
                onmouseout='this.style.backgroundColor="#f2f6ff"'>
                <td align="center">
                    <input type="checkbox" name="checkbox" onclick="return selectall1(this);" />
                    <label for="checkbox">
                    </label>
                </td>
                <td align="center" style="display: none;">
                    <%=dtcl.Rows[i]["cl_id"]%>
                </td>
                <%--<td align="center">
                    <%=dtcl.Rows[i]["材料编码"]%>
                </td>--%>
                <td align="left" style=" text-align:center;">
                    <%=SubStrings.GetWidth(9,dtcl.Rows[i]["材料名称"].ToString(),dtcl.Rows[i]["材料名称"].ToString())%>
                </td>
                <td class="gridtable" style=" text-align:center;">
                    <%=SubStrings.GetWidth(7,dtcl.Rows[i]["规格型号"].ToString(),dtcl.Rows[i]["规格型号"].ToString())%>
                </td>
                <td align="left" style=" text-align:center;">
                    <%=SubStrings.GetWidth(8, dtcl.Rows[i]["生产厂商"].ToString(), dtcl.Rows[i]["生产厂商"].ToString())%>
                </td>
                <%--<td class="gridtable"><%=ppmc1%></td>--%>
                <td class="gridtable" style=" text-align:center;">
                    <%=dtcl.Rows[i]["品牌名称"]%>
                </td>
                <td align="center" style=" text-align:center;">
                    <%=dtcl.Rows[i]["计量单位"]%>
                </td>
                <td align="center">
                 <%=GetGysNewPrice(dtcl.Rows[i]["cl_id"].ToString())%>
                </td>
                <td align="center">
                    <input type="text"  onblur="AddFxsPrice(this)" name="name" value=" <%= dtcl.Rows[i]["price"] %>" style="width:79px; height:24px; line-height:24px; text-align:center; background-color:#F2F6FF" />
                    <p style=" display:none;"><%= dtcl.Rows[i]["price"] %></p>
                    <p style=" display:none;"><%= dtcl.Rows[i]["cl_id"] %>;<%= dtcl.Rows[i]["gys_id"] %>;<%= dtcl.Rows[i]["fxs_id"] %></p>
                </td>
                <td align="center">
                    <input type="Button" name="filter" value="查阅" class="filter" filter="" onclick="Read('<%=dtcl.Rows[i]["cl_id"] %>')"
                        style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px;
                        width: 37px; cursor: pointer;" />
                </td>
                
            </tr>
            <%} %>
            <%else %>
            <%{ %>
            <tr style="background: #fff" onmouseover='this.style.backgroundColor="#fff0e9"' onmouseout='this.style.backgroundColor="#fff"'>
                <td align="center">
                    <input type="checkbox" name="checkbox" onclick="return selectall1(this);" />
                    <label for="checkbox">
                    </label>
                </td>
                <td align="center" style="display: none;">
                    <%=dtcl.Rows[i]["cl_id"]%>
                </td>
                <%--<td align="center">
                    <%=dtcl.Rows[i]["材料编码"]%>
                </td>--%>
                <td align="left" style=" text-align:center;">
                    <%=SubStrings.GetWidth(9,dtcl.Rows[i]["材料名称"].ToString(),dtcl.Rows[i]["材料名称"].ToString())%>
                </td>
                <td class="gridtable" style=" text-align:center;">
                    <%=SubStrings.GetWidth(7,dtcl.Rows[i]["规格型号"].ToString(),dtcl.Rows[i]["规格型号"].ToString())%>
                </td>
                <td align="left" style=" text-align:center;">
                    <%=SubStrings.GetWidth(8, dtcl.Rows[i]["生产厂商"].ToString(), dtcl.Rows[i]["生产厂商"].ToString())%>
                </td>
                <%--<td class="gridtable"><%=ppmc1%></td>--%>
                <td class="gridtable" style=" text-align:center;">
                    <%=dtcl.Rows[i]["品牌名称"]%>
                </td>
                <td align="center" style=" text-align:center;">
                    <%=dtcl.Rows[i]["计量单位"]%>
                </td>
                <td align="center">
                 <%=GetGysNewPrice(dtcl.Rows[i]["cl_id"].ToString())%>
                </td>
                <td align="center">
                    <input type="text" onblur="AddFxsPrice(this)" name="name" value=" <%= dtcl.Rows[i]["price"] %>" style="width:79px; height:24px; line-height:24px; text-align:center;" />
                    <p style=" display:none;"><%= dtcl.Rows[i]["price"] %></p>
                    <p style=" display:none;"><%= dtcl.Rows[i]["cl_id"] %>;<%= dtcl.Rows[i]["gys_id"] %>;<%= dtcl.Rows[i]["fxs_id"] %></p>
                </td>
                <td align="center">
                    <input type="Button" name="filter" value="查阅" class="filter" filter="" onclick="Read('<%=dtcl.Rows[i]["cl_id"] %>')"
                        style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px;
                        width: 37px; cursor: pointer;" />
                </td>
            </tr>
            <%} %>
            <%} %>
            <%} %>
        </tbody>
    </table>
    <div id="pageDiv" class="paginator" runat="server">   
    </div>
    </form>
</body>
</html>
