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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>������������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">

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
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {

                    var array = new Array();           //��������
                    array = xmlhttp.responseText;     //�����滻���ص�json�ַ���

                    var json = array;
                    var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			


                    for (var i = 0; i < myobj.length; i++)
                    {  //����,��ajax���ص�������䵽�ı�����				

                        document.getElementById('companyname').value = myobj[i].gys_name;       //��Ӧ��
                        document.getElementById('address').value = myobj[i].gys_address;        //��ַ
                        document.getElementById('tel').value = myobj[i].gys_tel;                //�绰  			 
                        document.getElementById('homepage').value = myobj[i].gys_homepage;       //��ҳ
                        document.getElementById('fax').value = myobj[i].gys_fax;                 //����
                        document.getElementById('area').value = myobj[i].gys_area;               //��������
                        document.getElementById('name').value = myobj[i].gys_user;               //��ϵ��
                        document.getElementById('phone').value = myobj[i].gys_user_phone;          //��ϵ�˵绰
                        document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax���صĹ�Ӧ��id	������ύʱʹ��	  				              

                    }

                }
            }
            xmlhttp.open("GET", "glscsxx3.aspx?id=" + id, true);
            xmlhttp.send();
        }

        function AddNewBrand(id)
        {
            var url = "xzpp.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand(id)
        {
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

                var url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid;
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
        }
</script>
</head>


<body>
  <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
    <script runat="server">
  protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        public DataTable dt_ppxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        public string gys_id="";
        public DataConn objConn=new DataConn();
        public string sSQL="";
        public string s_yh_id="";
        public string sp_result="";
        public DataTable dt_gysxxs = new DataTable();
         public string gys_types = "";                  //��λ����   
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["GYS_YH_ID"]!=null)
            {
                 s_yh_id = Session["GYS_YH_ID"].ToString(); 
            }
            else
            {
                if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
                {
                     s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
                 }
            }
			    //���쳧�̳ɹ�,�����û�id ��ѯ����Ĺ�Ӧ����Ϣ
			    string gys_type="";
                string gys_type_id="";
			    sSQL = "select ��λ���� ,gys_id from  ���Ϲ�Ӧ����Ϣ�� where yh_id='"+s_yh_id+"' ";  //��ѯ��λ����
			
                DataTable dt_type = objConn.GetDataTable(sSQL);
                if(dt_type!=null&&dt_type.Rows.Count>0)
                {
			            gys_type = dt_type.Rows[0]["��λ����"].ToString();
			            gys_id = dt_type.Rows[0]["gys_id"].ToString();  //��Ӧ��id   141
                }
			    if (gys_type.Equals("������"))
			    {
			        //����Ƿ�������Ϣ ֱ�Ӹ���yh_id ��ѯ��Ӧ����Ϣ 
                    sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+s_yh_id+"' ";
                    dt_gysxx = objConn.GetDataTable(sSQL);
           	    }
                if (gys_type.Equals("������"))
			    {	             
				    //���ݷ�����id ��<���Ϲ�Ӧ����Ϣ�ӱ�>�� ��ȡ����ͬƷ�Ƶ�Ʒ��id  �ٸ���Ʒ��id��<Ʒ���ֵ�>��ѯ��ͬ�� ������id
				    //�ٸ��ݲ�ͬ��������id ��ѯ��ͬ����������Ϣ
				
				    sSQL = "select pp_id from  ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gys_id+"' ";   //183,186
                	string gys_pp_id ="";
                    dt_gysxxs = objConn.GetDataTable(sSQL);
                    if(dt_gysxxs!=null&&dt_gysxxs.Rows.Count>0)
                    {
               	        gys_pp_id = Convert.ToString(dt_gysxxs.Rows[0]["pp_id"]);		
                    }
                    sSQL= "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id "
				    +"from ���Ϲ�Ӧ����Ϣ�� where  gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+gys_pp_id+"')"    //pp_id=186
				    +"and ��λ����='������'";             
                    dt_gysxx = objConn.GetDataTable(sSQL);
                }
                if (dt_gysxx.Rows.Count == 0) 
                    Response.Redirect("gyszym.aspx");
			    
                gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
							
			    sSQL="select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ�����='1' and scs_id='"+gys_id+"' ";
                dt_ppxx = objConn.GetDataTable(sSQL);          
                sSQL= "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+s_yh_id+"' ";
                dt_gysxxs = objConn.GetDataTable(sSQL);
                string gysid = "";
            
                if (dt_gysxxs != null && dt_gysxxs.Rows.Count>0)
                {
                    gysid = dt_gysxxs.Rows[0]["gys_id"].ToString();
                    gys_types = dt_gysxxs.Rows[0]["��λ����"].ToString();
                }
                string id = "";
                if (Request["id"]!=null&&Request["id"].ToString()!="")
                {
                    id = Request["id"].ToString();    //��ȡglfxsxx2ҳ�淵�صĹ�Ӧ��id
                }
		    
                if (id != "")
                {
                    DWLX(gys_types, id, gysid);
                }
        }
    protected void DWLX(string str_gysid_type, string id, string str_gysid)
        {
            //���ݷ�����id �Ӳ��Ϲ�Ӧ����Ϣ�ӱ��� ��ȡ����ͬƷ�Ƶ�Ʒ��id
            string sp_result = "";

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
            if (str_gysid_type.Equals("������"))
            {
                  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
                    sSQL = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='" + id + "'";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);
                    if (sp_result != "")
                    {
                        spjg(sp_result, gys_id, id);
                    }                 
            }
        }
    public void spjg(string sp_result,string gys_id, string id)
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
					 
			sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+id+"' ";

            dt_gysxx = objConn.GetDataTable(sSQL);					 
				     
			Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
            }
		if (sp_result.Equals("��ͨ��"))
            {
            sSQL = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+id+"' ";					
            int ret = objConn.ExecuteSQLForCount(sSQL,true);
			         
			Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
        }
		if (sp_result.Equals("�����"))
        {
            sSQL = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
			+"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱�  where gys_id ='"+id+"'";           
            dt_gysxx = objConn.GetDataTable(sSQL);
			         
			Response.Write("��˵���!");
        }

    }    
</script>
    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
        <div class="fxsxx">
		   <span class="fxsxx1">
		    </span>
			
			<%	
                if (gys_types.Equals("������"))
                {
			%>
			<div class="zjgxs">
			<select name="" class="fug" style="width:200px" onchange="Update_scs(this.options[this.options.selectedIndex].value)">
			 <% 
                 if (dt_gysxxs != null && dt_gysxxs.Rows.Count > 0)
                 {


                     foreach (System.Data.DataRow row in dt_gysxxs.Rows)
                     {
                         sSQL = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + row["fxs_id"].ToString() + "' and ��λ����='������' ";
                        System.Data.DataTable dt = objConn.GetDataTable(sSQL);       	
			            %>			
			            <option value='<%=dt.Rows[0]["gys_id"].ToString()%>'><%=dt.Rows[0]["��Ӧ��"].ToString()%></option>
			            <%}
                  }%>
			
			</select> 
			<span class="zjgxs1"><a href="#">�����µķ�����</a></span>
			</div>
			<%}
                %>
            <span class="fxsxx1">��˾����ϸ��Ϣ����:</span>

            <div class="fxsxx2">
           <%if (sp_result == "�����")
             {%>
             <dl>
                <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="Text1" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></dt>
                <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="Text3" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>"/></dt>
                <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="Text5" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/></dt>
                <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="Text7" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></dt>
                <dd>��˾���棺</dd><dt><input name="fax" type="text" id="Text9" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/></dt>
                <dd>��˾������</dd><dt><input name="area" type="text" id="Text11" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/></dt>
                <dd>��ϵ��������</dd><dt><input name="name" type="text" id="Text13" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></dt>
                <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="Text15" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></dt>
                <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Text17" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
             </dl>
           <%}
             else
             { %>
              <dl>
                <dd>��˾���ƣ�</dd><dt><input name="companyname" type="text" id="Text2" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" /></dt>
                <dd>��˾��ַ��</dd><dt><input name="address" type="text" id="Text4" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>"/></dt>
                <dd>��˾�绰��</dd><dt><input name="tel" type="text" id="Text6" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>"/></dt>
                <dd>��˾��ҳ��</dd><dt><input name="homepage" type="text" id="Text8" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" /></dt>
                <dd>��˾���棺</dd><dt><input name="fax" type="text" id="Text10" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>"/></dt>
                <dd>��˾������</dd><dt><input name="area" type="text" id="Text12" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>"/></dt>
                <dd>��ϵ��������</dd><dt><input name="name" type="text" id="Text14" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" /></dt>
                <dd>��ϵ�˵绰��</dd><dt><input name="phone" type="text" id="Text16" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" /></dt>
                <dd>��Ӫ��Χ  ��</dd><dt><input name="Business_Scope" type="text" id="Text18" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></dt>
             </dl>
           <%} %>				
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
                    <input type="submit" value="����" />

                </span>
          </div>
          </div>
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
  
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand(<%=gys_id %>)">ɾ��ѡ��Ʒ��</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">������Ʒ��</a></span>
<!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->   
</body>

</html>
