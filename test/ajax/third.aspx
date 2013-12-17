<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>

<%

	String id = Convert.ToString(Request["id"]);
	//Response.Write(id);
	
	if (id.Equals("0101")) //北京 
	{
		Response.Write("北京属性  <input type=input value = 010101>东城");
	}
	else if (id.Equals("0201")) //东北
	{
		Response.Write("黑龙江属性  <input type=input value = 010101>东城");
	}
	else if (id.Equals("0301")) //上海
	{
		Response.Write("上海属性  <input type=input value = 010101>东城");
	}
		
%>
