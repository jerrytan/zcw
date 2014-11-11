<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" EnableViewStateMac= "false" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content="IE=11.0000" http-equiv="X-UA-Compatible">     
<META http-equiv="Content-Type" content="text/html; charset=utf-8">     
<TITLE>供应商产品列表</TITLE>     
<LINK href="css/css.css" rel="stylesheet" type="text/css">   
<LINK href="css/all of.css" rel="stylesheet" type="text/css">  
<link href="css/cllb.css" rel="stylesheet" type="text/css" />  
<META name="GENERATOR" content="MSHTML 11.00.9600.17239">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://malsup.github.io/jquery.form.js"></script>
   
<script type="text/javascript">
    //列表数
    function ShowMenu(obj, n)
    {
        var Nav = obj.parentNode;
        if (!Nav.id)
        {
            var BName = Nav.getElementsByTagName("ul");
            var HName = Nav.getElementsByTagName("h2");
            var t = 2;
        } else
        {
            var BName = document.getElementById(Nav.id).getElementsByTagName("span");
            var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
            var t = 1;
        }
        for (var i = 0; i < HName.length; i++)
        {
            HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
            HName[i].className = "";
        }
        obj.className = "h" + t;
        for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
        if (BName[n].className == "no")
        {
            BName[n].className = "";
            obj.innerHTML = obj.innerHTML.replace("+", "-");
        } else
        {
            BName[n].className = "no";
            obj.className = "";
            obj.innerHTML = obj.innerHTML.replace("-", "+");
        }
    }
 </script>

<script type="text/javascript">
    var value;
    //点击选择属性值
    function AddSXZ(obj, sxbm, bh, sxz, sql)
    {
        var td = obj.parentNode;
        var a = td.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.backgroundColor = "#FFFFFF";
            a[i].style.color = "#707070";
        }
        obj.style.backgroundColor = "#4876FF";
        obj.style.color = "#FFFFFF";
        var flbm_cl = document.getElementById("flbm").value;
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        tds[2].innerHTML = sxz;         //属性值
        tds[3].innerHTML = sxbm + bh;   //属性编码+编号
        tds[4].innerHTML = sql;  //SQL语句
        var table = document.getElementById("sx");
        var tr = table.getElementsByTagName("tr");
        var ggxh = "";
        var clbh = flbm_cl.toString();
        var sxmc;
        for (var i = 0; i < tr.length; i++)
        {
            if (tr[i].cells[0].innerHTML == "品种")
            {
                document.getElementById("clmc").value = tr[i].cells[2].innerHTML;
            }
            var tds = tr[i];
            ggxh = ggxh + tr[i].cells[2].innerHTML;
            clbh += tr[i].cells[3].innerHTML.toString();
        }
        document.getElementById("clbm").value = clbh;
        document.getElementById("clmcjgg").value = ggxh;
        document.getElementById("ggxh").value = document.getElementById("clmcjgg").value;
    }
    //将组合的属性属性值 和对应材料信息 添加到材料列表中
    function AddValue()
    {
        var clbm = document.getElementById("clbm").value;
        var clm = document.getElementById("clmc").value;
        var ggjxh = document.getElementById("ggxh").value;
        if (ggjxh == "" || ggjxh == undefined)
        {
            alert("请重新选择规格");
            return;
        }
        document.getElementById("cpbh").value = clbm;
        document.getElementById("mcgz").value = ggjxh;

        //拼写SQL语句
        var table = document.getElementById("sx");
        var tr = table.getElementsByTagName("tr");
        var sSQL = "";
        for (var i = 0; i < tr.length; i++)
        {
            sSQL = sSQL + tr[i].cells[4].innerHTML + "◣";
        }
        document.getElementById("SQL").value = sSQL;
    }
</script>
<script type="text/javascript">
    //点击左侧列表数
    function lbs(obj, flbm, mc, dw)
    {
        var h = obj.parentNode.parentNode;
        var a = h.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.color = "#707070";
        }
        obj.style.color = "#4876FF";
        document.getElementById("ggxh").value = "";
        document.getElementById("clmcjgg").value = "";
        document.getElementById("flbm").value = flbm;
        document.getElementById("flmc").value = mc;
        document.getElementById("dw").value = dw;
        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
            {
                if (xmlhttp.responseText != "" && xmlhttp.responseText != undefined)
                {
                    document.getElementById("allcl").innerHTML = xmlhttp.responseText;
                }
            }
        }
        var url = "scsxzclxzsx.aspx?flbm=" + flbm + "&flmc=" + mc;
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }


    function saveReport()
    {
        //   document.getElementById("dmt").value = document.frames['frame1'].document.getElementById("dmtz").value;
        var scsid = document.getElementById("scsid").value;
        // jquery 表单提交
        $("#form1").ajaxSubmit(function (message)
        {
            // 对于表单提交成功后处理，message为提交页面saveReport.htm的返回内容 
            if (message == "1")
            {
                alert("提交成功");
                window.location.href = "gysglcl.aspx?gys_id=" + scsid; 
            }
            else
            {
                alert(message);
            }
        });
        return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转    onsubmit="return saveReport();"
    }    
</script>
 
</HEAD> 
<BODY>  
<form runat="server" id="form1" action="scsxzcl_save.aspx" method="post" onsubmit="return saveReport();">
<script runat="server">
public DataTable dt_sx = new DataTable();
public DataTable dt_sxz = new DataTable();
public DataTable dt_cl = new DataTable();
public string DWID = "";
public string DWLX = "";
public DataConn Conn = new DataConn();
public string cpbhsjk = "";
public string ggxzsjk = "";
public string jldwsjk = "";
public string dwzlsjk = "";
public string dwtjsjk = "";
public string smsjk = "";
public string pricesjk = "";
protected void Page_Load(object sender, EventArgs e)
{
    string scs_id = "";  //营业注册号
    string ppid = "";
    string flbm = "";
    string flmc = "";
    string clid = "";
    //scs_id = "300";
    //ppid = "300";
    //flbm = "030107";
    //flmc = "膨胀螺栓";
    //clid = "331";
    //this.lx.Value = "bj";
    if (Request["scs_id"] != null && Request["scs_id"].ToString() != "")
    {
        scs_id = Request["scs_id"].ToString();
    }


    if (Request["ppid"] != null && Request["ppid"].ToString() != "")
    {
        ppid = Request["ppid"].ToString();
    }
    if (Request["clid"] != null && Request["clid"].ToString() != "")
    {
        clid = Request["clid"].ToString();
        this.lx.Value = "bj";
    }

    if (scs_id != "" && ppid != "" && clid != "")
    {
        if (Request["flbm"] != null && Request["flbm"].ToString() != "")
        {
            flbm = Request["flbm"].ToString();
        }

        if (Request["flmc"] != null && Request["flmc"].ToString() != "")
        {
            flmc = Request["flmc"].ToString();
        }
        this.scsid.Value = scs_id;
        this.ppid.Value = ppid;
        this.flbm.Value = flbm;
        this.flmc.Value = flmc;
        Addsx(flbm, flmc, clid);
        string SQL = "";
        SQL = "select 规格型号,计量单位,单位重量,单位体积,说明,price,材料编码 from 材料表 where cl_id=" + clid;
        dt_cl = Conn.GetDataTable(SQL);
        if (dt_cl != null && dt_cl.Rows.Count > 0)
        {
            cpbhsjk = Convert.ToString(dt_cl.Rows[0]["材料编码"]);
            ggxzsjk = Convert.ToString(dt_cl.Rows[0]["规格型号"]);
            jldwsjk = Convert.ToString(dt_cl.Rows[0]["计量单位"]);
            dwzlsjk = Convert.ToString(dt_cl.Rows[0]["单位重量"]);
            dwtjsjk = Convert.ToString(dt_cl.Rows[0]["单位体积"]);
            smsjk = Convert.ToString(dt_cl.Rows[0]["说明"]);
            pricesjk = Convert.ToString(dt_cl.Rows[0]["price"]);
        }
    }
}
protected void Addsx(string flbm, string flmc, string clid)
{    
    this.SQL.Value = "1";
        string html = "";
        if (flbm != "")
        {            
            string sql_sx = "";
            sql_sx = "select 显示 as 属性名称,属性编码 from 材料分类属性表 where 分类编码='" + flbm + "' and 分类名称='" + flmc + "' order by 分类编码,属性编码";
            dt_sx = Conn.GetDataTable(sql_sx);
        }
        if (dt_sx != null && dt_sx.Rows.Count > 0)
        {
            html = "<table width='740' border='0' cellpadding='0' cellspacing='1' bgcolor='#dddddd' style='table-layout：fixed ;word-wrap：break-word'>"
                + " <thead>"
                + "   <tr>"
                + "    <th width='70' height='30' align='center' bgcolor='#E3ECFF'><strong>属性名称</strong></th>"
                + " <th align='center' bgcolor='#E3ECFF'><strong>规格\\型号</strong></th>"
                + " <th width='80' align='center' bgcolor='#E3ECFF'><strong>选中项</strong></th>"
                + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>编码</strong></th>"
                  + " <th  style='display:none;' width='80' align='center' bgcolor='#E3ECFF'><strong>SQL语句</strong></th>"
                + " </tr>"
                + " </thead>"
                + " <tbody id='sx'>";

            foreach (DataRow drsx in dt_sx.Rows)
            {
                string sql_sx = "select 属性名称,属性值,属性编码,编号,flsx_id,flsxz_id,fl_id from 材料分类属性值表  where 属性名称='" + drsx["属性名称"] + "' and 分类编码=" + flbm;
                dt_sxz = Conn.GetDataTable(sql_sx);
                string sxmc = Convert.ToString(drsx["属性名称"]);
                sxmc = sxmc.Replace("\r", " ");
                sxmc = sxmc.Replace("\n", " ");
                html += " <tr style='line-height:24px;'>"
               + " <td align='center' bgcolor='#FFFFFF'>" + sxmc + "</td>"
                + " <td align='left' bgcolor='#FFFFFF'> ";
                if (dt_sxz != null && dt_sxz.Rows.Count > 0)
                {
                    foreach (DataRow drsxz in dt_sxz.Rows)
                    {
                        string value = "";
                        string sxsxzbm = Convert.ToString(drsxz["属性编码"]) + Convert.ToString(drsxz["编号"]);
                        value = drsxz["属性名称"] + "," + drsxz["属性编码"] + "," + drsxz["flsx_id"] + "," + drsxz["属性值"] + "," + drsxz["编号"] + "," + drsxz["flsx_id"]
                            + "," + sxsxzbm + "," + drsxz["fl_id"] + "," + flmc + ",clid,clmc,clbm";
                        string sxbm = Convert.ToString(drsxz["属性编码"]);
                        string sxz = Convert.ToString(drsxz["属性值"]);
                        string bh = Convert.ToString(drsxz["编号"]);
                        sxbm = sxbm.Replace("\r", " ");
                        sxbm = sxbm.Replace("\n", " ");
                        sxz = sxz.Replace("\r", " ");
                        sxz = sxz.Replace("\n", " ");
                        bh = bh.Replace("\r", " ");
                        bh = bh.Replace("\n", " ");

                        html += "<a href='javascript:void(0)' onclick=\"AddSXZ(this,'" + sxbm +
                            "','" + bh + "','" + sxz + "','" + value + "')\">" + sxz + "&nbsp;&nbsp;</a>";
                    }
                }
                html += "</td>"
                    + " <td align='center' bgcolor='#FFFFFF'></td>"
                    + " <td style='display:none;'></td>"
                    + " <td style='display:none;'></td>"
                    + "</tr>";
            }
            html += " </tbody> "
                    + " <tfoot>"
                    + "        <tr>"
                    + "        <td width='120' height='32' align='right' bgcolor='#FFFFFF'>名称及规则：</td>"
                    + "        <td align='left' bgcolor='#FFFFFF'><input type='text' id='clmcjgg' style=' width: 293px; '/></td>"
                    + "        <td width='80' align='center' bgcolor='#FFFFFF'>"
                    + "        <input type='Button' name='btnDocNew' value='确定' onClick='AddValue()'  class='filter' style='color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;' /></td>"
                    + "      </tr>"
                    + "       </tfoot>"
                    + " </table>";
        }
        if (html != "")
        {
            this.allcl.InnerHtml = "";
            this.allcl.InnerHtml = html;
        }
    //}
}
</script>
 
<DIV class="box" id="cllbb"><!-- 头部结束-->     
    <DIV class="dlqqz5"  style="border:1px solid #4ea6ee; padding-top:10px; margin: -2px 0 0 0;">
    <DIV class="dlqqz2">
  <!--  列表数开始-->
<div id="menu_lb">
 
        <%string sSQL=""; %>
        <% sSQL="select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=2";%>
        <%DataTable dt1=new DataTable();%>
        <%dt1 = Conn.GetDataTable(sSQL); %>
        <%if(dt1!=null&&dt1.Rows.Count>0) %>
        <%{ %>
        <%int   firstlevel = 0; %>
                <%foreach (DataRow dryj in dt1.Rows)%>
                <%{%>
                        <%sSQL = ""; %>
                            <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=4 and  SUBSTRING(分类编码,1,2)="+dryj["分类编码"]; %>
                            <%DataTable dt2 = new DataTable(); %>
                            <%dt2 = Conn.GetDataTable(sSQL); %>
                            <%if (dt2 != null && dt2.Rows.Count > 0) %>
                            <%{ %>
                             <% int secondlevel = 0; %>
                                    <h1 onClick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)"><img src="images/biao2.jpg" alt="" /> <%=dryj["显示名字"]%></a></h1>
                                   
                                    <span class="no">
                                     <%foreach (DataRow drej in dt2.Rows)%>
                                        <%{%>
                                            <%sSQL = ""; %>
                                            <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=6 and SUBSTRING(分类编码,1,4)="+drej["分类编码"]; %>
                                            <%DataTable dt3 = new DataTable(); %>
                                            <%dt3 = Conn.GetDataTable(sSQL); %>                                                                                                       
                                                <%if (dt3 != null && dt3.Rows.Count > 0) %>
                                                <%{ %>        
                                                 <h2 onClick="javascript:ShowMenu(this,<%=secondlevel %>)"><a href="javascript:void(0)"><%=drej["显示名字"]%></a></h2>
                                                           <ul class="no">                           
                                                        <%  foreach (DataRow drsj in dt3.Rows)%>
                                                        <%  {%>                                       
                                                                <li><a href="javascript:void(0)" onclick="lbs(this,'<%=drsj["分类编码"]%>','<%=(drsj["显示名字"])%>','<%=drsj["单位"]%>')"><%=drsj["显示名字"]%></a></li>                                                       
                                                        <%  } %>
                                                           </ul>
                                                <%} %>
                                                <%else %>
                                                <%{ %>
                                                 <h2><a href="javascript:void(0)"onclick="lbs(this,'<%=drej["分类编码"]%>','<%=(drej["显示名字"])%>','<%=drej["单位"]%>')"><%=drej["显示名字"]%></a></h2>
                                                 <ul class="no"></ul>
                                                <%} %>
                                            <%secondlevel++; %>       
                                         <%} %>
                                   </span>
                            <%} %> 
                            <%else %>
                            <%{ %>
                                <h1><a href="javascript:void(0)"onclick="lbs(this,'<%=dryj["分类编码"]%>','<%=(dryj["显示名字"])%>','<%=dryj["单位"]%>')"><%=dryj["显示名字"]%></a></h1>
                                <span class="no"></span>
                            <%} %>
                            <% firstlevel++;  %>
                <%} %>
        <%} %>
    </div>
  <!--列表数结束-->
 
<div id="Div3" style="width:775px; min-height:400px; margin-left:202px;">
<div id="allcl" runat="server">
<table  width="740" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" style="table-layout：fixed ;word-wrap：break-word">
    <thead>
        <tr>
          <th width="70" height="30" align="center" bgcolor="#E3ECFF"><strong>属性名称</strong></th>
          <th align="center" bgcolor="#E3ECFF"><strong>规格\型号</strong></th>
          <th width="80" align="center" bgcolor="#E3ECFF"><strong>选中项</strong></th>
        </tr>
      </thead>
         <tbody id="sx">      
       </tbody> 
       <tfoot>
        <tr>
        <td width="120" height="32" align="right" bgcolor="#FFFFFF">名称及规则：</td>
        <td align="left" bgcolor="#FFFFFF"><input type="text" id="clmcjgg" style=" width: 293px; "/></td>
        <td width="80" align="center" bgcolor="#FFFFFF">
        <input type="Button" name="btnDocNew" value="确定" onClick="AddValue()"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" /></td>
      </tr>
       </tfoot>
  </table>
</div> 
<div id="Div1">
<table id="Table1" width="740" border="0" align="left" cellpadding="0" cellspacing="0" style="table-layout：fixed ;word-wrap：break-word; margin-top:10px; border:1px solid #ddd; padding:10px 0;" >
    <tbody id="Tbody1">     
      <tr> <td width="100" height="36" align="right" bgcolor="#FFFFFF">产品编号：</td>
        <td height="24" colspan="3" align="left" bgcolor="#FFFFFF"><label for="textfield"></label>
          <input name="cl_name4" type="text" id="cpbh" class="hyzhc_shrk9" readonly="readonly"  value='<%=cpbhsjk %>'/></td> 
        <td width="100" align="right" bgcolor="#FFFFFF">名称及规则：</td> 
        <td colspan="3" align="left" bgcolor="#FFFFFF"><input  readonly="readonly"  type="text" value='<%=ggxzsjk %>' id="mcgz" name="mcgz" class="hyzhc_shrk9" /></td>
        </tr>
      <tr>
        <td width="100" height="36" align="right" bgcolor="#FFFFFF">计量单位：</td>
        <td width="80" height="24" align="center" bgcolor="#FFFFFF"><input  type="text"  value='<%=jldwsjk %>' name="jldw" id="jldw" class="hyzhc_shrk8" /></td>
        <td width="80" align="right" bgcolor="#FFFFFF">单位重量：</td>
        <td width="80" align="left" bgcolor="#FFFFFF"><input  type="text" name="dwzl" value='<%=dwzlsjk %>' id="dwzl" class="hyzhc_shrk8" /></td>
  
      <td width="100" align="right" bgcolor="#FFFFFF">单位体积：</td>
        <td width="80" align="left" bgcolor="#FFFFFF"><input type="text" id="dwtj" name="dwtj" value='<%=dwtjsjk %>' class="hyzhc_shrk8" /></td>
                <td width="80" align="right" bgcolor="#FFFFFF">产品价格：</td>
        <td align="left" bgcolor="#FFFFFF"><input type="text" id="cpjg" name="cpjg" value='<%=pricesjk %>' class="hyzhc_shrk8" /></td>
        </tr>
      <tr>
        <td height="80" align="right" bgcolor="#FFFFFF">产品说明：</td>
      <td height="80" colspan="7" align="center" bgcolor="#FFFFFF"><textarea class="hyzhc_shrk2_2"  cols="40" id="yyfw" name="yyfw" rows="6" style="100%"  value='<%=smsjk %>' ><%=smsjk %></textarea></td>
        </tr>
    </tbody>
</table>

<div class="cpdt_2" style="width: 740px; float: left;">
 <iframe id="frame1" src="scsxzcltjtp.aspx" frameborder="0" marginheight="0"  style=" width:100%;  height:200px; padding:0px; margin:0px; border:0px; " > 
 </iframe> 
 <dd style=" text-align:center"> <input type="submit" value="保存" /></dd>
</div>
</div>
</div>
    </DIV>                
</DIV>
<DIV class="cgdlqq"></DIV>  </DIV>
 
<input type="hidden"  runat="server" id="flbm"/>    <%--分类编码  --%>
<input type="hidden"  runat="server" id="clbm"/>    <%--  材料编码--%>
<input type="hidden"  runat="server" id="ggxh"/>    <%--规格型号  --%>
<input type="hidden"  runat="server" id="clmc"/>    <%--材料名称  --%>
<input type="hidden"  runat="server" id="dw"/>      <%--单位      --%>
<input type="hidden"  runat="server" id="SQL"/>     <%-- SQL语句  --%>
<input type="hidden"  runat="server" id="DW_ID"/>   <%-- 单位id   --%>
<input type="hidden"  runat="server" id="flmc"/>    <%-- 分类名称   --%>
<input type="hidden"  runat="server" id="dmt"/>     <%-- 图片地址   --%>
 
<input type="hidden"  runat="server" id="scsid"/>   <%-- 生产商ID   --%>
<input type="hidden"  runat="server" id="ppid"/>    <%-- 生产商ID   --%>
<input type="hidden"  runat="server" id="lx"/>    <%-- 是新增还是编辑   --%>
<input type="hidden"  runat="server" id="clid"/>    <%-- 是新增还是编辑   --%>
</form>
</BODY></HTML>
