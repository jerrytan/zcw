<!--      
	   ������������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glscsxx.aspx 
       �����������
       author:����ӱ    
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>������������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
  
</head>

  <script type="text/javascript" language="javascript">
  //����2014��8��14�գ�û�з����̵Ĳ���Ȩ�ޣ����Բ���Ҫ���޸ĺ���
//      function Update(id)
//      {
//          if (window.XMLHttpRequest)
//          {
//              xmlhttp = new XMLHttpRequest();
//          }
//          else
//          {
//              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//          }
//          xmlhttp.onreadystatechange = function ()
//          {
//              if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//              {
//                  document.getElementById("scs_PP").innerHTML = xmlhttp.responseText;
//              }
//          }
//          xmlhttp.open("GET", "glfxsxx4.aspx?id=" + id + "&lx=scs", true);
//          xmlhttp.send();
//      }
      function Update_scs(id)
      { 
          if (window.XMLHttpRequest)
          {
              xmlhttp = new XMLHttpRequest();
          }
          else
          {
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.onreadystatechange = function () {

              if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                  var array = new Array();           //��������
                  array = xmlhttp.responseText;     //�����滻���ص�json�ַ���

                  var json = array;
                  var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			

                  if (myobj.length == 0) {
                      document.getElementById('companyname').value = "";       //��Ӧ��
                      document.getElementById('address').value = "";        //��ַ
                      document.getElementById('tel').value = "";                //�绰  			 
                      document.getElementById('homepage').value = "";       //��ҳ
                      document.getElementById('fax').value = "";                 //����
                      document.getElementById('area').value = "";               //��������
                      document.getElementById('name').value = "";               //��ϵ��
                      document.getElementById('phone').value = "";        //��ϵ�˵绰 
                      document.getElementById('sh').style.visibility = "hidden";
                      if (id != "0") {
                          if (confirm("����������δ��д��ϸ��Ϣ,�Ƿ��")) {
                              window.location.href = "grxx.aspx?gxs_id=" + id + "&lx=scs";
                          }
                      }
                  }
                  for (var i = 0; i < myobj.length; i++) {  //����,��ajax���ص�������䵽�ı�����				

                      document.getElementById('companyname').value = myobj[i].gys_name;       //��Ӧ��
                      document.getElementById('address').value = myobj[i].gys_address;        //��ַ
                      document.getElementById('tel').value = myobj[i].gys_tel;                //�绰  			 
                      document.getElementById('homepage').value = myobj[i].gys_homepage;       //��ҳ
                      document.getElementById('fax').value = myobj[i].gys_fax;                 //����
                      document.getElementById('area').value = myobj[i].gys_area;               //��������
                      document.getElementById('name').value = myobj[i].gys_user;               //��ϵ��
                      document.getElementById('phone').value = myobj[i].gys_user_phone;          //��ϵ�˵绰
                      document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax���صĹ�Ӧ��id	������ύʱʹ��	
                      if (myobj[i].sh == "�����") {
                          document.getElementById('sh').style.visibility = "visible";
                      }
                      else {
                          document.getElementById('sh').style.visibility = "hidden";
                      }
                  }

              }
          }
          xmlhttp.open("GET", "glscsxx3.aspx?id=" + id, true);
          xmlhttp.send();
          if (window.XMLHttpRequest)
          {
              xmlhttp1 = new XMLHttpRequest();
          }
          else
          {
              xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp1.onreadystatechange = function ()
          {
              if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
              {
                  var array1 = new Array();           //��������
                  array1 = xmlhttp1.responseText;     //�����滻���ص�json�ַ���
                  var json1 = array1;
                  var myobj1 = eval(json1);              //�����ص�JSON�ַ���ת��JavaScript���� 	
                  var s = "";
                  for (var j = 0; j < myobj1.length; j++)
                  {  //����,��ajax���ص�������䵽�ı�����				

                      s += "<div class='fgstp'><image src='images/wwwq_03.jpg'/>";
                      s += "  <span class='fdlpp1'>";
                      s += " <a href='ppxx.aspx?pp_id=" + myobj1[j].pp_id + "' class='fxsfxk'>" + myobj1[j].ppmc + "</a></span></div>";
                  }
                  document.getElementById("ppxx").innerHTML = s;
              }
          }
          xmlhttp1.open("GET", "glscsxx3.aspx?id=" + id + "&lx=ppxx", true);
          xmlhttp1.send();
      }

      function AddNewBrand(id)
      {
          var url = "xzpp.aspx?gys_id=" + id;
          window.open(url, "", "height=300,width=300,status=no,location=no,toolbar=no,directories=no,menubar=no");
      }
      function DeleteBrand(id) {
          var r = confirm("��ȷ������ɾ����Ʒ��!");
          if (r == true)
          {
              var brands = document.getElementsByName("brand");
              var ppid;
              ppid = "";
              for (var i = 0; i < brands.length; i++)
              {
                  if (brands[i].checked)
                  {

                      ppid += brands[i].value + ",";
                  }
              }
              var url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=1";
              window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
          }
      }
      function bj(id)
      {
         var ppid= document.getElementById("ppid").value;
         var ppmc = document.getElementById("ppmc").value;
         var url = "xzpp.aspx?gys_id=" + id + "&pp_id=" + ppid + "&ppmc=" + ppmc;        
          window.open(url, "", "height=300,width=300,status=no,location=no,toolbar=no,directories=no,menubar=no");
      }
      function ck(obj,ppmc,ppid)
      {
          var brands = document.getElementsByName("brand");
          if (obj.checked)
          {
              for (var i = 0; i < brands.length; i++)
              {
                  brands[i].checked = false;
              }
              obj.checked = true;
              document.getElementById("ppid").value = ppid;
              document.getElementById("ppmc").value = ppmc;
          }
          else
          {
              document.getElementById("ppid").value = "";
              document.getElementById("ppmc").value = "";
          }
         
      }
      function companyname_onclick() {

      }

      function homepage_onclick() {

      }

  </script>   
  <script runat="server">
        protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        public DataTable dt_ppxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        public string gys_id="";
        public DataConn objConn=new DataConn();
        public string sSQL="";
        public string s_yh_id = "";
        public string sp_result="";                 //�������
        public DataTable dt_gysxxs = new DataTable();
        public string gys_type = "";                  //��λ����  
        public string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {           
            if (Request["gys_id"]!=null)
            {
                gys_id = Request["gys_id"].ToString();//��ȡ��Ӧ��id
            }
            if (Session["GYS_YH_ID"] != null)
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
                if (gys_id=="")
                {
                    string sql = "select dw_id from �û��� where yh_id='" + s_yh_id + "' ";
                    gys_id = objConn.DBLook(sql);
                }
            }
             
            sSQL = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,��λ���� from ���Ϲ�Ӧ����Ϣ�� where gys_id='" + gys_id + "'  ";
             dt_gysxx = objConn.GetDataTable(sSQL);
                DataTable dt_type = objConn.GetDataTable(sSQL);
                if(dt_type!=null&&dt_type.Rows.Count>0)
                {
			       gys_type = dt_type.Rows[0]["��λ����"].ToString();                        
                }
                if (gys_type.Equals("������"))
                {                     
                    sSQL = "select Ʒ������,pp_id from Ʒ���ֵ� where   scs_id='" + gys_id + "' ";
                    dt_ppxx = objConn.GetDataTable(sSQL);                     
                }
                    
                if (gys_id != "")
                {                    
                    DWLX(gys_type, gys_id, gys_id);
                }
                 
        }
      
        protected void DWLX(string str_gysid_type, string id, string str_gysid)
        {
            id = gys_id;
            //���ݷ�����id �Ӳ��Ϲ�Ӧ����Ϣ�ӱ��� ��ȡ����ͬƷ�Ƶ�Ʒ��id
            if (str_gysid_type.Equals("������"))
            {
                //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                sSQL = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'";
                DataTable dt_select = objConn.GetDataTable(sSQL);
                if (dt_select != null && dt_select.Rows.Count > 0)
                {
                    sp_result = dt_select.Rows[0]["�������"].ToString();
                }
                if (sp_result != "")
                {
                    spjg(sp_result, gys_id, id);
                }
            }
           
        }
        public void spjg(string sp_result, string gys_id, string id)
    {
         if (sp_result.Equals("ͨ��"))
            {
			//�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
            sSQL = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"'),"
			+"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"'),"
			+"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+id+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"'),"
			+"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+id+"'),"
			+"��������=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+id+"'),"
			+"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+id+"') where gys_id ='"+id+"'";
                     
           
            int ret =objConn.ExecuteSQLForCount(sSQL,true);
					
			sSQL = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+id+"' ";

            dt_gysxx = objConn.GetDataTable(sSQL);			 
				     
            }
		if (sp_result.Equals("��ͨ��"))
            {
            sSQL = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+id+"' ";					
            int ret = objConn.ExecuteSQLForCount(sSQL,true);
        }
		if (sp_result.Equals("�����"))
        {
            sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
			+"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱�  where gys_id ='"+id+"'";       
            dt_gysxx = objConn.GetDataTable(sSQL);
        }

    }    
</script>
<body>
  <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
    <input type="hidden" id="ppid" />
    <input type="hidden" id="ppmc" />
    <%if (gys_type == "������")
      {%>
         <div class="fxsxx">
<%--		   <span class="fxsxx1">
		    </span>--%>
            <%--<span class="fxsxx1">��˾����ϸ��Ϣ����:</span>--%>
             <%--����2014��8��25�գ���divԭ����ʽ��fxsxx2����Ϊ��gysgybtr��--%>
            <div class="gysgybtr">
            <table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px; margin-top:10px;">
           <%if (sp_result == "�����")
             { %>
             <tr>
                  <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;��˾����ϸ��Ϣ�������:</td>
                </tr>
                <tr>
                  <td height="20" colspan="6" align="right"></td>
                </tr>
                <tr>
      <td width="50" height="30">&nbsp;</td>
      <td width="120">��˾����:</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" readonly type="text" id="Text1" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" onclick="return companyname_onclick()" /></td>
      <td width="50" align="right"></td>
      <td width="120">��˾��ַ��</td>
      <td width="329"><input name="address" readonly type="text" id="Text2" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>"/></td>
    </tr>
     <tr>
      <td height="30">&nbsp;</td>
      <td>��˾�绰��</td>
      <td><input name="tel" type="text" id="Text3" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/></td>
      <td>&nbsp;</td>
      <td>��˾��ҳ��</td>
      <td><input name="homepage" type="text" id="Text4" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" onclick="return homepage_onclick()" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��˾���棺</td>
      <td><input id="Text5" class="fxsxx3" name="fax" readonly type="text" value='<%=dt_gysxx.Rows[0]["��˾����"] %>' /></td>
      <td>&nbsp;</td>
      <td>��˾������</td>
      <td><input name="area" type="text" id="Text6" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��ϵ��������</td>
      <td><input name="name" type="text" id="Text7" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></td>
      <td>&nbsp;</td>
      <td>��ϵ�˵绰��</td>
      <td><input name="phone" type="text" id="Text8" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td>���鷶Χ��</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
          <input name="Business_Scope" readonly style="height:70px; width:805px;" type="text" id="Text9" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></td>
    </tr>

           <%}
             else
             {%>
              <tr>
                  <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;��˾����ϸ��Ϣ���£�</td>
                </tr>
                <tr>
                  <td height="20" colspan="6" align="right"></td>
                </tr>
                <tr>
      <td width="50" height="30">&nbsp;</td>
      <td width="120">��˾����:</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" id="Text10" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" onclick="return companyname_onclick()" /></td>
      <td width="50" align="right"></td>
      <td width="120">��˾��ַ��</td>
      <td width="329"><input name="address" type="text" readonly id="Text11" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ַ"] %>"/></td>
    </tr>
     <tr>
      <td height="30">&nbsp;</td>
      <td>��˾�绰��</td>
      <td><input name="tel" type="text" id="Text12" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>"/></td>
      <td>&nbsp;</td>
      <td>��˾��ҳ��</td>
      <td><input name="homepage" type="text" id="Text13" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" onclick="return homepage_onclick()" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��˾���棺</td>
      <td><input id="Text14" class="fxsxx3" name="fax" readonly type="text" value='<%=dt_gysxx.Rows[0]["����"] %>' /></td>
      <td>&nbsp;</td>
      <td>��˾������</td>
      <td><input name="area" type="text" id="Text15" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>"/></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td>��ϵ��������</td>
      <td><input name="name" type="text" id="Text16" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></td>
      <td>&nbsp;</td>
      <td>��ϵ�˵绰��</td>
      <td><input name="phone" type="text" id="Text17" readonly class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td>���鷶Χ��</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
          <input name="Business_Scope" readonly style="height:70px; width:805px;" type="text" id="Text18" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></td>
    </tr>

           <%} %>	
            </table>			
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="Hidden1" class="fxsxx3" value="<%=gys_id %>"/>
                    <%--<input type="submit" class="fxsbc2" value="����" style="cursor:pointer"/>--%>
                </span>
          </div>
          </div>
         <div class="ggspp">
    <div style="font-size:14px; font-weight:bold; line-height:36px; float:left; width:100%; background-color:#f7f7f7;">&nbsp;&nbsp;��˾Ʒ������</div>
    <% foreach (System.Data.DataRow row in dt_ppxx.Rows)
       {%>
        <div class="fgstp">
    <img src="images/wwwq_03.jpg" />
      <div class="fdlpp1"> 
        <input type="checkbox" name="brand" id="checkbox2" value="<%=row["pp_id"].ToString() %>" onclick="ck(this,'<%=row["Ʒ������"].ToString()%>','<%=row["pp_id"].ToString() %>')"  class="middle"/><%=row["Ʒ������"].ToString()%></div>
    </div>
  
  <%} %>
  
  </div>
                <%--    <span class="ggspp1" style="background-color:#f7f7f7">��˾Ʒ������</span>
                    <% foreach (System.Data.DataRow row in dt_ppxx.Rows){%>
                    <div class="fgstp">
                        <img src="images/wwwq_03.jpg" />
                        <span class="fdlpp1">
                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                            <%=row["Ʒ������"].ToString() %>
                        </span>
                    </div>
                    <%} %>
                    
                </div>--%>
          <%--  <span class="fxsbc1"><a onclick="DeleteBrand(<%=gys_id %>)" style="cursor:pointer;">ɾ��ѡ��Ʒ��</a></span>--%>
            <span class="fxsbc1"><a onclick="AddNewBrand(<%=gys_id %>)" style="cursor:pointer;">������Ʒ��</a></span>
              <span class="fxsbc1"><a onclick="bj('<%=gys_id %>')" style="cursor:pointer;">�༭ѡ��Ʒ��</a></span>
           <%-- <span class="fxsbc1"><input type="button" onclick="DeleteBrand(<%=gys_id %>)" value="ɾ��ѡ��Ʒ��" /></span>
            <span class="fxsbc1"><input type="button" onclick="AddNewBrand(<%=gys_id %>)" value="������Ʒ��"/></span>--%>
    <%}
        //����2014��8��13�գ��û������Ƿ����̣�û�й�����������Ϣ��Ȩ�ޣ�����Ӧע�ͷ����̵������Ϣ
      //else if (gys_type == "������")
      //{ %>
      
        <%--<div class="fxsxx">
		   <span class="fxsxx1">
		    </span>
                <div class="zjgxs">
                 <span>��˾����Ʒ�ƣ�</span><br />
			        <select name="pp" id="pp" class="fug" style="width:200px" onchange="Update(this.options[this.options.selectedIndex].value)">
			          <option value="0">��ѡ��Ʒ��</option>--%>
                    <%-- <% foreach (System.Data.DataRow row_fxs in dt_ppxx.Rows)
                        { %>			
			             <option value='<%=row_fxs["pp_id"].ToString()%>'><%=row_fxs["Ʒ������"].ToString()%></option>
	                <% }%>	--%>		
			    <%--    </select> 			
			    </div>
			    <div class="zjgxs">
                     <span>��Ʒ���µķ����̣�</span><br />
			        <select name="scs_PP" id="scs_PP" class="fug" style="width:200px" onchange="Update_scs(this.options[this.options.selectedIndex].value)">			
			        </select> 
			        <span class="zjgxs1"><a href="xzgxs.aspx?xzlx=scs&gxs_id=<%=gys_id %>"> �����µ�������</a></span>
			    </div>
         
            <span class="fxsxx1">�ù�˾����ϸ��Ϣ����:</span>

            <div class="fxsxx2">--%>
          <%-- <%if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
             {
                 if (sp_result == "�����")
                 {%>--%>
             <%--  <span  class="fxsxx1">�÷����̵���Ϣ���������</span>
             <dl>
                <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
                <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>"/></dt>
                <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/></dt>
                <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></dt>
                <dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/></dt>
                <dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/></dt>
                <dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></dt>
                <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></dt>
                <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
             </dl>--%>
          <%-- <%}
                 else
                 { %>
--%>
             <%-- <dl>
                <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></dt>
                <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>"/></dt>
                <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>"/></dt>
                <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></dt>
                <dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>"/></dt>
                <dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>"/></dt>
                <dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></dt>
                <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></dt>
                <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
             </dl>--%>
          <%-- <%}
             }
             else
             {%>--%>
             <%--  <span class="fxsxx1" id="sh" style=" visibility:hidden">�÷����̵���Ϣ���������</span>
              <dl>
                <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3"/></dt>
                <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="address" class="fxsxx3" /></dt>
                <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" /></dt>
                <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3"  /></dt>
                <dd>��˾���棺</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" /></dt>
                <dd>��˾������</dd><dt><input name="area" type="text" id="area" class="fxsxx3" /></dt>
                <dd>��ϵ��������</dd><dt><input name="name" type="text" id="name" class="fxsxx3" /></dt>
                <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3"  /></dt>
                <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3"  /></dt>
             </dl>--%>
            <%-- <%}  }%>				
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>                 
                    <input type="submit" value="����" />                     
                </span>
          </div>--%>
          <%--����2014��8��14�գ�ע�͸ñ�ǩ��������Ĺ�˾Ʒ�����µı�ǩ�ظ���--%>
         <%-- <span class="fxsxx1"></span>	
                    <div class="ggspp">
                        <span class="ggspp1">�ó��̵�Ʒ������</span> 
                        <div id="ppxx">
                         </div>      
                    </div>	--%>
           <%--����2014��8��13�գ�ע�͸ô����ţ�����ҳ��     --%>
        <%--  </div>       
      <%} %>--%>
        
                     </form>
      
<!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->   
</body>

</html>
