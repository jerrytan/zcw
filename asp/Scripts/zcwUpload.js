//按钮样式
$(function () {
//    $("#btnUploadfy,#btnClear")
//			.button()
//			.click(function (event) {
//			    event.preventDefault();
//			});

    $("#btnUploadfy").click(function () {
        $('#uploadify').uploadify('upload', '*')
    });
});
//图片上传
$(document).ready(function () {
    $("#uploadify").uploadify({
        'height': '20',
        'width': '150',
        'uploader': 'Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.jpg;*.jpeg;*.png;*.gif;*.pdf;*.doc;*.avi;*.mp4;*.rmvb;',
        'fileTypeDesc': '请选择文件',
        'queueID': 'fileQueue', //上传进度条显示位置
        'buttonText': '浏览...',
        'queueSizeLimit': 5, //图片队列的最大数量
        'auto': false, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'path': '../temp/vedio'
        }
    });
});  