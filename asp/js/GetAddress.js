$(function () {
    $.getJSON("../Ashx/GetAddress.ashx", { "action": "pro" }, function (data) {
        for (var i = 0; i < data.length; i++) {
            var html = "<option pro='" + data[i].省市地区编号 + "'>" + data[i].省市地区名称 + "</option>";
            $("#province").prepend(html);
        }
    });
    $("#province").change(function () {
        var pro = $("#province").children('option:selected').attr("pro");
        $("#city").children().remove();
        $.getJSON("../Ashx/GetAddress.ashx", { "action": "city", "pro": pro }, function (data) {
            var cityStr;
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    cityStr = data[i].省市地区名称;

                    var html = "<option pro='" + data[i].省市地区编号 + "'>" + cityStr + "</option>";
                    $("#city").prepend(html);
                }
            } else {
                $("#city").children().remove();
                $("#city").prepend("<option pro='10'>北京市</option>");
            }
        });
    });
});