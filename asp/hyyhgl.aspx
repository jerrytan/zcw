<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="hyyhgl.aspx.cs" Inherits="asp_hyyhgl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>供应商用户管理</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
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
    </script>
    <script type="text/javascript">
//        var strSelQQ = "";
        //获取前台选中行
//        function getS() {
//            var rowS = "测试一下";
            //            alert(rowS);
//            return rowS;
//        }
        //刷新页面
        function refresh() {
            this.location = this.location;
        }
        //添加
        function addPage() {
            newwin = window.open('hyyhgl_wh.aspx?state=0', 'myWindow', 'height=350px,width=450px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }
        //修改
        function changePage(obj) {
            var tr = obj.parentNode.parentNode;
            var tds = tr.cells;
            var qq = tds[2].innerText;
            var name = tds[3].innerText;
            var phone = tds[4].innerText;
            var email = tds[5].innerText;

            newwin = window.open('hyyhgl_wh.aspx?qq=' + qq + '&name=' + name + '&phone=' + phone + '&email=' + email + '&state=1', 'myWindow', 'height=350px,width=450px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }
                function Checked(obj) {
                    if (!obj.checked) {
                        return;
                    }
                    var tr = obj.parentNode.parentNode;
                    var tds = tr.cells;
//                  var str = "你选中";
//                    for (var i = 0; i < tds.length; i++) {
//                        str += tds[i].innerText+",";
//                    }
                    //                    alert(str);
                    //                    strSelQQ += tds[2].innerText + ",";
                    document.getElementById("txt_Selected").value+= tds[2].innerText + ",";            
                }
    </script>
</head>
<body>
    <form runat="server">
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->
    <!-- 检索 开始-->
    <div id="jiansuo">
        <font style="font-size: 9pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;检索条件：</font>
        <select name="lieming" id="lieming" style="width: 128px; border-right: #808080 1px solid;
            border-top: #808080 1px solid; font-size: 9pt; border-left: #808080 1px solid;
            border-bottom: #808080 1px solid">
            <option value="QQ号">QQ号</option>
            <option value="姓名">姓名</option>
            <option value="手机号">手机号</option>
        </select>
        <select name="yunsuanfu" id="yunsuanfu" style="width: 88px; border-right: #808080 1px solid;
            border-top: #808080 1px solid; font-size: 9pt; border-left: #808080 1px solid;
            border-bottom: #808080 1px solid">
            <option selected="selected" value="like">包含关键字</option>
            <option value="=">等于</option>
            <option value="&lt;">小于</option>
            <option value=">">大于</option>
            <option value="">=">大于等于</option>
            <option value="&lt;=">小于等于</option>
        </select><input name="txtKeyWord" type="text" id="txtKeyWord" style="border-right: #808080 1px solid;
            border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
        <input id="chkSearchInResult" type="checkbox" name="chkSearchInResult" checked="checked" /><label
            for="chkSearchInResult">在结果中检索</label>&nbsp;&nbsp;
        <input type="submit" name="filter" value="检索" id="filter" class="filter" style="color: Black;
            border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px;" />
        &nbsp;&nbsp;
        <input type="submit" name="btnDocNew" value="添加" onclick="addPage();" id="btnDocNew"
            class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
            height: 20px; width: 37px;" />&nbsp;&nbsp;
        <input type="button" id="btnFilter" value="组合查询" onclick="btnFilter_Click()" style="height: 20px;
            width: 64px; border-style: none; font-family: 宋体; font-size: 12px;" />&nbsp;&nbsp;
        <%--<input type="submit" name="btnDelete" value="删除选中行" onclick="return confirm(&#39;真的彻底删除选中的记录吗？&#39;);"
            id="btnDelete" class="btnDelete1" style="color: Black; border-style: None; font-family: 宋体;
            font-size: 12px; height: 20px; width: 72px;" />--%>
          <asp:Button ID="btnDelete" runat="server" Text="删除选中行" class="btnDelete1" style="color: Black; border-style: None; font-family: 宋体;
            font-size: 12px; height: 20px; width: 72px;" onclick="btnDelete_Click"/>
    </div>
    <!-- 检索 结束-->
    <!-- 用户信息 开始 -->

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
                    <th align="center">
                        <strong>角色权限</strong>
                    </th>
                    <th align="center">
                        <strong>操作</strong>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%for (int i = 0; i < listGys.Count; i++)
                  { %>
                <tr>
                    <td align="center">
                        <input type="checkbox" onclick="Checked(this)" />
                    </td>
                    <td align="center">
                        <%=i+1 %>
                    </td>
                    <td>
                        <%=listGys[i].QQ%>
                    </td>
                    <td class="gridtable">
                        <%=listGys[i].Name%>
                    </td>
                    <td>
                        <%=listGys[i].Phone%>
                    </td>
                    <td>
                        <%=listGys[i].Email%>
                    </td>
                    <td>
                        <%string powerGys = listGys[i].Power.ToString(); %>
                        <%if (powerGys.Contains("管理生产商") && powerGys.Contains("管理分销商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                        <label>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商") && powerGys.Contains("管理分销商")) %>
                        <%{%>
                        <label>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                        <label>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <% } %>
                        <%else if (powerGys.Contains("管理分销商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                        <label>
                            <input type="checkbox" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商")) %>
                        <%{%>
                        <label>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <% } %>
                        <%else if (powerGys.Contains("管理分销商"))
                            { %>
                        <label>
                            <input type="checkbox" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <%} %>
                        <%else if (powerGys.Contains("管理材料信息"))
                            { %>
                        <label>
                            <input type="checkbox" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <%} %>
                        <%else
                            { %>
                        <label>
                            <input type="checkbox" value="管理生产商" name="cbx1" runat="server" />
                            管理生产商
                        </label>
                        <label>
                            <input type="checkbox" value="管理分销商" name="cbx2" runat="server" />
                            管理分销商</label>
                        <label>
                            <input type="checkbox" value="管理材料信息" name="cbx3" runat="server" />
                            管理材料信息</label>
                        <%} %>
                    </td>
                    <td align="center">
                        <input type="button" name="filter" value="编辑" id="Submit1" onclick="changePage(this);"
                            class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                            height: 20px; width: 37px;" />
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        <table width="100%" align="left" cellpadding="0" cellspacing="0">
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
        </table>
    </div>
    <!-- 用户信息 结束 -->
    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
    </form>
    <input type="hidden" id="txt_Selected" value="" runat="server"/>
</body>
</html>
