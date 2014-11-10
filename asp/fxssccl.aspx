<%@ Import Namespace="System.Data" %>
<%@ Page Language="C#"%>

<script runat="server">
 DataConn objConn = new DataConn();
 protected void Page_Load(object sender, EventArgs e)
 {
     string cl_id = "";
     if (Request["cl_id"]!=null&&Request["cl_id"].ToString()!="")
     {
         cl_id = Request["cl_id"].ToString();
     }
     while (cl_id.EndsWith(","))
     {
         cl_id = cl_id.Substring(0, cl_id.Length - 1);
     }
     
 }
    </script>
