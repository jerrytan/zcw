<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QQ_dlyz.aspx.cs" Inherits="asp_QQ_dlyz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function isQQ(str) {
            var reg = /^\d{5,10}$/;
            if (!reg.test(str.value) && document.getElementById("user_qq").value != "") {
                alert("QQ号格式错误，请重新输入");
                document.getElementById("user_qq").focus();
            }
        }
        function load() {
            document.getElementById("gys_name").disabled = true;
            document.getElementById("gys_address").disabled = true;
            document.getElementById("gys_phone").disabled = true;
            document.getElementById("gys_homepage").disabled = true;
            document.getElementById("gslx").disabled = true;
            document.getElementById("user_name").disabled = true;
            document.getElementById("user_phone").disabled = true;
        }
    </script>
</head>
<body onload="load();">
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->
    <form id="form1" runat="server">
    <div class="gysgytb">
        <div class="gysgybtl">
            <img src="images/www_03.jpg"></div>
        <div class="gysgybtr">
            <dl>
                <dd>
                    <b>您的信息如下:</b></dd>
                <dt>&nbsp;</dt>
                <dd>
                    您的QQ号码：
                </dd>
                <dt>
                    
                    <input class="gysggg" id="user_qq" type="text"  name="user_qq" onblur="isQQ(this);"  runat="server"/>
                    <asp:ImageButton  id="btnCheck" Width="49" Height="25" runat="server" 
                        ImageUrl="images/yanzheng.jpg" onclick="btnCheck_Click" />
                   <%-- <img src="images/yanzheng.jpg" width="49" height="25" />--%>
                </dt>
                <dd>
                    公司名称：
                </dd>
                <dt>
                    <input id="gys_name" class="gysggg" type="text" name="gys_name" runat="server"/>
                </dt>
                <dd>
                    公司地址：
                </dd>
                <dt>
                    <input class="gysggg" id="gys_address" type="text" name="gys_address" runat="server"/></dt>
                <dd>
                    公司电话：
                </dd>
                <dt>
                    <input class="gysggg" id="gys_phone" type="text" name="gys_phone" runat="server"/></dt>
                <dd>
                    公司主页：
                </dd>
                <dt>
                    <input class="gysggg" id="gys_homepage" type="text" name="gys_homepage" runat="server"/>
                </dt>
                <dd>
                    公司类型：
                </dd>
                <dt>
                    <select id="gslx" style="width: 120px; color: blue" name="scs_type" runat="server">
                        <option  value="">请选择</option>
                        <option  value="生产商">生产商</option>
                        <option value="分销商">分销商</option>
                    </select>
                </dt>
                <dd>
                    您的姓名：
                </dd>
                <dt>
                    <input class="gysggg" id="user_name" type="text" name="user_name" runat="server"/></dt>
                <dd>
                    您的手机：
                </dd>
                <dt>
                    <input class="gysggg" id="user_phone" type="text" name="user_phone" runat="server"/></dt>
                <dd style="width: 300px; color: red">
                   <%-- 注意：*号的为必填项,不能为空!--%>
                </dd>
                <dt style="width: 80%;">
                     <%--<asp:ImageButton  id="btnSave" runat="server" ImageUrl="images/bbc_03.jpg" 
                         onclick="btnSave_Click" />--%>
                    <%--<img src="images/bbc_03.jpg" alt="" />--%>
                </dt>
            </dl>
        </div>
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
