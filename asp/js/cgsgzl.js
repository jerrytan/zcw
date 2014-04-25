$(function () {
    $("#btn").click(function () {
        $("#show").css("display", "block");
        $("#layer").css("display", "block");
    });
    $("#clos").click(function () {
        $("#show").css("display", "none");
        $("#layer").css("display", "none");
    });

    $("#btnSave").click(function () {
        var s = "";
        $("input[name='item']:checked").each(function () {
            s += $(this).val() + ",";
        });
        s = s.substr(0, s.length - 1);
        if (s.length > 0) {
            $("#hid").val(s);
            alert("已成功选择要进行关注的类别!!!");
        } else {
            alert("没有选择要进行关注的类别!!!");
        }
        $("#show").css("display", "none");
        $("#layer").css("display", "none");
    });
})