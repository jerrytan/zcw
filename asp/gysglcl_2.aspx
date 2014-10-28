<!-- 
�ļ���:  gysglcl_2.aspx   
       ���������gys_id��ejfl
       author:�����
-->
<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="gysglcl_2.aspx.cs" Inherits="asp_gysglcl_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>��Ӧ�̹������ҳ��2</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <script src="js/gysglcl.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            height: 13px;
        }
        .style2
        {
            height: 11px;
        }
    </style>
</head>
<script type="text/javascript" language="javascript">
    function Add(obj) {
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        var cl_mc = Trim(tds[1].innerHTML);
        document.getElementById("cl_mc").value = cl_mc;
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
    function btnFilter_Click() {
        var gy = document.getElementById("lblgys_id").value;
        var ej_cl = document.getElementById("ej_cl").value;
        window.parent.location.href = 'xzclym.aspx?gys_id=' + gy + '&ej=' + ej_cl;
    }
    function BJCL(cl_mc) {
        var gys = document.getElementById("lblgys_id").value;
        window.open("clbj.aspx?cl_mc=" + cl_mc + "&gys_id=" + gys);
    }
    function delete_cl() {
        var table = document.getElementById("table2");
        var input = table.getElementsByTagName("input");
        var cl_id = "";
        for (var i = 0; i < input.length;i++) {
            if (input[i].type == "checkbox" && input[i].checked) {
                cl_id += Trim(input[i].value)+",";
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
                    alert('ɾ���ɹ�');
                    location.reload();
                }
                else {
                    alert('ɾ��ʧ��');
                    location.reload();
                }
            }
        }
        xmlhttp.open("GET", "gysglcl_2_ajax.aspx?cl_id=" + cl_id, true);
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
        var tableid = 'table2';
        //����id
        var overcolor = '#fff0e9'; //��꾭����ɫ
        var color1 = '#f2f6ff'; 	//��һ����ɫ
        var color2 = '#fff'; 	//�ڶ�����ɫ
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
    <div id="jiansuo2">
����������
<input name="txtKeyWord" runat="server" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
<div class="jiansuo_img">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table">
  <tr>
    <td width="80" height="30" align="center">
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/asp/images/jiansuo.gif" OnClick="JianSuo"/></td>
    <td width="85" align="left">
   <input type="button" class="btnFilter" value="��Ӳ���" onclick="btnFilter_Click()" style=" margin-top:0px; height: 20px;width: 64px; border-style: none; font-family: ����; font-size: 12px; cursor:pointer;" /></td>
    <td>
     <input type="button" class="btnFilter" value="ɾ������" onclick="delete_cl()" style=" margin-top:0px; height: 20px;width: 64px; border-style: none; font-family: ����; font-size: 12px; cursor:pointer;" /></td>
  </tr>
</table>
</div></div>
<input type="hidden" value="" id="ej_cl" runat="server" />
   <div id="divtable" runat="server" style="height:230px"> 
<table width="100%"  border="0"  cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2" id="table2" style="table-layout��fixed ;word-wrap��break-word;">
      <thead>
        <tr>
          <th width="42" align="center" style="font-size:12px" class="style2"><strong>ѡ ��</strong></th>
          <th width="125" align="center" style="font-size:12px" class="style2"><strong>��������</strong></th>
          <th align="center" class="style2" style="font-size:12px"><strong>Ʒ ��</strong></th>
          <th width="85" align="center" style="font-size:12px" class="style2"><strong>���\�ͺ�</strong></th>
          <th width="55" align="center" style="font-size:12px" class="style2"><strong>�� ��</strong></th>
          <th width="255" align="center" style="font-size:12px" class="style2"><strong>��Ӧ��</strong></th>
          <th width="53" align="center" style="font-size:12px" class="style2"><strong>�� ��</strong></th>
        </tr>
      </thead>
      <tbody>
       <% foreach (System.Data.DataRow R_cl in dt_cl.Rows)
          {%>
        <tr>
          <td align="center"><input type="checkbox" name="input" id="checkbox" value="<%=R_cl["cl_id"].ToString() %>"/>
            <label for="checkbox"></label></td>
          <td align="left" style="font-size:12px"><%=R_cl["��ʾ��"].ToString()%></td>
          <td class="style1" style="font-size:12px"><%=R_cl["Ʒ������"].ToString()%></td>
          <td style="font-size:12px"><%=R_cl["����ͺ�"].ToString()%></td>
          <td style="font-size:12px"><%=R_cl["���ϱ���"].ToString()%></td>
          <td align="left" style="font-size:12px"><%=R_cl["��������"].ToString()%></td>
          <td align="center">
          <input type="submit" name="input" value="�༭" id="filter" onclick="BJCL('<%=R_cl["��ʾ��"].ToString()%>')" class="filter" filter="" style="color:Black;border-style:None;font-family:����;font-size:12px;height:20px;width:37px; cursor:pointer;"/>
          <input type="hidden" id="lblgys_id" runat="server" />
          </td>
          </tr>
          <%}%>
          <%if (dt_cl.Rows.Count < 10)
            {
                for (int i = 0; i < 10 - dt_cl.Rows.Count; i++)
                {%>  
                    <tr><td></td><td class="style1"></td><td></td><td></td><td></td><td></td><td></td></tr>
                <%}
            }%>
      </tbody>
    </table>
  <div style="text-align:center"  runat="server" id="dic">
    <asp:LinkButton ID="btnhead" runat="server" CommandArgument="Head" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">��ҳ</asp:LinkButton>&nbsp;
     <asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">��ҳ</asp:LinkButton>&nbsp;
    <asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Pager"
            OnCommand="PagerButtonClick" ForeColor="Black">��ҳ</asp:LinkButton>&nbsp;
    <asp:LinkButton ID="btnfoot" runat="server" CommandArgument="Foot" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">βҳ</asp:LinkButton>&nbsp;
            ��<asp:Label ID="lblCurPage" runat="server"  Text="0" ForeColor="Blue">Label</asp:Label>/
              <asp:Label ID="lblPageCount" runat="server" Text="0" ForeColor="Blue">Label</asp:Label>ҳ
     
        <br />
    </div>
</div>
    </form>
</body>
</html>
