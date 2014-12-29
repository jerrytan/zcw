function MsgShow(msg, state) {
    ///	<summary>
    ///		自定义alert属性，建议最多四个字。
    ///	</summary>
    ///	<returns type="jQuery" />
    ///	<param name="msg" type="String">
    ///		提示信息
    ///	</param>
    ///	<param name="state" type="bool">
    ///		成功(true)或者失败(false)
    ///	</param>
    var width = $(window).width();
    var height = $(window).height();
    if (state == true) {
        $("body").append(' <div id="divMsg" style="width: 184px; height: 39px; float:left; position:absolute; top:' + (height - 47) / 2 + 'px; left:' + (width - 184) / 2 + 'px;"><div style="width: 184px; height: 47px;  background-color: #5B5D62; float: left; border-radius: 12px 12px; filter: alpha(opacity=20); opacity: 0.2;position:absolute; top:0px; left:0px;"></div><div style="width: 170px; height: 33px; background-color: White; float: left; border-radius: 8px 8px;  z-index:1000px; margin:7px;position:absolute; top:0px; left:0px; "><div id="state" style="width:33px; height:33px;float:left; margin-left:11px; background-image:url(Images/true.png);">   </div><div id="msg" style=" width:113px; height:33px; float:left; line-height:33px; padding-left:5px; font-family:楷体; font-size:17px; font-weight:bold; color:#5B5D62; text-align:center;">' + msg + '</div></div></div>');
        setTimeout(function () {
            $("#divMsg").remove();
        }, 2500);
    } else if (state == false) {
        $("body").append(' <div id="divMsg" style="width: 184px; height: 39px; float:left; position:absolute; top:' + (height - 47) / 2 + 'px; left:' + (width - 184) / 2 + 'px;"><div style="width: 184px; height: 47px;  background-color: #5B5D62; float: left; border-radius: 12px 12px; filter: alpha(opacity=20); opacity: 0.2;position:absolute; top:0px; left:0px;"></div><div style="width: 170px; height: 33px; background-color: White; float: left; border-radius: 8px 8px;  z-index:1000px; margin:7px;position:absolute; top:0px; left:0px; "><div id="state" style="width:33px; height:33px;float:left; margin-left:11px; background-image:url(Images/false.png);">   </div><div id="msg" style=" width:113px; height:33px; float:left; line-height:33px; padding-left:5px; font-family:楷体; font-size:17px; font-weight:bold; color:#5B5D62; text-align:center;">' + msg + '</div></div></div>');
        setTimeout(function () {
            $("#divMsg").remove();
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