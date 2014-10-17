<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cgsgzgys.aspx.cs" Inherits="asp_Cgsgzgys" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
    <script type="text/javascript">
        function readGysxx(obj) {
            //            window.parent.location.href = "clxx.aspx?cl_id=" + obj;
            window.open("gysxx.aspx?gys_id=" + obj);
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
            var tb_gzcl = document.getElementById("table3");
            var chks = tb_gzcl.getElementsByTagName("input");
            var gys_ids = '';
            for (var i = 0; i < chks.length; i++) {
                if (chks[i].type == "checkbox" && chks[i].checked) {
                    gys_ids += Trim(chks[i].parentNode.parentNode.cells[0].innerHTML) + ",";
                }
            }
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var array = xmlhttp.responseText;     //接收替换返回的json字符串
                    if (array == 1) {
                        alert("删除成功");
                        location.reload();
                    }
                    else
                        alert("删除失败");
                }
            }
            xmlhttp.open("GET", "cgsgzgys_ajax.aspx?gysids=" + gys_ids, true);
            xmlhttp.send();

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
            var tableid = 'table3';
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
        <div class="jiansuo3">
            供应商：
            <input name="txtKeyWord2" type="text" id="txtKeyWord2" style="border-right: #808080 1px solid;
                border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
            &nbsp;&nbsp;地区：
            <select id="Select1" class="fu1" name="Select1">
                <option selected="selected" value=""></option>
            </select>
            &nbsp;
            <select id="Select2" class="fu1" name="Select2">
                <option selected="selected" value=""></option>
            </select>
            &nbsp;
            <input type="submit" name="filter2" value="检索" id="filter2" class="filter" filter=""
                style="color: Black; border-style: None; font-family: 宋体; font-size: 12px; height: 20px;
                width: 37px; cursor: pointer;" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" name="btnDelete" value="删除分销商" onclick="deleteGzcl()"
                id="btnDelete" class="btnDelete1" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 72px; cursor: pointer;" />
        </div>
        <table width="755" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2"
            id="table3">
            <thead>
                <tr>
                    <th align="center" width="37">
                        <strong>选择</strong>
                    </th>
                    <th align="center" width="200">
                        <strong>分销商</strong>
                    </th>
                    <th align="center" width="80">
                        <strong>地区</strong>
                    </th>
                    <th align="center" width="120">
                        <strong>主页</strong>
                    </th>
                    <th align="center" width="55">
                        <strong>收藏人</strong>
                    </th>
                    <th align="center" width="80">
                        <strong>收藏人QQ</strong>
                    </th>
                    <th align="center" width="44">
                        <strong>操作</strong>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%foreach (System.Data.DataRow dr in dt_topfxs.Rows)
                  { %>
                <tr>
                    <td align="center" style="display: none">
                        <%=dr["gys_id"] %>
                    </td>
                    <td align="center">
                        <input type="checkbox" name="checkbox" />
                    </td>
                    <td align="left">
                        <%=dr["供应商"]%>
                    </td>
                    <td align="left">
                        <%=dr["联系地址"]%>
                    </td>
                    <td>
                        <%=dr["主页"]%>
                    </td>
                    <td class="gridtable">
                        <%=strScr%>
                    </td>
                    <td>
                        <%=strScrQQ%>
                    </td>
                    <td align="center">
                        <%-- <a href="clxx.aspx?cl_id=<%=dr["cl_id"] %>">--%>
                        <input type="button" name="filter" value="查阅" id="btnRead" onclick="readGysxx(<%=dr["gys_id"] %>)"
                            class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                            height: 20px; width: 37px; cursor: pointer;" />
                        <%-- </a>--%>
                    </td>
                </tr>
                <%} %>
                <%if (dt_topfxs.Rows.Count < 10)
                  {
                      for (int i = 0; i < 4 - dt_topfxs.Rows.Count; i++)
                      {%>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
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
