<!--
        网页头部，用在所有不需要登录的页面
        文件名：header.aspx
        传入参数：无
        owner:丁传宇 
		author：张新颖  修改登录 后显示 与登出问题
-->
   <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>

<div class="box">
    <div class="top"></div>
    <div class="logo">
        <a href="index.aspx">
            <img src="images/logo_03.jpg" /></a>
    </div>
    <div class="hydl_an">
        <a href="hyzcsf.aspx"><img src="images/anniu_hyzc.jpg" width="96" height="30" /></a>
    </div>
    <div class="sous">
        <form id="form1" name="form1" method="get" action="ss.aspx">
            <%string keyWord=Request["sou"];%>            
            <input name="sou" type="text" class="sou" value="<%=keyWord%>"/>          
            <input type="submit" name="btnSubmit" value="" style="background:url('images/sss_03.jpg');width:96px;height:28px;margin-top:1px;cursor:pointer;" />
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
             <div class="anniu"><a  href="QQ_out.aspx" target="_self">采购商登出</a></div>
			 <div class="anniu"><a  href="cgsgl_2.aspx" target="_self">采购商主页面</a></div>
    <%
            }
            //供应商登录
            else if(((CGS_QQ_ID == null ) || (cgs_yh_id == null))&&((GYS_QQ_ID != null ) && (gys_yh_id != null )))
            {
    %>
                 <div class="anniu"><a href="QQ_out.aspx" target="_self">供应商登出</a></div>
				 <div class="anniu"><a href="gyszym.aspx" target="_self">供应商主页面</a></div>
    <%
            }
    %>
 <script type="text/javascript">

            function clickMe(url)
            {
                window.open(url, "", "height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
            function fsubmit(obj) {
                obj.submit();
            }

    </script>

