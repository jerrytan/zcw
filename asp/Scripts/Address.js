/// <reference path="jquery-1.8.3.js" />
/// <reference path="../Ashx/GetAddress.ashx" />

$(function () {
    $.get("Ashx/GetAddress.ashx", { "action": "pro" }, function (data) {
        var json = eval('(' + data + ')');
        for (var i = 0; i < json.length; i++) {
            var html = "<option pro='" + json[i].省市地区编号 + "'>" + json[i].省市地区名称 + "</option>";
            $("#s0").prepend(html);
        }
        $("#s0").children(":last").attr("selected", "selected");
    });
    $("#s0").change(function () {
        var pro = $("#s0").children('option:selected').attr("pro");
        $("#s1").children().remove();
        $.getJSON("Ashx/GetAddress.ashx", { "action": "city", "pro": pro }, function (data) {
            var cityStr;
            if (data.length != 0) {
                for (var i = 0; i < data.length; i++) {
                    cityStr = data[i].省市地区名称;

                    var html = "<option pro='" + data[i].省市地区编号 + "'>" + cityStr + "</option>";
                    $("#s1").prepend(html);
                }
                $("#region").val($("#s0").children('option:selected').val() + $("#s1").children(':last').val());
                $("#s1").children(":last").attr("selected", "selected");
            } else {
                $("#s1").children().remove();
                $("#region").val($("#s0").children('option:selected').val());
            }
        });
    });
});
