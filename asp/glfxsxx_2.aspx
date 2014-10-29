<%@ Page Language="C#" AutoEventWireup="true" CodeFile="glfxsxx_2.aspx.cs" Inherits="asp_glfxsxx_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>���������ҳ��2</title>
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
                    alert('ɾ���ɹ�');
                    location.reload();
                }
                else {
                    alert('ɾ��ʧ��');
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
    <input type="hidden" id="lblgys_id" runat="server" />
    <div id="jiansuo2"> 
��˾���ƣ�
<input name="txtKeyWord" runat="server" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
<input type="hidden" id="ppmc" value="" runat="server" />
<div class="jiansuo_img">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 0px">
  <tr>
    <td width="80" height="30" align="center">
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/asp/images/jiansuo.gif" OnClick="JianSuo"/></td>
    <td width="85" align="left">
   <input type="button" class="btnDelete1" value="����������" onclick="btnFilter_Click()" style="height: 20px;width: 72px; border-style: none; font-family: ����; font-size: 12px; cursor:pointer;" /></td>
 <td width="85" align="left">
 <input type="button" class="btnDelete1" value="ɾ��������" onclick="Delete_gs()" style="height: 20px;width: 72px; border-style: none; font-family: ����; font-size: 12px; cursor:pointer;" /></td>
  </tr>
</table>
</div>
</div>
<div id="divtable" runat="server" style="height:200px"> 
        <table  border="0"  cellpadding="0" cellspacing="1" bgcolor="#dddddd" 
            class="table2" id="table2" style="table-layout��fixed ;word-wrap��break-word;">
          <thead>
            <tr>
              <th width="35" align="center" style="font-size:12px">ѡ ��</th>
              <th align="center" style="font-size:12px">����������</th>
              <th width="60" align="center" style="font-size:12px"><strong>�� ��</strong></th>
              <th width="100" align="center" style="font-size:12px"><strong>��˾ע������</strong></th>
              <th width="120" align="center" style="font-size:12px"><strong>ע���ʽ���Ԫ��</strong></th>
              <th width="100" align="center" style="font-size:12px"><strong>��˾�绰</strong></th>
              <th width="45" align="center" style="font-size:12px"><strong>�� ��</strong></th>
            </tr>
          </thead>
          <tbody>
          <% foreach (System.Data.DataRow dr in dt_gxs.Rows)
             {%>
            <tr>
              <td align="center"><input type="checkbox" name="input"  value="<%=dr["gys_id"]%>" />
                <label for="checkbox"></label></td>
              <td align="left" style="font-size:12px" class="style1"><%=dr["��Ӧ��"]%></td>
              <td style="font-size:12px"><%=dr["��������"]%></td>
              <td align="center" style="font-size:12px"><%=dr["ע������"]%></td>
              <td align="center" style="font-size:12px"><%=dr["ע���ʽ�"]%></td>
              <td align="left" style="font-size:12px"><%=dr["�绰"]%></td>
              <td align="center"><input type="submit" name="input" value="����" class="filter" onclick="ChaYue('<%=dr["��Ӧ��"] %>')" style="color:Black;border-style:None;font-family:����;font-size:12px;height:20px;width:37px; cursor:pointer;"/></td>
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
