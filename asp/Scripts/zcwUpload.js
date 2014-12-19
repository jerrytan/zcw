/// <reference path="jquery-1.4.1.js" />


//按钮样式
$(function () {
    $("#btnUploadfy").click(function () {
        $('#uploadify').uploadify('upload', '*');
    });

});
//图片上传
$(document).ready(function () {
    GetFlash();
    $("input[name='ra']").click(function () {
        //alert("1");
        $("#myRo").val($("input[name='ra']:checked").val());
        GetFlash();
    });


    $("#vType").change(function () {
        if ($("#vType").children('option:selected').val() == "图片") {
            $("#myTypeExts").val("*.jpg;*.jpeg;*.png;*.gif");
            $("#myCount").val("5");
            $("#myAction").val("img");
            GetFlash();
        } else if ($("#vType").children('option:selected').val() == "视频") {
            $("#myTypeExts").val("*.avi;*.rmvb;*.mp4;*.wmv;*.swf");
            $("#myCount").val("1");
            $("#myAction").val("vdo");
            GetFlash();
        } else if ($("#vType").children('option:selected').val() == "文档") {
            $("#myTypeExts").val("*.pdf;*.doc;*.txt;");
            $("#myCount").val("1");
            $("#myAction").val("dom");
            GetFlash();
        } else {
            alert("Oh No");
        }

    });
});
function GetFlash() {
    $("#uploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': 'Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': $("#myTypeExts").val(),
        //'fileTypeDesc': '请选择文件',
        'queueID': 'fileQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': $("#myCount").val(), //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'action': $("#myAction").val(),
            'clid': $("#myclid").val(),
            'radio': $("#myRo").val()
        },
        'onUploadSuccess': function (file, data, response) {
            if (data == "0") {
                alert("上传成功！");
            } else if (data == "0") {
                alert("上传失败！");
            } else if (data == "img") {
                alert("您最多只能上传五张材料相关图片！");
                $('#uploadify').uploadify('stop');
            } else if (data == "video") {
                alert("您最多只能上传一个材料相关视频！");
                $('#uploadify').uploadify('stop');
            } else if (data == "dom") {
                alert("您最多只能上传一个材料相关文档！");
                $('#uploadify').uploadify('stop');
            } else {
                alert(data);
            }
        }
    });
}