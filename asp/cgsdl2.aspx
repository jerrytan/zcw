<!--
        采购商QQ登陆页面（用于从QQ登录返回）
        文件名：cgsdl2.aspx
        传入参数：无
               
    -->

<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    public string yh_id = "";
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataConn objcon = new DataConn();
        string SQL = "select yh_id, QQ号码 from 用户表 where QQ号码='" + this.username.Value + "'";
        DataTable dt_yh = new DataTable();
        dt_yh = objcon.GetDataTable(SQL);
        yh_id = dt_yh.Rows[0]["yh_id"].ToString();
        Session["CGS_YH_ID"] = yh_id;
        if (dt_yh.Rows.Count > 0)
        {
            Response.Redirect("cgsgl.aspx");
        }
        else
        {
            Response.Write("<script>alert('您的账号未注册！');</" + "script>");
        }  
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title></title>

    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        charset="utf8" data-callback="true"></script>

</head>
<body>
   <%-- <%
        //Session["logout"] = null;
    %>--%>
<form>
   <%-- <script type="text/javascript">
        if (QC.Login.check()) {//如果已登录
            QC.Login.getMe(function(openId, accessToken) {
                //alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n！"));
                //alert("尊敬的供应商，您好，您已经用QQ号登陆成功，确认后自动返回。");
                //using cookie to store openId

                var cookieStr = "CGS_QQ_ID=" + openId;
                //alert(cookieStr);
                document.cookie = cookieStr;
                
                window.close();
                opener.close();
                opener.opener.location.href = "cgsgl_2.aspx";
            });
        }
    </script>--%>
    <span>QQ号码：</span><input type="text" id="username" runat="server" /><br /><br />
      <span>密码：</span><input type="text" id="Text1" runat="server" /><br />
    </div>
    <asp:Button ID="Button1" runat="server" Text="登录" onclick="Button1_Click" />
</form>
</body>
</html>
