<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
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
				myCookie.Expires = DateTime.Now.AddDays(-10);
				Response.Cookies.Add(myCookie);
				Request.Cookies.Remove(cookieName);


				if (Session["CGS_YH_ID"] != null)
				{
					Session["CGS_YH_ID"] = null;
					Session.Remove("CGS_YH_ID");
				}
			}
			cookieName = "GYS_QQ_ID";
			if (Request.Cookies[cookieName] != null)
			{
				HttpCookie myCookie = new HttpCookie(cookieName);
				myCookie.Expires = DateTime.Now.AddDays(-10);
				Response.Cookies.Add(myCookie);
				Request.Cookies.Remove(cookieName);
			}
			if (Session["GYS_YH_ID"] != null)
			{
				Session["GYS_YH_ID"] = null;
				Session.Remove("GYS_YH_ID");

			}
			DelCookeis();
			Response.Redirect("index.aspx");             
        }  
     /// <summary>
     /// 小张添加  遍历删除cookie  QQ登陆后 注销时 QQde cookie有三个 
     /// </summary>
    public void DelCookeis()
    {

        foreach (string cookiename in  Request.Cookies.AllKeys)
        {
            HttpCookie cookies = Request.Cookies[cookiename];
            if (cookies != null)
            {
               cookies.Expires = DateTime.Today.AddDays(-1);
               Response.Cookies.Add(cookies);
               Request.Cookies.Remove(cookiename);
            }
        }    

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
s