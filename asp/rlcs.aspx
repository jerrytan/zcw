<!--
      ���쳧��ҳ��
	  (���û����쳧�̺� �Ѷ�Ӧ���û�id��������Ĺ�Ӧ��(���Ϲ�Ӧ����Ϣ���yh_id))
	  �ļ���:  ���쳧��.aspx        
	  �������:��	   

     
--> 


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
               protected DataTable dt_wrl_gys = new DataTable(); //δ����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
               protected DataTable dt_yrl_gys= new DataTable(); //�Ѿ�����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	

               protected void Page_Load(object sender, EventArgs e)
               {  
                    
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    string str_wrl_gys = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id is null ";
                    SqlDataAdapter da_wrl_gys = new SqlDataAdapter(str_wrl_gys, conn);
                    DataSet ds_wrl_gys = new DataSet();
                    da_wrl_gys.Fill(ds_wrl_gys, "���Ϲ�Ӧ����Ϣ��");
                    dt_wrl_gys = ds_wrl_gys.Tables[0];	

			        string yh_id = Convert.ToString(Session["yh_id"]);    
                    
                    string str_yrl_gys = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id ='"+ yh_id+"'";
                    SqlDataAdapter da_yrl_gys = new SqlDataAdapter(str_yrl_gys, conn);
                    DataSet ds_yrl_gys = new DataSet();
                    da_yrl_gys.Fill(ds_yrl_gys, "���Ϲ�Ӧ����Ϣ��");
                    dt_yrl_gys = ds_yrl_gys.Tables[0];	                
               }
	                  
        
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
   <title>���쳧��ҳ��</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script language ="javascript">
        function send_request() 
        {
            var gys_list = document.getElementById("gyslist");
            var gys_id = gys_list.options[gys_list.selectedIndex].value;
            //alert(gys_id);

            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    alert(xmlhttp.responseText);
                    location.reload();
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }


            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" +gys_id, true);
            xmlhttp.send();
        }
    </script>
</head>




<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

<%
  if(dt_yrl_gys.Rows.Count > 0)  //�Ѿ�������Ĺ�Ӧ����
  {
  %>
    <div class="rlcs"><span class="rlcszi">���Ѿ��ڱ�վ����Ĺ�Ӧ������</span></div>
    <%foreach (System.Data.DataRow row in dt_yrl_gys.Rows)
      { %>
        <span class="rlcszi"><a href="gysxx.aspx?gys_id=<%=row["gys_id"].ToString()%>"><%=row["��Ӧ��"].ToString() %></a></span>
    <%} %>
    <div class="rlcs1">
  <%
  }
  
%>

<form id="form1" >
  <div class="rlcs"><span class="rlcszi">������������Ϣ�Ѿ��ڱ�վ���������̣� ��������ͼ</span><img src="images/www_03.jpg" /></div>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">��ѯ���</span>
       <select name="gys" id="gyslist">
      <%foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
      { %>
        <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString() %></span>
    <%} %>
       </select>

   <a  onclick="send_request()" ></div> <img src="images/rl_03.jpg" /></a>
     
  </div>

   <div class="rlcs4">
    <span class="rlcs7">�����û���ҵ���˾���������ύ��˾���ϣ��ҷ�������Ա����3���������������˹���������ͼ���£�</span>
    <span><img src="images/www_03.jpg" /></span>
    </div>
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



</div>


</body>
</html>
