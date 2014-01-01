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
            <img src="images/sss_03.jpg" onclick="javascript:fsubmit(document.form1);">
        </form>
    </div>
    <%
			HttpCookie QQ_id = Request.Cookies["QQ_id"];
            Object logout = Session["logout"];
            
			if ((QQ_id == null ) || (QQ_id != null && logout!= null ))
			{
    %>
    <div class="anniu"><a onclick=clickMe("gysdl.aspx")>供应商登录</a></div>
    <div class="anniu"><a onclick=clickMe("cgsdl.aspx")>采购商登录</a></div>
    <%      }else {%>
    <div class="anniu">
        <a onclick=clickMe("gysdc.aspx")>供应商登出</a>
    </div>
    
    <div class="anniu">
         <a onclick=clickMe("gysdc.aspx")>采购商登出</a>
    </div>
   
    <%		}%>
        <script>
            function clickMe(url) {
                //var url = "cgsdl.aspx";
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
            function fsubmit(obj) {
                obj.submit();
            }

    </script>
