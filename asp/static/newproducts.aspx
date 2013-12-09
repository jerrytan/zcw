<!--
        新材料,用于首页
        文件名：newproducts.aspx
        传入参数：无        
-->
<div class="qyjs">
    <script type="text/javascript">
        var imgUrl = new Array();
        var imgtext = new Array();
        var imgLink = new Array();

        imgUrl[1] = "images/ya.jpg";
        imgtext[1] = "山东明水农场完成大棚果蔬种植";
        imgLink[1] = escape("#");

        imgUrl[2] = "images/ay.jpg";
        imgtext[2] = "山东明水农场完成大棚果蔬种植";
        imgLink[2] = escape("#");

        imgUrl[3] = "images/ya.jpg";
        imgtext[3] = "山东明水农场完成大棚果蔬种植";
        imgLink[3] = escape("#");


        var focus_width1 = 536
        var focus_height2 = 227
        var text_height2 = 0
        var swf_height1 = focus_height2 + text_height2
        var pics = "", links = "", texts = "";
        for (var i = 1; i < imgUrl.length; i++) { pics = pics + ("|" + imgUrl[i]); links = links + ("|" + imgLink[i]); texts = texts + ("|" + imgtext[i]); }
        pics = pics.substring(1); links = links.substring(1); texts = texts.substring(1);
        document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="" width="' + focus_width1 + '" height="' + swf_height1 + '">');
        document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="images/js_hz.swf"><param name="quality" value="high"><param name="bgcolor" value="#f0f0f0"><param name="color" value="#ff0000">');
        document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
        document.write('<param name="FlashVars" value="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width1 + '&borderheight=' + focus_height2 + '&textheight=' + text_height2 + '">');
        document.write('<embed src="images/js_hz.swf" wmode="opaque" FlashVars="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width1 + '&borderheight=' + focus_height2 + '&textheight=' + text_height2 + '" menu="false" bgcolor="#F0F0F0" quality="high" width="' + focus_width1 + '" height="' + focus_height2 + '" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="" />');
        document.write('</object>');
    </script>
</div>

<span class="gd"><a href="#">查看更多材料...</a></span>
