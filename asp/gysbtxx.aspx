<!--
        ��Ӧ�̲�����Ϣҳ  (δ��)
        �ļ���:  gysbuxx.aspx   
        
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
    <script>
        function formsubmit()
        {
            //alert("shit");
            document.getElementById("gysbtxx").submit();
        }
    </script>
</head>

<script runat="server">
        protected DataTable dt_yh = new DataTable();  //��Ӧ�̲�����Ϣ(�û���)            

        protected void Page_Load(object sender, EventArgs e)
        {            
			string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]); 	 //��ȡ�����û�id	 
			//String yh_id = "29"; 	 //��ȡ�����û�id	
            if(yh_id!="")
			{
              String str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,�ֻ�,����,QQ����,���� from �û��� where  yh_id='"+yh_id+"' ";
              SqlDataAdapter da_yh = new SqlDataAdapter(str_gysxx, conn);
			  DataSet ds_yh = new DataSet();
              da_yh.Fill(ds_yh, "�û���");
              dt_yh = ds_yh.Tables[0]; 
              
            }			
            	
        }
</script>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

<form action="gysbtxx2.aspx" method="post">

<div class="gytb">

<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>
<dd>��˾���ƣ�</dd>  <dt><input name="gys_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾����"] %>"  /></dt>
<dd>��˾��ַ��</dd>  <dt><input name="gys_address" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾��ַ"] %>"/></dt>
<dd>��˾��ҳ��</dd>  <dt><input name="gys_homepage" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾��ҳ"] %>"/></dt>
<dd>��˾�绰��</dd>  <dt><input name="gys_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾�绰"] %>"/></dt>

<dd>��˾�ǣ�</dd>    
<!--
<dt><input name="gys_type" type="radio" value="scs" checked>������  
    <input name="gys_type" type="radio" value="fxs" />������ </dt>
-->	
                            <dt>
						    <select name="scs_type" id="scs_type" style="width: 120px; color: Blue">
                            <option value="������">������</option>
                            <option value="������">������</option>                        
                            </select>
							</dt>

<dd>����������</dd>    <dt><input name="user_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["����"] %>"/></dt>
<dd>�����ֻ���</dd>    <dt><input name="user_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["�ֻ�"] %>"/></dt>
<dd>����QQ���룺</dd>  <dt><input name="user_qq" type="text" class="ggg" value="<%=dt_yh.Rows[0]["QQ����"] %>"/></dt>
<dd>��˾��Ӫҵִ�գ� </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>

</dl>
<span class="gybtan">
    
	<!--
	<%string yh_id = Convert.ToString(Session["yh_id"]);     //��ȡsession�е��û�id%>
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a>
	-->
	
	<input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
    <input type="submit" value="����" />
	</span></div>
	
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


</div>


</body>
</html>
