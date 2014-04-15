<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>
    <script runat="server">
         protected void Page_Load(object sender, EventArgs e)
        {
            string cookieName="";
            cookieName = "CGS_QQ_ID";
	        if (Request.Cookies[cookieName] != null)
            {
                HttpCookie myCookie = new HttpCookie(cookieName);
                myCookie.Expires = DateTime.Now.AddDays(-10d);
                Response.Cookies.Add(myCookie);
            }	           

                Session["CGS_YH_ID"]=null;
			    Session.Remove("CGS_YH_ID");        		     

                cookieName = "GYS_QQ_ID";
	        if (Request.Cookies[cookieName] != null)
            {
                HttpCookie myCookie = new HttpCookie(cookieName);
                myCookie.Expires = DateTime.Now.AddDays(-10d);
                Response.Cookies.Add(myCookie);
            }		  

                Session["GYS_YH_ID"]=null;
			    Session.Remove("GYS_YH_ID");	
            Response.Redirect("index.aspx");
        }   
</script>
<script type="text/javascript">
    function QQ_logout()
    {
        QC.Login.signOut();
    }   
</script>
</head>
<body>
</body>
</html>
