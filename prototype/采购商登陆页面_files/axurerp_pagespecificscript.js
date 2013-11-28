for(var i = 0; i < 10; i++) { var scriptId = 'u' + i; window[scriptId] = document.getElementById(scriptId); }

$axure.eventManager.pageLoad(
function (e) {

});
gv_vAlignTable['u4'] = 'top';gv_vAlignTable['u7'] = 'center';gv_vAlignTable['u9'] = 'center';
u0.style.cursor = 'pointer';
$axure.eventManager.click('u0', u0Click);
InsertAfterBegin(document.body, "<div class='intcases' id='u0LinksClick'></div>")
var u0LinksClick = document.getElementById('u0LinksClick');
function u0Click(e) 
{
windowEvent = e;


	ToggleLinks(e, 'u0LinksClick');
}

InsertBeforeEnd(u0LinksClick, "<div class='intcaselink' onmouseout='SuppressBubble(event)' onclick='u0Clickucf2bc545925741fa86bf15174a82da1a(event)'>If login succeeds</div>");
function u0Clickucf2bc545925741fa86bf15174a82da1a(e)
{

	SetPanelState('u5', 'pd0u5','none','',500,'none','',500);

	SetPanelVisibility('u5','','fade',500);
function waitu1c0c23c63246422da25fddb557bf42061() {

	SetPanelVisibility('u5','hidden','none',500);

	parent.window.close();

    var reload = ParentWindowNeedsReload('采购商管理收藏页面.html');
	top.opener.window.location.href = $axure.globalVariableProvider.getLinkUrl('采购商管理收藏页面.html');
    if (reload) {
        top.opener.window.location = "resources/reload.html#" + encodeURI(top.opener.window.location.href);
    }
}
setTimeout(waitu1c0c23c63246422da25fddb557bf42061, 1000);

	ToggleLinks(e, 'u0LinksClick');
}

InsertBeforeEnd(u0LinksClick, "<div class='intcaselink' onmouseout='SuppressBubble(event)' onclick='u0Clicku7c73a6c4c0f241628fee0ff2879deb95(event)'>If login fails</div>");
function u0Clicku7c73a6c4c0f241628fee0ff2879deb95(e)
{

	SetPanelState('u5', 'pd1u5','none','',500,'none','',500);

	SetPanelVisibility('u5','','none',500);
function waitu6e0a9274833741408feafd3ffbcac6ef1() {

	SetPanelVisibility('u5','hidden','none',500);
}
setTimeout(waitu6e0a9274833741408feafd3ffbcac6ef1, 1000);

	ToggleLinks(e, 'u0LinksClick');
}
gv_vAlignTable['u2'] = 'center';gv_vAlignTable['u3'] = 'top';