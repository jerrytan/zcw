<!--
        ��Ӧ�̲�����Ϣҳ  
        �ļ���:  gysbtxx.aspx   
		���������s_yh_id  �û�id
        author:����ӱ
-->
<!-- 
����2014��8��13�գ�118�����if-else�ж��û�����
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" EnableEventValidation="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
<title>��Ӧ�̲�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />  
</head>
<script type="text/javascript" language="javascipt">
    function aa() {
        alert("adsfh");
    }
    function isPhone(str) {
        var reg = /^0?1[358]\d{9}$/;
        if (!reg.test(str.value) && document.getElementById("user_phone").value != "") {
            alert("�ֻ��Ÿ�ʽ��������������");
            document.getElementById("user_phone").focus();
        }
    }
    function yxCheck(str) {
        var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        if (!reg.test(str.value) && document.getElementById("user_email").value != "") {
            alert("��������Ч�������ַ");
            document.getElementById("user_email").focus();
        }
    }
</script>

<script runat="server">
	protected DataTable dt_yh = new DataTable();  //��Ӧ�̲�����Ϣ(�û���)  
	public string s_yh_id="";// <%--�û�id--%>
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
            sSQL="select ����,�ֻ�,QQ����,����,����,�Ƿ���֤ͨ�� from �û��� where yh_id='"+s_yh_id+"'";
		    dt_yh = objConn.GetDataTable(sSQL);              
		}		         
      
	}
   // <%--����2014��9��2��--%>
    protected void ImageButton3_Click(object sender, EventArgs e)	
    {
       if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
	    {
			s_yh_id = Session["GYS_YH_ID"].ToString();
		}
        if(this.user_phone.Value!="")
        {
            if(this.user_email.Value=="")
            {
                
                sSQL = "update �û��� set �ֻ�='" + this.user_phone.Value + "', ����=''  where yh_id='" + s_yh_id + "'";
                objConn.ExecuteSQLForCount(sSQL, true);
                Response.Write("<script>window.alert('��Ϣ�ѱ���ɹ�,�뷵�أ�');window.location.href='gyszym.aspx';</"+"script>"); 
            }
            else
            {
                sSQL = "update �û��� set �ֻ�='" + this.user_phone.Value + "', ����='"+ this.user_email.Value +"'  where yh_id='" + s_yh_id + "'";
                objConn.ExecuteSQLForCount(sSQL, true);
                Response.Write("<script>window.alert('��Ϣ�ѱ���ɹ�,�뷵�أ�');window.location.href='gyszym.aspx';</"+"script>"); 
            }
        }
       else
       {
           Response.Write("<script>window.alert('�������ֻ����룡');</"+"script>"); 
       }
     }
</script>

<body>
<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->
<form name="form1" runat="server">
<%--<div class="gysgytb">--%>
<div class="gysgybtr2">
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
               if(dt_yh.Rows[0]["����"].ToString()=="������")
               {			 
			      Response.Write("<br>");								 
			      Response.Write("<dd>");
			      Response.Write("������Ϣ����:");
			      Response.Write("</dd>");
			      Response.Write("<dt>");
			      Response.Write("</dt>");
                }
                else
                {			 
			       Response.Write("<br>");								 
			       Response.Write("<dd>");
			       Response.Write("������Ϣ����:");
			       Response.Write("</dd>");
			       Response.Write("<dt>");
			       Response.Write("</dt>");
                }
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
               <%if(dt_yh!=null&&dt_yh.Rows.Count>0)
                { %>

	            <dd>����������</dd>    <dt><input  name="user_name" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["����"] %>" disabled/><font color="red"><strong></strong></font></dt>
	            <dd>�����ֻ���</dd>    <dt><input id="user_phone"   name="user_phone" type="text" class="gysggg" onblur="isPhone(this)" value="<%=dt_yh.Rows[0]["�ֻ�"] %>"/><font color="red"><strong>*</strong></font></dt>
                <dd>���䣺</dd><dt><input id="user_email" name="user_email" class="gysggg" type="text" onblur="yxCheck(this)" value="<%=dt_yh.Rows[0]["����"] %>" /></dt>
	            <dd>����QQ���룺</dd><dt><input  name="user_qq" type="text" class="gysggg" value="<%=dt_yh.Rows[0]["QQ����"] %>" disabled/></dt>

           <%} 
        else
        {%>
	            <dd>������</dd>    <dt><input name="user_name" class="gysggg" value="<%=dt_yh.Rows[0]["����"]%>" disabled="disabled" type="text"/><font color="red"><strong></strong></font></dt>
	            <dd>�ֻ���</dd>    <dt><input id="user_phone" runat="server" name="user_phone" class="gysggg" value="" type="text" onblur="isPhone(this)"/><font color="red"/><strong>*</strong></font></dt>
                <dd>���䣺</dd><dt><input id="user_email" runat="server" name="user_email" class="gysggg" value="" type="text" onblur="yxCheck(this)"/></dt>
	            <dd>QQ���룺</dd><dt><input name="user_qq" class="gysggg" value="<%=dt_yh.Rows[0]["QQ����"] %>" disabled="disabled" type="text"/></dt>
                <% } %> 
                <dd style="width:300px; color:Red">ע�⣺*�ŵ�Ϊ������,����Ϊ��!</dd>
		<dt style="width:80%; text-align:center;">
        <asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="~/asp/images/aaaa_03.jpg"  Width="60px" Height="20px"  onclick="ImageButton3_Click"/></dt>
	</dl>
</div>
<%--</div>--%>
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
