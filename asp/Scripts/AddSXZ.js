/// <reference path="jquery-1.4.1.js" />
/// <reference path="MyControl/MyControl.js" />

//李宗鹏添加增加材料分类属性值开始----------------------------------------------------------------------
var tbody = $("#sx").children();
var len = parseInt($("#sx").children().length);
for (var i = 0; i < len; i++) {
    var newz = tbody.eq(i).children().eq(2).children().eq(0).val().replace(" ", "");
    tbody.eq(i).children().eq(2).children().eq(0).val(tbody.eq(i).children().eq(2).children().eq(0).val().replace(" ",""))
    var oldz = tbody.eq(i).children().eq(5).text().replace(" ","");
    if (newz != oldz) {
        var getThisData = { "flbm": $("#flbm").val(), "sxmc": tbody.eq(i).children().eq(0).text(), "ppid": $("#ppid").val(), "newz": newz, "i": i };
        $.ajax({
            url: "Ashx/AddclsxzHandler.ashx",
            type: "get",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            async: false,
            data: getThisData,
            success: function (data) {
                var strs = data.split("*");
                if (strs[0] == "0") {
                    MsgShow(strs[1]);
                    tbody.eq(parseInt(strs[3]));
                    tbody.eq(parseInt(strs[3])).children().eq(1).append(strs[2]);
                    tbody.eq(parseInt(strs[3])).children().eq(1).children("a:last-child").trigger("click");
                    $("[name='btnDocNew']").trigger("click");
                } else if (strs[0] == "1") {
                    MsgShow(strs[1]);
                }
            }
        });
    }
}

//李宗鹏添加增加材料分类属性值结束----------------------------------------------------------------------

function AddFLSXZ(obj) {
    var _this = $(obj).parent().parent();
    var oldz = _this.children().eq(5).text();
    var newz = $(obj).val();
    if (oldz != newz) {
        if (confirm("属性值:" + newz + "不存在；是否添加？")) {
            var getThisData = { "flbm": $("#flbm").val(), "sxmc": _this.children().eq(0).text(), "ppid": $("#ppid").val(), "newz": newz };
            $.ajax({
                url: "Ashx/AddclsxzHandler.ashx",
                type: "get",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                async: false,
                data: getThisData,
                success: function (data) {
                    var strs = data.split("*");
                    if (strs[0] == "0") {
                        MsgShow(strs[1]);
                        _this.children().eq(1).append(strs[2]);
                        _this.children().eq(1).children("a:last-child").trigger("click");

                    } else if (strs[0] == "1") {
                        MsgShow(strs[1]);
                    }
                }
            });
        } else {
            $(obj).val(oldz);
        }
    }
}