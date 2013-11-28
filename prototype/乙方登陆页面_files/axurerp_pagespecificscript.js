for(var i = 0; i < 4; i++) { var scriptId = 'u' + i; window[scriptId] = document.getElementById(scriptId); }

$axure.eventManager.pageLoad(
function (e) {

});
gv_vAlignTable['u3'] = 'center';
u1.style.cursor = 'pointer';
$axure.eventManager.click('u1', function(e) {

if (true) {

	parent.window.close();

    var reload = ParentWindowNeedsReload('乙方主页面.html');
	top.opener.window.location.href = $axure.globalVariableProvider.getLinkUrl('乙方主页面.html');
    if (reload) {
        top.opener.window.location = "resources/reload.html#" + encodeURI(top.opener.window.location.href);
    }

}
});
