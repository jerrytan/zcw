<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"  EnableViewStateMac= "false"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>分销商新增代理材料</title>
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/cllb.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://malsup.github.io/jquery.form.js"></script>
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
                                     if (price==""||price==undefined)
                                     {
                                         price = "0";
                                     }
                                     if (cl_id == "" || cl_id == undefined)
                                     {
                                         cl_id = tr.cells[7].innerHTML + "|" + price + ",";
                                     }
                                     else
                                     {
                                         cl_id += tr.cells[7].innerHTML + "|" + price + ",";
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
                 return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转 
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
}
</script>
<form  runat="server" id="form1" action="fxsxzdlcl_Save.aspx" method="post" onsubmit="return saveReport();">
<input type="hidden" runat="server" id="cl_id" />
  <DIV class="box">
  <div id="jiansuo" style="margin-bottom:10px;">检索条件：
<input name="txtKeyWord" type="text" id="txtKeyWord" style="border-right: #808080 1px solid;
                        border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid; width:250px;" />&nbsp;&nbsp;
                    <input type="submit" name="filter" value="检索" id="filter" class="filter" filter="" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px;cursor:pointer;" />	&nbsp;&nbsp;&nbsp;               
<input type="submit" name="btnDocNew" value="添加" onClick="Fxsxzdlcl()"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" /></div>
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
          <th width="70" align="center"><strong>出场价格</strong></th>          
          <th width="70" align="center"><strong>预售价格</strong></th>
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
          <td align="center"><input type="text"  style="width:100%; height:100%;" /></td>
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
</form>
</body>
</html>
