$(function () {

    $("#ckAll").click(function () {//全选 反选
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

    $(".ppxz2").find("a").each(function () {//分类
        var t = $("#type").text();
        var ta = $(this).attr("href");
        ta = ta.substr(ta.lastIndexOf('=') + 1, 4);
        if (ta == t) {
            $(this).css("background-color", "#0033FF");
            $(this).css("color", "#fff");
        }
    });

    $(".dlspx").find("a").each(function () {//排序            
        var s = $("#sort").text();
        s = s.substr(s.length - 1, 1);
        var sa = $(this).attr("href");
        if (sa != null && sa != "") {
            sa = sa.substr(sa.lastIndexOf('&') - 1, 1);
        }
        if (sa == s) {
            $(this).parent("span").css("background-color", "#0033FF");
            $(this).css("color", "#fff");
        }
    });

});