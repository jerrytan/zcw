<!--
        会员用户管理页面
        文件名：hyyhgl.aspx
        传入参数：
                p  列表页数
        负责人:  苑伟业
-->

<%--<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>--%>

<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="hyyhgl.aspx.cs" Inherits="asp_hyyhgl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible">
    <title>会员用户管理</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function deleteS() {
            alert("删除成功");
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
            var tableid = 'table'; 	//表格的id
            var overcolor = '#fff0e9'; //鼠标经过颜色
            var color1 = '#f2f6ff'; //第一种颜色
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

        //刷新页面
        function refresh() {
            this.location = this.location;
        }
        //添加
        function addPage() {
        var lx= document.getElementById("lx").value;
        var gys_dw_id=document.getElementById("gys_dw_id").value;
            newwin = window.open('hyyhgl_wh.aspx?gys_dw_id='+gys_dw_id+'&lx='+lx+'&state=0', 'myWindow', 'height=300px,width=390px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }
        //修改
        function changePage(obj) {
            var tr = obj.parentNode.parentNode;
            var tds = tr.cells;
            var qq = Trim(tds[2].innerHTML);
            var name = Trim(tds[3].innerHTML);
            var phone = Trim(tds[4].innerHTML);
            var email = Trim(tds[5].innerHTML);
            var scs;var fxs;var cl;
           <%if (Session["GYS_QQ_ID"] != null){ %>//Session["GYS_QQ_ID"]改成Session["GYS_QQ_ID"]
                scs = tds[6].childNodes[1].checked;
                fxs = tds[6].childNodes[3].checked;
                cl = tds[6].childNodes[5].checked;
           <%} else{%>
                scs=false;fxs=false;cl=false;
           <%} %>
            newwin = window.open('hyyhgl_wh.aspx?qq=' + qq + '&name=' + name + '&phone=' + phone + '&email=' + email+'&scs='+scs+'&fxs='+fxs+'&cl='+cl + '&state=1', 'myWindow', 'height=270px,width=390px,top=100,left=400,toolbar=no,menubar=no,resizable=no,location=no,status=no,scrollbars=no');
        }

         function Checked(obj) {
            if (!obj.checked) {
                        return;
             }
              var tr = obj.parentNode.parentNode;
              var tds = tr.cells;
              document.getElementById("txt_Selected").value += Trim(tds[2].innerHTML) + ",";
          }

//          function getDelete() {
//              var trs = document.getElementById("tbody").rows;
//              for (var i = 0; i < trs.length; i++) {
//                  var tds = trs[i].cells;
//                   if (tds[0].childNodes[1].checked) { 
//                      document.getElementById("txt_Selected").value += Trim(tds[2].innerHTML) + ","; 
//                  }
//              }
//          }

    </script>
</head>
<body>
    <form runat="server">
    <!-- 头部2开始-->
   <%-- <uc2:Header2 ID="Header2" runat="server" />--%>
   <%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>
        <div class="box">

    <div class="topx">
        <a href="index.aspx"><img src="images/topx_02.jpg" /></a>
    </div>

      <%         
            //HttpCookie GYS_QQ_ID = Session["GYS_QQ_ID"];更换成Session
          Object GYS_QQ_ID = Session["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  

            //HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];//更换成Session
            Object CGS_QQ_ID = Session["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];     
    
              
            //采购商登录
             if(((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID != null ) && (cgs_yh_id != null)))
            {
    %>
             <div class="anniu"><a  href="QQ_out.aspx" target="_self">采购商登出</a></div>
    <%
            }
            //供应商登录
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
    %>
                 <div class="anniu"><a  href="QQ_out.aspx" target="_self">供应商登出</a></div>
				 <div class="anniu"><a  href="gyszym.aspx" target="_self">供应商主页面</a></div>
    <%
            }
    %>
    <div class="gyzy0">
        <div class="gyzy">
            尊敬的
			<%foreach(System.Data.DataRow row in dt_Yh.Rows){%>            
            <span><%=row["姓名"].ToString() %></span>           
            <%}%>
            ，欢迎来到众材网！
            <div style="float:right"><span style="font-weight:bold;">
            <%if (GYS_QQ_ID != null)
              { %>
            <a href="gysgly_wh.aspx">[修改完善公司信息]</a>
            <%} else{ %>
            <a href="cgsgly_wh.aspx">[修改完善公司信息]</a>
            <%} %>
            </span>&nbsp;&nbsp;&nbsp;&nbsp;[<a href="index.aspx">退出登录</a>]
        </div></div>
    </div>
    <input type="hidden" id="lx" runat="server" />
    <!-- 头部2结束-->
    <!-- 检索 开始-->
    <div id="jiansuo">
        <font style="font-size: 9pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;检索条件：</font>
        <select runat="server" name="lieming" id="lieming" style="width: 128px; border-right: #808080 1px solid;
            border-top: #808080 1px solid; font-size: 9pt; border-left: #808080 1px solid;
            border-bottom: #808080 1px solid">
            <option value=""></option>
            <option value="QQ号">QQ号</option>
            <option value="姓名">姓名</option>
            <option value="手机号">手机号</option>
        </select>
        <select name="yunsuanfu" id="yunsuanfu" style="width: 88px; border-right: #808080 1px solid;
            border-top: #808080 1px solid; font-size: 9pt; border-left: #808080 1px solid;
            border-bottom: #808080 1px solid">
            <option selected="selected" value="like">包含关键字</option>
            <option value="=">等于</option>
            <option value="&lt;">小于</option>
            <option value=">">大于</option>
            <option value="">=">大于等于</option>
            <option value="&lt;=">小于等于</option>
        </select><input runat="server" name="txtKeyWord" type="text" id="txtKeyWord" style="border-right: #808080 1px solid;
            border-top: #808080 1px solid; border-left: #808080 1px solid; border-bottom: #808080 1px solid" />
        <input id="chkSearchInResult" type="checkbox" name="chkSearchInResult" checked="checked" /><label
            for="chkSearchInResult">在结果中检索</label>&nbsp;&nbsp;
        <%--<input type="submit" name="filter" value="检索" id="filter" class="filter" style="color: Black;
            border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px;" />--%>
        <asp:Button ID="filter" name="filter" runat="server" Text="检索"  class="filter" 
            style="color: Black;
            border-style: None; font-family: 宋体; font-size: 12px; height: 20px; width: 37px;cursor:pointer;" 
            onclick="filter_Click"/>
        &nbsp;&nbsp;
        <input type="submit" name="btnDocNew" value="添加" onclick="addPage();" id="btnDocNew"
            class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
            height: 20px; width: 37px;cursor:pointer;" />&nbsp;&nbsp;
        <input type="button" id="btnFilter" value="组合查询"  style="height: 20px;
            width: 64px; border-style: none; font-family: 宋体; font-size: 12px;" />&nbsp;&nbsp;
        <%--<input type="submit" name="btnDelete" value="删除选中行" onclick="return confirm(&#39;真的彻底删除选中的记录吗？&#39;);"
            id="btnDelete" class="btnDelete1" style="color: Black; border-style: None; font-family: 宋体;
            font-size: 12px; height: 20px; width: 72px;" />--%>
          <asp:Button ID="btnDelete" runat="server" Text="删除选中行" class="btnDelete1" style="color: Black; border-style: None; font-family: 宋体;
            font-size: 12px; height: 20px; width: 72px;cursor:pointer;" 
            onclick="btnDelete_Click"/>
    </div>
    <!-- 检索 结束-->
    <!-- 用户信息 开始 -->
    <input type="hidden" runat="server" id="gys_dw_id" />
    <div class="yhb">
        <table border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" id="table">
            <thead>
                <tr>
                    <th align="center">
                        <strong>选择</strong>
                    </th>
                    <th align="center">
                        <strong>序号</strong>
                    </th>
                    <th align="center">
                        <strong>QQ号码</strong>
                    </th>
                    <th align="center">
                        <strong>姓名</strong>
                    </th>
                    <th align="center">
                        <strong>手机号</strong>
                    </th>
                    <th align="center">
                        <strong>邮箱</strong>
                    </th>
                    <%if (Session["GYS_QQ_ID"] != null)
                      { %>
                    <th align="center">
                        <strong>角色权限</strong>
                    </th>
                    <%} %>
                    <th align="center">
                        <strong>操作</strong>
                    </th>
                </tr>
            </thead>
            <tbody id="tbody">
                <%for (int i = 0; i < listGys.Count; i++)
                  { %>
                <tr>
                    <td align="center">
                        <input type="checkbox" onclick="Checked(this)" />
                    </td>
                    <td align="center">
                        <%=i+1 %>
                    </td>
                    <td>
                        <%=listGys[i].QQ%>
                    </td>
                    <td class="gridtable">
                        <%=listGys[i].Name%>
                    </td>
                    <td>
                        <%=listGys[i].Phone%>
                    </td>
                    <td>
                        <%=listGys[i].Email%>
                    </td>

                    <%if (Session["GYS_QQ_ID"] != null)
                      { %>
                    <td>
                        <%string powerGys = listGys[i].Power.ToString(); %>
                        <%if (powerGys.Contains("管理生产商") && powerGys.Contains("管理分销商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商") && powerGys.Contains("管理分销商")) %>
                        <%{%>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <% } %>
                        <%else if (powerGys.Contains("管理分销商") && powerGys.Contains("管理材料信息")) %>
                        <%{%>
                            <input type="checkbox" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <% } %>
                        <%else if (powerGys.Contains("管理生产商")) %>
                        <%{%>
                            <input type="checkbox" checked="checked" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <% } %>
                        <%else if (powerGys.Contains("管理分销商"))
                        { %>
                            <input type="checkbox" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" checked="checked" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <%} %>
                        <%else if (powerGys.Contains("管理材料信息"))
                        { %>
                            <input type="checkbox" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                            管理生产商
                            <input type="checkbox" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                            管理分销商
                            <input type="checkbox" checked="checked" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                            管理材料信息
                        <%} %>
                        <%else
                        { %>
                        <input id="Checkbox1" type="checkbox" value="管理生产商" name="cbx1" disabled="disabled" runat="server" />
                        管理生产商
                        <input id="Checkbox2" type="checkbox" value="管理分销商" name="cbx2" disabled="disabled" runat="server" />
                        管理分销商
                        <input id="Checkbox3" type="checkbox" value="管理材料信息" name="cbx3" disabled="disabled" runat="server" />
                        管理材料信息
                        <%} %>
                    </td>
                    <%} %>
                    <td align="center">
                        <input type="button" name="filter" value="编辑" id="Submit1" onclick="changePage(this);"
                            class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                            height: 20px; width: 37px;cursor:pointer;" />
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
       <%-- <table width="100%" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td width="40" align="left" valign="middle">
                    &nbsp;
                </td>
                <td width="266" height="40" align="left" valign="middle">
                    共7页/当前第1页
                </td>
                <td align="right" valign="middle">
                    <a href="#">首页</a> <a href="#">上一页</a> <a href="#">下一页</a> <a href="#">尾页</a> 转到第
                    <input name="textfield244" type="text" class="queding_bk" size="3" />
                    页
                    <input type="submit" name="btnDocNew" value="确定" onclick="return VerifyMyIMP();"
                        class="filter" style="color: Black; border-style: None; font-family: 宋体; font-size: 12px;
                        height: 20px; width: 37px;" />
                </td>
                <td width="40" align="right" valign="middle">
                    &nbsp;
                </td>
            </tr>
        </table>--%>


        <!-- 页码开始-->
       <div style="text-align:center"> <!--加入div控制分页居中-->
       <div class="fy2">
            <div class="fy3">
                <% if(current_page<=1 && pageCount_page>1) {%> 
                    <font class="p" style="color:Gray">首页</font>
                    <a href="hyyhgl.aspx?p=<%=current_page+1 %>" class="p" style="color:Black">下一页</a>
                    <a href="hyyhgl.aspx?p=<%=pageCount_page %>" class="p" style="color:Black">末页</a>
                <%} %>
                <% else if(current_page<=1 && pageCount_page<=1) {%>
                
                <% }%>    
                <% else if(!(current_page<=1)&&!(current_page == pageCount_page)){ %>
                    <a href="hyyhgl.aspx?p=<%=1 %>"class="p" style="color:Black">首页</a>
                    <a href="hyyhgl.aspx?p=<%=current_page-1 %>" class="p" style="color:Black">上一页</a>
                    <a href="hyyhgl.aspx?p=<%=current_page+1 %>" class="p" style="color:Black">下一页</a>
                    <a href="hyyhgl.aspx?p=<%=pageCount_page %>" class="p" style="color:Black">末页</a>
                <%}%>
                <% else if(current_page == pageCount_page){ %>
                    <a href="hyyhgl.aspx?p=<%=1 %>"class="p" style="color:Black">首页</a>
                    <a href="hyyhgl.aspx?p=<%=current_page-1 %>" class="p" style="color:Black">上一页</a>
                    <font class="p" style="color:Gray">末页</font> 
                <%} %>
                <font style="color:Black" >直接到第</font>  
                <select onchange="window.location=this.value" name="" class="p" style="color:Black">
                <% foreach (var v in this.Items)
                { %>
                    <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>
                <%} %>
                </select>
                <font style="color:Black" >页&nbsp;&nbsp;&nbsp;第 <%=current_page %> 页/共 <%=pageCount_page %> 页</font>
            </div>
        </div>
        </div>
        <!-- 页码结束-->



    </div>
    <!-- 用户信息 结束 -->
    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
    </form>
    <input type="hidden" id="txt_Selected" value="" runat="server"/>
</body>
</html>
