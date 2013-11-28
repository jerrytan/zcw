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

InsertBeforeEnd(u0LinksClick, "<div class='intcaselink' onmouseout='SuppressBubble(event)' onclick='u0Clicku14d1baefcb7a4d4ebee80b3e77df19d6(event)'>If login succeeds</div>");
function u0Clicku14d1baefcb7a4d4ebee80b3e77df19d6(e)
{

	SetPanelState('u5', 'pd0u5','none','',500,'none','',500);

	SetPanelVisibility('u5','','fade',500);
function waituc6f1b4a814fb4118b57afdec5c4f56111() {

	SetPanelVisibility('u5','hidden','none',500);

	parent.window.close();

    var reload = ParentWindowNeedsReload('供应商主页面.html');
	top.opener.window.location.href = $axure.globalVariableProvider.getLinkUrl('供应商主页面.html');
    if (reload) {
        top.opener.window.location = "resources/reload.html#" + encodeURI(top.opener.window.location.href);
    }
}
setTimeout(waituc6f1b4a814fb4118b57afdec5c4f56111, 1000);

	ToggleLinks(e, 'u0LinksClick');
}

InsertBeforeEnd(u0LinksClick, "<div class='intcaselink' onmouseout='SuppressBubble(event)' onclick='u0Clicku2039cf65ecf448c2be02e97a2aa3c881(event)'>If login fails</div>");
function u0Clicku2039cf65ecf448c2be02e97a2aa3c881(e)
{

	SetPanelState('u5', 'pd1u5','none','',500,'none','',500);

	SetPanelVisibility('u5','','none',500);
function waitu716a93de438046dba069ccefd71531601() {

	SetPanelVisibility('u5','hidden','none',500);
}
setTimeout(waitu716a93de438046dba069ccefd71531601, 1000);

	ToggleLinks(e, 'u0LinksClick');
}
gv_vAlignTable['u2'] = 'center';gv_vAlignTable['u3'] = 'top';