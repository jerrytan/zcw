﻿<%--<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cgsgly_wh.aspx.cs" Inherits="asp_cgsgly_wh" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>公司信息维护</title>
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Address.js" type="text/javascript"></script>
    <!--前台数据输入验证 开始-->
    <script type="text/javascript">
        $(function () {
            $("#s1").change(function () {
                $("#region").val($("#s0").children('option:selected').val() + $("#s1").children('option:selected').val());
            });
        });
        function gsyxCheck(str) {
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            if (!reg.test(str.value) && document.getElementById("txt_gsyx").value != "") {
                alert("请输入有效的邮箱地址");
                document.getElementById("txt_gsyx").focus();
            }
        }
        function yxCheck(str) {
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            if (!reg.test(str.value) && document.getElementById("txt_yx").value != "") {
                alert("请输入有效的邮箱地址");
                document.getElementById("txt_yx").focus();
            }
        }
        function isPhone(str) {
            var reg = /^0?1[358]\d{9}$/;
            if (!reg.test(str.value) && document.getElementById("txt_sj").value != "") {
                alert("手机号格式错误，请重新输入");
                document.getElementById("txt_sj").focus();
            }
        }
        function isTelePhone(str) {
            var reg = /^(0(10|2[1-3]|[3-9]\d{2}))?[1-9]\d{6,7}$/;
            if (!reg.test(str.value) && document.getElementById("txt_gsdh").value != "") {
                alert("电话格式错误，请重新输入");
                document.getElementById("txt_gsdh").focus();
            }
        }
        function gsmcCheck(str) {
            if ((str.value.length > 40 || str.value.length < 4) && document.getElementById("txt_gsmc").value != "") {
                alert("公司名称长度只能在4-40位字符之间");
                document.getElementById("txt_gsmc").focus();
            }
        }
        function isQQ(str) {
            var reg = /^\d{5,10}$/;
            if (!reg.test(str.value) && document.getElementById("txt_gsQQ").value != "") {
                alert("QQ号格式错误，请重新输入");
                document.getElementById("txt_gsQQ").focus();
            }
        }
        function gszyCheck(str) {
            var reg = /^(http(s)?:\/\/)?(www\.)?[\w-]+\.\w{2,4}(\/)?$/;
            if (!reg.test(str.value) && document.getElementById("txt_gszy").value != "") {
                alert("公司网址格式不正确，请重新输入");
                document.getElementById("txt_gszy").focus();
            }
        }
        function yhzhCheck(str) {
            var reg = /^(\d{15})|(\d{19})$/;
            if (!reg.test(str.value) && document.getElementById("txt_yhzh").value != "") {
                alert("银行账户填写不正确，请重新输入");
                document.getElementById("txt_yhzh").focus();
            }
        }
        function dateCheck(str) {
            var reg = /^([1-2]\d{3})[\/|\-](0?[1-9]|10|11|12)[\/|\-]([1-2]?[0-9]|0[1-9]|30|31)$/ig;
            if (!reg.test(str.value) && document.getElementById("txt_zcrq").value != "") {
                alert("日期填写格式不正确，请重新输入。应如：2000-01-01");
                document.getElementById("txt_zcrq").focus();
            }
        }
        function qyrsCheck(str) {
            var reg = /^[0-9]*$/;
            if (!reg.test(str.value) && document.getElementById("txt_qyrs").value != "") {
                alert("企业人数填写格式不正确，请重新输入");
                document.getElementById("txt_qyrs").focus();
            }
        }
        function zczeCheck(str) {
            var reg = /^[+-]?\d+(\.\d+)?$/;
            if (!reg.test(str.value) && document.getElementById("txt_zcze").value != "") {
                alert("资产总额填写格式不正确，请重新输入");
                document.getElementById("txt_zcze").focus();
            }
        }
    </script>
    <!--前台数据输入验证 结束-->
</head>
<body>
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
            //HttpCookie GYS_QQ_ID = Session["GYS_QQ_ID"];更换
          Object GYS_QQ_ID = Session["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  

            //HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];//更换
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
			<%foreach(System.Data.DataRow row in dt_Yh.Rows){%>            
            <span><%=row["姓名"].ToString() %></span>           
            <%}%>
            欢迎来到众材网！
              <div style="float:right"><span style="font-weight:bold;">
    <a href="hyyhgl.aspx">[会员用户管理主页面]</a></span><%--&nbsp;&nbsp;&nbsp;&nbsp;[<a href="index.aspx">退出登录</a>]--%>
        </div>
        </div>
    </div>
    <!-- 头部2结束-->
    <form id="form1" runat="server">
    <div class="yhb">
        <table width="998px" border="0" cellspacing="0" style="border: 1px solid #dddddd;font-size:12px;">
            <tr>
                <td height="34" colspan="6" bgcolor="#f7f7f7">
                    <strong class="left_jianju">公司信息</strong>
                </td>
            </tr>
            <tr>
                <td height="20" colspan="6" align="right">
                </td>
            </tr>
            <tr>
                <td width="50" height="40">
                    <span class="xinghao">*</span>
                </td>
                <td width="120">
                    公司名称：
                </td>
                <td width="329">
                    <label for="textfield">
                    </label>
                    <input name="txt_gsmc" type="text" class="hyzhc_shrk" id="txt_gsmc" runat="server" onblur="gsmcCheck(this);"/>
                </td>
                <td width="50" align="right">
                </td>
                <td width="120">
                    公司简称：
                </td>
                <td width="329">
                    <input name="txt_gsjc" type="text" class="hyzhc_shrk" id="txt_gsjc" runat="server" maxlength="40"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                    营业执照注册号：
                </td>
                <td>
                    <input name="txt_yyzzzch" type="text" class="hyzhc_shrk" id="txt_yyzzzch" runat="server"/>
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司QQ号：
                </td>
                <td>
                    <input name="txt_gsQQ" type="text" class="hyzhc_shrk" id="txt_gsQQ" runat="server" onblur="isQQ(this)"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                    营业执照图片：
                </td>
                <td>
                    <input type="button" id="btnFilter" value="选择文件"  style="height: 20px;
                        width: 64px; border-style: none; font-family: 宋体; font-size: 12px;" />
                    请上传小于5Mb的jpg\gif\png格式的图片
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    法定代表人：
                </td>
                <td>
                    <input name="txt_fddbr" maxlength="20" type="text" class="hyzhc_shrk" id="txt_fddbr" runat="server"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                     公司注册日期：
                </td>
                <td>
                    <input name="txt_zcrq" type="text" class="hyzhc_shrk" id="txt_zcrq" runat="server" onblur="dateCheck(this);"/>
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    注册资金（万元）：
                </td>
                <td>
                    <input name="txt_zczj" type="text" class="hyzhc_shrk" id="txt_zczj" runat="server"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td style=' width:130px;'>
                    资产总额（万元）：
                </td>
                <td>
                    <input name="txt_zcze" type="text" class="hyzhc_shrk" id="txt_zcze" runat="server" onblur="zczeCheck(this);"/>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    注册级别：
                </td>
                <td>
                     <select runat="server" id="zcjb">
                        <option value="">请选择</option>
                        <option value="国家级">国家级</option>
                        <option value="省级">省级</option>
                        <option value="地市级">地市级</option>
                        <option value="区县级">区县级</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td>
                    资质等级：
                </td>
                <td>
                     <select runat="server" id="zzdj">
                        <option value="">请选择</option>
                        <option value="一级">一级</option>
                        <option value="二级">二级</option>
                        <option value="三级">三级</option>
                    </select>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    企业类别：
                </td>
                <td>
                    <select runat="server" id="qylb">
                        <option value="">请选择</option>
                        <option value="国有">国有</option>
                        <option value="私营">私营</option>
                        <option value="个体">个体</option>
                        <option value="集体">集体</option>
                        <option value="三资">三资</option>
                        <option value="三资">外资</option>
                        <option value="其他">其他</option>
                    </select>
                </td>
            </tr>
            <tr>
                 <td height="40">
                    &nbsp;
                </td>
                <td>
                    开户银行：
                </td>
                <td>
                    <input name="txt_khyh" type="text" class="hyzhc_shrk" id="txt_khyh" runat="server"/>
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    单位类型：
                </td>
                <td>
                    <select runat="server" id="dwlx">
                        <option value="采购商">采购商</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td>
                    账户名称：
                </td>
                <td>
                    <input name="txt_zhmc" type="text" class="hyzhc_shrk" id="txt_zhmc" runat="server"/>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    银行账户：
                </td>
                <td>
                    <input name="txt_yhzh" type="text" class="hyzhc_shrk" id="txt_yhzh" runat="server" onblur="yhzhCheck(this);"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司所在地：
                </td>
                <td>
                    <span class="fl">
                    <select id="s0" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>
                        <select id="s1" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>
                        <input type="hidden" id="region"  value="北京市" runat="server" />
                        <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
                        <script src="Scripts/Address.js" type="text/javascript"></script>
                        <%--<select id="s1"  class="fu1" runat="server"><option></option></select>
                        <select id="s2" class="fu2" runat="server"><option></option></select>
                        <select id="s3" class="fu3" runat="server"><option></option></select>
                        <script type="text/javascript">
                            var s = ["s1", "s2", "s3"];
                            var opt0 = ["-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                            for (i = 0; i < s.length - 1; i++)
                                document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                            change(0);
                            function btn_sub_onclick() {

                            }

                        </script>--%>
                    </span>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    企业人数：
                </td>
                <td>
                      <input maxlength="7" name="txt_qyrs" type="text" class="hyzhc_shrk" id="txt_qyrs" runat="server" onblur="qyrsCheck(this);"/>
                </td>
            </tr>
            <tr>
                 <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司地址：
                </td>
                <td>
                    <input name="txt_gsdz" type="text" class="hyzhc_shrk" id="txt_gsdz" runat="server"/>
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司电话：
                </td>
                <td>
                      <input name="txt_gsdh" type="text" class="hyzhc_shrk" id="txt_gsdh" runat="server" onblur="isTelePhone(this);"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td>
                    公司主页：
                </td>
                <td>
                    <input name="txt_gszy" maxlength="80" type="text" class="hyzhc_shrk" id="txt_gszy" runat="server" onblur="gszyCheck(this)"/>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                     公司邮编：
                </td>
                <td>
                    <input name="txt_gsyb" type="text" class="hyzhc_shrk" id="txt_gsyb" runat="server"/>
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td>
                    公司传真：
                </td>
                <td>
                    <input name="txt_gscz" type="text" class="hyzhc_shrk" id="txt_gscz" runat="server"/>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    
                </td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td height="40">
                    <span class="xinghao">*</span>
                </td>
                <td>
                    经营范围：
                </td>
                <td colspan="4" height="90px">
                    <label for="textfield21">
                    </label>
                    <textarea class="hyzhc_shrk2" cols="40" id="jyfw"
                        name="txt_jyfw" rows="6" runat="server"></textarea>
                </td>
            </tr>
            <tr>
                <td height="66">
                    &nbsp;
                </td>
                <td>
                    备 注：
                </td>
                <td colspan="4" height="60px">
                    <textarea class="hyzhc_shrk3" cols="40" id="txt_bz"
                        name="txt_bz" rows="6" runat="server"></textarea>
                </td>
            </tr>
            <tr>
                <td height="34" colspan="6" bgcolor="#f7f7f7">
                    <strong class="left_jianju">管理员信息</strong>
                </td>
            </tr>
            <tr>
                <td height="20" colspan="6" align="right">
                </td>
            </tr>
<tr>
    <td height="40" colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50"><span class="xinghao">*</span></td>
        <td width="120" height="40">姓 名：</td>
        <td align="left"><input name="txt_xm" type="text" class="hyzhc_shrk_2" id="txt_xm" runat="server" /></td>
        <td width="80"><span class="xinghao">*</span></td>
        <td width="60" height="40">手 机：</td>
        <td align="left"><input name="txt_sj" type="text" class="hyzhc_shrk_2" id="txt_sj"  runat="server"/></td>
        <td width="70">&nbsp;</td>
        <td width="60">邮 箱：</td>
        <td align="left"><input name="txt_yx" type="text" class="hyzhc_shrk_3" id="txt_yx" runat="server" /></td>
        <td width="48">&nbsp;</td>
        </tr>
    </table></td>
    </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td height="60">
                    &nbsp;
                </td>
                <td>
                    <!-- <img src="images/lijizhuce.gif" alt="" width="94" height="36" /> -->
                    <!--<input id="btn_sub"  type="submit" value="" style="width:94px;height:36px;background:url(images/lijizhuce.gif) no-repeat;" onclick="return btn_sub_onclick()" />-->
                    <asp:ImageButton id="Submit1"  runat="server" ImageUrl="images/12ff_03.jpg" onclick="Submit1_Click" />
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
    <!-- 用户信息 结束 -->
    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>

