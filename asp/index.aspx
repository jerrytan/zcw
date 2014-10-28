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
<title>�ڲ���-----������װ����ҵ�Ĺ�װ���Ͽ�͹�Ӧ����Ϣ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
</head>

<body>
 
    <!-- ͷ�� ��ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ�� ����-->

    <!-- ͷ������ include menu.ascx ��ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ͷ������ include menu.ascx ����-->

    <!-- ͷ����� static bannder.aspx ��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- ͷ����� static bannder.aspx ����-->

<!-- ��� ��ʼ-->
<div class="left">
    <!-- ��� ʮ���Ʒ top10product.ascx ��ʼ-->
    <uc3:top10product ID="top10product" runat="server" />
    <!-- ��� ʮ���Ʒ top10product.ascx ����-->

    <!-- ��� ʮ���� top10manu.ascx ��ʼ -->
    <uc2:Top10manu ID="Top10manu" runat="server" />
    <!-- ��� ʮ���� top10manu.ascx ���� -->
</div>
<!-- ��� ����-->

<div class="center">
    <!-- �м� �²��� newproducts.aspx  ��ʼ-->
    <!-- #include file="static/newproducts.aspx" -->
    <!-- �м� �²��� newproducts.aspx  ����-->

    <!-- �м� �������� clfx.ascx ��ʼ -->
    <uc5:clfx ID="clfx" runat="server" />
    <!-- �м� �������� clfx.ascx ��ʼ -->
</div>

<div class="right">
    <!-- �ұ� ʮ��Ʒ�� top10brand.ascx ��ʼ -->
    <uc4:top10brand ID="top10brand" runat="server" />
    <!-- �ұ� ʮ��Ʒ�� top10brand.ascx ���� -->

    <!-- �ұ� ��� static/ads.aspx ��ʼ-->
    <div class="right1">
        <!-- #include file="static/ads.aspx" -->
    </div>
    <!-- �ұ� ��� static/ads.aspx ����-->
</div>

    <!-- ���� ������Ʒrxcp.ascx ��ʼ -->
    <uc6:rxcp ID="rxcp" runat="server" />
    <!-- ���� ������Ʒrxcp.ascx ���� -->

    <!-- ���� �������� aboutus.aspx ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- ���� �������� aboutus.aspx ����-->

    <!-- β�� footer.aspx ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- β�� footer.aspx ����-->



<script type="text/javascript">
    var speed = 9//�ٶ���ֵԽ���ٶ�Խ��
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
