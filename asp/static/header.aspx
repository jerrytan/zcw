<!--
        网页头部，用在所有不需要登录的页面
        文件名：header.aspx
        传入参数：无        
-->

    <div class="box">
    <div class="top"></div>
    <div class="logo">
        <a href="index.aspx">
            <img src="images/logo_03.jpg" /></a>
    </div>

    <div class="sous">
	    <form id="form1" name="form1" method="post" action="ss.aspx">
        <input name="sou" type="text" class="sou" />
		
		<!--
        <a href="ss.aspx">
            <img src="images/sss_03.jpg" /></a>	
        -->	
		
	    <img src="images/sss_03.jpg" onClick="javascript:fsubmit(document.form1);">
        </form>
    </div>

    <div class="anniu"><a href="gysdl.aspx" target="_blank">供应商登录</a></div>
    <div class="anniu"><a href="cgsgl.aspx" target="_blank">采购商登录</a></div>
	
	
	
	
	
	<script language="javascript">
    function fsubmit(obj)
	{
    obj.submit();
    }
 
    </script>


