$(function () {
    var ss = $(".content");
    function Load() {
        var name = $("#name").html(); //产品分类
        var pp = $(".content0 a.now").attr("val"); //品牌
        var sort = $("#sort li.active").attr("val"); //排序           
        var url = "ejfl.aspx?name=" + name + "&sort=" + sort + "&pp=" + pp;
        var classname = "";
        var id = "";
        var idstr = "";
        for (var i = 1; i <= ss.length - 1; i++) {
            classname = ".content" + i + " " + "a.now";
            id = $(classname).attr("val");
            idstr += id + "x";
        }
        idstr = idstr.substring(0, idstr.length - 1);
        url = url + "&ids=" + idstr;
        window.location.href = url;
    };

    //排序
    $("#sort li").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
        Load();
    });
    //Click
    for (var i = 0; i < ss.length; i++) {
        classname = ".content" + i + " a";
        $(classname).click(function () {
            $(this).addClass("now").siblings().removeClass("now");
            Load();

        });
    }

    //初始化
    var msgStr = $("#msgStr").html();
    var strs = msgStr.split(",");
    if (strs.length > 2) {
        //排序按钮的状态
        $("#sort").find("li").each(function () {
            if ($(this).attr("val") == strs[0]) {
                $(this).addClass("active");
            }
        });
        //其他属性值的状态
        for (var i = 0; i < ss.length; i++) {
            classname = ".content" + i;
            $(classname).find("a").each(function () {
                if ($(this).attr("val") == strs[i + 1]) {
                    $(this).addClass("now");
                }
            });
        };

        if ($("#btnMore") != null) {
            $("#more").css("display", "block");
        }

    } else {
        var classnameR = "";
        for (var i = 0; i < ss.length; i++) {
            classname = ".content" + i + " a[val=0]";
            classnameR = ".content" + i + " a[val!=0]";
            $(classname).addClass("now");
            $(classnameR).removeClass("now");
        };
        $("#sort li[val=0]").addClass("active");
        $("#sort li[val!=0]").removeClass("active");
    };

    //点击显示更多属性
    $("#btnMore").click(function () {
        if ($("#more").css("display") == "none") {
            $("#more").css("display", "block");
        } else {
            $("#more").css("display", "none");
        }
    });



    $("#ckAll").click(function () {//全选反选
        var flag = $("#ckAll").attr("checked");
        $("input[name='item']").each(function () {
            $(this).attr("checked", flag);
        });
    });
    $("input[name='item']").each(function () {
        $(this).click(function () {
            if ($("input[name='item']:checked").length == $("input[name='item']").length) {
                $("#ckAll").attr("checked", true);
            } else {
                $("#ckAll").attr("checked", false);
            }
        });
    });

    $("#collect").click(function () {//收藏
        var s = "";
        $("input[name='item']:checked").each(function () {
            s += $(this).val() + "x";
        });
        s = s.substr(0, s.length - 1);
        if (s != "") {
            var url = "sccl.aspx?cl_id=" + s;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        } else {
            alert("暂时无法收藏，请先选择要收藏的材料");
        }
    });
})