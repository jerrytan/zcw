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
                    document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }


            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" +gys_id, true);
            xmlhttp.send();
        }
    </script>
</head>


<script runat="server"  > 
		
		
               protected DataTable dt = new DataTable(); //δ����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
              
               protected void Page_Load(object sender, EventArgs e)
               {  
                    
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    string sql = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id is null and ��λ���� ='������'";
                    SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "���Ϲ�Ӧ����Ϣ��");
                    dt = ds.Tables[0];	

			        string yh_id = Convert.ToString(Session["yh_id"]);                    
               }
	                  
        
    </script>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->



<form id="form1" >
  <div class="rlcs"><span class="rlcszi">������������Ϣ�Ѿ��ڱ�վ���������̣� ��������ͼ</span><img src="images/www_03.jpg" /></div>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">��ѯ���</span>
       <select name="gys" id="gyslist">
      <%foreach (System.Data.DataRow row in dt.Rows)
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
