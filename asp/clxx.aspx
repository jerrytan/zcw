<!--
        ��������ҳ��
        �ļ�����clxx.aspx
        ���������cl_id
        owner:������
               
    -->

<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ϣ����ҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/lrtk.js" ></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="js/SJLD.js" ></script>
<script type="text/javascript" language="javascript">
    var $j = jQuery.noConflict();
    $j(document).ready(function () {
        var url = "clxx_ajax.aspx";
        var fxsmsg = $j("#fxsid_msg").val();
        var fxscount = $j("#fxscount_msg").val();

        $j("#s1").change(function () {
            var item1 = $j("#s1 option:selected").text();
            var data = { address: item1, cl_id: fxsmsg};
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //���зָ�
                    var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                    var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                    $j("#clfxs_list").html(fxs_list); //�滻ɸѡ������
                    $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                }
            }, "text");
        });
        $j("#s2").change(function () {
            var item2 = $j("#s2 option:selected").text();
            var data = { address: item2, cl_id: fxsmsg};
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //���зָ�
                    var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                    var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                    $j("#clfxs_list").html(fxs_list); //�滻ɸѡ������
                    $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                }
            }, "text");
        });
        $j("#s3").change(function () {
            var item3 = $j("#s3 option:selected").text();
            var data = { address: item3, cl_id: fxsmsg};
            $j.post(url, data, function (msg) {
                var content = msg;
                if (content.indexOf("@") >= 0) {
                    var str_fxs = msg.split('@'); //���зָ�
                    var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                    var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                    $j("#clfxs_list").html(fxs_list); //�滻ɸѡ������
                    $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                }
            }, "text");
        });
    });
    </script>
<script runat="server"> 

        protected DataTable dt_clxx = new DataTable();   //��������(���ϱ�)
		protected DataTable dt_flxx = new DataTable();   //��������(���Ϸ����)
		protected DataTable dt_ppxx = new DataTable();   //Ʒ������(Ʒ���ֵ�)
		protected DataTable dt_scsxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_fxsxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_image = new DataTable();  //���ϴ�ͼƬ(���϶�ý����Ϣ��)
		protected DataTable dt_images = new DataTable();  //����СͼƬ(���϶�ý����Ϣ��)
        
        protected int CurrentPage=1;    
        protected int Page_Size=2;
        protected int PageCount;

        private string cl_id;	//����id
        private string cl_number; //���ϱ��
		private string ppid;	 //Ʒ��id
        protected DataConn dc_obj = new DataConn();
        protected string content; //���湩Ӧ����Ϣ
        protected string fy_list; //�����ҳ��Ϣ

        protected void Page_Load(object sender, EventArgs e)
        {		      
        
			cl_id = Request["cl_id"];

            string str_sqlclname = "select ��ʾ��,fl_id,���ϱ��� from ���ϱ� where cl_id='"+cl_id+"' ";           
            dt_clxx = dc_obj.GetDataTable(str_sqlclname);

             //���ϱ���ʼ�����1
            string str_updatecounter = "update ���ϱ� set ���ʼ��� = (select ���ʼ��� from ���ϱ� where cl_id = '"+ cl_id +"')+1 where cl_id = '"+ cl_id +"'";   
            dc_obj.ExecuteSQL(str_updatecounter,true);
			
            string fl_id = Convert.ToString(dt_clxx.Rows[0]["fl_id"]);
			string str_sqlxsmz = "select ��ʾ����,������� from ���Ϸ���� where fl_id='"+fl_id+"' ";           
            dt_flxx = dc_obj.GetDataTable(str_sqlxsmz);
			
			string str_sqlppmc = "select pp_id,Ʒ������,����ͺ�,���ϱ��� from ���ϱ� where cl_id='"+cl_id+"' ";            
            dt_ppxx = dc_obj.GetDataTable(str_sqlppmc);
			
			string str_sqlgysxx =  "select ��ϵ���ֻ�,��Ӧ��,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where ��λ����='������' and gys_id in (select gys_id from ���ϱ� where cl_id='"+cl_id+"') ";
            dt_scsxx = dc_obj.GetDataTable(str_sqlgysxx);
			
			string str_sqltop3 =  "select top 3 ��ŵ�ַ,�������� from ���϶�ý����Ϣ�� where cl_id='"+cl_id+"' and ý������ = 'ͼƬ' and ��С='��'";        
            dt_image = dc_obj.GetDataTable(str_sqltop3);
			
			string str_sqlfcdz = "select ��ŵ�ַ,�������� from ���϶�ý����Ϣ�� where cl_id='"+cl_id+"' and ý������ = 'ͼƬ' and ��С='С'";            
            dt_images = dc_obj.GetDataTable(str_sqlfcdz);
        
            string str_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id = (select pp_id from ���ϱ� where cl_id='"+cl_id+"'))";         
            dt_fxsxx = dc_obj.GetDataTable(str_fxsxx);
			
            string strP = Request.QueryString["p"];
            if(string.IsNullOrEmpty(strP))//�жϴ������Ĳ����Ƿ�Ϊ��  
            {
                strP = "1";
            }
            
            int p;
            bool b1 = int.TryParse(strP, out p);
            if (b1 == false)
            {
                p = 1;
            }
            CurrentPage = p;
                
            //��ȡ"��ҳ��"
            string strC = "";
            if(string.IsNullOrEmpty(strC))
            {
                double recordCount = this.GetCLFXSCount(); 
                double d1 = recordCount / Page_Size; 
                double d2 = Math.Ceiling(d1); 
                int pageCount = (int)d2; 
                strC = pageCount.ToString();
            }
            int c;
            bool b2 = int.TryParse(strC,out c);
            if (b2 == false)
            {
                c = 1;
            }
            PageCount = c;

            //����/��ѯ��ҳ����
            int begin = (p - 1) * Page_Size + 1;
            int end = p * Page_Size;
            dt_fxsxx = this.GetPageList(cl_id,begin,end);

            if(dt_fxsxx != null && dt_fxsxx.Rows.Count>0 )
            {
                //��Ӧ���б�
                foreach(System.Data.DataRow row in dt_fxsxx.Rows)
                {
                     content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                            + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                            + row["��Ӧ��"].ToString() + "</li><li>��ϵ�ˣ�"
                            + row["��ϵ��"].ToString() + "</li><li>�绰��"
                            + row["��ϵ���ֻ�"].ToString() + "</li><li>��ַ��"
                            + row["��ϵ��ַ"].ToString() + "</li></ul></a></div>";
                }
                 //��ҳ��ʾ��Ϣ
               	 if((CurrentPage <= 1) && (PageCount <=1)) { //һҳ
					fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>��һҳ</font>&nbsp;<font style='color:Gray'>��һҳ</font>&nbsp;&nbsp;��"
					+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
				}
				else if((CurrentPage<= 1)  && (PageCount>1)) {//��ҳ 
					fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>��һҳ</font>&nbsp;<a href='clxx.aspx?cl_id="
					+ cl_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
					+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
				}   
				else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //��ҳ
					fy_list += "<span style='font-size:12px;color:Black'><a href='clxx.aspx?cl_id="
					+ cl_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<a href='clxx.aspx?cl_id="
					+ cl_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
					+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
				}
				else if((CurrentPage == PageCount) && (PageCount > 1)){  //ĩҳ
					fy_list += "<span style='font-size:12px;color:Black'><a href='clxx.aspx?cl_id="
					+ cl_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<font style='color:Gray'>��һҳ</font>&nbsp;&nbsp;��"
					+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>"; 
				}
            }
        
        }		
         //�����ݿ��ȡ��¼��������
        protected int GetCLFXSCount()
        {
            int i_count=0;
            try
            {
                string cl_id = Request["cl_id"];   //��ȡ��Ӧ��id
                string str_sql_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id = (select pp_id from ���ϱ� where cl_id='"+cl_id+"'))"; 
                i_count = dc_obj.GetRowCount(str_sql_fxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 

        //��ȡ��ҳ��Ϣ:cl_id ����id, begin ��ʼ, end ����
        protected DataTable GetPageList(string cl_id, int begin, int end)
        {
            
            //ִ�з�ҳ��sql���
            string str_sqlpage = @"select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from (select ROW_NUMBER() over (order by gys_id) as RowId,* from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id = (select pp_id from ���ϱ� where cl_id= @cl_id )))t where t.RowId between @begin and @end";
            //�����Ӧ����ֵ
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@cl_id",SqlDbType.VarChar),
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = cl_id;
            return  dc_obj.GetDataTable(str_sqlpage,parms);
        }
</script>
</head>
<body>
<!-- ͷ����ʼ-->
<!-- #include file="static/header.aspx" -->
<!-- ͷ������-->

<!-- ������ʼ-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- ��������-->

<!-- banner��ʼ-->
<!-- #include file="static/banner.aspx" -->
<!-- banner ����-->

<div class="sc">
    <!-- ���������� ��ʼ -->
    <div class="sc1"><a href="index.aspx">��ҳ ></a>
    <% foreach(System.Data.DataRow row in dt_flxx.Rows){%>
        <a href="ejfl.aspx?name=<%=row["�������"].ToString() %>"><%=row["��ʾ����"].ToString() %></a>
    <%}%>> 
    <% foreach(System.Data.DataRow row in dt_clxx.Rows){%>
        <a href="clxx.aspx?cl_id=<%=cl_id %>"><%=row["��ʾ��"].ToString() %></a>
    <%}%>
    </div>
    <!-- ���������� ���� -->
    
	<!-- ͼƬ�б���ղ� ��ʼ -->
    <div class="xx1">
        <div class="xx2">
            <div style="HEIGHT: 300px; OVERFLOW: hidden;" id="idTransformView">
                <ul id="idSlider" class="slider">
					<%
	                foreach(System.Data.DataRow row in dt_images.Rows)
                    {%>
                    <div style="POSITION: relative">
                    	<%
	                    if(row["��ŵ�ַ"].ToString()!="")
	                    {%>
                            <a ><img  src="<%=row["��ŵ�ַ"].ToString()%>" width="320" height="300" id="bigImage"></a>
                        <%}%>
                    
                    </div>
					<%}%>
                </ul>
            </div>
            <div>
                <ul id="idNum" class="hdnum">
                <% for (int i=0;i< dt_images.Rows.Count;i++){
                    System.Data.DataRow row =dt_images.Rows[i];
                %>   
                    <li>
                        <img src='<%=row["��ŵ�ַ"].ToString()%>' width="61px" height="45px" click="changeImage('<%=row["��ŵ�ַ"].ToString()%>')">
                    </li>
                <%}%>
                </ul>
            </div>
        </div>
    
        <div class="xx3">
            <dl>
                  <% foreach(System.Data.DataRow row in dt_ppxx.Rows){
					ppid =  row["pp_id"].ToString();
					cl_number = row["���ϱ���"].ToString();
                  %>
                  <dd>Ʒ��:</dd>
                  <dt style="height:30px;"><%=row["Ʒ������"].ToString() %></dt>
                  
				  <dd>�ͺ�:</dd>
                  <dt style="height:30px;"><%=row["����ͺ�"].ToString() %></dt>
                  <dd>����:</dd>
                  <dt style="height:30px;"><%= cl_number %></dt>
                  <%}%> 
            </dl>
			<%
				//��Ӧ��
				HttpCookie GYS_QQ_id = Request.Cookies["GYS_QQ_ID"];   
				Object GYS_YH_id = Session["GYS_YH_ID"];  
				if((GYS_QQ_id == null ) && (GYS_YH_id == null))	//��Ӧ��δ��¼����ʾ�ղ�
				{
			%>
					<span class="xx4" style=" display:block; margin-left:40%; margin-right:auto;"  onclick="sc_login(<%=cl_id %>)">
						<a href="" onclick="NewWindow('<%=cl_number %>',<%=ppid %>)">���ղأ����ڲ���</a>
					</span>	
			<%
				}
			%>
               
        </div>
    </div>
    <!-- ͼƬ�б���ղ� ���� -->

    <!-- ��������Ӧ����������Ϣ ��ʼ -->
    <div class="xx5">
        <img src="images/sst_03.jpg" />
        <div class="xx6">
            <ul>
                <li class="xx7">��������Ϣ</li>
		        <% foreach(System.Data.DataRow row in dt_scsxx.Rows){%>  
                <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
                <li>������<%=row["��Ӧ��"].ToString()%></li>
                <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
                <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
                </a>
		        <%}%>  
            </ul>
        </div>
    </div>
    <!-- ��������Ӧ����������Ϣ ���� -->

    <!-- ��ʾ �����б��Ӧ��Ӧ����Ϣ ��ʼ -->
    <div class="xx8" >
        <div class="xx9">
            <div class="fxs1">
                <select id="s1" class="fu1"><option></option></select> ʡ���У�
                <select id="s2" class="fu2"><option></option></select> �ؼ���
                <select id="s3" class="fu3"><option></option></select> �С��ؼ��С���
                <script type="text/javascript"  language ="javascript" > 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s1", "s2", "s3"];
                    var opt0 = ["-ʡ(��)-", "-�ؼ��С���-", "-�ؼ��С��ء���-"];
                    for (i = 0; i < s.length - 1; i++)
                    document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script>
            </div>
            <!-- ��Ŵ�ֵ����-->
                <input type="hidden" id="fxsid_msg" name="fxsid_msg" value="<%=cl_id %>"/>
            <div id="clfxs_list">
                <%=content %>
            </div>
        </div>
    </div>
    <!-- ��ʾ �����б��Ӧ��Ӧ����Ϣ ���� -->
    <div id="fy_list" style=" margin-left:34%;margin-top:40px;float:left;height:auto;width:400px;">
            <%=fy_list %> 
    </div>


    <!-- ��ʾ3�Ŵ�ͼƬ ��ʼ -->
    <%foreach(System.Data.DataRow row in dt_image.Rows){%>
    <div class="xx10">
        <div class="xx11">
            <img alt="��ŵ�ַ" src="<%=row["��ŵ�ַ"].ToString()%>" />
        </div>
    </div>
    <%}%>
    <!-- ��ʾ3�Ŵ�ͼƬ ���� -->
   
    <!-- ��ʾ ��Ƶ ��ʼ -->
    <% if (cl_id.Equals("74")) { %>
    <div class="xx10">
        <div class="xx11">������Ƶ</div>
        <embed src="http://tv.people.com.cn/img/2010tv_flash/outplayer.swf?xml=/pvservice/xml/2011/10/6/12d1c210-dd85-4872-8eb2-33b224fb0743.xml&key=�������:/150716/152576/152586/&quote=1&" quality="high" width="480" height="384" align="middle" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash"></embed>
    </div>
    <% } %>
    <!-- ��ʾ ��Ƶ ���� -->
</div>

<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->
<script language="javascript">
  mytv("idNum","idTransformView","idSlider",300,5,true,2000,5,true,"onmouseover");
  //��ť����aa����������bb����������cc���������dd����������ee����������ff����ʱgg�������ٶ�hh���Զ�����ii��
 </script>


<script type="text/javascript">
    function NewWindow(number,ppid) {
		var url = "sccl.aspx?cl_id=" + number + "|" + ppid;        
		window.open(url,"","height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
    }
    function changeImage(src) {
        document.getElementById("bigImage").src = src;
    }
</script>
</body>
</html>