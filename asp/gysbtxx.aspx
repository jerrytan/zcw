<!--
        ��Ӧ�̲�����Ϣҳ  
        �ļ���:  gysbtxx.aspx   
		���������s_yh_id  �û�id
        author:����ӱ
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ӧ�̲�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
   
</head>

<script runat="server">
	protected DataTable dt_yh = new DataTable();  //��Ӧ�̲�����Ϣ(�û���)  
	public string s_yh_id=""; 
	public string sSQL=""; 
	public DataConn objConn = new DataConn();      
	protected void Page_Load(object sender, EventArgs e)
	{            
	   if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
		{
			s_yh_id = Session["GYS_YH_ID"].ToString();
		}
		if(s_yh_id!="")
		{
			sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,�ֻ�,����,QQ����,����,�Ƿ���֤ͨ�� from �û��� where  yh_id='"+s_yh_id+"' ";
		    dt_yh = objConn.GetDataTable(sSQL); 	              
		}		            	
	}				   
</script>

<script language="javascript">

	 function Form_submit()
	 {
		
		if(document.form1.gys_name.value=="")
		{
			alert("��˾���Ʋ���Ϊ��,����д!");
			document.form1.gys_name.focus();
			return false;
		}
		else if(document.form1.gys_address.value=="")
		{
			alert("��˾��ַ����Ϊ��,����д!");
			document.form1.gys_address.focus();
			return false;
		}		
		else if(document.form1.gys_phone.value=="")
		{
			alert("��˾�绰����Ϊ��,����д!");
			document.form1.gys_phone.focus();
			return false;
		}
		else if(document.form1.user_name.value=="")
		{
			alert("������������Ϊ��,����д!");
			document.form1.user_name.focus();
			return false;
		}
		else if(document.form1.user_phone.value=="")
		{
			alert("����ֻ����벻��Ϊ��,����д");
			document.form1.user_phone.focus();
			return false;
		}
	 }
</script>


<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

<form name="form1" action="gysbtxx2.aspx" method="post" onsubmit="return Form_submit()">

<div class="gysgytb">

<div class="gysgybtl"><img src="images/www_03.jpg" /></div>
<div class="gysgybtr">
	<dl>

		<span id="msg" style=" font-size:14px;font-weight: 600; line-height:20px;">
		<%
		   if(dt_yh.Rows[0]["�Ƿ���֤ͨ��"].ToString()=="�����")
            {
                Response.Write("<font color='red'>�����ĵȺ�,�����������ύ,������˵��С�����");
			    Response.Write("<br>");
			    Response.Write("�ҷ�������Ա�ᾡ�������!</font>");
			    Response.Write("<br>");
			    Response.Write("<dd>");
			    Response.Write("������Ϣ����:");
			    Response.Write("</dd>");
			    Response.Write("<dt>");
			    Response.Write("</dt>");
            }
            else if(dt_yh.Rows[0]["�Ƿ���֤ͨ��"].ToString()=="ͨ��")
            {
                Response.Write("<font color='green'>��ϲ��!�����ͨ��,���Զ��������̽�������.</font>");				 
			    Response.Write("<br>");								 
			    Response.Write("<dd>");
			    Response.Write("������Ϣ����:");
			    Response.Write("</dd>");
			    Response.Write("<dt>");
			    Response.Write("</dt>");
            }
            else if(dt_yh.Rows[0]["�Ƿ���֤ͨ��"].ToString()=="��ͨ��")
            {
                Response.Write(">���δͨ��,�����������Ϣ!");
			    Response.Write("<br>");								 
			    Response.Write("<dd>");
			    Response.Write("������Ϣ����:");
			    Response.Write("</dd>");
			    Response.Write("<dt>");
			    Response.Write("</dt>");
            }                   
					 
		%>
		</span>
        <%if(dt_yh!=null&&dt_yh.Rows.Count>0) { %>
                <dd>��˾���ƣ�</dd> <dt><input name="gys_name" id="Text1" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["��˾����"] %>"  /><font color="red"><strong>*</strong></font></dt>
	            <dd>��˾��ַ��</dd>	<dt><input name="gys_address" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["��˾��ַ"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>��˾�绰��</dd> <dt><input name="gys_phone" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["��˾�绰"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>&nbsp;��˾��ҳ��</dd>  <dt><input name="gys_homepage" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["��˾��ҳ"] %>"/></dt>

	            <dd>&nbsp;��˾�ǣ�</dd>    
								            <dt>
									            <select name="scs_type" id="Select1" style="width: 120px; color: Blue">
                                                <%if(dt_yh.Rows[0]["����"].ToString()=="������" ){ %>
                                               
										            <option value="������" selected="selected">������</option>
										            <option value="������">������</option>      
                                               <%  }else if(dt_yh.Rows[0]["����"].ToString()=="������" ){%>   
                                                    <option value="������">������</option>
										            <option value="������" selected="selected">������</option>
                                              <%}else{ %>
                                                <option value="" selected="selected">--��ѡ��λ����--</option>
                                                 <option value="������">������</option>
										         <option value="������">������</option>
                                              <%} %>               
									            </select>
								            </dt>

	            <dd>����������</dd>    <dt><input name="user_name" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["����"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>�����ֻ���</dd>    <dt><input name="user_phone" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["�ֻ�"] %>"/><font color="red"><strong>*</strong></font></dt>
	            <dd>&nbsp;����QQ���룺</dd>  <dt><input name="user_qq" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["QQ����"] %>"/></dt>

        <%} 
        else
        {%>
	        <dd>��˾���ƣ�</dd>  <dt><input name="gys_name" id="gys_name" type="text" class="gysggg" value=""  /><font color="red"><strong>*</strong></font></dt>
	        <dd>��˾��ַ��</dd>  <dt><input name="gys_address" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>��˾�绰��</dd>  <dt><input name="gys_phone" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>&nbsp;��˾��ҳ��</dd>  <dt><input name="gys_homepage" type="text" class="gysggg" value=""/></dt>


	        <dd>&nbsp;��˾�ǣ�</dd>    
								        <dt>
									        <select name="scs_type" id="scs_type" style="width: 120px; color: Blue">
										        <option value="������">������</option>
										        <option value="������">������</option>                        
									        </select>
								        </dt>
	        <dd>����������</dd>    <dt><input name="user_name" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>�����ֻ���</dd>    <dt><input name="user_phone" type="text" class="gysggg" value=""/><font color="red"><strong>*</strong></font></dt>
	        <dd>&nbsp;����QQ���룺</dd>  <dt><input name="user_qq" type="text" class="gysggg" value=""/></dt>
      <% } %> 
	<!--
	<dd>��˾��Ӫҵִ�գ� </dd><dt><input name="gys_license" type="file" class="ggg" /> 
		<a href=""><img src="images/sc_03.jpg" /></a></dt>
	-->
		<input name="gysgys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
		<dd style="width:300px; color:Red">ע�⣺*�ŵ�Ϊ������,����Ϊ��!</dd>
		<dt style="width:80%; text-align:center;"><input style="width:74px;height:22px;background:url(/asp/images/aaaa_03.jpg) no-repeat;" type="submit" value="" /></dt>
		
	</dl>
</div>
</div>
</form>

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->
</body>
</html>
