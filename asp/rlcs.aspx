<!--
      ���쳧��ҳ��
	  (���û����쳧�̺� �Ѷ�Ӧ���û�id��������Ĺ�Ӧ��(���Ϲ�Ӧ����Ϣ���yh_id))
	  �ļ���:  ���쳧��.aspx        
	  �������:�û�id	  
     author:����ӱ
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
 
</head>

<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

  <script runat="server">
    protected DataTable dt_wrl_gys = new DataTable(); //δ����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
    protected DataTable dt_yrl_gys = new DataTable(); //�Ѿ�����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
    protected DataTable dt_dsh_gys = new DataTable(); //��ʾ�û�����Ĺ�Ӧ��
    public DataConn objConn = new DataConn();
    public string s_yh_id = "";
    public string sSQL = "";
    public string s_spjg="";   //�������
    public string s_gys_id="";   //��Ӧ��id
     public DataTable dt_clgys = null;     //���Ϲ�Ӧ��   ��ѯʹ��
     protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
        }
        string gys_type = "";
		if(s_yh_id!="")
		{
			sSQL = "select ���� from �û��� where yh_id ='" + s_yh_id + "' ";
			DataTable dt_yh = objConn.GetDataTable(sSQL);
			if (dt_yh != null && dt_yh.Rows.Count > 0)
			{
				gys_type = dt_yh.Rows[0]["����"].ToString();
			}

			//�����û����������(������/������)��ѯ��صĹ�Ӧ��
			sSQL = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where ��λ����='" + gys_type + "' and (yh_id is null or yh_id='') ";
			dt_wrl_gys = objConn.GetDataTable(sSQL);
			sSQL = "select count(*) from ��Ӧ����������� where yh_id = '" + s_yh_id + "'";
			string s_count = objConn.DBLook(sSQL);
			int count = Convert.ToInt32(s_count);
			if (count != 0)
			{
				sSQL = "select gys_id, ������� from ��Ӧ����������� where yh_id = '" + s_yh_id + "'";
				DataTable dt_gysxx = objConn.GetDataTable(sSQL);
				if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
				{
					s_spjg = dt_gysxx.Rows[0]["�������"].ToString();
					s_gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
					if (s_spjg == "ͨ��")
					{
						sSQL = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '" + s_yh_id + "' where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, false);
						sSQL = "select ��Ӧ��,gys_id,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where yh_id ='" + s_yh_id + "'";
						dt_yrl_gys = objConn.GetDataTable(sSQL);
					}
					else if (s_spjg == "��ͨ��")
					{
						sSQL = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '' where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, false);
						//��֤��ͨ��,ͬʱϣ���û��������쳧��,���԰�ԭ�еļ�¼�ӹ�Ӧ��������������
						sSQL = "delete ��Ӧ�����������  where gys_id = '" + s_gys_id + "'";
						objConn.ExecuteSQL(sSQL, true);
					}
					else if (s_spjg == "�����")
					{
						sSQL = "select ��Ӧ��,gys_id,��ϵ��ַ from ��Ӧ����������� where yh_id ='" + s_yh_id + "'";
						dt_dsh_gys = objConn.GetDataTable(sSQL);
					}
				}
			}
		}
		else
		{
			objConn.MsgBox(this.Page,"QQ_ID�����ڣ������µ�¼");
		}
    }
     protected void CkeckCompany(object sender, EventArgs e)
    {
        if (this.company.Value!="")
        {
            string SQL = "select * from ���Ϲ�Ӧ����Ϣ�� where ��Ӧ�� like '%" + this.company.Value + "%'";
            dt_clgys = objConn.GetDataTable(SQL);
        }
        else
        {
            dt_clgys = null;
            string SQL = "select * from ���Ϲ�Ӧ����Ϣ�� ";
            dt_clgys = objConn.GetDataTable(SQL);
        }
    }
   </script>
    <script language ="javascript">
        function send_request()
        {
            var gys_list = document.getElementById("gyslist");
            var gys_id = gys_list.options[gys_list.selectedIndex].value;

            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    location.reload();
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" + gys_id, true);
            xmlhttp.send();
        }
        function Select_Gys_Name(gys_id)
        {
            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    alert(xmlhttp.responseText);
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "rlcs_3.aspx?gys_id=" + gys_id, true);
            xmlhttp.send();
        }
    </script>

<form runat="server">
<div style=" float:left;">

<%
        if(s_spjg!="")
        {
            if(s_spjg=="ͨ��")
            {
%>
                    <div>                  
                         <div class="rlcs">
                             <span class="rlcszi" style="color:Blue;font-size:12px">
				                            <%Response.Write("��ϲ��!�����ͨ��,����Խ������²�����");%>
                                            <br />
                                            <a href="glscsxx.aspx">��������������Ϣ</a>
                                            <br />
                                            <a href="gysglcl.aspx">���������Ϣ</a>

		                     </span>
                         </div>  
                     
<%                      if(dt_yrl_gys.Rows.Count>0)
                         {
%>
                            <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">���Ѿ��ڱ�վ����Ĺ�Ӧ������:</span></div>
<%
                             foreach (System.Data.DataRow row in dt_yrl_gys.Rows)
                             { 
%>
                                <span class="rlcszi">
                                    <a href="gysxx.aspx?gys_id=<%=row["gys_id"].ToString()%>"><%=row["��Ӧ��"].ToString() %></a>
                                </span>
<%                           } 
                         }
%>
                    </div>
                    <img src="images/www_03.jpg" />
<%
             }
            else if(s_spjg=="�����")
            {
%>  
                <div>
                    <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                       Response.Write("�𾴵��û�,����!�����ڱ�վ������");
%>
				         <br>
<%                      foreach (System.Data.DataRow row in dt_dsh_gys.Rows)
                        { 
%>                    
					        <a  style="color:Blue;font-size:12px" href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��Ӧ��"].ToString() %></a>				
		            
<%                      } 
%>
				    </span>
                </div>   
				    <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                      Response.Write("�������������Ϣ���ύ,�����ĵȴ�,�ҷ�������Ա�ᾡ������ظ�."); 
%>			
					 </span>
                </div>
                </div>
                 <img src="images/www_03.jpg" />
<%
            }
            else if(s_spjg=="��ͨ��")
            {
%>
                <div class="rlcs">
                    <span class="rlcszi" style="color:Blue;font-size:12px">
<%                       Response.Write("�����������������Ϣ��׼ȷ!����������!"); 
%>
					 </span>
                </div> 
                <div class="rlcs1">
                        <div class="rlcs2">
                            <input name="sou1" type="text" class="sou1" />
                            <a href="#">
                                <img src="images/ccc_03.jpg" />
                            </a>
                         </div>
                        <div class="rlcs3">
                            <div class="rlcs4">
                                 <span class="rlcs5">��ѯ���</span>
                                 <select name="gys" id="gyslist" >
<%                               foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
                                 { 
%>
                                     <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString() %></span>
<%                                }
%>
                                 </select>
                                <a  onclick="send_request()" > <img src="images/rl_03.jpg" /></a>
                            </div>
                         </div>
                         <div class="rlcs4">
                            <span class="rlcs7">�����û���ҵ���˾���������ύ��˾���ϣ��ҷ�������Ա����3���������������˹���������ͼ���£�</span>
                            <span><img src="images/www_03.jpg" /></span>
                        </div>
                   </div>
<%
            }
         }
         else
         {
%>               <div class="rlcs1">
                    <div class="rlcs2">
                        <input name="sou1" id="company" type="text" class="sou1" runat="server" />
                      <asp:ImageButton runat="server" ID="CkeckedCompany" ImageUrl="images/ccc_03.jpg"  OnClick="CkeckCompany"  />
                        </div>
                    <div class="rlcs3">
                        <div class="rlcs4">
                                <span class="rlcs5">��ѯ���</span>
<%
                                if (dt_clgys != null)
                                {
                                       
%>
                                    <select name="gys" id="gyslist"  style=" width:200px;">
<%
                                    foreach (System.Data.DataRow row in dt_clgys.Rows)
                                    {
%>
                                        <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString()%></span>
<%
                                    }
%>
                                    </select>                                           
 <%   
                                }
                                else
                                { 
%>
                                    <select name="gys" id="gyslist" style=" width:200px;" >
<%                                  foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
                                    { 
 %>
                                         <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString() %></span>
<%                                   }
%>
                                    </select>
<%
                                 }
%>     
                                <a  onclick="send_request()" > <img src="images/rl_03.jpg" /></a>
                        </div>
                        </div>
                        <div class="rlcs4">
                        <span class="rlcs7">�����û���ҵ���˾���������ύ��˾���ϣ��ҷ�������Ա����3���������������˹���������ͼ���£�</span>
                        <span><img src="images/www_03.jpg" /></span>
                    </div>
                </div> 
<%
         }
%>
</div>

<div class="rlcs1"></div>
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
