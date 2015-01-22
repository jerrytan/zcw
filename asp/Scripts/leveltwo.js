/// <reference path="jquery-1.4.1.min.js" />

$(function () {
    GetPageList();
});

//获取分页数据
function GetPageList(pageflbm) {
    $(".cpb").click(function () { return false; });
    $(".pageLink").click(function () {
        GetList($("#allbm").val(), this);
        return false;
    });
}
//ajax获取数据
function GetList(pageflbm, obj) {
    var pageUrl = "action=leveltwogetList&flbm=" + $("#flbm").val() + "&orderby=" + $("#orderby").val();
    if (pageflbm != null) {
        pageUrl += ("&allbm=" + pageflbm);
    }
    if (obj != null) {
        pageUrl += ("&" + $(obj).attr("href").split("?")[1]);
    }

    $.getJSON("Ashx/levelPage.ashx", pageUrl, function (options) {
        $("#clbox").children().remove();
        $(".paginator").html("")
        var clxx = options.clList;
        var pageHtml = options.NavStr;
        for (var i = 0; i < clxx.length; i++) {
            var json = clxx[i];
            var html = "<div class='dlspxt'><a href='clxx.aspx?cl_id=" + json.clid + "' target ='_blanck'><img class='dlspxtimg' width='150' height='150' src='" + GetCrossDomain() + "/" + json.存放地址 + "' /></a><div class='dlspxt1'><span class='dlsl'><a href='clxx.aspx?cl_id=" + json.clid + "' target ='_blanck'>" + json.显示名 + "</a></span> <span class='dlsgg'>" + mysubstring(12, "规格:" + json.规格型号) + "</span> <span class='dlsgg'>品牌:" + json.品牌名称 + "</span> <span class='dlsgg2'><img src='images/yanzheng_1.gif' width='16' height='16' /><img src='images/yanzheng_2.gif' width='16' height='16' /><img src='images/yanzheng_3.gif' alt='' width='16' height='16' /></span> </div> </div>";
            $("#clbox").append(html);
        }
        $(".paginator").append(pageHtml);
        GetPageList();
    });
}
//获取筛选
function liveColor(obj) {
    $(obj).parent().children().css("color", "#0081CC");
    $(obj).parent().children().css("background-color", "");
    $(obj).css("color", "#FFFFFF");
    $(obj).css("background-color", "#0081CC");
    $("#allbm").val("");
    var allsxz = $(obj).parent().parent().parent();
    for (var i = 0; i < allsxz.children().length; i++) {
        var flsxzA = allsxz.children().eq(i).children().eq(1).children();
        for (var j = 0; j < flsxzA.length; j++) {
            //var aa=$(flsxzA[j]).attr("class");
            if (i == 0 && $(flsxzA[j]).attr("style") == "color: rgb(255, 255, 255); background-color: rgb(0, 129, 204);" && $(flsxzA[j]).attr("ppid") != "all") {
                $("#allbm").val($(flsxzA[j]).attr("ppid") + "*");
            } else {
                if ($(flsxzA[j]).attr("style") == "color: rgb(255, 255, 255); background-color: rgb(0, 129, 204);" && $(flsxzA[j]).attr("flsxzid") != "all" && $(flsxzA[j]).attr("ppid") != "all") {
                    $("#allbm").val($("#allbm").val() + "|" + $(flsxzA[j]).attr("flsxzid"));
                }
            }
        }
    }
    //重新获取数据
    GetList($("#allbm").val(), null);
}



//orderby排序
function orderby(obj, sign) {
    var flbm = $("#allbm").val();
    if (sign == "0") {
        changeOrder(obj);
        $("#orderby").val("cl_id");
        //MsgShow("默认排序", true);
        GetList(flbm, null);
    } else if (sign == "1" || sign == "2") {
        if ($(obj).css("border") != "1px solid rgb(228, 57, 60)") {
            changeOrder(obj);
            $(obj).css("font-weight", "bold").css("padding", "0 10px 0 0px");

            $(obj).children("b").attr("class", "orderb").attr("style", "");
            if (sign == "1") {
                $("#orderby").val("js");
                //MsgShow("人气排序", true);
                GetList(flbm, null);
            } else if (sign == "2") {
                $("#orderby").val("updatetime");
                //MsgShow("最新排序",true);
                GetList(flbm, null);
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