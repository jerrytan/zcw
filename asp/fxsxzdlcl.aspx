<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"  EnableViewStateMac= "false"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>分销商新增代理材料</title>
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/cllb.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
<!--
        function onloadEvent(func)
        {
            var one = window.onload
            if (typeof window.onload != 'function')
            {
                window.onload = func
            }
            else
            {
                window.onload = function ()
                {
                    one();
                    func();
                }
            }
        }
        function showtable()
        {
            var tableid = 'table';
            //表格的id
            var overcolor = '#fff0e9'; //鼠标经过颜色
            var color1 = '#f2f6ff'; 	//第一种颜色
            var color2 = '#fff'; 	//第二种颜色
            var tablename = document.getElementById(tableid)
            var tr = tablename.getElementsByTagName("tr")
            for (var i = 1; i < tr.length; i++)
            {
                tr[i].onmouseover = function ()
                {
                    this.style.backgroundColor = overcolor;
                }
                tr[i].onmouseout = function ()
                {
                    if (this.rowIndex % 2 == 0)
                    {
                        this.style.backgroundColor = color1;
                    } else
                    {
                        this.style.backgroundColor = color2;
                    }
                }
                if (i % 2 == 0)
                {
                    tr[i].className = "color1";
                } else
                {
                    tr[i].className = "color2";
                }
            }
        }
        onloadEvent(showtable);
-->

</script>
    <script language="javascript" type="text/javascript">
        function selectall1(obj)
        {
            if (obj.checked)
            {
                var Table = document.getElementById("table");
                var ck = Table.getElementsByTagName("input");
                for (var i = 0; i < ck.length; i++)
                {
                    var e = ck[i];
                    if (e.type == 'checkbox')
                    {
                        if (e.name == 'checkbox')
                        {
                            if (e.checked == false)
                            {
                                document.getElementById("checkboxAll").checked = false;
                            }
                        }
                        else
                        {
                            document.getElementById("checkboxAll").checked = true;
                        }
                    }
                }
            }
            else
            {
                document.getElementById("checkboxAll").checked = false;
            }
        }
        function selectall()
        {
            var Table = document.getElementById("table");
            var ck = Table.getElementsByTagName("input");
            var ckb = document.getElementsByName("checkboxAll");
            if (document.getElementById("checkboxAll").checked)
            {
                for (var i = 0; i < ck.length; i++)
                {
                    var e = ck[i];
                    if (e.type == 'checkbox' && e.name == 'checkbox')
                    {
                        e.checked = true;
                    }
                }
            }
            else
            {
                for (var i = 0; i < ck.length; i++)
                {
                    var e = ck[i];
                    if (e.type == 'checkbox' && e.name == 'checkbox')
                    {
                        e.checked = false;
                    }
                }
            }
        }
    </script>
    <script type="text/javascript">
        function Fxsxzdlcl()
        {
            try
            {
                var cl_id;
                var Table = document.getElementById("table");
                var ck = Table.getElementsByTagName("input");
                for (var i = 0; i < ck.length; i++)
                {
                    var e = ck[i];
                    var tr = e.parentNode.parentNode;
                    if (e.type == 'checkbox')
                    {
                        if (e.name == 'checkbox')
                        {
                            if (e.checked)
                            {
                                var price;
                                var txt = tr.getElementsByTagName("input");
                                for (var j = 0; j < txt.length; j++)
                                {
                                    if (txt[j].type == "text")
                                    {
                                        price = txt[j].value;
                                    }
                                }
                                if (price == "" || price == undefined)
                                {
                                    price = "0";
                                }
                                if (cl_id == "" || cl_id == undefined)
                                {
                                    cl_id = tr.cells[7].innerHTML + "|" + price + "|"+tr.cells[5].innerHTML+",";
                                }
                                else
                                {
                                    cl_id += tr.cells[7].innerHTML + "|" + price + "|"+tr.cells[5].innerHTML+",";
                                }

                            }
                        }
                    }
                }
                if (cl_id == "" || cl_id == undefined)
                {
                    alert("请选择要新增的材料！");
                    return false;
                }
                else
                {
                    document.getElementById("cl_id").value = cl_id;
                    return true;
                }
            } catch (e)
            {
                alert("添加错误！错误信息：" + e);
                return false;
            }
        }

        function saveReport()
        {
            var fxs = document.getElementById("fxs_id").value;
            // jquery 表单提交
            $("#form1").ajaxSubmit(function (message)
            {
                // 对于表单提交成功后处理，message为提交页面saveReport.htm的返回内容 
                if (message == "1")
                {
                    alert("提交成功");
                    window.location.href = 'fxsglcl.aspx?gys_id=' + fxs;
                    //  $("#cl").empty();
                    //关闭
                    //                window.opener = null;
                    //                window.open("", "_self");
                    //                window.close();
                }
                else
                {
                    alert(message);
                }
            });
            return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转 action="fxsxzdlcl_Save.aspx" method="post" onsubmit="return saveReport();"
        }  
         </script>
    
</head>
<body>
<script runat="server">
public DataConn Conn = new DataConn();
public string scsid = "";       //生产商ID
public string fxsid = "";       //分销商ID
public string ppid = "";
public string ppmc = "";
public DataTable dt = new DataTable();
protected void Page_Load(object sender, EventArgs e)
{
    if (Request["scsid"]!=null&&Request["scsid"].ToString()!="")
    {
        scsid = Request["scsid"].ToString();       
    }
    if (Request["fxsid"] != null && Request["fxsid"].ToString() != "")
    {
        fxsid = Request["fxsid"].ToString();       
    }
    if (Request["ppid"] != null && Request["ppid"].ToString() != "")
    {
        ppid = Request["ppid"].ToString();      
    }
    if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
    {
        ppmc = Request["ppmc"].ToString();
    }
    this.scs_id.Value = scsid;
    this.pp_id.Value = ppid;
    this.fxs_id.Value = fxsid;
    this.pp_mc.Value = ppmc;
    string sSQL = "select 材料编码,显示名,规格型号,计量单位,price,pp_id,品牌名称,cl_id from 材料表 where gys_id='" + scsid
        + "'  and pp_id='" + ppid + "' and 品牌名称='" + ppmc + "' and cl_id not in(select cl_id from 供应商材料表 where gys_id='"+scsid+"' and fxs_id='"+fxsid+"')";
    dt = Conn.GetDataTable(sSQL);
    if (!IsPostBack)
    {
        createlm(dt);
    }
}
protected void Add_Click(object sender, System.EventArgs e)
{
    string value = "";
    string cl_id1= "";   //SQL语句
    string fxs_id1 = "";   //SQL语句
    try
    {    
        
        cl_id1 = this.cl_id.Value;
        fxs_id1 = this.fxs_id.Value;
        string sSQL = "";
        if (cl_id1 != "")
        {
            while (cl_id1.EndsWith(","))
            {
                cl_id1 = cl_id1.Substring(0, cl_id1.Length - 1);
            }
            string Insert = "";
            string[] cl_price = cl_id1.Split(',');   //添加几项
            for (int i = 0; i < cl_price.Length; i++)
            {
                string[] cl = cl_price[i].Split('|');
                string price = "";
                price = cl[1];
                sSQL = "select fl_id,材料编码,是否启用,类型,price,显示名,pp_id,说明,分类名称,品牌名称,生产厂商,规格型号,计量单位,单位体积,单位重量,gys_id,分类编码,yh_id,一级分类名称 from 材料表 where cl_id='" + cl[0] + "'";
                DataTable dt_cl = Conn.GetDataTable(sSQL);
                if (dt_cl != null && dt_cl.Rows.Count > 0)
                {
                    if (price == "0" || price == "")
                    {
                        price = dt_cl.Rows[0]["price"].ToString();
                    }
                    string sql = "select count(*) from 供应商材料表 where cl_id='" + cl[0] + "' and fxs_id='" + fxs_id1 + "'";
                    string count = Conn.DBLook(sql);
                    if (count=="")
                    {
                        count = "0";
                    }
                    int sl = Convert.ToInt32(count);
                    if (sl > 0)
                    {
                        value += "材料名称为：" + dt_cl.Rows[0]["显示名"] + " 材料编码为：" + dt_cl.Rows[0]["材料编码"] + " 的材料已存在！";
                    }
                    else
                    {
                        Insert += "   insert into 供应商材料表(cl_id,fl_id,材料编码,是否启用,类型,price,显示名,pp_id,说明,分类名称,品牌名称,生产厂商,规格型号,计量单位,单位体积,单位重量,gys_id,分类编码,yh_id,一级分类名称,fxs_id,updatetime) values(" +
                         "'" + cl[0] + "','" + dt_cl.Rows[0]["fl_id"] + "','" + dt_cl.Rows[0]["材料编码"] + "','1','" + dt_cl.Rows[0]["类型"] + "','" + price + "','"
                         + dt_cl.Rows[0]["显示名"] + "','" + dt_cl.Rows[0]["pp_id"] + "','" + dt_cl.Rows[0]["说明"] + "','" + dt_cl.Rows[0]["分类名称"] + "','" +
                         dt_cl.Rows[0]["品牌名称"] + "','" + dt_cl.Rows[0]["生产厂商"] + "','" + dt_cl.Rows[0]["规格型号"] + "','" + dt_cl.Rows[0]["计量单位"] + "','"
                         + dt_cl.Rows[0]["单位体积"] + "','" + dt_cl.Rows[0]["单位重量"] + "','" + dt_cl.Rows[0]["gys_id"] + "','" + dt_cl.Rows[0]["分类编码"] + "','" +
                         dt_cl.Rows[0]["yh_id"] + "','" + dt_cl.Rows[0]["一级分类名称"] + "','" + fxs_id1 + "',(select getdate()))";
                        Insert += "  insert into PriceFxs( FxsPriceClid, GysId, FxsId, GysPrice, FxsPrice)values('" + cl[0] + "','" + dt_cl.Rows[0]["gys_id"] + "','" + fxs_id1 + "',(select ScsPrice from PriceScs where ScsPriceClid='" + cl[0] + "' and ScsPriceUpdatetime =(select MAX(ScsPriceUpdatetime) from PriceScs where ScsPriceClid='" + cl[0] + "')),'" + cl[1] + "')";
                    }
                }
            }
            if (Conn.RunSqlTransaction(Insert))
            {
                if (value=="")
                {
                    value = "添加成功！";
                }           
            }
            else
            {
                value = "添加失败！";
            }
        }
        else
        {
            value = "未选中材料！";
        }
    }
    catch (Exception ee)
    {
        value = "添加材料失败！错误信息：" + ee.ToString();
    }
    //Response.Write("<script>alert('" + value + "');window.opener.reload()location.href = 'fxsglcl.aspx?gys_id=" + fxs_id1 + "'; </" + "script>");
    Response.Write("<script>alert('" + value + "');window.opener.location.reload();window.close(); </" + "script>");
}
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
    if (sColumName=="出厂价格")
    {
        sColumName="price";
    }
    //得到要筛选字段的类型
    string SQL = "select 材料编码,显示名,规格型号,计量单位,price,pp_id,品牌名称,cl_id from 材料表 where gys_id='" + scsid
         + "'  and pp_id='" + ppid + "' and 品牌名称='" + ppmc + "' and cl_id not in(select cl_id from 供应商材料表 where gys_id='" + scsid + "' and fxs_id='" + fxsid + "')";
    sSQL = "select * from (" + SQL + ")#temp where 1=0";
    objDt = Conn.GetDataTable(sSQL);
    for (int i = 0; i < objDt.Columns.Count; i++)
    {
        sTempColumnName = objDt.Columns[i].ColumnName.ToString().Trim();
        sFieldType = objDt.Columns[i].DataType.Name.ToString().Trim();
        if (sColumName==sTempColumnName)
        {
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
    string sql = SQL;  
    sql = "select * from (" + sql + ")#temp where " + strCondition;
    dt = Conn.GetDataTable(sql);
}

private void createlm(DataTable objDt)
{
    ListItem objItem = null;
    if (objDt != null)
    {

        for (int i = 0; i < objDt.Columns.Count; i++)
        {
            switch (objDt.Columns[i].ColumnName)
            {
                case "cl_id":
                    break;
                case "pp_id":
                    break;
                case "price":
                       objItem = null;
                    objItem = new ListItem();
                    objItem.Text = "出厂价格";
                    lieming.Items.Add(objItem);
                    break;
                default:
                    objItem = null;
                    objItem = new ListItem();
                    objItem.Text = objDt.Columns[i].ColumnName;
                    objItem.Text = objDt.Columns[i].ColumnName;
                    lieming.Items.Add(objItem);
                    break;
            }

        }
    }
}
    
//*****************************小张新增检索功能结束*********************************
</script>
<form  runat="server" id="form1" >
<input type="hidden" runat="server" id="cl_id" />
  <DIV class="box">
 <div id="jiansuo" style="margin-bottom:10px;">
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
                    </asp:DropDownList>&nbsp; <asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid;
                        border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                        runat="server"></asp:TextBox>  
                        &nbsp; &nbsp;                   
                    <asp:Button ID="filter" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
                        BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                        filter Font-Names="宋体"></asp:Button>    
                         <asp:Button ID="btnDocNew" runat="server" Text="添加" OnClientClick="return Fxsxzdlcl();" OnClick="Add_Click" CssClass="filter"
                        BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                        filter Font-Names="宋体"></asp:Button>          

 </div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2" id="table">
      <thead>
        <tr>
          <th width="40" align="center"><strong>
            <input  class="middle" type="checkbox" name="checkboxAll" id="checkboxAll" onclick="return selectall();"   /><br />
            </strong></th>
           <th width="100" align="center"><strong>材料编码</strong></th>
          <th width="100" align="center"><strong>材料名称</strong></th>
          <th width="140" align="center"><strong>规格/型号</strong></th>
          <th width="70" align="center"><strong>单位</strong></th>
          <th width="70" align="center"><strong>生产商指导价</strong></th>          
          <th width="70" align="center"><strong>实时报价</strong></th>
           <td align="center" style="display:none">cl_id</td>
          <th width="60" align="center"><strong>操作</strong></th>
        </tr>
      </thead>
      <tbody id="cl">
 <%if (dt != null && dt.Rows.Count > 0) %>
 <%{ %>
 <%foreach (DataRow dr in dt.Rows)%>
 <%{%>
          <tr>
          <td align="center"><input type="checkbox" name="checkbox" onclick="return selectall1(this);"  />
          <label for="checkbox"></label></td>
          <td align="center"><%=dr["材料编码"]%></td>
          <td align="left"><%=dr["显示名"]%></td>
          <td class="style1"><%=dr["规格型号"]%></td>
          <td align="center"><%=dr["计量单位"]%></td>
          <td align="center"><%=dr["price"] %></td>          
          <td align="center"><input type="text"  runat="server" style="width:100%; height:100%;" /></td>
           <td align="center" style="display:none"><%=dr["cl_id"] %></td>
          <td align="center"><a href="clxx.aspx?cl_id=<%=dr["cl_id"] %>" target="_blank"><img src="images/chayue.gif" alt="" width="37" height="20" /></a></td>
        </tr>
 <% } %>
  
 <%} %>
    
      </tbody>
    </table>
<table width="100%" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40" align="left">共7页/当前第1页 </td>
                <td align="right" valign="middle"> <a href="#">首页</a> <a href="#">上一页</a> <a href="#">下一页</a> <a href="#">尾页</a> 转到第
  <input name="textfield244" type="text" class="queding_bk" size="3" />
                  页 
                  <input type="submit" name="btnDocNew" value="确定" onClick="return VerifyMyIMP();"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" />
                  
                </td>
    </tr>
  </table>
</DIV>
<input runat="server" type="hidden" id="scs_id" />
<input runat="server" type="hidden" id="fxs_id" />
<input runat="server" type="hidden" id="pp_id" />
<input runat="server" type="hidden" id="pp_mc" />
<input runat="server" type="hidden" id="nowp" />
</form>
</body>
</html>
