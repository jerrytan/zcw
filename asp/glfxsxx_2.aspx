<%@ Page Language="C#" AutoEventWireup="true" CodeFile="glfxsxx_2.aspx.cs" Inherits="asp_glfxsxx_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>管理分销商页面2</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <script src="js/gysglcl.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 152px;
        }
    </style>
</head>
<script type="text/javascript" language="javascript">
    function btnFilter_Click() {
        var gys = document.getElementById("lblgys_id").value;
        var pp= document.getElementById("ppmc").value;
        window.parent.parent.location.href = 'xzgxs.aspx?pp_mc=' + pp + '&gxs_id=' + gys + '&xzlx=fxs';
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
    function Delete_gs() {
        var table = document.getElementById("table2");
        var input = table.getElementsByTagName("input");
        var gs_id = "";
        for (var i = 0; i < input.length; i++) {
            if (input[i].type == "checkbox" && input[i].checked) {
                gs_id += Trim(input[i].value) + ",";
            }
        }
        var xmlhttp;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var text = xmlhttp.responseText;
                if (text == 1) {
                    alert('删除成功');
                    location.reload();
                }
                else {
                    alert('删除失败');
                    location.reload();
                }
            }
        }
        xmlhttp.open("GET", "glfxsxx_2_ajax.aspx?gs_id=" + gs_id, true);
        xmlhttp.send();
    }

    function ChaYue(gsmc) {
        window.open("glfxsxx_3.aspx?gsmc=" + gsmc + "&lx=fxs");
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
<body>
    <form id="form1" runat="server"> 
    <input type="hidden" id="lblgys_id" runat="server" />
    <div id="jiansuo2"> 
公司名称：
<input name="txtKeyWord" runat="server" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
<input type="hidden" id="ppmc" value="" runat="server" />
<div class="jiansuo_img">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 0px">
  <tr>
    <td width="80" height="30" align="center">
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/asp/images/jiansuo.gif" OnClick="JianSuo"/></td>
    <td width="85" align="left">
   <input type="button" class="btnDelete1" value="新增分销商" onclick="btnFilter_Click()" style="height: 20px;width: 72px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" /></td>
 <td width="85" align="left">
 <input type="button" class="btnDelete1" value="删除分销商" onclick="Delete_gs()" style="height: 20px;width: 72px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" /></td>
  </tr>
</table>
</div>
</div>
<div id="divtable" runat="server" style="height:200px"> 
        <table  border="0"  cellpadding="0" cellspacing="1" bgcolor="#dddddd" 
            class="table2" id="table2" style="table-layout：fixed ;word-wrap：break-word;">
          <thead>
            <tr>
              <th width="35" align="center" style="font-size:12px">选 择</th>
              <th align="center" style="font-size:12px">分销商名称</th>
              <th width="60" align="center" style="font-size:12px"><strong>地 区</strong></th>
              <th width="100" align="center" style="font-size:12px"><strong>公司注册日期</strong></th>
              <th width="120" align="center" style="font-size:12px"><strong>注册资金（万元）</strong></th>
              <th width="100" align="center" style="font-size:12px"><strong>公司电话</strong></th>
              <th width="45" align="center" style="font-size:12px"><strong>操 作</strong></th>
            </tr>
          </thead>
          <tbody>
          <% foreach (System.Data.DataRow dr in dt_gxs.Rows)
             {%>
            <tr>
              <td align="center"><input type="checkbox" name="input"  value="<%=dr["gys_id"]%>" />
                <label for="checkbox"></label></td>
              <td align="left" style="font-size:12px" class="style1"><%=dr["供应商"]%></td>
              <td style="font-size:12px"><%=dr["地区名称"]%></td>
              <td align="center" style="font-size:12px"><%=dr["注册日期"]%></td>
              <td align="center" style="font-size:12px"><%=dr["注册资金"]%></td>
              <td align="left" style="font-size:12px"><%=dr["电话"]%></td>
              <td align="center"><input type="submit" name="input" value="查阅" class="filter" onclick="ChaYue('<%=dr["供应商"] %>')" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;"/></td>
         </tr>
         <%}%>
         <%if (dt_gxs.Rows.Count < 10)
            {
                for (int i = 0; i < 10 - dt_gxs.Rows.Count; i++)
                {%>  
                    <tr><td></td><td class="style1"></td><td></td><td></td><td></td><td></td><td></td></tr>
                <%}
            }%>
          </tbody>
        </table>
         <div style="text-align:center"  runat="server" id="dic">
    <asp:LinkButton ID="btnhead" runat="server" CommandArgument="Head" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">首页</asp:LinkButton>&nbsp;
     <asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">上页</asp:LinkButton>&nbsp;
    <asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Pager"
            OnCommand="PagerButtonClick" ForeColor="Black">下页</asp:LinkButton>&nbsp;
    <asp:LinkButton ID="btnfoot" runat="server" CommandArgument="Foot" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">尾页</asp:LinkButton>&nbsp;
            第<asp:Label ID="lblCurPage" runat="server"  Text="0" ForeColor="Blue">Label</asp:Label>/
              <asp:Label ID="lblPageCount" runat="server" Text="0" ForeColor="Blue">Label</asp:Label>页
        <br />
    </div>
      </div>
    </form>
</body>
</html>
