<!--
       供应商管理材料页面 可以删除选中的材料文件名:  gysglcl.aspx   
       传入参数：s_yh_id 用户id 
       author:张新颖 新增分销商管理材料页面 
      
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>
<%@ Page Language="C#"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>分销商管理材料页面</title>
    <META content="IE=10.000" http-equiv="X-UA-Compatible">
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/gysglcl.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script> 
 
   <%-- 点击左侧列表数，右侧填值--%>
    <script type="text/javascript">
        function lbs(obj,ppid,ppmc,scs)
        {
            var h = obj.parentNode.parentNode;
            var a = h.getElementsByTagName("a");
            for (var i = 0; i < a.length; i++)
            {
                a[i].style.color = "#707070";
            }
            obj.style.color = "#4876FF";
            document.getElementById("ppid").value = ppid;
            document.getElementById("ppmc").value = ppmc;
            document.getElementById("scsid").value = scs;
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
                    $("#table4").empty();
                    $("#table4").append(xmlhttp.responseText);
                }
            }
            var url = "fxsglcl2.aspx?ppid=" + ppid+"&ppmc="+ppmc+"&scs="+scs;
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
        }
    </script>
      <script language="javascript" type="text/javascript">
          function selectall1(obj)
          {
              if (obj.checked)
              {
                  var Table = document.getElementById("table4");
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
              var Table = document.getElementById("table4");
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
    //新增材料
        function btnFilter_Click()
        {
            var fxs_id = document.getElementById("fxsid").value;
            var ppid = document.getElementById("ppid").value;
            var ppmc = document.getElementById("ppmc").value;
            var scs = document.getElementById("scsid").value;
            if (ppid == "" || ppid == undefined)
            {
                alert("请选择品牌！");
                return;
            }
            else
            {
                var url = "fxsxzdlcl.aspx?ppid=" + ppid + "&ppmc=" + ppmc + "&scsid=" + scs + "&fxsid=" + fxs_id;
                window.location.href = url;
            }
        }
        //查阅
        function Read(cl_id)
        {
            var url = "clxx.aspx?cl_id=" + cl_id;
            window.location.href = url;
        }
        //删除材料
        function delete_cl()
        {
            var fxs_id = document.getElementById("fxsid").value;
            var ppid = document.getElementById("ppid").value;
            var ppmc = document.getElementById("ppmc").value;
            var scs = document.getElementById("scsid").value;

            var table = document.getElementById("table4");
            var input = table.getElementsByTagName("input");
            var cl_id = "";
            for (var i = 0; i < input.length; i++)
            {
                if (input[i].type == "checkbox" && input[i].checked)
                {
                    cl_id += Trim(input[i].value) + ",";
                }
            }
            if (cl_id == "" || cl_id == undefined)
            {
                alert("请选择要删除的材料!");
                return;
            }
            else
            {
                var xmlhttp;
                if (window.XMLHttpRequest)
                {
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var text = xmlhttp.responseText;
                        if (text == 1)
                        {
                            alert('删除成功');
                            location.reload();
                        }
                        else
                        {
                            alert('删除失败');
                            location.reload();
                        }
                    }
                }
                xmlhttp.open("GET", "fxsscdlcl.aspx?cl_id=" + cl_id + "&ppid=" + ppid + "&ppmc=" + ppmc + "&scsid=" + scs + "&fxsid=" + fxs_id, true);
                xmlhttp.send();
            }
        }
    </script>
</head>
<body>
    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <script runat="server">
        protected string gys_id = "";
        public DataTable dt_gys = new DataTable();
        public DataConn objConn = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
            {
                gys_id = Request["gys_id"].ToString();
            }
            this.fxsid.Value = gys_id;
          //  gys_id = "318";
        }
    </script>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="scsid" />
    <input type="hidden" runat="server" id="ppid" />
    <input type="hidden" runat="server" id="ppmc" />
    <input type="hidden" runat="server" id="fxsid" />
    <DIV class="dlqqz5" style="border:1px solid #4ea6ee; padding-top:10px; margin-bottom:10px; ">
     <div id="menu2">
     <div class="dlqqz1_2" style="margin-left:10px;">您的生产商品牌列表</div>
     <%if (gys_id != "") %>
     <%{ %>
         <%string sSQL = ""; %>
         <% sSQL = "select  distinct a.gys_id as 生产商Id,a.供应商 as 生产商 from 材料供应商信息表 a left join (select * from  品牌字典  where pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='"+gys_id+"'))b on a.gys_id=b.scs_id where pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='"+gys_id+"')";%>
         <% dt_gys = objConn.GetDataTable(sSQL); %>
         <%if (dt_gys != null && dt_gys.Rows.Count > 0) %>
         <%{ %>
             <%int   firstlevel = 0; %>
             <%foreach (DataRow drgys in dt_gys.Rows)%>
             <% {%>
                   <%sSQL = ""; %>
                   <%sSQL = "select 品牌名称,pp_id from 品牌字典 where scs_id='" + drgys["生产商Id"] + "' and 是否启用='1' and pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='"+gys_id+"')"; %>
                   <%DataTable dtpp = new DataTable(); %>
                   <%dtpp = objConn.GetDataTable(sSQL); %>
                   <%if (dtpp != null && dtpp.Rows.Count > 0) %>
                   <%{ %>
                        <% int secondlevel = 0; %>
                        <h1 onClick="javascript:ShowMenu(this,<%=firstlevel %>)">
                            <a href="javascript:void(0)"><img src="images/biao2.jpg" alt="" /> <%=drgys["生产商"]%></a></h1>                                   
                                    <span class="no">
                        <%foreach (DataRow drpp in dtpp.Rows) %>
                        <%{ %>
                             <h2><a href="javascript:void(0)" onclick="lbs(this,'<%=drpp["pp_id"] %>','<%=drpp["品牌名称"]%>','<%=drgys["生产商"]%>')"><%=drpp["品牌名称"]%></a></h2>
                               <ul class="no"></ul>
                        <%} %>
                        </span>
                   <%} %>
                   <%else %>
                   <%{ %>
                    <h1><a href="javascript:void(0)" ><%=drgys["生产商"]%></a></h1>
                                <span class="no"></span>
                   <%} %>
                   <%firstlevel++; %>
             <% } %>
         <%} %>
     <%} %>
     <%else %>
     <%{ %>
     <%} %>
     </div>
     <div id="cgs_lb" style="width:755px; margin-left:232px;">
    <div   class="jiansuo3">
    检索条件：
    <input name="txtKeyWord" runat="server" type="text" id="txtKeyWord" style="border-right: #808080 1px solid; border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
    <div class="jiansuo_img">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table">
  <tr>
    <td width="80" height="30" align="center">
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/asp/images/jiansuo.gif" /></td>
    <td width="85" align="left">
   <input type="button" class="btnFilter" value="添加材料" onclick="btnFilter_Click()" style=" margin-top:0px; height: 20px;width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" /></td>
    <td>
     <input type="button" class="btnFilter" value="删除材料" onclick="delete_cl()" style=" margin-top:0px; height: 20px;width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" /></td>
  </tr>
</table>
</div>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" class="table2" id="table4">
      <thead>
        <tr >
          <th width="37" align="center"><input  class="middle" type="checkbox" name="checkboxAll" id="checkboxAll" onclick="return selectall();"   /> </th>
          <th width="100" align="center"><strong>材料编码</strong></th>
          <th width="90" align="center"><strong>材料名称</strong></th>
          <th width="140" align="center"><strong>规格/型号</strong></th>
          <th width="180" align="center"><strong>供应商</strong></th>
          <th width="80" align="center"><strong>品牌</strong></th>
          <th width="55" align="center"><strong>单位</strong></th>
          <th width="80" align="center"><strong>价格</strong></th>
          <th width="44" align="center"><strong>操作</strong></th>
        </tr>
      </thead>
      <tbody>       
      </tbody>
    </table>
 <%--<div style="text-align:center"  runat="server" id="dic">
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
    </div>--%>
</div>
     </DIV>
    </form>
</body>
</html>
