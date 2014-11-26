
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<script runat="server">  
    protected void Page_Load(object sender, EventArgs e)
    { 
        string str=Request.QueryString["action"].ToString();
        Response.Write(str);
        
    }
</script>