/// <reference path="jquery-1.4.1.min.js" />
/// <reference path="MyControl/MyControl.js" />

$(function () {
    NoSkip();
    getFold();
    GetPage();
})
function NoSkip() {
    $(".levelone").click(function () {
        _this = $(this);
        var href = _this.attr("href");
        var strs = href.split("?")[1];
        strs = strs.split("&");
        var flbm = strs[0].split("=")[1];
        var flmc = strs[1].split("=")[1];
        if (flbm != $("#flbm").val() && flmc != $("#flmc").val()) {
            $("#pagesize").val("");
            $("#pageindex").val("");
            var getThisData = { "action": "levelonefl", "flbm": flbm };
            $.ajax({
                url: "Ashx/levelPage.ashx",
                type: "get",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                async: false,
                data: getThisData,
                success: function (data) {
                    $(".sc2").children().remove();
                    $(".sc2").append(data);
                    getFold();
                    $("#flbm").val(flbm);
                    $("#flmc").val(flmc);
                }
            });
            getclxx();
            return false;
        } else {
            return false;
        }

    });
}
//折叠脚本
function getFold() {
    var LanMu = $(".lanmu-list");
    var lanMuSun = LanMu.children('dd');
    if ((lanMuSun.size()) > 1) {
        LanMu.children("dd:gt(1)").hide();
        $(".listmore").show();
    }
    $(".listmore").bind("click", function () {
        if (!$(".listmore").hasClass('ListMoreOn')) {
            $(".listmore").addClass('ListMoreOn');
            LanMu.children("dd:gt(1)").slideDown();
            $(".listmore").html("折叠栏目 ↑")
        } else {
            $(".listmore").removeClass('ListMoreOn');
            LanMu.children("dd:gt(1)").slideUp();
            $(".listmore").html("查看更多 ↓");

        }
    })
}

//分页ajax
function getclxx() {
    var getThisData = { "action": "levelonecl", "flbm": flbm, "pageIndex": $("pageindex").val(), "pageSize": $("#pagesize").val() };
    $.ajax({
        url: "Ashx/levelPage.ashx",
        type: "get",
        contentType: "application/x-www-form-urlencoded; charset=gb2312",
        //async: false,
        data: getThisData,
        success: function (data) {

            alert("1");
        }
    });
}
function GetPage() {
    //    $(".paginator a").click(function () {
    //        return false;
    //    });
    $(".cpb").click(function () {
        return false;
    });
    $(".pageLink").click(function () {
        var _this = $(this);
        var page = _this.attr("href").split("?")[1];
        var pageUrl = page + "&action=getClxx&flbm=" + $("#flbm").val()+"&orderby="+$("#orderby").val();
        ajaxGetList(pageUrl);
        return false;
    });
}

//orderby排序
function orderby(obj, sign) {
    if (sign == "0") {
        changeOrder(obj);
        //MsgShow("默认排序", true);
        $("#orderby").val("cl_id");
        var pageUrl = "action=getClxx&flbm=" + $("#flbm").val() + "&orderby=" + $("#orderby").val();
        ajaxGetList(pageUrl);
    } else if (sign == "1" || sign == "2") {
        if ($(obj).css("border") != "1px solid rgb(228, 57, 60)") {
            changeOrder(obj);
            $(obj).css("font-weight", "bold").css("padding", "0 10px 0 0px");

            $(obj).children("b").attr("class", "orderb").attr("style", "");
            if (sign == "1") {
                //MsgShow("人气排序", true); 
                $("#orderby").val("js");
                var pageUrl = "action=getClxx&flbm=" + $("#flbm").val() + "&orderby=" + $("#orderby").val();
                ajaxGetList(pageUrl);
            } else if (sign == "2") {
                //MsgShow("最新排序", true);
                $("#orderby").val("updatetime");
                var pageUrl = "action=getClxx&flbm=" + $("#flbm").val() + "&orderby=" + $("#orderby").val();
                ajaxGetList(pageUrl);
            }
        } else {
            return false;
        }

    }
}
function changeOrder(obj) {
    $(obj).parent().children("dd").each(function () {
        $(this).css("border", "1px solid #CECBCE").css("background", "").css("padding", "");
        $(this).children("a").css("color", "#666666").css("font-weight", "normal").css("padding", "0 10px");
        $(this).children("b").attr("class", "").attr("style", "");
    });
    $(obj).css("border", "1px solid #E4393C")
                .css("background", "#E4393C")
                .children("a").css("color", "white");
}


function ajaxGetList(pageUrl) {
    $.getJSON("Ashx/levelPage.ashx", pageUrl, function (options) {
        $("#clbox").children().remove();
        $(".paginator").html("")
        var clxx = options.clList;
        var pageHtml = options.NavStr;
        for (var i = 0; i < clxx.length; i++) {
            var json = clxx[i];
            var html = "<div class='dlspxt'><a  href='clxx.aspx?cl_id=" + json.clid + "' target ='_blanck'><img class='dlspxtimg' width='150' height='150' src='" + GetCrossDomain() + "/" + json.存放地址 + "' /></a><div class='dlspxt1'><span class='dlsl'><a  href='clxx.aspx?cl_id=" + json.clid + "' target ='_blanck'>" + json.显示名 + "</a></span> <span class='dlsgg'>" + mysubstring(12, "规格:" + json.规格型号) + "</span> <span class='dlsgg'>品牌:" + json.品牌名称 + "</span> <span class='dlsgg2'><img src='images/yanzheng_1.gif' width='16' height='16' /><img src='images/yanzheng_2.gif' width='16' height='16' /><img src='images/yanzheng_3.gif' alt='' width='16' height='16' /></span> </div> </div>";
            $("#clbox").append(html);
        }
        $(".paginator").append(pageHtml);
        GetPage();
    });
}