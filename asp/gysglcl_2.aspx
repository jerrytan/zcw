<!-- 
文件名:  gysglcl_2.aspx   
       传入参数：gys_id和ejfl
       author:蒋桂娥
-->
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" EnableViewStateMac= "false"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>供应商管理材料页面2</title>
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
//        var ej_cl = document.getElementById("ej_cl").value;
        //        window.parent.location.href = 'xzclym.aspx?gys_id=' + gy + '&ej=' + ej_cl;
        var pp_id = document.getElementById("ppid").value;
        if (pp_id==""||pp_id==undefined)
        {
            alert("请先选择品牌！");
        }
        else
        {
            var url = 'scsxzcl.aspx?scs_id=' + gy + "&ppid=" + pp_id;
            window.open(url);
          //  window.parent.location.href = 'scsxzcl.aspx?scs_id=' + gy + "&ppid=" + pp_id;
        }
       
    }
    function BJCL(cl_id,flbm,flmc,pp_id) {
      var gy = document.getElementById("lblgys_id").value;
      //      var pp_id = document.getElementById("ppid").value;
      if (pp_id==""||pp_id==undefined)
      {
          alert("请选择品牌！");
          return;
      }
      window.open('scsxzcl.aspx?scs_id=' + gy + "&ppid=" + pp_id + "&cl_id=" + cl_id + "&flmc=" + flmc+"&flbm="+flbm);
    }
    function delete_cl() {
        var table = document.getElementById("table2");
        var input = table.getElementsByTagName("input");
        var cl_id = "";
        for (var i = 0; i < input.length;i++) {
            if (input[i].type == "checkbox" && input[i].checked) {
                cl_id += Trim(input[i].value) + ",";
            }

        }
        if (cl_id == "" && cl_id == undefined)
        {
            alert("请先勾选需要删除的材料！");
            return;
        }
        if (!confirm("是否删除选中材料"))
        {
            return;
        }
        else
        {
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
                    if (text == "1") {
                        alert('删除成功');
                        location.reload();
                    }
                    else {
                        alert('删除失败');
                        location.reload();
                    }
                }
            }
            xmlhttp.open("GET", "scssccl.aspx?cl_id=" + cl_id, true);
            xmlhttp.send();
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

<body>
<script runat="server">
    public string gys_id = "";
    public string pp_id = "";
    public DataConn Conn = new DataConn();
    public int PageSize = 10;
    DataTable dt_cl = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
        {
            gys_id = Request["gys_id"].ToString();
        }
        if (Request["ppid"]!=null&&Request["ppid"].ToString()!="")
        {
            pp_id = Request["ppid"].ToString();
        }
        this.lblgys_id.Value = gys_id;
        this.ppid.Value = pp_id;
        string sSQL = "";
        if (pp_id!="")
        {
            sSQL = "select cl_id,显示名,品牌名称,规格型号,材料编码,生产厂商,分类编码,分类名称,pp_id from 材料表 where gys_id='" + gys_id + "' and pp_id='" + pp_id + "' order by updatetime desc";
            dt_cl = Conn.GetDataTable(sSQL);  
        }
        else
        {
            sSQL = "select top 10 cl_id,显示名,品牌名称,规格型号,材料编码,生产厂商,分类编码,分类名称,pp_id from 材料表 where gys_id='" + gys_id + "' order by updatetime desc";
            dt_cl = Conn.GetDataTable(sSQL);  
        }
       
        if (!IsPostBack)
        {
            createlm(dt_cl);
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
            txtKeyWord.Text = "";
        }
        if (sColumName == "材料名称")
        {
            sColumName = "显示名";
        }
        if (sColumName == "供应商")
        {
            sColumName = "生产厂商";
        }
        //得到要筛选字段的类型
        string sql_js = "";
        if (pp_id != "")
        {
            sql_js = "select cl_id,显示名,品牌名称,规格型号,材料编码,生产厂商,分类编码,分类名称,pp_id from 材料表 where gys_id='" + gys_id + "' and pp_id='" + pp_id + "'"; 
        }
        else
        {
            sql_js = "select top 10 cl_id,显示名,品牌名称,规格型号,材料编码,生产厂商,分类编码,分类名称,pp_id from 材料表 where gys_id='" + gys_id + "'";
        }
        if (sColumName == "全部")
        {
            strCondition = "";
        }
        else
        {
            sSQL = "select * from (" + sql_js + ")#temp where 1=0";
            objDt = Conn.GetDataTable(sSQL);
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
        if (strCondition == "")
        {
            string sql = sql_js;
            dt_cl = Conn.GetDataTable(sql);
        }
        else
        {
            string sql = "select * from (" + sql_js + ")#temp where " + strCondition;
            dt_cl = Conn.GetDataTable(sql);
        }
    }
   
    private void createlm(DataTable objDt)
    {
        ListItem objItem = null;
        if (objDt != null)
        {
            objItem = null;
            objItem = new ListItem();
            objItem.Text = "全部";
            lieming.Items.Add(objItem); 
            for (int i = 0; i < objDt.Columns.Count; i++)
            {
                switch (objDt.Columns[i].ColumnName)
                {
                    case "cl_id":
                        break;
                    case "分类编码":
                        break;
                    case "分类名称":
                        break;
                    case "品牌名称":
                        break;
                    case "显示名":
                         objItem = null;
                        objItem = new ListItem();
                        objItem.Text ="材料名称";
                        lieming.Items.Add(objItem);
                        break;
                    case "生产厂商":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "供应商";
                        lieming.Items.Add(objItem);
                        break;
                    default:
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = objDt.Columns[i].ColumnName;
                        lieming.Items.Add(objItem);
                        break;
                }
            }
        }
    }
    //*****************************小张新增检索功能结束*********************************
</script>
  <form id="form1" runat="server">
    <input type="hidden" id="lblgys_id" runat="server" />
    <input type="hidden" id="ppid" runat="server" />

        <div id="jiansuo2"> 
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
                       
                    </asp:DropDownList>&nbsp; <asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid;
                        border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                        runat="server"></asp:TextBox>  
                        &nbsp;            
                    <asp:Button ID="Button1" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
                        BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                        filter Font-Names="宋体"></asp:Button>
                        &nbsp;
                         <input type="button" class="btnDelete1" value="新增材料" onclick="btnFilter_Click()" style="height: 20px;width: 72px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" />&nbsp;
                         <input type="button" class="btnDelete1" value="删除材料" onclick="delete_cl()" style="height: 20px;width: 72px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" /></td>

</div>

<input type="hidden" value="" id="ej_cl" runat="server" />
   <div id="divtable" runat="server" style="height:230px"> 
<table width="100%"  border="0"  cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2" id="table2" style="table-layout：fixed ;word-wrap：break-word;">
      <thead>
        <tr>
          <th width="42" align="center" style="font-size:12px" class="style2"><strong>选 择</strong></th>
          <th width="125" align="center" style="font-size:12px" class="style2"><strong>材料名称</strong></th>
          <th align="center" class="style2" style="font-size:12px"><strong>品 牌</strong></th>
          <th width="85" align="center" style="font-size:12px" class="style2"><strong>规格\型号</strong></th>
          <th width="55" align="center" style="font-size:12px" class="style2"><strong>编 码</strong></th>
          <th width="255" align="center" style="font-size:12px" class="style2"><strong>供应商</strong></th>
          <th width="53" align="center" style="font-size:12px" class="style2"><strong>操 作</strong></th>
        </tr>
      </thead>
      <tbody>
       <% foreach (System.Data.DataRow R_cl in dt_cl.Rows)
          {%>
        <tr>
          <td align="center"><input type="checkbox" name="input" id="checkbox" value="<%=R_cl["cl_id"].ToString() %>"/>
            <label for="checkbox"></label></td>
          <td align="left" style="font-size:12px"><%=R_cl["显示名"].ToString()%></td>
          <td class="style1" style="font-size:12px"><%=R_cl["品牌名称"].ToString()%></td>
          <td style="font-size:12px"><%=R_cl["规格型号"].ToString()%></td>
          <td style="font-size:12px"><%=R_cl["材料编码"].ToString()%></td>
          <td align="left" style="font-size:12px"><%=R_cl["生产厂商"].ToString()%></td>
          <td align="center">
          <input type="Button" name="input" value="编辑" id="filter" onclick="BJCL('<%=R_cl["cl_id"].ToString() %>','<%=R_cl["分类编码"].ToString()%>','<%=R_cl["分类名称"].ToString() %>','<%=R_cl["pp_id"].ToString() %>')" class="filter" filter="" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;"/>
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
   
</div>
    </form>
</body>
</html>
