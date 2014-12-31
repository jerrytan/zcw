function MsgShow(msg, state) {
    ///	<summary>
    ///		自定义alert信息属性
    ///	</summary>
    ///	<returns type="jQuery" />
    ///	<param name="msg" type="String">
    ///		提示信息
    ///	</param>
    ///	<param name="state" type="bool">
    ///		成功(true)或者失败(false),提示信息务必是四个字
    ///     如果不填写，可以多行显示提示信息
    ///	</param>
    var link = '<link id="link" href="../Scripts/MyControl/Style/MyControl.css" rel="stylesheet" />';
    $("head").append(link);
    var width = $(window).width();
    var height = $(window).height();
    if (state == true) {
        $("body").append(' <div id="divMsg" style="position:absolute; top:' + (height - 47) / 2 + 'px; left:' + (width - 184) / 2 + 'px;"><div class="msgIcon" style=""></div><div class="msgShow" style=""><div class="stateTrue" >   </div><div class="msg" style="">' + msg + '</div></div></div>');
        setTimeout(function () {
            $("#divMsg").remove();
            $("#link").remove();
        }, 2500);
    } else if (state == false) {
        $("body").append(' <div id="divMsg" style=" position:absolute; top:' + (height - 47) / 2 + 'px; left:' + (width - 184) / 2 + 'px;"><div class="msgIcon" style=""></div><div class="msgShow" style=""><div class="stateFalse" >   </div><div class="msg" style=" ">' + msg + '</div></div></div>');
        setTimeout(function () {
            $("#divMsg").remove();
            $("#link").remove();
        }, 2500);
    } else if (state == "" || state == undefined || state == null) {
        var width = $(window).width();
        var height = $(window).height();
        $("body").append('  <div id="divMsg" style="width: 184px; height: 39px; float: left; position: absolute; top: ' + (height - 39) / 2 + 'px; left: ' + (width - 184) / 2 + 'px;"><div class="hide" style="width: 184px; height:47px; background-color: #5B5D62; float: left; border-radius: 12px 12px;filter: alpha(opacity=20); opacity: 0.2; position: absolute; top: 0px; left: 0px;"></div><div class="msgShow" style="width: 170px; height: 25px; background-color: White; float: left; border-radius: 8px 8px; margin: 7px; position: absolute; top: 0px;left:0px;"> <div class="msg" style="width: 160px; height: auto; float: left; line-height: 17px;padding: 5px; font-family: 楷体; font-size: 15px; font-weight: bold; color: #5B5D62;text-align: center;">' + msg + '</div></div></div>');
        $(".msgShow").css("height", $(".msg").height() + 10 + "px");
        $(".hide").css("height", ($(".msgShow").height() + 14) + "px");
        $("#divMsg").css("height",$(".hide").height() + "px");
        $("#divMsg").css("top", (height - $("#divMsg").height()) / 2 + "px");

        setTimeout(function () {
            $("#divMsg").remove();
            $("#link").remove();
        }, 2500);
    }
};
$(window).resize(function () {
    var width = $(window).width();
    var height = $(window).height();
    $("#divMsg").css("top", (height - 47) / 2 + "px");
    $("#divMsg").css("left", (width - 184) / 2 + "px");
});
$(window).scroll(function () {
    $("#divMsg").css("top", ($(window).height() - 47) / 2 + ($(window).scrollTop()) + "px");
});