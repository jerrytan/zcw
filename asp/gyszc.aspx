﻿<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gyszc.aspx.cs" Inherits="asp_gyszc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta content="IE=10.000" http-equiv="X-UA-Compatible" />
    <title>会员注册</title>
    <link rel="stylesheet" type="text/css" href="css/themes/base/jquery.ui.all.css" />
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="Scripts/jquery-1.8.3.js"></script>
<script type="text/javascript" src="Scripts/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="Scripts/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="Scripts/ui/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="Scripts/ui/i18n/jquery.ui.datepicker-zh-CN.js" charset="UTF-8"></script>
    <script src="Scripts/Address.js" type="text/javascript"></script>

    <script src="Scripts/zcJScript.js" type="text/javascript"></script>
    <script src="Scripts/MyControl.js" type="text/javascript"></script>
    <!--前台数据输入验证 开始-->
    <script type="text/javascript">

        $(function () {
            $("#s1").change(function () {
                $("#region").val($("#s0").children('option:selected').val() + $("#s1").children('option:selected').val());
            });


            //日期
            $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
            $("#txt_zcrq").datepicker({
                changeMonth: true,
                changeYear: true,
				followOffset : [0, 24]
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
//            var _d = /^1[3578][01379]\d{8}$/g;

//            var _l = /^1[34578][01256]\d{8}$/g;

//            var _y = /^(134[012345678]\d{7}|1[34578][0123456789]\d{8})$/g;
            var strs = /^1[34578][01234567890]\d{8}$/g;

//            if (!_y.test(document.getElementById("txt_sj").value) ||! _l.test(document.getElementById("txt_sj").value) || !_d.test(document.getElementById("txt_sj").value) ) {
            if (!strs.test(document.getElementById("txt_sj").value)) {
                if (document.getElementById("txt_sj").value != "") {
                    alert("手机号格式错误，请重新输入");
                    document.getElementById("txt_sj").focus();
                }else if(document.getElementById("txt_sj").value == ""){
                    alert("请输入手机号");
                    document.getElementById("txt_sj").focus();
                 }
             }
        } 
        function zczj(str) {
            var reg = /^\d{1,15}$/;
            if (!reg.test(str.value) || document.getElementById("txt_zczj").value == "") {
                //&& document.getElementById("txt_zczj").value != ""
                alert("请输入数字！");
                document.getElementById("txt_zczj").focus();
            } 
        }
        function isTelePhone(str) {
            
            var reg = /^(0(10|2[1-3]|[3-9]\d{2}))?[1-9]\d{6,7}$/;
            var regStr = /^0\d{2,4}-?\d{7,8}$/;
            if (reg.test(str.value) || regStr.test(str.value) && document.getElementById("txt_gsdh").value != "") {
                //&& document.getElementById("txt_gsdh").value != ""
                
            } else {
                alert("电话格式错误，请重新输入");
                document.getElementById("txt_gsdh").focus();
            }


            if (document.getElementById("txt_gsdh").value == "") {
                document.getElementById("txt_gsdh").value = "请填写区号+电话号码";
                document.getElementById("txt_gsdh").style.color = "#999";
            }
        }
        function gsmcCheck(str) {
            if ((str.value.length > 40 || str.value.length < 4) && document.getElementById("txt_gsmc").value != "") {
                alert("公司名称长度只能在4-40位字符之间");
                document.getElementById("txt_gsmc").focus();
            }
            else if (document.getElementById("txt_gsmc").value == "") {
                document.getElementById("txt_gsmc").focus();
            }
        }
        function getiphone(obj)
        {
            if(document.getElementById("txt_sj").value == "请输入手机号！")
            {
                document.getElementById("txt_sj").value ="";
                document.getElementById("txt_gsmc").style.color = "#000";
            }
        }
        function getfocus(obj) {
            if (obj.value == "请填写工商局注册的全称（4-40位字符）") {
                obj.value = "";
                obj.style.color = "#000";
            } else if (obj.value == "请填写公司地址") {
                obj.value = "";
                obj.style.color = "#000";
            } else if (obj.value == "请填写区号+电话号码") {
                document.getElementById("txt_gsdh").value = "";
                obj.style.color = "#000";
            }else if(obj.value=="请注意邮箱格式"){
                obj.value="";
                obj.style.color = "#000";

            }
             else {
                obj.style.color = "#000";
            }
        }
        function losefocus(obj) {
            if (document.getElementById("txt_gsdz").value == "") {
                document.getElementById("txt_gsdz").value = "请填写公司地址";
                document.getElementById("txt_gsdz").style.color = "#999";
            }
        }
        function lose(obj) {
            ///^[+]{0,1}(/d){1,3}[ ]?([-]?((/d)|[ ]){1,12})+$/
        var reg= /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            if (document.getElementById("txt_yx").value == "") {
                document.getElementById("txt_yx").value = "请注意邮箱格式";
                document.getElementById("txt_yx").style.color = "#999";
            }
            else if (!reg.test(document.getElementById("txt_yx").value) ) {
                alert("邮箱格式不正确");
                document.getElementById("txt_yx").focus();
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
//            var reg = /^(http(s)?:\/\/)?(www\.)?[\w-]+\.\w{2,4}(\/)?$/;
//            if (!reg.test(str.value) && document.getElementById("txt_gszy").value != "") {
//                alert("公司网址格式不正确，请重新输入");
//                document.getElementById("txt_gszy").focus();
//            }
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
        function getup() {
            //提交前判断
            var x = document.getElementById("s0").value;
            var sj = document.getElementById("s1").value;
            var xsj = document.getElementById("region").value;
            document.getElementById("x").value = x;
            document.getElementById("sj").value = sj;
            document.getElementById("xsj").value = xsj;
        }
    </script>
    <!--前台数据输入验证 结束-->
</head>
<body>
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="x" /><input type="hidden" runat="server"
        id="sj" /><input type="hidden" runat="server" id="xsj" />
    <div class="yhb">
        <div class="hyzhc_title">
            <ul>
                <li>注册步骤：</li>
                <li>1、选择注册身份</li>
                <li class="zhuce_red">2、填写注册信息</li>
                <li>3、注册成功</li>
            </ul>
        </div>
        <table width="998px" border="0" cellspacing="0" style="border: 1px solid #dddddd;
            font-size: 12px;">
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
                <td width="130">
                    公司名称：
                </td>
                <td width="329">
                    <label for="textfield">
                    </label>
                    <input name="txt_gsmc" style="color: #999" type="text" class="hyzhc_shrk" id="txt_gsmc"
                        runat="server" onblur="gsmcCheck(this);" onfocus="getfocus(this)" value="请填写工商局注册的全称（4-40位字符）" />
                </td>
                <td width="50" align="right">
                </td>
                <td width="120">
                    公司简称：
                </td>
                <td width="329">
                    <input name="txt_gsjc" type="text" class="hyzhc_shrk" id="txt_gsjc" runat="server"
                        maxlength="40" />
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
                    <input name="txt_yyzzzch" type="text" class="hyzhc_shrk" id="txt_yyzzzch" runat="server" />
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司QQ号：
                </td>
                <td>
                    <input name="txt_gsQQ" type="text" class="hyzhc_shrk" id="txt_gsQQ" runat="server"
                        onblur="isQQ(this)" />
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
                    <input type="button" id="btnFilter" value="选择文件" style="height: 20px; width: 64px;
                        border-style: none; font-family: 宋体; font-size: 12px;" />
                    请上传小于5Mb的jpg\gif\png格式的图片
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    法定代表人：
                </td>
                <td>
                    <input name="txt_fddbr" maxlength="20" type="text" class="hyzhc_shrk" id="txt_fddbr"
                        runat="server" />
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
                    <input name="txt_zcrq" type="text" class="hyzhc_shrk" id="txt_zcrq" runat="server" />
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    注册资金（万元）：
                </td>
                <td>
                    <input name="txt_zczj" type="text" onblur="zczj(this)" class="hyzhc_shrk" id="txt_zczj" runat="server" />
                </td>
            </tr>
            <tr>
                <td height="40">
                    &nbsp;
                </td>
                <td>
                    资产总额（万元）：
                </td>
                <td>
                    <input name="txt_zcze" type="text" class="hyzhc_shrk" id="txt_zcze" runat="server"
                        onblur="zczeCheck(this);" />
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
                        <option value="外资">外资</option>
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
                    <input name="txt_khyh" type="text" class="hyzhc_shrk" id="txt_khyh" runat="server" />
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    单位类型：
                </td>
                <td>
                    <select runat="server" id="dwlx">
                        <option value="">请选择</option>
                        <option value="生产商">生产商</option>
                        <option value="分销商">分销商</option>
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
                    <input name="txt_zhmc" type="text" class="hyzhc_shrk" id="txt_zhmc" runat="server" />
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    银行账户：
                </td>
                <td>
                    <input name="txt_yhzh" type="text" class="hyzhc_shrk" id="txt_yhzh" runat="server"
                        onblur="yhzhCheck(this);" />
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
                        <%--<select id="s2" class="fu2" runat="server" value="<%=this.options[this.options.selectedIndex].text %>">
                            <option></option>
                        </select>--%>
                       <%-- <script type="text/javascript">
                            var s = ["s0", "s1", "s2"];
                            var opt0 = ["-区域-", "-省(市)-", "-地级市、区-"];
                            for (i = 0; i < s.length - 1; i++)
                                document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                            change(0);
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
                    <input maxlength="7" name="txt_qyrs" type="text" class="hyzhc_shrk" id="txt_qyrs"
                        runat="server" onblur="qyrsCheck(this);" />
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
                    <input name="txt_gsdz" style="color: #999" type="text" class="hyzhc_shrk" id="txt_gsdz"
                        runat="server" onblur="losefocus()" onfocus="getfocus(this)" value="请填写公司地址" />
                </td>
                <td>
                    <span class="xinghao">*</span>
                </td>
                <td>
                    公司电话：
                </td>
                <td>
                    <input name="txt_gsdh" type="text" style="color: #999" class="hyzhc_shrk" id="txt_gsdh"
                        runat="server" onblur="isTelePhone(this);" value="请填写区号+电话号码" onfocus="getfocus(this)" />
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
                    <input name="txt_gszy" maxlength="80" type="text" class="hyzhc_shrk" id="txt_gszy"
                        runat="server" onblur="gszyCheck(this)" />
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    公司邮编：
                </td>
                <td>
                    <input name="txt_gsyb" type="text" class="hyzhc_shrk" id="txt_gsyb" runat="server" />
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
                    <input name="txt_gscz" type="text" class="hyzhc_shrk" id="txt_gscz" runat="server" />
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
                    <textarea class="hyzhc_shrk2" cols="40" id="jyfw" name="txt_jyfw" rows="6" runat="server"></textarea>
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
                    <textarea class="hyzhc_shrk3" cols="40" id="txt_bz" name="txt_bz" rows="6" runat="server"></textarea>
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
                <td height="40" colspan="6">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="50">
                                <span class="xinghao">*</span>
                            </td>
                            <td width="120" height="40">
                                姓 名：
                            </td>
                            <td align="left">
                                <input name="txt_xm" type="text" class="hyzhc_shrk_2" id="txt_xm" runat="server" />
                            </td>
                            <td width="80">
                                <span class="xinghao">*</span>
                            </td>
                            <td width="60" height="40">
                                手 机：
                            </td>
                            <td align="left">
                                <input name="txt_sj" type="text" class="hyzhc_shrk_2" id="txt_sj" style="color: #999" onfocus="getiphone(this)"   onblur="isPhone(this)" runat="server" value="请输入手机号！" />
                            </td>
                            <td width="70">
                                &nbsp;
                            </td>
                            <td width="60">
                                邮 箱：
                            </td>
                            <td align="left">
                                <input name="txt_yx" style="color: #999" type="text" class="hyzhc_shrk_3" id="txt_yx"
                                    onblur="lose(this)" onfocus="getfocus(this)" runat="server" value="请注意邮箱格式" />
                            </td>
                            <td width="48">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
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
                    <%--<asp:ImageButton ID="Submit1" runat="server" ImageUrl="images/lijizhuce.gif" OnClientClick="getup()"
                        OnClick="Submit1_Click" />--%>
                        <%--<input type="image" name="Submit1" id="Submit1" src="images/lijizhuce.gif" onclick="getup();" >--%>
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/lijizhuce.gif" OnClientClick="getup()"
                        OnClick="Submit1_Click" />
                    <%--<input type="button" name="name" value="" onclick="getup()" style=" cursor:pointer; background-image:url(images/lijizhuce.gif); width:94px; height:36px;" />--%>
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
