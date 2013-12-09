<!--
	首页
	文件名：index.aspx
	传入参数：无
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Register Src="include/Top10manu.ascx" TagName="Top10manu" TagPrefix="uc2" %>
<%@ Register Src="include/top10product.ascx" TagName="top10product" TagPrefix="uc3" %>
<%@ Register Src="include/top10brand.ascx" TagName="top10brand" TagPrefix="uc4" %>
<%@ Register Src="include/clfx.ascx" TagName="clfx" TagPrefix="uc5" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <title>众材网-----面向建筑装饰企业的公装材料库</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
    <!-- 头部开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部结束-->


    <!-- 导航开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 导航结束-->


    <!-- banner开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner 结束-->

    <div class="left">

        <!-- top10产品开始-->
        <uc3:top10product ID="top10product" runat="server" />
        <!-- top 10产品 结束-->

        <!-- top10厂商开始-->
        <uc2:Top10manu ID="Top10manu" runat="server" />
        <!-- top 10产品 结束-->
    </div>


    <div class="center">
        <!-- 新产品开始-->
        <!-- #include file="static/newproducts.aspx" -->
        <!-- 新产品 结束-->
        
        <!-- 材料发现 开始-->
        <uc5:clfx ID="clfx" runat="server" />
        <!-- 材料发现 结束-->

    </div>



    <div class="right">
        <!-- 10大品牌 开始-->
        <uc4:top10brand ID="top10brand" runat="server" />
        <!-- 10大品牌 结束-->

        <div class="right1">
            <!--  右侧广告 开始-->
            <!-- #include file="static/ads.aspx" -->
            <!-- 右侧广告 结束-->
        </div>

    </div>


    <!--  热销产品 开始-->
    <!-- #include file="static/rxcp.aspx" -->
    <!-- 热销产品 结束-->

    <!--  关于我们 开始-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- 关于我们 结束-->


    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->


    </div>

    <!--  footer 开始-->
    <script type="text/javascript"><!--//--><![CDATA[//><!--
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
    //--><!]]></script>
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
    <script type="text/javascript"><!--//--><![CDATA[//><!--
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
    //--><!]]></script>
    <!-- footer 结束-->


</body>
</html>





