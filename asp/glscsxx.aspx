<!--      
	   ������������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glscsxx.aspx 
       �����������    
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
   <script type="text/javascript" language="javascript">
       $(document).ready(function () {
           $("#ckAll").click(function () {
               var v = $(this).attr("checked");  //��ȡ"ȫѡ��ѡ��"�Ƿ�ѡ�е�ֵ                 
               $(":checkbox.fxsfxk").attr("checked", v); //����class=ck�ĸ�ѡ���Ƿ�ѡ��
           });
           $(":checkbox.fxsfxk").click(function () {
               var a = $(":checkbox.fxsfxk").size(); //��ȡ���е�class=ck�ĸ�ѡ������                
               var b = $(":checkbox.fxsfxk:checked").size();
               var c = a == b;
               $("#ckAll").attr("checked", c);
           });

           //����ѡ��ظ�ѡ������ɾ��
           $("#btnDeleteBatch").click(function () {
               var count = $(":checkbox.fxsfxk:checked").size();
               if (count == 0) {
                   window.alert("��ѡ��ɾ����Ʒ��!");
                   return;
               }


               $(":checkbox.fxsfxk:checked").each(function () {
                   var tr = $(this).parent().parent();
                   $(tr).remove();


                   $("#btnDeleteBatch").val("0"); //����ֵ
                   var str = $("#btnDeleteBatch").val(); //��ȡֵ
                   //var data = { "str": str };
                   //window.alert(str);

                   // $.post("glsccsxxym.aspx/GetArray", str, function (answer) //ajax  û�ɹ�
                   //{
                   // if (answer == "ok") 
                   //{
                   //window.alert("�޸�ɾ���ɹ�!");
                   // }
                   //}, "json");
               });
           });
       });  
          
   
        		
   </script>
</head>


<script runat="server" >

        public class ScsInformotion
        {
            public string ScsName { get; set; }  //���� ��Ӧ������
            public string GysCode { get; set; }   //���� ��Ӧ��Id           
        }
        public List<ScsInformotion> Items { get; set; }
        protected DataTable dt = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			string gys_id = Request["gys_id"];
            String yh_id = Convert.ToString(Session["yh_id"]);
			if (Request.Form["companyname"] != null)
            {
                conn.Open();				
                string companyname = Request["companyname"];
                string address = Request["address"];
                string tel = Request.Form["tel"];
                string homepage = Request.Form["homepage"];
                string fax = Request["fax"];
                string area = Request["area"];
                string description = Request.Form["description"];
                string name = Request.Form["name"];
                string phone = Request.Form["phone"];                
                string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��='" + companyname + "',��ַ='" + address + "',�绰='" + tel + "',��ҳ='" + homepage + "',����='" + fax + "',��������='" + area + "',��ϵ��='" + name + "',��ϵ���ֻ�='" + phone + "' where gys_id='"+gys_id+"' ";
                SqlCommand cmd2 = new SqlCommand(sql, conn);
                int ret = (int)cmd2.ExecuteNonQuery();
                conn.Close();

            }
            string str = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ� from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
            SqlCommand cmd1 = new SqlCommand(str, conn);
            conn.Open();
			SqlDataReader reader1 = cmd1.ExecuteReader();
            while (reader1.Read())
            {
                this.companyname.Value = reader1["��Ӧ��"].ToString();
                this.address.Value = reader1["��ַ"].ToString();
                this.tel.Value = reader1["�绰"].ToString();
                this.homepage.Value = reader1["��ҳ"].ToString();
                this.fax.Value = reader1["����"].ToString();
                this.area.Value = reader1["��������"].ToString();
                this.name.Value = reader1["��ϵ��"].ToString();
                this.phone.Value = reader1["��ϵ���ֻ�"].ToString();

            }
            conn.Close();
							
			SqlDataAdapter adapter = new SqlDataAdapter("select Ʒ������,scs_id from Ʒ���ֵ� where �Ƿ�����='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds = new DataSet();
            adapter.Fill(ds, "Ʒ���ֵ�");
            dt = ds.Tables[0];       
			return;
          
           
             
            
        }

        protected string CsharpVoid1(string str) //ɾ�� ����ajax���÷��� ������
        {
		    string str1 = str ;
			
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);      			
            conn.Open();			
			string sql2 = "update  Ʒ���ֵ� set �Ƿ�����='0' where  pp_id='"+str1+"' ";
           
            SqlCommand cmd3 = new SqlCommand(sql2, conn);
            int ret = (int)cmd3.ExecuteNonQuery();			
            str = "���,�޸ĳɹ�!" ;
			return str;
        }
		
	
</script>

<body>

<!-- ͷ����ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ������-->


<%string gys_id = Request["gys_id"];%>
<form id="login" name="login" action="glscsxx.aspx?gys_id=<%=gys_id%>" method="post">
<div class="fxsxx">
<span class="fxsxx1">��˾����ϸ��Ϣ����</span>

<div class="fxsxx2">
 <dl>
       <dd>��˾���ƣ�</dd>
    <dt><input runat="server" name="companyname" type="text" id="companyname" class="fxsxx3"  /></dt>
     <dd>��˾��ַ��</dd>
    <dt><input runat="server" name="address" type="text" id="address" class="fxsxx3" /></dt>
     <dd>��˾�绰��</dd>
    <dt><input runat="server" name="tel" type="text" id="tel" class="fxsxx3" /></dt>
     <dd>��˾��ҳ��</dd>
    <dt><input runat="server" name="homepage" type="text" id="homepage" class="fxsxx3" /></dt>
     <dd>��˾���棺</dd>
    <dt><input runat="server" name="fax" type="text" id="fax" class="fxsxx3" /></dt>
     <dd>��˾������</dd>
    <dt><input runat="server" name="area" type="text" id="area" class="fxsxx3" /></dt>           
     <dd>��˾��飺</dd>
    <dt><textarea name="description" cols="" rows="" class="fgsjj" value="<%=Request.Form["description"] %>"></textarea></dt>
	
	
	<!--
     <dd>��˾logo��</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>��˾ͼƬ��</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
    
    -->



	<dd>��ϵ��������</dd>
    <dt><input runat="server" name="name" type="text" id="name" class="fxsxx3" /></dt>
     <dd>��ϵ�˵绰��</dd>
    <dt><input runat="server" name="phone" type="text" id="phone" class="fxsxx3" /></dt>

    
 </dl>
<span  class="fxsbc"><a href="#"><input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg" ></a></span>

<div class="ggspp">
<span class="ggspp1">��˾Ʒ������</span>
   <div><span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" id="ckAll" />ȫѡ</span></div>
		
		<% foreach (System.Data.DataRow row in dt.Rows){%> 
           <div class="fgstp"><img src="images/wwwq_03.jpg" /> 
           <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" /><%=row["Ʒ������"].ToString() %></span></div>

<%} %>
        
</div> 
</div>
</div>
</form>

</div>

	  <a runat="server" id="btnDeleteBatch" onclick="GetArray(124)" href="#">ɾ��ѡ��Ʒ��</a>
	  
      <span class="ggspp1" ><a href="xzpp.aspx?gys_id=61"  style="color:Red">����Ʒ��</a></span>


<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->




</div>



</body>
</html>
