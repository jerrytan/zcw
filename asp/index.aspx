<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Register Src="include/Top10manu.ascx" TagName="Top10manu" TagPrefix="uc2" %>
<%@ Register Src="include/top10product.ascx" TagName="top10product" TagPrefix="uc3" %>
<%@ Register Src="include/top10brand.ascx" TagName="top10brand" TagPrefix="uc4" %>
<%@ Register Src="include/clfx.ascx" TagName="clfx" TagPrefix="uc5" %>
<%@ Register Src="include/rxcp.ascx" TagName="rxcp" TagPrefix="uc6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
<title>众材网-----面向建筑装饰企业的公装材料库和供应商信息库</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
</head>

<body>
 
    <!-- 头部 开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部 结束-->

    <!-- 头部导航 include menu.ascx 开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 头部导航 include menu.ascx 结束-->

    <!-- 头部广告 static bannder.aspx 开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- 头部广告 static bannder.aspx 结束-->

<!-- 左边 开始-->
<div class="left">
    <!-- 左边 十大产品 top10product.ascx 开始-->
    <uc3:top10product ID="top10product" runat="server" />
    <!-- 左边 十大产品 top10product.ascx 结束-->

    <!-- 左边 十大厂商 top10manu.ascx 开始 -->
    <uc2:Top10manu ID="Top10manu" runat="server" />
    <!-- 左边 十大厂商 top10manu.ascx 结束 -->
</div>
<!-- 左边 结束-->

<div class="center">
    <!-- 中间 新材料 newproducts.aspx  开始-->
    <!-- #include file="static/newproducts.aspx" -->
    <!-- 中间 新材料 newproducts.aspx  结束-->

    <!-- 中间 材料文章 clfx.ascx 开始 -->
    <uc5:clfx ID="clfx" runat="server" />
    <!-- 中间 材料文章 clfx.ascx 开始 -->
</div>

<div class="right">
    <!-- 右边 十大品牌 top10brand.ascx 开始 -->
    <uc4:top10brand ID="top10brand" runat="server" />
    <!-- 右边 十大品牌 top10brand.ascx 结束 -->

    <!-- 右边 广告 static/ads.aspx 开始-->
    <div class="right1">
        <!-- #include file="static/ads.aspx" -->
    </div>
    <!-- 右边 广告 static/ads.aspx 结束-->
</div>

    <!-- 中下 热销产品rxcp.ascx 开始 -->
    <uc6:rxcp ID="rxcp" runat="server" />
    <!-- 中下 热销产品rxcp.ascx 结束 -->

    <!-- 中下 关于我们 aboutus.aspx 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 中下 关于我们 aboutus.aspx 结束-->

    <!-- 尾部 footer.aspx 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- 尾部 footer.aspx 结束-->



<script type="text/javascript">
    var speed = 9//速度数值越大速度越慢
    var demo = document.getElementById("demo");
    var demo2 = document.getElementById("demo2");
    var demo1 = document.getElementById("demo1");
    demo2.innerHTML = demo1.innerHTML
    function Marquee() {
        if (demo2.offsetWidth - demo.scrollLeft <= 0)
            demo.scrollLeft -= demo1.offsetWidth
        else {
            demo.scrollLeft++
        }
    }
    var MyMar = setInterval(Marquee, speed)
    demo.onmouseover = function () { clearInterval(MyMar) }
    demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }
</script>
<%--<script type=text/javascript><!--    //--><![CDATA[//><!--
    function menuFix() {
        var sfEls = document.getElementById("nav").getElementsByTagName("li");
        for (var i = 0; i < sfEls.length; i++) {
            sfEls[i].onmouseover = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseDown = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onMouseUp = function () {
                this.className += (this.className.length > 0 ? " " : "") + "sfhover";
            }
            sfEls[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
            }
        }
    }
    window.onload = menuFix;
    //--><!]]></script>--%>
</body>
</html>
