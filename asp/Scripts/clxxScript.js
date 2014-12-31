/// <reference path="jquery-1.4.1.js" />
$(function () {

    GetDomVdoDom();//获取文档视频信息
    GetDetails();//获取详情页
});

function GetDomVdoDom() {
    $.ajax({
        type: 'get',
        async: true, //是否同步
        data: { 'action': 'dv', 'clid': $("#myclid").val() },
        url: "http://192.168.1.22:88/Ashx/clxxJsonHandler.ashx",
        dataType: "jsonp", //数据类型为jsonp  
        jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
        success: function (data) {
            //        $("#domShow").text(data.domFile);

            

            

            if (data.domFile == null || data.domFile == "") {
                $("#two2").css("display", "none");
            } else {
                $("#domName").text(data.domName);
                $("#domTime").text(data.domTime);
                $('#domShow').FlexPaperViewer({
                    config: {

                        SWFFile: "http://192.168.1.22:88/" + data.domFile, //swf路径

                        jsDirectory: "Scripts/flexpaper/FlexPaperViewer.swf", //设置FlexPaperViewer.swf的路径
                        Scale: 0.6, //初始化缩放比例，参数值应该是大于零的整数
                        ZoomTransition: 'easeOut', //Flexpaper中缩放样式，它使用和Tweener一样的样式，默认参数值为easeOut.其他可选值包括: easenone, easeout, linear, easeoutquad
                        ZoomTime: 0.5, //从一个缩放比例变为另外一个缩放比例需要花费的时间，该参数值应该为0或更大
                        ZoomInterval: 0.2, //缩放比例之间间隔，默认值为0.1，该值为正数。
                        FitPageOnLoad: false, //初始化得时候自适应页面，与使用工具栏上的适应页面按钮同样的效果。
                        FitWidthOnLoad: true, //初始化的时候自适应页面宽度，与工具栏上的适应宽度按钮同样的效果。
                        FullScreenAsMaxWindow: false, //当设置为true的时候，单击全屏按钮会打开一个flexpaper最大化的新窗口而不是全屏，当由于flash播放器因为安全而禁止全屏，而使用flexpaper作为独立的flash播放器的时候设置为true是个优先选择。
                        ProgressiveLoading: true, //当设置为true的时候，展示文档时不会加载完整个文档，而是逐步加载，但是需要将文档转化为9以上的flash版本（使用pdf2swf的时候使用-T 9 标签）。
                        MaxZoomSize: 5, //设置最大的缩放比例。
                        MinZoomSize: 0.2, //最小的缩放比例。
                        SearchMatchAll: false, //设置为true的时候，单击搜索所有符合条件的地方高亮显示。
                        InitViewMode: 'Portrait', //设置启动模式如"Portrait" or "TwoPage"
                        RenderingOrder: 'flash,html',
                        StartAtPage: '2', //从第几页开始显示

                        ViewModeToolsVisible: true, //工具栏上是否显示样式选择框。
                        ZoomToolsVisible: true, //工具栏上是否显示缩放工具。
                        NavToolsVisible: true, //工具栏上是否显示导航工具。
                        CursorToolsVisible: true, //工具栏上是否显示光标工具。
                        SearchToolsVisible: true, //工具栏上是否显示搜索。
                        FullScreenVisible: true, //工具栏上是否显示全屏按钮。

                        //此项无效，flash中已经完全去除打印按钮
                        //                PrintToolsVisible: true,
                        //                PrintPaperAsBitmap: true,
                        //                PrintEnabled: true,
                        //                AutoAdjustPrintSize: true,

                        WMode: 'window',
                        localeChain: "zh_CN"//设置地区（语言），目前支持以下语言。en_US (English) fr_FR (French) zh_CN (Chinese, Simple) es_ES (Spanish) pt_BR (Brazilian Portugese) ru_RU (Russian) fi_FN (Finnish) de_DE (German) nl_NL (Netherlands) tr_TR (Turkish) se_SE (Swedish) pt_PT (Portugese) el_EL (Greek) da_DN (Danish) cz_CS (Czech) it_IT (Italian) pl_PL (Polish) pv_FN (Finnish) hu_HU (Hungarian)
                    }
                });
            }
            if (data.videoFile == null || data.videoFile == "") {
                $("#two3").css("display","none") ;
            } else {
                $("#videoName").text(data.videoName);
                $("#videoTime").text(data.videoTime);
                $("#videoDetails").html("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='900' height='500'><param name='movie' value='Scripts/flv/vcastr.swf'><param name='quality' value='high'><param name='allowFullScreen' value='true' /><param name='FlashVars' value='vcastr_file=" + "http://192.168.1.22:88/" + data.videoFile + "&vcastr_title=" + data.videoName + "&BarColor=0x9F79EE&BarPosition=0' /><param value='transparent' name='wmode'><embed src='Scripts/flv/vcastr.swf' wmode='transparent' allowFullScreen='true' FlashVars='vcastr_file=" + "http://192.168.1.22:88/" + data.videoFile + "&vcastr_title=" + data.videoName + "&BarColor=0x9F79EE&BarPosition=0' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='900' height='500'></embed></object>");
            }
        }
    });



//    $.getJSON("Ashx/clxxJsonHandler.ashx", { 'action': 'dv', 'clid': $("#myclid").val() }, function (data) {
//        
//    });
}
function GetDetails() {
    $.ajax({
        type: 'get',
        async: true, //是否同步
        data:  { 'action': 'des', 'clid': $("#myclid").val() },
        url: "http://192.168.1.22:88/Ashx/clxxsHandler.ashx",
        dataType: "jsonp", //数据类型为jsonp  
        jsonp: "jsoncallback", //服务端用于接收callback调用的function名的参数  
        success: function (data) { 
            $("#domDetails").html(data.state);
        } 
    });
}
function SwfShow(file) {
    
}