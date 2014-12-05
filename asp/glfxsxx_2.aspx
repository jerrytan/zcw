<%@ Page Language="C#" AutoEventWireup="true" CodeFile="glfxsxx_2.aspx.cs" Inherits="asp_glfxsxx_2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>���������ҳ��2</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 152px;
        }
    </style>
</head>
<script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
<script type="text/javascript">
    function btnPrevs() {
        var pageI = document.getElementById("pageI").value; //$("#pageI").val();
        var pageS = document.getElementById("pageS").value; //$("#pageS").val();
        if (Number(pageI) > 1) {
            pageI = (Number(pageI) - 1).toString();
            document.getElementById("pageI").value = pageI;
            document.getElementById("form1").submit();

            } else {
                return;
            }
        }
        function btnNexts() {
            var pageI = document.getElementById("pageI").value; //parseInt($("#pageI").val());
            var pageC = document.getElementById("lblPageCount").innerText; //parseInt($("#lblPageCount").text()); innerText
            if (parseInt(pageI) < parseInt(pageC)) {
                document.getElementById("pageI").value = (parseInt(pageI) + 1).toString();
                document.getElementById("form1").submit();
            } else {

                return;
            }
        }

    function btnFilter_Click() {
        var pp_id = document.getElementById("ppid").value;
        if (pp_id == "" || pp_id == undefined) {
            alert("��ѡ��Ʒ�ƣ�");
            return;
        }
        else {
            var gys = document.getElementById("lblgys_id").value;
            var pp = document.getElementById("ppmc").value;
            var url = 'scsxzfxs.aspx?ppmc=' + pp + '&scsid=' + gys + '&ppid=' + pp_id;
            window.parent.parent.open(url);
            //window.parent.parent.location.href = 'xzgxs.aspx?pp_mc=' + pp + '&gxs_id=' + gys + '&xzlx=fxs';
            // window.parent.parent.location.href = 'scsxzfxs.aspx?ppmc=' + pp + '&scsid=' + gys + '&ppid=' + pp_id;
        }
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
        var pp_id = document.getElementById("ppid").value;
        if (pp_id == "" || pp_id == undefined) {
            alert("����ѡ��Ʒ�ƣ�");
            return;
        }
        else {
            var table = document.getElementById("table2");
            var input = table.getElementsByTagName("input");
            var fxs_id = "";
            for (var i = 0; i < input.length; i++) {
                if (input[i].type == "checkbox" && input[i].checked) {
                    fxs_id += Trim(input[i].value) + ",";
                }
            }
            if (fxs_id == "" || fxs_id == undefined) {
                alert("��ѡ����Ҫɾ���ķ����̣�");
                return;
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
            var gys_id = document.getElementById("lblgys_id").value;
            xmlhttp.open("GET", "glfxsxx_2_ajax.aspx?gys_id=" + gys_id + "&pp_id=" + pp_id + "&fxs_id=" + fxs_id, true);
            xmlhttp.send();
        }
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
    <input type="hidden" value="" id="pageS" runat="server" />
    <input type="hidden" value="" id="pageI" runat="server" />
    <input type="hidden" id="lblgys_id" runat="server" />
    <input type="hidden" id="ppid" runat="server" />
    <input type="hidden" id="ppmc" value="" runat="server" />
    <div id="jiansuo2">
        <asp:Label ID="shaixu" runat="server"><font style="FONT-SIZE: 9pt">����������</font></asp:Label>
        <asp:DropDownList ID="lieming" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
            font-size: 9pt; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
            runat="server" Width="128px">
        </asp:DropDownList>
        <asp:DropDownList ID="yunsuanfu" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
            font-size: 9pt; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
            runat="server" Width="88px">
            <asp:ListItem Value="like" Selected="True">�����ؼ���</asp:ListItem>
            <asp:ListItem Value="=">����</asp:ListItem>
            <asp:ListItem Value="&lt;">С��</asp:ListItem>
            <asp:ListItem Value="&gt;">����</asp:ListItem>
            <asp:ListItem Value="&gt;=">���ڵ���</asp:ListItem>
            <asp:ListItem Value="&lt;=">С�ڵ���</asp:ListItem>
        </asp:DropDownList>
        &nbsp;
        <asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid; border-top: #808080 1px solid;
            border-left: #808080 1px solid; border-bottom: #808080 1px solid" runat="server"></asp:TextBox>
        &nbsp;
        <asp:Button ID="filter" runat="server" Text="����" OnClick="filter_Click" CssClass="filter"
            BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
            filter Font-Names="����"></asp:Button>
        &nbsp;
        <input type="button" class="btnDelete1" value="����������" onclick="btnFilter_Click()"
            style="height: 20px; width: 72px; border-style: none; font-family: ����; font-size: 12px;
            cursor: pointer;" />&nbsp;
        <input type="button" class="btnDelete1" value="ɾ��������" onclick="Delete_gs()" style="height: 20px;
            width: 72px; border-style: none; font-family: ����; font-size: 12px; cursor: pointer;" />
    </div>
    <div id="divtable" runat="server" style="height: 200px">
        <table border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2"
            id="table2" style="table-layout��fixed; word-wrap��break-word;">
            <thead>
                <tr>
                    <th width="35" align="center" style="font-size: 12px">
                        <strong>ѡ ��</strong>
                    </th>
                    <th align="center" style="font-size: 12px">
                        <strong>����������</strong>
                    </th>
                    <th width="100" align="center" style="font-size: 12px">
                        <strong>�� ��</strong>
                    </th>
                    <th width="100" align="center" style="font-size: 12px">
                        <strong>��˾ע������</strong>
                    </th>
                    <th width="100" align="center" style="font-size: 12px">
                        <strong>ע���ʽ���Ԫ��</strong>
                    </th>
                    <th width="80" align="center" style="font-size: 12px">
                        <strong>��˾�绰</strong>
                    </th>
                    <th width="45" align="center" style="font-size: 12px">
                        <strong>״̬</strong>
                    </th>
                    <th width="45" align="center" style="font-size: 12px">
                        <strong>�� ��</strong>
                    </th>
                </tr>
            </thead>
            <tbody>
                <% if (dt_gxs != null && dt_gxs.Rows.Count > 0)
                   {
                       foreach (System.Data.DataRow dr in dt_gxs.Rows)
                       {%>
                <tr>
                    <%
                        string zcrq = dr["ע������"].ToString().Substring(0, 10);
                    %>
                    <td align="center">
                        <input type="checkbox" name="input" value="<%=dr["gys_id"]%>" />
                        <label for="checkbox">
                        </label>
                    </td>
                    <td align="left" style="font-size: 12px" class="style1">
                        <%=SubStrings.GetWidth(11,dr["��Ӧ��"].ToString(),dr["��Ӧ��"].ToString())%>
                    </td>
                    <td style="font-size: 12px;">
                        <%=dr["��������"]%>
                    </td>
                    <td align="center" style="font-size: 12px">
                        <%=zcrq%>
                    </td>
                    <td align="center" style="font-size: 12px;">
                        <%=dr["ע���ʽ�"]%>
                    </td>
                    <td align="left" style="font-size: 12px">
                        <%=dr["�绰"]%>
                    </td>
                    <td align="left" style="font-size: 12px">
                        <%=Convert.ToString(dr["�Ƿ�����"])=="1"?"����":"δ����"%>
                    </td>
                    <td align="center">
                        <input type="submit" name="input" value="����" class="filter" onclick="ChaYue('<%=dr["��Ӧ��"] %>')"
                            style="color: Black; border-style: None; font-family: ����; font-size: 12px; height: 20px;
                            width: 37px; cursor: pointer;" />
                    </td>
                </tr>
                <%}
                   }%>
                <%if (dt_gxs != null && dt_gxs.Rows.Count < 10)
                  {
                      for (int i = 0; i < 10 - dt_gxs.Rows.Count; i++)
                      {%>
                <tr>
                    <td>
                    </td>
                    <td class="style1">
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
        <div style="text-align: center" runat="server" id="dic">
            <asp:LinkButton ID="btnhead" runat="server" CommandArgument="Head" CommandName="Pager"
                OnCommand="PagerButtonClick" ForeColor="Black">��ҳ</asp:LinkButton>&nbsp;
            <%--<asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Pager"
                OnCommand="PagerButtonClick" ForeColor="Black" OnClick="btnPrev_Click">��ҳ
                </asp:LinkButton>&nbsp;--%>
            <input type="button" id="btnPrev" name="btnPrev" onclick="btnPrevs()" value="��ҳ" runat="server" />
            <input type="button" id="btnNext" name="btnNext" value="��ҳ" onclick="btnNexts()" runat="server" />
            <%--<asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Pager"
                OnCommand="PagerButtonClick" ForeColor="Black" OnClick="btnNext_Click">
                ��ҳ</asp:LinkButton>--%>
            &nbsp;
            <asp:LinkButton ID="btnfoot" runat="server" CommandArgument="Foot" CommandName="Pager"
                OnCommand="PagerButtonClick" ForeColor="Black">βҳ</asp:LinkButton>&nbsp; 
                ��
                <label id="lblCurPage" runat="server"  >0</label>
                <%--<asp:Label ID="lblCurPage" runat="server" Text="0" ForeColor="Blue"></asp:Label>--%>/
                <%--<asp:Label ID="lblPageCount" runat="server" Text="0" ForeColor="Blue"></asp:Label>--%>
                <label id="lblPageCount" runat="server"  >0</label>
                ҳ
            <br />
        </div>
    </div>
    </form>
</body>
</html>
