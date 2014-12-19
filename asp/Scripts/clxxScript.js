/// <reference path="jquery-1.4.1.js" />
$(function () {
    GetDomVdoDom();//获取文档视频信息
    GetDetails();//获取详情页

});
function GetDomVdoDom() {
    $.getJSON("Ashx/clxxJsonHandler.ashx", { 'action': 'dv', 'clid': $("#myclid").val() }, function (data) {
        $("#domName").text(data.domName);
        $("#domTime").text(data.domTime);
        $("#videoName").text(data.videoName);
        $("#videoTime").text(data.videoTime);
        $("#videoDetails").html("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='900' height='500'><param name='movie' value='Scripts/flv/vcastr.swf'><param name='quality' value='high'><param name='allowFullScreen' value='true' /><param name='FlashVars' value='vcastr_file=" + data.videoFile + "&vcastr_title=" + data.videoName + "&BarColor=0x9F79EE&BarPosition=0' /><param value='transparent' name='wmode'><embed src='Scripts/flv/vcastr.swf' wmode='transparent' allowFullScreen='true' FlashVars='vcastr_file=" + data.videoFile + "&vcastr_title=" + data.videoName + "&BarColor=0x9F79EE&BarPosition=0' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='900' height='500'></embed></object>");


    });
}
function GetDetails() {
    $.get("Ashx/clxxsHandler.ashx", { 'action': 'des', 'clid': $("#myclid").val() }, function (data) {
        $("#domDetails").html(data);
    });
}