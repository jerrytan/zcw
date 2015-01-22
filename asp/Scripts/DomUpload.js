/// <reference path="jquery-1.4.1.js" />



//图片上传
function GetImgFlash() {
    $("#imgUploadify").uploadify({
        // 'debug': true,
        'height': '20',
        'width': '150',
        'uploader': GetCrossDomain() + '/Ashx/UploadifyHandler.ashx',
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
                for (var i = 1; i < datas.length - 1; i++) {
                    imgid = datas[i].split('*');
                    var imgnamethis = imgid[0].split('//')[imgid[0].split('//').length - 1];
                    var imgnameall;
                    imgnameall = imgnamethis.split(".")[0];
                    if (imgnameall.length > 5) {
                        imgnameall = imgnameall.substring(0, 6);
                    }

                    var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div  imgid='" + imgid[1] + "' style='background-image: url(" + imgid[0] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'><a href='javascript:void(0)' title='" + imgnamethis + "'>" + imgnameall + "</a></div> </div>";
                    $("#imgQ").append(imghtml);
                }

                $("#mySecc").val("1");

            } else if (data == "1") {
                MsgShow("上传失败！", false);
                $("#mySecc").val("2");
            } else if (datas[0] == "img") {
                MsgShow("您最多只能上传五张材料相关图片！");
                $('#imgUploadify').uploadify('stop');
                $("#mySecc").val("2");
                for (var i = 1; i < datas.length - 1; i++) {
                    imgid = datas[i].split('*');
                    var imgnamethis = imgid[0].split('//')[imgid[0].split('//').length - 1];
                    var imgnameall;
                    imgnameall = imgnamethis.split(".")[0];
                    if (imgnameall.length > 5) {
                        imgnameall = imgnameall.substring(0, 6);
                    }

                    var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div  imgid='" + imgid[1] + "' style='background-image: url(" + imgid[0] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'><a href='javascript:void(0)' title='" + imgnamethis + "'>" + imgnameall + "</a></div> </div>";
                    $("#imgQ").append(imghtml);
                }
                imgDel();
            } else if (datas[0] == "imgMore") {
                MsgShow("您传的图片重复！");
                for (var i = 1; i < datas.length - 1; i++) {
                    imgid = datas[i].split('*');
                    var imgnamethis = imgid[0].split('//')[imgid[0].split('//').length - 1];
                    var imgnameall;
                    imgnameall = imgnamethis.split(".")[0];
                    if (imgnameall.length > 5) {
                        imgnameall = imgnameall.substring(0, 6);
                    }

                    var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div  imgid='" + imgid[1] + "' style='background-image: url(" + imgid[0] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'><a href='javascript:void(0)' title='" + imgnamethis + "'>" + imgnameall + "</a></div> </div>";
                    $("#imgQ").append(imghtml);
                }
            }
        },
        'onQueueComplete': function (event, data) {
            //上传成功
            if ($("#mySecc").val() == "1") {
                MsgShow("上传完成!", true);
                imgDel();
            } else {
                //上传失败
            }

        }
    });
}

//视频上传
function GetVideoFlash() {
    $("#videoUploadify").uploadify({
        //'debug': true,
        'height': '20',
        'width': '150',
        'fileSizeLimit': 0,
        'uploader': GetCrossDomain() + '/Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.avi;*.rmvb;*.mp4;*.wmv;*.swf',
        //'fileTypeDesc': '请选择文件',
        'queueID': 'videoQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': 1, //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': false, //是否允许选择多个文件
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

                MsgShow("上传成功！", true);
                $("#btnSaveVideoTitleAndMsg").css("display", "");
            } else if (data == "0") {
                MsgShow("上传失败！", false);
            } else if (data == "vdo") {
                MsgShow("您最多只能上传一个材料相关视频！");
                $('#videoUploadify').uploadify('stop');
            } else {
                MsgShow(data);
            }
        }
    });
}

//文档上传
function GetDomFlash() {
    $("#domUploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': GetCrossDomain() + '/Ashx/UploadifyHandler.ashx',
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

                MsgShow("上传成功！", true);

                $("#btnSaveDomTitleAndMsg").css("display", "");
            } else if (data == "1") {
                MsgShow("上传失败！", false);
            } else if (data == "dom") {
                MsgShow("您最多只能上传一个材料相关文档！");
                $('#domUploadify').uploadify('stop');
            } else {
                MsgShow(data);
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
            MsgShow("请输入视频名称！");
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
            MsgShow("请输入文档名称！");
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
        $('#domUploadify').uploadify('stop');
    });

    $("#domMsg").focusout(function () {
        GetDomFlash();
        $('#domUploadify').uploadify('stop');
    });
    $("#videoName").focusout(function () {
        GetVideoFlash();
        $('#videoUploadify').uploadify('stop');
    });

    $("#videoMsg").focusout(function () {
        GetVideoFlash();
        $('#videoUploadify').uploadify('stop');
    });
    delVideo();
    delDom();

});

$(document).ready(function () {
    //修改视频和文档信息按钮
    SaveTitleMsg();
    //修改材料信息
    if ($("#myclid").val() != "" && $("#myclid").val() != null) {



        $("#ceng").fadeOut(200);
        getXheditor();
        $("#xhe0_iframearea").attr("style", "height:100%");
        $("#xhe0_container").children().attr("style", "height:100%");
        SetBtn(); //设置设置保存按钮
        //        Draggable(); //拖动
        //        $("#drag").fadeOut(200);
        DomUpload();


        $.ajax({
            type: 'get',
            async: true, //是否同步
            data: { 'action': 'getAll', 'clid': $('#myclid').val() },
            url: GetCrossDomain() + "/Ashx/clxxJsonHandler.ashx",


            dataType: "jsonp", //数据类型为jsonp  
            jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
            //jsonpCallback: "success_jsonp",
            success: function (data) {
                var imgFile = data.imgFiles;
                var imgFiles = "";
                if (imgFile != null && imgFile != "") {
                    imgFiles = imgFile.split(",");
                }
                var domDes = data.domDetails;
                var domFile = data.domFile;
                var videoFile = data.videoFile;
                var videoName = data.videoName;
                //显示图片
                if ((imgFiles.length - 1) > 0) {
                    $("#imgQ").children().remove();
                }
                for (var i = 0; i < imgFiles.length - 1; i++) {
                    if (imgFiles[i] != "" && imgFiles[i] != null) {
                        imgid = imgFiles[i].split('*');

                        var imgnamethis = imgid[0].split('//')[imgid[0].split('//').length - 1];
                        var imgnameall;
                        imgnameall = imgnamethis.split(".")[0];
                        if (imgnameall.length > 5) {
                            imgnameall = imgnameall.substring(0, 6);
                        }
                        var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div  imgid='" + imgid[1] + "' style='background-image: url(" + imgid[0] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'><a href='javascript:void(0)' title='" + imgnamethis + "'>" + imgnameall + "</a></div> </div>";
                        $("#imgQ").append(imghtml);
                    }
                }
                imgDel();

                //显示已经上传的文档
                $("#domName").val(data.domName);
                $("#domDelName").text(domFile);
                $("#domMsg").val(data.DomSm);
                if (data.domFile != null && data.domFile != "") {
                    //启用保存标题和说明 按钮
                    $("#btnSaveDomTitleAndMsg").css("display", "");
                }
                //显示上传视频
                $("#videoDelName").text(videoFile);
                $("#videoName").val(videoName);
                $("#videoMsg").val(data.VideoSm);
                if (data.videoFile != null && data.videoFile != "") {
                    //启用保存标题和说明 按钮
                    $("#btnSaveVideoTitleAndMsg").css("display", "");
                }
                //显示详情
                editor.appendHTML(domDes);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("jsonp.error:" + textStatus);
            }
        });
        //获取多媒体信息
        $.getJSON(GetCrossDomain() + "/Ashx/clxxJsonHandler.ashx", { "action": "getAll", "clid": $("#myclid").val() }, function (data) {

        });
    }
});
//获取删除图片事件
function imgDel() {
    $(".imgDel").click(function () {
        if (confirm("是否删除该图片？")) {
            var imgid = $(this).parent().attr("imgid");
            $.ajax({
                type: 'get',
                async: true, //是否同步
                data: { 'action': 'imgdel', 'imgid': imgid, 'clid': $("#myclid").val() },
                url: GetCrossDomain() + "/Ashx/UploadifyHandler.ashx",


                dataType: "jsonp", //数据类型为jsonp  
                jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
                //jsonpCallback: "success_jsonp",
                success: function (data) {
                    //var datas = data.split(',');
                    if (data.state == "0") {
                        MsgShow("删除成功！", true);
                        $("#imgQ").children().remove();
                        var imgtemp = data.img;
                        var imgs = imgtemp.split(",");
                        for (var i = 0; i < imgs.length - 1; i++) {
                            imgid = imgs[i].split('*');
                            var imgnamethis = imgid[0].split('//')[imgid[0].split('//').length - 1];
                            var imgnameall;
                            imgnameall = imgnamethis.split(".")[0];
                            if (imgnameall.length > 5) {
                                imgnameall = imgnameall.substring(0, 6);
                            }

                            var imghtml = "<div style='width: 60px; height: 80px; border: 1px solid #DDDDDD; float: left; margin-left:2px; margin-top:2px;'><div  imgid='" + imgid[1] + "' style='background-image: url(" + imgid[0] + "); background-size: 60px 60px; width: 60px; height: 60px; float: left;'><a  class='imgDel' href='javascript:void(0);' style='background-image:url(images/shanchu.gif); width: 11px; height: 10px; float: right;'></a></div><div style='width: 60px; height: 20px; line-height: 20px; text-align: center; float: left;'><a href='javascript:void(0)' title='" + imgnamethis + "'>" + imgnameall + "</a></div> </div>";
                            $("#imgQ").append(imghtml);
                        }
                        imgDel();
                        //return false;
                    } else if (data.state == "1") {
                        MsgShow("删除失败！", false);
                    } else {
                        alert(data);
                        $("#mySecc").val(data);
                    }
                }
            });
        }
    });
}

//删除视频
function delVideo() {
    $("#btnDelNewVideo").click(function () {
        if (confirm("是否删除？")) {
            $.ajax({
                type: 'get',
                async: true, //是否同步
                data: { 'action': 'videodel', 'clid': $("#myclid").val(), 'url': $("#videoDelName").text() },
                url: GetCrossDomain() + "/Ashx/UploadifyHandler.ashx",
                dataType: "jsonp", //数据类型为jsonp  
                jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
                success: function (data) {
                    if (data.state == "0") {
                        MsgShow("删除成功！", true);
                        $("#btnSaveVideoTitleAndMsg").css("display", "none");
                        $("#videoDelName").text("您还未上传视频！")
                        $("#videoName").val("");
                        $("#videoMsg").val("");
                    } else if (data.state == "1") {
                        MsgShow("删除失败！", false);
                    }
                }
            });
        }
    });
}

//删除文档
function delDom() {
    $("#btnDelNewDom").click(function () {
        if (confirm("是否删除？")) {
            $.ajax({
                type: 'get',
                async: true, //是否同步
                data: { 'action': 'domdel', 'clid': $("#myclid").val(), 'url': $("#domDelName").text() },
                url: GetCrossDomain() + "/Ashx/UploadifyHandler.ashx",
                dataType: "jsonp", //数据类型为jsonp  
                jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
                success: function (data) {
                    if (data.state == "0") {
                        MsgShow("删除成功！", true);

                        $("#btnSaveDomTitleAndMsg").css("display", "none");
                        $("#domName").val("");
                        $("#domMsg").val("");
                        $("#domDelName").text("您还未上传文档！")
                    } else if (data.state == "1") {
                        MsgShow("删除失败！", false);
                    }
                }
            });
        }
    });
}

//修改标题和说明
function SaveTitleMsg() {
    $("#btnSaveDomTitleAndMsg").click(function () {
        var title = $("#domName").val();
        var msg = $("#domMsg").val();
        var url = $("#domDelName").text();
        $.ajax({
            type: 'get',
            async: true, //是否同步
            data: { 'action': 'editorDom', 'clid': $("#myclid").val(), 'title': title, 'msg': msg, 'url': url },
            url: GetCrossDomain() + "/Ashx/UploadifyHandler.ashx",
            dataType: "jsonp", //数据类型为jsonp  
            jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
            success: function (data) {
                if (data.state == "0") {
                    MsgShow("保存成功！",true);
                } else if (data.state == "1") {
                    MsgShow("保存失败！",false);
                }
            }
        });
    });

    $("#btnSaveVideoTitleAndMsg").click(function () {
        var title = $("#videoName").val();
        var msg = $("#videoMsg").val();
        var url = $("#videoDelName").text();
        $.ajax({
            type: 'get',
            async: true, //是否同步
            data: { 'action': 'editorVideo', 'clid': $("#myclid").val(), 'title': title, 'msg': msg, 'url': url },
            url: GetCrossDomain() + "/Ashx/UploadifyHandler.ashx",
            dataType: "jsonp", //数据类型为jsonp  
            jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
            success: function (data) {
                if (data.state == "0") {
                    MsgShow("保存成功！", true);
                } else if (data.state == "1") {
                    MsgShow("保存失败！", false);
                }
            }
        });
    });
}