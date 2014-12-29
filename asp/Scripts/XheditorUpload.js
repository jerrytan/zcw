/// <reference path="MyControl/MyControl.js" />

var editor;
function XHClose() {
    var height = $(window).height();
    var width = $(window).width();
    $("#divXh").attr("style", "width:700px;height:195px;");

    $("#ceng").fadeOut();
    $("#show").val("0");
}
function XHShow() {
    var height = $(window).height();
    var width = $(window).width();
    var divH = 500;//$("#divXh").height();
    var divW = 1000;//$("#divXh").width();
    var showHeight;
    var showWidth;
    if (height < divH) {
        showHeight = 0;
    } else {
        showHeight = (height - divH) / 2;
    }
    if (width < divW) {
        showWidth = 0;
    } else {
        showWidth = (width - divW) / 2;
    }
    $("#divXh").attr("style", "width:1000px; height: 500px; border: 1px solid blue; position:absolute; top:" + showHeight + "px; left:" + showWidth + "px;");
    $("#xhe0_iframearea").attr("style", "height:100%");
    $("#xhe0_container").children().attr("style", "height:100%");
    $("#ceng").attr("style", "background:#000;filter:alpha(opacity=20);position:absolute;top:0px; left:0px;width:" + width + "px; height:" + height + "px;z-index:10px;opacity:0.2");
    $("#ceng").fadeIn();
    $("#show").val("1");
}
function getXheditor() { 
//xheditor编辑设置
    $(pageInit);
    function pageInit() {
        var allPlugin = {
            Save: {
                c: 'save',
                t: '',
                //h: 1,
                e: function () {
                    //此处执Ajax行上传
                    if (editor.getSource() != "" && editor.getSource() != null) {
                        $.ajax({
                            type: 'get',
                            async: true, //是否同步
                            data: { 'clid': $("#myclid").val(), 'filedata': editor.getSource() },
                            url: "http://192.168.1.22/Ashx/DetailsHandler.ashx",
                            dataType: "jsonp", //数据类型为jsonp  
                            jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
                            success: function (data) {
                                if (data.state == "1") {
                                    MsgShow("保存成功！", true);
                                    //_this.hidePanel();
                                    XHClose();
                                } else if (data.state == "2") {
                                    MsgShow("保存失败！", false);
                                } else {
                                    alert("无数据");
                                }
                            }
                        });
                    } else {
                        alert("请输入内容！或者直接关闭！");
                    }
                    //});
                }
            },
            Close: {
                c: 'close',
                t: '',
                //h: 1,
                e: function () {
                    if ($("#show").val() == "0") {
                        $(".close").attr("style", "background: transparent url(Scripts/xheditor/small.gif) no-repeat 18px 50px;width: 50px;height: 18px;background-position: 1px 1px;border:0px;");
                        $("#drag").fadeIn();
                        XHShow();
                    } else {
                        $(".close").attr("style", "background: transparent url(Scripts/xheditor/big.gif) no-repeat 18px 50px;width: 50px;height: 18px;background-position: 1px 1px;border:0px;");
                        $("#drag").fadeOut();
                        XHClose();
                    }
                }
            },
            ImgUploadfy: {
                c: 'imgUploadfy',
                t: '',
                e: function () {
                    var _this = this;
                    var jTest = $('<div><label for="xheImgUrl" style=" float:left;"> 图片文件：</label> <input id="imgUrl" type="text" style="width: 105px;" tabindex="-1" value="http://" /> <input type="button" class="xheBtn" id="imgNewuploadify" tabindex="-1" style="float:left;"/></div><div style="padding: 0px;"><div style="margin: 1px 0px 2px 0px"><label for="xheImgAlt"> 替换文本:</label> <input type="text" id="xheImgAlt" style="width:169px;" value="" /></div><div style="margin: 1px 0px 2px 0px"><label for="xheImgWidth">&nbsp;宽&nbsp;&nbsp;度&nbsp;:</label><input type="text" id="xheImgWidth" style="width: 50px;" value=""><label for="xheImgHeight">&nbsp;高&nbsp;&nbsp;度&nbsp;:</label><input type="text" id="xheImgHeight" style="width: 50px;" value=""></div><div style="margin: 1px 0px 2px 0px"><label for="xheImgAlign">对齐方式:</label><select id="xheImgAlign" style=" width:54px; height:22px; font-size:5px;"><option selected="selected" value="">默认</option><option value="left">左对齐</option><option value="right">右对齐</option><option value="top">顶端</option><option value="middle">居中</option><option value="baseline">基线</option><option value="bottom">底边</option> </select><label for="xheImgBorder">&nbsp;边&nbsp;&nbsp;框&nbsp;:</label><input type="text" id="xheImgBorder" style="width: 50px;"></div><div style="text-align: right; margin: 2px 0px 0px 0px"><input type="button" id="imgSave" value="确定"><input type="button" id="imgCancel" value="取消"></div></div>');
                    var jTestInput = $('#xheTestInput', jTest),
                     jSave = $('#imgSave', jTest);
                    jCancel = $("#imgCancel", jTest);
                    jSave.click(function () {
                        //获取图片信息开始
                        var imgDialog = $(".xheDialog");
                        var url = imgDialog.children().eq(0).children().eq(1).val();
                        var alt = imgDialog.children().eq(1).children().eq(0).children().eq(1).val();
                        var width = imgDialog.children().eq(1).children().eq(1).children().eq(1).val();
                        var height = imgDialog.children().eq(1).children().eq(1).children().eq(3).val();
                        var align = imgDialog.children().eq(1).children().eq(2).children().eq(1).find("option:selected").val();
                        var border = imgDialog.children().eq(1).children().eq(2).children().eq(3).val();
                        var style = "";
                        if (alt != null && alt != "") {
                            style = style + 'alt="' + alt + '" ';
                        }
                        if (width != null && width != "") {
                            style = style + 'width="' + width + '" ';
                        }
                        if (height != null && height != "") {
                            style = style + 'height="' + height + '" ';
                        }
                        if (align != null && align != "") {
                            style = style + 'align="' + align + '" ';
                        }
                        if (border != null && border != "") {
                            style = style + 'border="' + border + '"';
                        }
                        var html = "";
                        if (url != null && url != "" && url != "http://") {
                            html = '<img src="' + url + '" ' + style + '  /><br />';
                        }
                        //获取图片信息结束
                        editor.appendHTML(html);
                        _this.loadBookmark();
                        //_this.pasteText(html);
                        _this.hidePanel();
                        return false;
                    });
                    jCancel.click(function () {
                        _this.hidePanel();
                    });
                    _this.saveBookmark();
                    _this.showDialog(jTest);
                    GetUploadfyImg();
                }
            }
        };
        editor = $('#elm').xheditor({
            plugins: allPlugin,
            //skin: 'o2007blue',
            tools: 'Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,SelectAll,Align,List,Outdent,Indent,Link,Unlink,ImgUploadfy,Hr,Emot,Table,Preview,Print,Removeformat,Source,Close,Save'
            //upImgUrl: '{editorRoot}http://192.168.1.22/Ashx/XheditorHandler.ashx?clid=' + $("#myclid").val() + '&uploadurl={editorRoot}http://192.168.1.22/Ashx/XheditorHandler.ashx%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png'
        });
    }

    SetBtn();
}

$(function () {
    //SetBtn();//设置设置保存按钮
    //Draggable();//拖动
    //$("#drag").fadeOut();//隐藏拖动


});

//拖动
function Draggable() {
    $("#divXh").draggable({ handle: "#drag" });
    $("div, #drag").disableSelection();
}

//设置自定义按钮
function SetBtn() {
    $("#xhe0_iframearea").attr("style", "height:100%");
    $("#xhe0_container").children().attr("style", "height:100%");
    $("[title='关于 xhEditor']").parent().attr("style", "display:none");
    //关闭按钮
    $("[cmd='Close']").parent().attr("style", "float:right;width: 50px;height: 18px;");
    $("[cmd='Close']").attr("style", "width: 50px;height: 18px;");
    $("[cmd='Close']").children().attr("style", "width: 50px;height: 18px;");
    //保存按钮
    $("[cmd='Save']").parent().attr("style", "float:right;width: 50px;height: 18px;");
    $("[cmd='Save']").attr("style", "width: 50px;height: 18px;");
    $("[cmd='Save']").children().attr("style", "width: 50px;height: 18px;");
}

//当浏览器窗口大小改变时，设置显示内容的高度
window.onresize = function () {
    if ($("#show").val() == "1") {
        XHShow();
    }
}

 //图片上传
function GetUploadfyImg() {
    $("#imgNewuploadify").uploadify({
        'height': '13',
        'width': '50',
        'uploader': 'http://192.168.1.22/Ashx/UploadifyHandler.ashx',
        'swf': 'Scripts/uploadify/uploadify.swf',
        'fileTypeExts': '*.jpg;*.jpeg;*.png;*.gif;',
        'fileTypeDesc': 'Image',
        'queueID': 'fileQueue', //上传进度条显示位置
        'buttonText': '上传',
        'queueSizeLimit': 5, //图片队列的最大数量
        'auto': true, //是否自动上传
        'multi': true, //是否允许选择多个文件
        'formData': {
            'action': 'imgxh',
            'clid': $("#myclid").val()
        },
        'onUploadSuccess': function (file, data, response) {
            //alert(data);
            $("#imgUrl").val(data);
        }
    });
    $(".uploadify").attr("style", "float:left; position:absolute;top:9px;right:11px; margin:0px;");
};