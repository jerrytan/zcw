<!--  
	    �����������Ϣҳ��   �Է�������Ϣ�����޸ı��� �����µķ�����
        �ļ�����glfxsxx2.aspx
        ���������gys_id    
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
<title>��������Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

             
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			string gys_id = Request["gys_id"];          
			if (Request.Form["companyname"] != null)  //�޸ĺ�д��
            {
                conn.Open();
                string companyname = Request["companyname"];   //��˾����
                string address = Request["address"];            //��ַ
                string tel = Request.Form["tel"];               //�绰
                string homepage = Request.Form["homepage"];     //��ҳ
                string fax = Request["fax"];                    //����              
                string description = Request.Form["description"];  //��˾���
                string name = Request.Form["name"];                //��ϵ��
                string phone = Request.Form["phone"];              //��ϵ���ֻ�
                
                if (gys_id != "")
                {
                    string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��='" + companyname + "',��ַ='" + address + "',�绰='" + tel + "',��ҳ='" + homepage + "',����='" + fax + "',��ϵ��='" + name + "',��ϵ���ֻ�='" + phone + "' where gys_id in (select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where  pp_id  in (select   pp_id from ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gys_id+"')) ";
                    SqlCommand cmd2 = new SqlCommand(sql, conn);
                    int ret = (int)cmd2.ExecuteNonQuery();
                }
				if (gys_id == "")
				{
                string sql1 = "insert into  ���Ϲ�Ӧ����Ϣ��( ��Ӧ��,��ַ,�绰,��ҳ,����,��ϵ��,��ϵ���ֻ�,��λ����) values('" + companyname + "','" + address + "','" + tel + "','" + homepage + "','" + fax + "','" + name + "','" + phone + "','������' )  ";
                SqlCommand cmd3 = new SqlCommand(sql1, conn);
                int ret1 = (int)cmd3.ExecuteNonQuery();
				//�������������,��ԭ��int ret2 = (int)cmd3.ExecuteNonQuery();  ��ִ��cmd3
                string sql2 = "update ���Ϲ�Ӧ����Ϣ�� set gys_id=(select myId from ���Ϲ�Ӧ����Ϣ�� where ��Ӧ��='"+companyname+" ') where ��Ӧ��='"+companyname+" '";               
				SqlCommand cmd4 = new SqlCommand(sql2, conn);
                int ret2 = (int)cmd4.ExecuteNonQuery();
                
                }
				conn.Close();
            }

            //������ ��Ӧ�����ֺ͹�Ӧ��id
            SqlDataAdapter da = new SqlDataAdapter("select ��Ӧ��,gys_id,dq_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in (select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where  pp_id  in (select   pp_id from ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gys_id+"'))  ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϲ�Ӧ����Ϣ��");
            dt = ds.Tables[0];
            this.Items = new List<ScsInformotion>();
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];
                ScsInformotion item = new ScsInformotion();
                item.ScsName = Convert.ToString(dr["��Ӧ��"]);
                item.GysCode = Convert.ToString(dr["gys_id"]);
				item.Dq_id = Convert.ToString(dr["dq_id"]);
                this.Items.Add(item);  //�ѹ�Ӧ�����ֺ͹�Ӧ��id �͵���id���뼯��
            }
			
			SqlDataAdapter da1 = new SqlDataAdapter("select Ʒ������ from Ʒ���ֵ� where  pp_id  in (select   pp_id from ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='67') ", conn); //�����̴����Ʒ�� ������
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "Ʒ���ֵ�");
            dt1 = ds1.Tables[0];
			
			//��ȡ�����򴫹����Ĳ�����Ӧ��id
            string strP = Request.QueryString["bm"];
            
            SqlDataAdapter da2 = new SqlDataAdapter("select distinct ������������,���������� from ���������ֵ�" , conn); //����������������Ϣ
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "���������ֵ�");
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select distinct ʡ�е�������,���������� from ���������ֵ� where LEN(ʡ�е������)='2'" , conn); //����������ʡ��
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���������ֵ�");
            dt3 = ds3.Tables[0];
			
			SqlDataAdapter da4 = new SqlDataAdapter("select distinct ʡ�е�������,ʡ�е������ from ���������ֵ� where LEN(ʡ�е������)='4'" , conn); //����������ʡ��
            DataSet ds4 = new DataSet();
            da4.Fill(ds4, "���������ֵ�");
            dt4 = ds4.Tables[0];
			
			this.Selects1 = new List<DqInformotion>();
			this.Selects2 = new List<DqInformotion>();
			this.Selects3 = new List<DqInformotion>();
            for (int x = 0; x < dt2.Rows.Count; x++)
            {			   
                DataRow dr = dt2.Rows[x];
                DqInformotion item = new DqInformotion();
                item.DqName = Convert.ToString(dr["������������"]);               
                this.Selects1.Add(item);  //�������������Ƽ��뼯��
				
               
            }
			 for (int x = 0; x < dt3.Rows.Count; x++)
             {	                  
				  DataRow dr1 = dt3.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["ʡ�е�������"]);               
                  this.Selects2.Add(item1);  //������ʡ���뼯��				
             }
			for (int x = 0; x < dt4.Rows.Count; x++)
             {	                  
				  DataRow dr1 = dt4.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["ʡ�е�������"]);               
                  this.Selects3.Add(item1);  //������ʡ���뼯��				
             }
			
			
           
			if(strP!=null)
			{
			SqlDataAdapter da5 = new SqlDataAdapter("select ʡ�е�������,������������,����������,ʡ�е������ from ���������ֵ� where dq_id in(select dq_id from ���Ϲ�Ӧ����Ϣ�� where gys_id='"+strP+"') ", conn); //����������������Ϣ
            DataSet ds5 = new DataSet();
            da5.Fill(ds5, "���������ֵ�");
            dt5 = ds5.Tables[0];
			this.Selects1 = new List<DqInformotion>();
			this.Selects2 = new List<DqInformotion>();
			this.Selects3 = new List<DqInformotion>();
            for (int x = 0; x < dt5.Rows.Count; x++)
            {			   
                DataRow dr = dt5.Rows[x];
                DqInformotion item = new DqInformotion();
                item.DqName = Convert.ToString(dr["������������"]);               
                this.Selects1.Add(item);  //�������������Ƽ��뼯��
				
               if(Convert.ToString(dr["ʡ�е������"]).Length ==2)
			    {
				  DataRow dr1 = dt5.Rows[x];
                  DqInformotion item1 = new DqInformotion();
                  item1.DqName = Convert.ToString(dr1["ʡ�е�������"]);               
                  this.Selects2.Add(item1);  //������ʡ���뼯��
				}
				if(Convert.ToString(dr["ʡ�е������"]).Length ==4)
				 {
				  DataRow dr2 = dt5.Rows[x];
                  DqInformotion item2 = new DqInformotion();
                  item2.DqName = Convert.ToString(dr2["ʡ�е�������"]);               
                  this.Selects3.Add(item2);  //�������ؼ��м��뼯��
				 }
           }
           }
            
            if (strP == null )  //���ݴ������Ĺ�Ӧ��id���в�ѯ��������Ϣ
            {
                string strr = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ� from ���Ϲ�Ӧ����Ϣ��  where gys_id in (select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where  pp_id  in (select   pp_id from ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gys_id+"')) ";
                SqlCommand cmd = new SqlCommand(strr, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    this.companyname.Value = reader["��Ӧ��"].ToString();
                    this.address.Value = reader["��ַ"].ToString();
                    this.tel.Value = reader["�绰"].ToString();
                    this.homepage.Value = reader["��ҳ"].ToString();
                    this.fax.Value = reader["����"].ToString();
                    this.name.Value = reader["��ϵ��"].ToString();
                    this.phone.Value = reader["��ϵ���ֻ�"].ToString();
                }
                conn.Close();
            }
            if (strP != null) 
            {
                string str = "select ��Ӧ��,gys_id,dq_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in (select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where  pp_id  in (select   pp_id from ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+strP+"')) ";
                SqlCommand cmd1 = new SqlCommand(str, conn);
                conn.Open();
                SqlDataReader reader1 = cmd1.ExecuteReader();
                while (reader1.Read())  //��ȡ
                {                  
                    this.companyname.Value = reader1["��Ӧ��"].ToString();   //value��Ӧ���Ǳ���id������  
                    this.address.Value = reader1["��ַ"].ToString();
                    this.tel.Value = reader1["�绰"].ToString();
					this.homepage.Value = reader1["��ҳ"].ToString();
					this.fax.Value = reader1["����"].ToString();					
					this.name.Value = reader1["��ϵ��"].ToString();
					this.phone.Value = reader1["��ϵ���ֻ�"].ToString();
                }
                conn.Close();
            }
            
        }
    </script>

<body>

<!-- ͷ����ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ������-->

<%string gys_id = Request["gys_id"];%>
<form id="login" name="login" action="glfxsxx.aspx?gys_id=<%=gys_id%>" method="post">

<div class="fxsxx">
<span class="fxsxx1">��˾�ķ�����Ϣ����</span>
<div class="zjgxs">
 
<select name=""  id="selectbox" class="fug"  onchange="javascript:location.href='glfxsxx.aspx?bm='+this.value">
<%foreach (var v in this.Items)
  { %>
<option name="" onclick="TextSelect()" id=""  value="<%=v.GysCode%>"><%=v.ScsName%></option>
<%} %>
</select>


<span class="zjgxs1"><a onclick="ClearAllTextBox()"  href="glfxsxx.aspx">�����µĹ�����</a></span></div>
<div class="fxsxx2">
 <dl>
    <dd>��˾���ƣ�</dd>
    <dt><input runat="server" name="companyname" id="companyname" type="text" class="fxsxx3"/></dt>
     <dd>��˾��ַ��</dd>
    <dt><input runat="server" name="address" id="address" type="text" class="fxsxx3"/></dt>
     <dd>��˾�绰��</dd>
    <dt><input runat="server" name="tel" id="tel" type="text" class="fxsxx3"/></dt>
     <dd>��˾��ҳ��</dd>
    <dt><input runat="server" name="homepage" id="homepage" type="text" class="fxsxx3"/></dt>
     <dd>��˾���棺</dd>
    <dt><input runat="server" name="fax" id="fax" type="text" class="fxsxx3"/></dt>
	
	
    <dd>��������</dd>
    <dt><div class="fxs1">
	<select name="" class="fu1">
	<%foreach (var v in this.Selects1) { %>
    <option><%=v.DqName%></option>
    <%} %>	
	</select> 
	
	<select name="" class="fu2">	
	<%foreach (var v in this.Selects2) { %>
    <option><%=v.DqName%></option>
    <%} %>
	</select>
	ʡ���У�
	
    <select name="" class="fu3">
	<%foreach (var v in this.Selects3) { %>
    <option><%=v.DqName%></option>
    <%} %>
	</select>
	����
	<select name="" class="fu4"><option>����</option></select> �����أ� 
	</div></dt>
     
	 
	 
	 <dd>����Ʒ�ƣ�</dd>
    <dt>
	<%foreach(System.Data.DataRow row in dt1.Rows){%>
	<span class="fdlpp"><input name="" type="checkbox" value="" class="fxsfxk" /><%=row["Ʒ������"].ToString() %></span>
     <%}%>
	</dt>
		
		
     <dd>��˾��飺</dd>
    <dt><textarea name="" cols="" rows="" class="fgsjj"></textarea></dt>
	
	
	
	<!--
     <dd>��˾ͼƬ��</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
     -->
	 
	 
	 
	 <dd>��ϵ��������</dd>
    <dt><input runat="server" name="name" id="name" type="text" class="fxsxx3"/></dt>
     <dd>��ϵ�˵绰��</dd>
    <dt><input runat="server" name="phone" id="phone" type="text" class="fxsxx3"/></dt>
    
 </dl>

<span class="fxsbc"><a href="#"><input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg" ></a></span></div>
</div>
</div>
</form>



<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->





<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<script type="text/javascript">
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
</body>
</html>
