<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
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
                        if (e.type == 'checkbox' && e.name == 'checkbox')
                        {
                            if (e.checked==false)
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
                var tableid = 'table'; 	//表格的id
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
       <%-- 添加分销商--%>
      <script type="text/javascript">
          function Addfxs()
          {
              try
              {
                  var addid;
                  var Table = document.getElementById("table");
                  var ck = Table.getElementsByTagName("input");
                  for (var i = 0; i < ck.length; i++)
                  {
                      var e = ck[i];
                      var tr = e.parentNode.parentNode;
                      if (e.type == 'checkbox' && e.name == 'checkbox')
                      {
                          if (e.checked)
                          {
                              if (addid == "" || addid == undefined)
                              {
                                  addid = tr.cells[1].innerHTML + ",";
                              }
                              else
                              {
                                  addid += tr.cells[1].innerHTML + ",";
                              }
                          }
                      }
                  }
                  if (addid == "" || addid == undefined)
                  {
                      alert("请选择要新增的分销商！");
                      return false;
                  }
                  else
                  {
                      document.getElementById("fxsid").value = addid;
                      return true;
                  }
              } catch (e)
              {
                  alert("添加错误！错误信息："+e.ToString());
                  return false;
              }
          }

          function getup()
          {
              var sj = document.getElementById("s1").value;
              var s = document.getElementById("s2").value;
              document.getElementById("sj").value = sj;
              document.getElementById("xsj").value = s;
          }
      </script>
    <%-- 检索--%>
</head>
<body>
  <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->

<script runat="server">
    DataConn Conn = new DataConn();
    DataTable dt_fxs = new DataTable();//材料供应商信息表
    public int PageSize = 10;
    public string pp_id = "";
    public string pp_mc = "";
    public string scs_id = "";
    protected void Page_Load(object sender, EventArgs e)
    { 
        if (Request["ppid"]!=null&&Request["ppid"].ToString()!="")
        {
            pp_id = Request["ppid"].ToString();
        }
        if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
        {
            pp_mc = Request["ppmc"].ToString();
        }
        if (Request["scsid"] != null && Request["scsid"].ToString() != "")
        {
            scs_id = Request["scsid"].ToString();
        }
        this.scsid.Value = scs_id;
        this.ppid.Value = pp_id;
        this.ppmc.Value = pp_mc;
        string sSQL = "";
        sSQL = " select p.等级,p.分类名称,p.范围,p.fl_id,c.供应商 from 品牌字典 p  left join  材料供应商信息表  c on p.scs_id=c.gys_id where  c.gys_id='" +
            scs_id + "' and p.scs_id='" + scs_id + "' and pp_id='" + pp_id + "' and 品牌名称='" + pp_mc + "'";
        DataTable dt = new DataTable();
        dt = Conn.GetDataTable(sSQL);
        if (dt!=null&&dt.Rows.Count>0)
        {
            this.ppmc1.InnerHtml = pp_mc;
            this.scs2.InnerHtml = Convert.ToString(dt.Rows[0]["供应商"]);
            this.grade2.InnerHtml = Convert.ToString(dt.Rows[0]["等级"]);
            this.scope2.InnerHtml = Convert.ToString(dt.Rows[0]["范围"]);          
        }
        sSQL = " select 供应商,地址,电话,联系人,联系人手机,单位类型,gys_id from 材料供应商信息表 where isnull(是否启用,'')='1' and gys_id not in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='" + pp_id +
            "' and 品牌名称='" + pp_mc + "' and 生产厂商ID='"+scs_id+"')";
        dt_fxs = Conn.GetDataTable(sSQL);
        if (!IsPostBack)
        {
            createlm(dt_fxs);
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
        if (sColumName == "公司名称")
        {
            sColumName = "供应商";
        }
        string sql_js = "";
        sql_js = " select 供应商,地址,电话,联系人,联系人手机,单位类型,gys_id from 材料供应商信息表 where isnull(是否启用,'')='1' and gys_id not in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='" + pp_id +
             "' and 品牌名称='" + pp_mc + "' and 生产厂商ID='" + scs_id + "')";
        if (sColumName == "" && sOperator == "" && sKeyWord == "")
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
        if (strCondition=="")
        {
            string sql = sql_js;
            dt_fxs = Conn.GetDataTable(sql); 
        }
        else
        {
            string sql = sql_js;
            sql = "select * from (" + sql + ")#temp where " + strCondition;
            dt_fxs = Conn.GetDataTable(sql);
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
                    case "gys_id":
                        break;
                    case "供应商":
                         objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "公司名称";
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
    //添加
    protected void ADDFXS(object sender, EventArgs e)
    {
        string value = "";
        string fxsid = this.fxsid.Value;  //选中作为分销商的 公司的gys_id
        while(fxsid.EndsWith(","))
        {
            fxsid = fxsid.Substring(0, fxsid.Length - 1);
        }
        if (fxsid != "")
        {
            string[] fxs = fxsid.Split(',');
            string sSQL = "";
            for (int i = 0; i < fxs.Length; i++)
            {
                string sql = "select count(*) from 分销商和品牌对应关系表 where pp_id='" + this.ppid.Value + "' and 品牌名称='" + this.ppmc.Value +
                    "' and fxs_id='" + fxs[i] + "' and 生产厂商ID='" + this.scsid.Value + "'";
                string count = Conn.DBLook(sql);
                if (count=="")
                {
                    count = "0";
                }
                int jl = Convert.ToInt32(count);
                if (jl > 0)
                {
                    value +="分销商ID为："+fxs[i]+ " 品牌名称为：" + this.ppmc.Value + " 品牌id为：" + this.ppid.Value + "的分销商已存在";
                }
                else
                {
                    sSQL += "insert into 分销商和品牌对应关系表 (pp_id,品牌名称,是否启用,fxs_id,分销商,updatetime,yh_id,生产厂商ID)values('" +
                        this.ppid.Value + "','" + this.ppmc.Value + "','0','" + fxs[i] + "',(select 供应商 from 材料供应商信息表 where gys_id='" + fxs[i] +
                        "'),(select getdate()),(select yh_id from 材料供应商信息表 where gys_id='" + fxs[i] + "'),'" + this.scsid.Value + "')    ";
                }
            }           
            if (Conn.RunSqlTransaction(sSQL))
            {
                if (value=="")
                {
                    value = "添加成功！";
                }
               // Response.Write("<script>alert('添加成功！');window.location.href='glfxsxx.aspx?gys_id=" + this.scsid.Value + "';</" + "script>");
            }
            else
            {
                value = "添加失败！";
                //Response.Write("<script>alert('添加失败！');window.localtion.reload();</" + "script>");
            }
        }
        Response.Write("<script>alert('" + value + "');window.opener.location.reload();window.close(); </" + "script>");
    }
</script>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="scsid" />
    <input type="hidden" runat="server" id="ppid" />
    <input type="hidden" runat="server" id="ppmc" />
    <input type="hidden" runat="server" id="fxsid" />
    <input type="hidden" runat="server" id="fl_id" />
    <DIV class="fxsxx">
<table width="1000" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #ddd; background-color:#f7f7f7; margin-top:10px; font-size:12px">
  <tr>
    <td width="120" height="50" align="right"><strong>品牌名称：</strong></td>
    <td width="200" style="padding-left:10px;"> <div id="ppmc1" runat="server"></div></td>
    <td width="60" align="right"><strong>生产商：</strong></td>
    <td width="200" style="padding-left:10px;"> <div id="scs2" runat="server"></div></td>
    <td width="50" align="right"><strong>等级：</strong></td>
    <td><div id="grade2"  runat="server"> </div></td>
    <td width="50"><strong>范围：</strong></td>
    <td><div id="scope2"  runat="server">  </div></td>    
  </tr>
</table>
  <div id="jiansuoxzfxs" style="text-align:center;"> 
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
                    </asp:DropDownList>
                    &nbsp;<asp:TextBox ID="txtKeyWord" Style="border-right: #808080 1px solid;
                        border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid"
                        runat="server"></asp:TextBox>  
                        &nbsp; &nbsp;                     
                    <asp:Button ID="filter" runat="server" Text="检索" OnClick="filter_Click" CssClass="filter"
                        BorderStyle="None" Width="37px" Height="20px" ForeColor="Black" Font-Size="12px"
                        filter Font-Names="宋体"></asp:Button>
                        <asp:Button ID="Button2"  runat="server" name="btnDocNew"  Text="添加" OnClientClick=" return Addfxs();" OnClick="ADDFXS"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" />
</DIV>
 <asp:Label Text="" runat="server" ID="lblhint" ForeColor="Red"></asp:Label>
<table border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#dddddd" id="table"  style="font-size:12px">
      <thead>
        <tr>
          <th align="center"><strong><input type="checkbox" name="checkboxAll" id="checkboxAll" onclick="return selectall();"  /></strong></th>
          <th align="center"><strong>公司名称</strong></th>
          <th align="center"><strong>地区</strong></th>
          <th align="center"><strong>电话</strong></th>
          <th align="center"><strong>联系人</strong></th>
          <th align="center"><strong>联系人电话</strong></th>
          <th align="center"><strong>单位类型</strong></th>
          <th align="center"><strong>操作</strong></th>
        </tr>
      </thead>
      <tbody id="fxs">
      <%if (dt_fxs!=null&&dt_fxs.Rows.Count>0)%>
      <%  {%>
              <%foreach (DataRow dr in dt_fxs.Rows)%>
              <%  {%>
                      <tr>
                          <td align="center"><input type="checkbox" name="checkbox" onclick="return selectall1(this);" /></td>
                          <td  style=" display:none;"><%=dr["gys_id"]%></td>
                          <td align="left" style="padding-left:10px;"><%=dr["供应商"]%></td>
                          <td align="center" style="padding-left:10px;"><%=dr["地址"]%></td>
                          <td style="padding-left:10px;"><%=dr["电话"]%></td>
                          <td align="center"><%=dr["联系人"]%></td>
                          <td align="center"><%=dr["联系人手机"]%></td>
                          <td align="center"><%=dr["单位类型"]%></td>
                          <td align="center"><a href="cyfxsxx.aspx?gys_id=<%=dr["gys_id"] %>" target="_blank"><img src="images/chayue.gif" width="37" height="20" /></a></td>
                       </tr>
              <%  } %>       
      <%  } %>
      
      </tbody>
</table>
 
 </DIV>
</form>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  
</body>
</html>
