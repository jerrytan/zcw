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
      </script>
    <%-- 检索--%>
</head>
<body>
  <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->

<script runat="server">
    DataConn Conn = new DataConn();
    DataTable dt_fxs = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    { 
        string pp_id = "";
        string pp_mc = "";
        string scs_id = "";
        //scs_id = "300";
        //pp_id = "300";
        //pp_mc = "钢材测试";
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
        //sSQL = "select 等级,分类名称,范围,fl_id from 品牌字典 where scs_id='" + scs_id + "' and pp_id='" + pp_id +
        //    "' and 品牌名称='" + pp_mc + "'union select  供应商  from 材料供应商信息表 where  gys_id='"+scs_id+"'";
        DataTable dt = new DataTable();
        dt = Conn.GetDataTable(sSQL);
        if (dt!=null&&dt.Rows.Count>0)
        {
            this.ppmc1.InnerHtml = pp_mc;
            this.scs2.InnerHtml = Convert.ToString(dt.Rows[0]["供应商"]);
            this.grade2.InnerHtml = Convert.ToString(dt.Rows[0]["等级"]);
            this.scope2.InnerHtml = Convert.ToString(dt.Rows[0]["范围"]);
            this.fl_name2.InnerHtml = Convert.ToString(dt.Rows[0]["分类名称"]);
            this.fl_id.Value = Convert.ToString(dt.Rows[0]["fl_id"]);
        }
        sSQL = " select 供应商,地址,电话,联系人,联系人手机,单位类型,gys_id from 材料供应商信息表 where isnull(是否启用,'')='1' and gys_id not in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='" + pp_id +
            "' and 品牌名称='" + pp_mc + "' and 生产厂商ID='"+scs_id+"')";
        dt_fxs = Conn.GetDataTable(sSQL);
        
    }

    protected void ADDFXS(object sender, EventArgs e)
    {
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
                sSQL += "insert into 分销商和品牌对应关系表 (pp_id,品牌名称,是否启用,fxs_id,分销商,updatetime,分类名称,fl_id,分类编码,yh_id,生产厂商ID)values('" +
                    this.ppid.Value + "','" + this.ppmc.Value + "','0','" + fxs[i] + "',(select 供应商 from 材料供应商信息表 where gys_id='" + fxs[i] +
                    "'),(select getdate()),'" + this.fl_name2.InnerHtml + "','" + this.fl_id.Value + "',(select 分类编码 from 材料分类表 where fl_id='" +
                    this.fl_id.Value + "'),(select yh_id from 材料供应商信息表 where gys_id='" + fxs[i] + "'),'" + this.scsid.Value + "')    ";
                sSQL += "insert into 材料供应商信息从表(pp_id,品牌名称,是否启用,gys_id,等级,范围,供应商,updatetime,分类名称,分类编码,fl_id)values('" +
                    this.ppid.Value + "','" + this.ppmc.Value + "','1','" + fxs[i] + "','" + this.grade2.InnerHtml + "','" +
                    this.scope2.InnerHtml + "','" + this.scs2.InnerHtml + "',(select getdate()),'" + this.fl_name2.InnerHtml + "',(select 分类编码 from 材料分类表 where fl_id='" +
                    this.fl_id.Value + "'),'" + this.fl_id.Value + "')";
                sSQL += "update 材料供应商信息从表 set uid=(select myID from 材料供应商信息从表 where 供应商 ='" +
                    this.scs2.InnerHtml + "' and 品牌名称='" + this.ppmc.Value + "' and gys_id='" + fxs[i] + "' and pp_id='" +
                    this.ppid.Value + "') where isnull(uid,'')='' and 供应商='" + this.scs2.InnerHtml + "' and 品牌名称='" + this.ppmc.Value + "' and gys_id='" + fxs[i] + "' and pp_id='" +
                    this.ppid.Value+"'";
            }           
            if (Conn.RunSqlTransaction(sSQL))
            {
                Response.Write("<script>alert('添加成功！');window.location.href='glfxsxx.aspx?gys_id=" + this.scsid.Value + "';</" + "script>");
            }
            else
            {
                Response.Write("<script>alert('添加失败！');window.localtion.reload();</" + "script>");
            }
        }
    }
</script>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="scsid" />
    <input type="hidden" runat="server" id="ppid" />
    <input type="hidden" runat="server" id="ppmc" />
    <input type="hidden" runat="server" id="fxsid" />
    <input type="hidden" runat="server" id="fl_id" />
    <DIV class=fxsxx>
<table width="1000" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #ddd; background-color:#f7f7f7; margin-top:10px;">
  <tr>
    <td width="120" height="50" align="right"><strong>品牌名称：</strong></td>
    <td width="200" style="padding-left:10px;"> <div id="ppmc1" runat="server"></div></td>
    <td width="60" align="right"><strong>生产商：</strong></td>
    <td width="200" style="padding-left:10px;"> <div id="scs2" runat="server"></div></td>
    <td width="50" align="right"><strong>等级：</strong></td>
    <td><div id="grade2"  runat="server"> </div></td>
    <td width="50"><strong>范围：</strong></td>
    <td><div id="scope2"  runat="server">  </div></td>
    <td width="50"><strong>分类：</strong></td>
    <td><div id="fl_name2" runat="server">  </div></td>
  </tr>
</table>
 
<TABLE width="1000" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0; 	background-color: #d9e5fd;">
  <TBODY>
  <TR>
    <TD height="40" style="WIDTH: 80px">&nbsp;</TD>
    <TD style="WIDTH: 50px">供应商：</TD>
    <TD style="width:300px;"><INPUT id=txt_gys name=txt_gys class="hyzhc_shrk"></TD>
    <TD align="right" style="WIDTH: 50px">地区：</TD>
    <TD class=style4 style="width:300px;"><SELECT id=Select1 class=fu1 name=Select1> 
        <OPTION selected value=""></OPTION></SELECT> <SELECT id=Select2 class=fu1 
      name=Select2> <OPTION selected value=""></OPTION></SELECT>
        <SELECT id=Select4 class=fu3 name=Select4> 
          <OPTION selected value=""></OPTION></SELECT>
      <SCRIPT language=javascript type=text/javascript>
          var s = ["s0", "s1", "s2", "s3"];
          var opt0 = ["-区域-", "-省(市)-", "-地级市、区-", "-县级市、县、区-"];
          for (i = 0; i < s.length - 1; i++)
              document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
          change(0);
                </SCRIPT>
       </TD>
    <TD>
   <input type="Button" name="filter" value="检索" id="filter" class="filter" filter="" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px;cursor:pointer;" />	&nbsp;&nbsp;&nbsp;               
<asp:Button  runat="server" name="btnDocNew"  Text="添加" OnClientClick=" return Addfxs();" OnClick="ADDFXS"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" />
    </TD></TR></TBODY>
</TABLE>
 
<table border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#dddddd" id="table" >
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
 
    <table width="100%" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td width="266" height="40" align="left" valign="middle">共7页/当前第1页 </td>
                <td align="right" valign="middle"> <a href="#">首页</a> <a href="#">上一页</a> <a href="#">下一页</a> <a href="#">尾页</a> 转到第
<input name="textfield244" type="text" class="queding_bk" size="3" />
                  页 
                  <input type="submit" name="btnDocNew" value="确定" onClick="return VerifyMyIMP();"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" />
                  
                </td>
      </tr>
</table> 
 </DIV>
</form>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  
</body>
</html>
