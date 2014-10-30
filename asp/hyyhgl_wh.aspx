<!--
        会员用户管理_维护页面
        文件名：hyyhgl.aspx
        传入参数：
        qq:QQ号码，name: 姓名，phone：手机号码，
        email：邮箱，state：状态     
        负责人:  苑伟业
-->
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hyyhgl_wh.aspx.cs" Inherits="asp_hyyhgl_wh" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>维护用户信息</title>
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function isQQ(str) {
            var reg = /^\d{5,10}$/;
            if (!reg.test(str.value) && document.getElementById("txt_QQ").value != "") {
                alert("QQ号格式错误，请重新输入");
                document.getElementById("txt_QQ").focus();
            }
            if (document.getElementById("txt_QQ").value == "") {
                alert("请输入有效的QQ号码");
                document.getElementById("txt_QQ").focus();
            }
        }
        function isPhone(str) {
            var reg = /^0?1[358]\d{9}$/;
            if (!reg.test(str.value) && document.getElementById("txt_phone").value != "") {
                alert("手机号格式错误，请重新输入");
                document.getElementById("txt_phone").focus();
            }
        }
        function yxCheck(str) {
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            if (!reg.test(str.value) && document.getElementById("txt_Email").value != "") {
                alert("请输入有效的邮箱地址");
                document.getElementById("txt_Email").focus();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="yhxx">
        <div id="yhxx_top">
            维护用户信息</div>
        <div class="yhxx_cont">
            <dl>
                <dd>
                    QQ号：</dd>
                <dt>
                    <label for="textfield">
                    </label>
                    <input name="QQ" type="text" class="shuru" id="txt_QQ" runat="server" onblur="isQQ(this)"/>
                    <span class="xinghao">*</span>
                </dt>
                <dd>
                    姓名：</dd>
                <dt>
                    <label for="textfield3">
                    </label>
                    <input type="text" name="txt_name" class="shuru" id="txt_name" runat="server"/>
                </dt>
                <dd>
                    手机号码：</dd>
                <dt>
                    <label for="textfield2">
                    </label>
                    <input type="text" name="txt_phone" class="shuru" id="txt_phone" runat="server" onblur="isPhone(this)"/>
                </dt>
                <dd>
                    邮箱：</dd>
                <dt>
                    <label for="textfield4">
                    </label>
                    <input type="text" name="txt_Email" class="shuru" id="txt_Email" runat="server" onblur="yxCheck(this)"/>
                </dt>
                <%if (Request.Cookies["GYS_QQ_ID"] != null)
                  { %>
                <dd>
                    角色权限：</dd>
                <dt id="dt">
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理生产商" id="cbx1" runat="server"/>
                        管理生产商</label>
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理分销商" id="cbx2" runat="server"/>
                        管理分销商</label>
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理材料信息" id="cbx3" runat="server"/>
                        管理材料信息</label><span class="xinghao">*</span></dt>
                        <%} %>
            </dl>
        </div>
        <div id="yhxx_bottom">
            <asp:Button ID="btnSubmit" runat="server" Text="提交" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" onclick="btnSubmit_Click" />
            <%--<input type="submit" name="btnDocNew" value="提交" 
                id="btnDocNew" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" />--%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%--<input type="submit" name="btnDocNew" value="取消" onclick="return VerifyMyIMP();"
                id="btnDocNew" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" />--%>
            <asp:Button ID="btnCancel" runat="server" Text="取消" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" onclick="btnCancel_Click"/>

        </div>
    </div>
    </form>
</body>
</html>
