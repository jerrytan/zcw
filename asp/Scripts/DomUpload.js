/// <reference path="jquery-1.4.1.js" />

//图片上传
function GetImgFlash() {
    $("#imgUploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': 'Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.jpg;*.jpeg;*.png;*.gif',
        //'fileTypeDesc': '请选择文件',
        'queueID': 'imgQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': 5, //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'action': 'img',
            'clid': $("#myclid").val()
        },
        'onUploadSuccess': function (file, data, response) {
            var datas = data.split(',');
            $("#imgQ").children().remove();
            if (datas[0] == "0") {
                for (var i = 1; i < datas.length-1; i++) {
                    var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div style='background-image: url(" + datas[i] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'>...</div> </div>";
                    $("#imgQ").append(imghtml);
                }
                $("#mySecc").val("1");

            } else if (data == "1") {
                alert("上传失败！");
                $("#mySecc").val("2");
            } else if (datas[0] == "img") {
                alert("您最多只能上传五张材料相关图片！");
                $("#mySecc").val("2");
                $('#uploadify').uploadify('stop');
                for (var i = 1; i < datas.length - 1; i++) {
                    var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div style='background-image: url(" + datas[i] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'>...</div> </div>";
                    $("#imgQ").append(imghtml);
                }
                $("#mySecc").val("1");
            } else {
                alert(data);
            }
        },
        'onQueueComplete': function (event, data) {
            //上传成功
            if ($("#mySecc").val() == "1") {
                alert("上传完成!");
                $(".imgDel").click(function () {
                    if (confirm("是否删除该图片？")) {
                        var urlFile = $(this).parent().css("background-image");
                        var _this = $(this);
                        var clid = $("#myclid").val();
                        $.get("Ashx/UploadifyHandler.ashx", { 'action': 'imgdel', 'file': urlFile, 'clid': $("#myclid").val() }, function (data) {
                            var datas = data.split(',');
                            if (datas[0] == "0") {
                                _this.parent().parent().remove();
                                alert("删除成功！");
                                //return false;
                            } else if (data == "1") {
                                alert("删除失败！");
                            } else {
                                alert(data);
                                $("#mySecc").val(data);
                            }
                        });
                    }
                });
            } else {
                //上传失败
            }

        }
    });
}

//视频上传
function GetVideoFlash() {
    $("#videoUploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': 'Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.avi;*.rmvb;*.mp4;*.wmv;*.swf',
        //'fileTypeDesc': '请选择文件',
        'queueID': 'videoQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': 1, //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'action': 'vdo',
            'clid': $("#myclid").val(),
            'name': $("#videoName").val(),
            'msg': $("#videoMsg").val()
        },
        'onUploadSuccess': function (file, data, response) {
            var datas = data.split(',');
            if (datas[0] == "0") {
                $("#videoDelName").text(datas[1]);
                $("#btnDelNewVideo").click(function () {
                    if (confirm("是否删除？")) {
                        $.get("Ashx/UploadifyHandler.ashx", { 'action': 'videodel', 'clid': $("#myclid").val(), 'url': $("#videoDelName").text() }, function (data) {
                            if (data == "0") {
                                alert("删除成功！");
                                $("#domDelName").text("您还未上传文档！")
                            } else if (data == "1") {
                                alert("删除失败！");
                            }
                        });
                    }
                });
                alert("上传成功！");
            } else if (data == "0") {
                alert("上传失败！");
            } else if (data == "vdo") {
                alert("您最多只能上传一个材料相关视频！");
                $('#uploadify').uploadify('stop');
            } else {
                alert(data);
            }
        }
    });
}

//文档上传
function GetDomFlash() {
    $("#domUploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': 'Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.pdf;*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.txt;',
        //'fileTypeDesc': '请选择文件',
        'queueID': 'domQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': 1, //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'action': 'dom',
            'clid': $("#myclid").val(),
            'name': $("#domName").val(),
            'msg': $("#domMsg").val()
        },
        'onUploadSuccess': function (file, data, response) {
            var datas = data.split(',');
            if (datas[0] == "0") {
                $("#domDelName").text(datas[1]);
                $("#btnDelNewDom").click(function () {
                    if (confirm("是否删除？")) {
                        $.get("Ashx/UploadifyHandler.ashx", { 'action': 'domdel', 'clid': $("#myclid").val(), 'url': $("#domDelName").text() }, function (data) {
                            if (data == "0") {
                                alert("删除成功！");
                                $("#domDelName").text("您还未上传文档！")
                            } else if (data == "1") {
                                alert("删除失败！");
                            }
                        });
                    }
                });
                alert("上传成功！");
            } else if (data == "1") {
                alert("上传失败！");
            } else if (data == "dom") {
                alert("您最多只能上传一个材料相关文档！");
                $('#uploadify').uploadify('stop');
            } else {
                alert(data);
            }
        }
    });
}

function DomUpload() {
    //图片上传按钮
    GetImgFlash();
    $("#btnImgUploadfy").click(function () {
        $('#imgUploadify').uploadify('upload', '*')
    });
    //视频上传按钮
    GetVideoFlash();
    $("#btnVideoUploadfy").click(function () {
        if ($("#videoName").val() == null || $("#videoName").val() == "") {
            alert("请输入视频名称！");
            $('#btnVideoUploadfy').uploadify('cancel');
            return;
        } else {
            //GetVideoFlash();
            $('#videoUploadify').uploadify('upload', '*')
        }
    });
    //文档上传按钮
    GetDomFlash();
    $("#btnDomUploadfy").click(function () {
        if ($("#domName").val() == null || $("#domName").val() == "") {
            alert("请输入文档名称！");
            $('#domUploadify').uploadify('cancel');
            return;
        } else {
            $('#domUploadify').uploadify('upload', '*')
        }
    });
}


$(function () {
    $("#domName").focusout(function () {
        GetDomFlash();
    });

    $("#domMsg").focusout(function () {
        GetDomFlash();
    });
    $("#videoName").focusout(function () {
        GetVideoFlash();
    });

    $("#videoMsg").focusout(function () {
        GetVideoFlash();
    });


});


//获取删除图片事件
function ImgDel() {

}