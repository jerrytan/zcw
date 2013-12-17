<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>

<%

	String id = Convert.ToString(Request["id"]);
	//Response.Write(id);
	Response.Write("<option value = 0101>请选择子类</option>");
	if (id.Equals("01")) //东北 
	{
		Response.Write("<option value = 0101>北京</option><option value = 0102>天津</option><option value = 0103>河北</option>");
	}
	else if (id.Equals("02")){
		Response.Write("<option value = 0201>黑龙江</option><option value = 0202>吉林</option><option value = 0203>辽宁</option>");
	}
	else if (id.Equals("03")){
		Response.Write("<option value = 0301>上海</option><option value = 0302>江苏</option><option value = 0303>浙江</option>");
	}
		
%>
