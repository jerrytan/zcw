<%@ Register Src="~/asp/include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <!-- 头部2开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部2结束-->

    <!-- -->
    <div class="yhb">
        <div class="hyzhc_title">
            <ul>
                <li>注册步骤：</li>
                <li class="zhuce_red">1、选择注册身份</li>
                <li>2、填写注册信息</li>
                <li>3、注册成功</li>
            </ul>
        </div>
        <div class="shenfen">
            <dl>
                <dt><a href="gyszc.aspx">
                    <img alt="#" src="images/dengluren.gif" width="87" height="103" /></a></dt>
                <dd>
                    <a href="gyszc.aspx">供应商注册</a></dd>
            </dl>
            <dl>
                <dt><a href="cgszc.aspx">
                    <img alt="#" src="images/dengluren.gif" width="87" height="103" /></a></dt>
                <dd>
                    <a href="cgszc.aspx">采购商注册</a></dd>
            </dl>
        </div>
    </div>
    <!-- -->

    <!-- 用户信息 结束 -->
    <!-- 关于我们 广告服务 投诉建议 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 广告服务 投诉建议 结束-->
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
