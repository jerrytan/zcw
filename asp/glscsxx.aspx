<!--      
	   ������������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glscsxx.aspx 
       �����������    
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>������������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>


<script runat="server">

       
        protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected DataTable dt_ppxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]);         
			//���쳧�̳ɹ�,�����û�id ��ѯ����Ĺ�Ӧ����Ϣ
            String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
            dt_gysxx = ds_gysxx.Tables[0];
           		

            if (dt_gysxx.Rows.Count == 0) Response.Redirect("gyszym.aspx");
			    
		

            
            gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
							
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ�����='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "Ʒ���ֵ�");
            dt_ppxx = ds_ppxx.Tables[0];  			                                        
        }

       		
	
</script>

<body>

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
        <div class="fxsxx">
		   <span class="fxsxx1">
		   <%
			string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]);         
			
            String str_gysxx = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
            DataTable dt_gysxxs = ds_gysxx.Tables[0];
            string gysid = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	
            
			conn.Open();   
		    string sql_gys_id = "select count(*) from ��Ӧ����ʱ�޸ı� where gys_id='"+gysid+"' ";
		    SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
            Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
			conn.Close();

            if (obj_check_gys_exist != null)
            {
               int count = Convert.ToInt32(obj_check_gys_exist);
               if (count != 0)  
               {  //��� ��Ӧ����ʱ�޸ı� �м�¼ ��ѯ�������
			    string str_select = "select ������� from ��Ӧ����ʱ�޸ı� where gys_id='"+gys_id+"'";
			    SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			    DataSet ds_select = new DataSet();
			    da_select.Fill(ds_select,"��Ӧ����ʱ�޸ı�");
			    DataTable dt_select = ds_select.Tables[0];
			    string sp_result = Convert.ToString(dt_select.Rows[0]["�������"]); 
			    if(sp_result!="")
			    {
                  if (sp_result.Equals("ͨ��"))
                  {  
				  
				     //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ����ʱ�޸ı� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                     string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"'),"
				     +"��ַ=(select ��˾��ַ from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"'),�绰=(select ��˾�绰 from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"'),"
					 +"��ҳ=(select ��˾��ҳ from ��Ӧ����ʱ�޸ı� where gys_id='"+gys_id+"'),����=(select ��˾���� from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"'),"
				     +"��ϵ��=(select ��ϵ������ from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ����ʱ�޸ı� where gys_id='"+gys_id+"'),"
					 +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ����ʱ�޸ı� where  gys_id='"+gys_id+"') where gys_id ='"+gys_id+"'";
                     conn.Open();
                     SqlCommand cmd2 = new SqlCommand(sql, conn);
                     int ret = (int)cmd2.ExecuteNonQuery();
				     conn.Close();
					 Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
                  }
			      if (sp_result.Equals("��ͨ��"))
                  {
                     string sql_delete = "delete  ��Ӧ����ʱ�޸ı� where gys_id ='"+gys_id+"' ";
					
                     conn.Open();
                     SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                     int ret = (int)cmd_delete.ExecuteNonQuery();
			         conn.Close();
					 Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                  }
			    }
              }
			}
			%>
		    </span>
            <span class="fxsxx1">��˾����ϸ��Ϣ����:</span>

            <div class="fxsxx2">
                <dl>
                    <dd>��˾���ƣ�</dd>
                    <dt>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></dt>
                    <dd>��˾��ַ��</dd>
                    <dt>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>"/></dt>
                    <dd>��˾�绰��</dd>
                    <dt>
                        <input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>"/></dt>
                    <dd>��˾��ҳ��</dd>
                    <dt>
                        <input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></dt>
                    <dd>��˾���棺</dd>
                    <dt>
                        <input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>"/></dt>
                    <dd>��˾������</dd>
                    <dt>
                        <input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>"/></dt>
                    

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
                    <dt>
                        <input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></dt>
                    <dd>��ϵ�˵绰��</dd>
                    <dt>
                        <input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" />

                    </dt>
					 <dd>��Ӫ��Χ��</dd>
                    <dt>
                        <input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" />

                    </dt>


                </dl>
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["gys_id"] %>"/>
                    <input type="submit" value="����" />

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">��˾Ʒ������</span>
                    
                    <% foreach (System.Data.DataRow row in dt_ppxx.Rows){%>
                    <div class="fgstp">
                        <img src="images/wwwq_03.jpg" />
                        <span class="fdlpp1">
                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                            <%=row["Ʒ������"].ToString() %>
                        </span>
                    </div>

                    <%} %>
                    
                </div>
            </div>
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">ɾ��ѡ��Ʒ��</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">������Ʒ��</a></span>
        </div>
    



	  

    <script>
        function AddNewBrand(id)
        {
             var url = "xzpp.aspx?gys_id=" + id;
             window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand()
        {
            var r = confirm("��ȷ������ɾ����Ʒ��!");
            if (r == true) {

                var brand_str = "?pp_id=";
                var brands = document.getElementsByName("brand");

                for (var i = 0; i < brands.length; i++) {
                    if (brands[i].checked) {

                        brand_str = brand_str + "," + brands[i].value;
                    }

                }

                var url = "scpp.aspx" + brand_str;
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
        }
    </script>


    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  



</body>
</html>
