
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
    var editor;
    $(pageInit);
    function pageInit() {
        var allPlugin = {
            Save: {
                c: 'save',
                t: '',
                //h: 1,
                e: function () {
                    var _this = this;
                    var jTest = $('<div style=" width:130px; height:53px; line-height:25px; text-align:center;font-size:11px;">&nbsp;是否保存?<br /><input type="button" id="btnSave" value="保存" />&nbsp;&nbsp;<input type="button" id="btnCancel" value="取消" /></div>');
                    _this.showPanel(jTest);
                    jSave = $('#btnCancel', jTest);
                    var btnSave = $('#btnSave', jTest);
                    jSave.click(function () {
                        _this.hidePanel();
                    });
                    btnSave.click(function () {
                        //此处执Ajax行上传
                        if (editor.getSource() != "" && editor.getSource() != null) {
                            $.post("Ashx/DetailsHandler.ashx", { 'clid': $("#myclid").val(), 'filedata': editor.getSource() }, function (data) {
                                if (data == "1") {
                                    alert("保存成功！");
                                    _this.hidePanel();
                                    XHClose();
                                } else if (data == "2") {
                                    alert("保存失败！");
                                } else {
                                    alert("无数据");
                                }
                            });
                        } else {
                            alert("请输入内容！或者直接关闭！");
                        }
                    });
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
            }
        };
        editor = $('#elm').xheditor({
            plugins: allPlugin,
            //skin: 'o2007blue',
            tools: 'Fontface,FontSize,Bold,Italic,Underline,Strikethrough,FontColor,BackColor,SelectAll,Align,List,Outdent,Indent,Link,Unlink,Img,Hr,Emot,Table,Preview,Print,Removeformat,Close,Save',
            upImgUrl: '{editorRoot}../../Ashx/XheditorHandler.ashx?clid=' + $("#myclid").val() + '&uploadurl={editorRoot}../../Ashx/XheditorHandler.ashx%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png'
        });
    }

}

$(function () {
    //SetBtn();//设置设置保存按钮
    Draggable();//拖动
    $("#drag").fadeOut();//隐藏拖动

    //$("#xhe0_iframearea").attr("style", "height:100%");
    //$("#xhe0_container").children().attr("style", "height:100%");

});

//拖动
function Draggable() {
    $("#divXh").draggable({ handle: "#drag" });
    $("div, #drag").disableSelection();
}

//设置自定义按钮
function SetBtn() {
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
