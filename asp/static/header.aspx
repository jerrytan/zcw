<!--
        网页头部，用在所有不需要登录的页面
        文件名：header.aspx
        传入参数：无
        owner:丁传宇 
		author：张新颖  修改登录 后显示 与登出问题
-->
   <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>

<script runat="server">
     public bool Logout()
        {
             bool b=false;
            HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  
            HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];          
            if(((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID != null ) && (cgs_yh_id != null)))
            {
                string cookieName = "CGS_QQ_ID";
	            if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }		            
		        if (Session["CGS_YH_ID"] != null) 
		        {
                    Session["CGS_YH_ID"]=null;
			        Session.Remove("CGS_YH_ID");
            		     
		        }
               b= true;
            }
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
                 string cookieName = "GYS_QQ_ID";
	            if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }		            
		        if (Session["GYS_YH_ID"] != null) 
		        {
			        Session.Remove("GYS_YH_ID");
            		     
		        }
                b= true;
            }
            return b;
        }

</script>

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
            //供应商登陆或者登出
			HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
            Object gys_yh_id = Session["GYS_YH_ID"];  
            HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            Object cgs_yh_id = Session["CGS_YH_ID"];          
			if (((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID == null ) || (cgs_yh_id == null)))
			{
    %>
                <div class="anniu"><a onclick='clickMe("gysdl.aspx")'>供应商登录</a></div>
                <div class="anniu"><a onclick='clickMe("cgsdl.aspx")'>采购商登录</a></div>

    <%      } 
            //采购商登录
            else if(((GYS_QQ_ID == null ) || (gys_yh_id == null ))&&((CGS_QQ_ID != null ) && (cgs_yh_id != null)))
            {
    %>
             <div class="anniu"><a onclick="QQ()">采购商登出</a></div>
    <%
            }
            //供应商登录
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
    %>
                 <div class="anniu"><a onclick="QQ()">供应商登出</a></div>
    <%
            }
    %>

        <script >

            function QQ_logout()
            {
                QC.Login.signOut();
            }
            function QQ()
            {
                QQ_logout();
                var b = '<%=Logout()%>';
                if (b)
                {
                    window.location.href = "index.aspx"; 
                }
            }
            function clickMe(url)
            {               
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
            function fsubmit(obj) {
                obj.submit();
            }

    </script>