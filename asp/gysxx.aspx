<!--
        ��Ӧ����Ϣҳ��
        �ļ�����gysxx.aspx
        ���������gys_id    ��Ӧ�̱��
        ������:����       
    -->
<%@ Register Src="/asp/include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=8ee0deb4c10c8fb4be0ac652f83e8f5d"></script>
    <title>���Ϲ�Ӧ����Ϣ</title>
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            var url = "gysxx_ajax.aspx";
            var fxsmsg = $j("#fxsid_msg").val();
            var fxscount = $j("#fxscount_msg").val();
            $j("#s1").change(function () {
                var item1 = $j("#s1 option:selected").text();
                var data = { address: item1, gys_id: fxsmsg, gys_count: fxscount };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#fxsxx_list").html(fxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                    }
                }, "text");
            });
            $j("#s2").change(function () {
                var item2 = $j("#s2 option:selected").text();
                var data = { address: item2, gys_id: fxsmsg, gys_count: fxscount };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#fxsxx_list").html(fxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                    }
                },"text");
            });
            $j("#s3").change(function () {
                var item3 = $j("#s3 option:selected").text();
                var data = { address: item3, gys_id: fxsmsg, gys_count: fxscount };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@")>= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var fxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var fxs_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#fxsxx_list").html(fxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(fxs_fy);      //�滻ɸѡ������
                    } 
                }, "text");
            });
        });
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

     <script runat="server">
        protected DataTable dt_fxsxx = new DataTable();  //��Ӧ����Ϣ����(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_gysxx = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_ppxx = new DataTable(); //����Ʒ��(Ʒ���ֵ�)
		protected DataTable dt_clxx = new DataTable(); //�ֻ���Ӧ(���ϱ�)

        protected string gys_id;    //��Ӧ��id
        protected string gys_type;  //��Ӧ�����ͣ������̺ͷ�����
        protected string gys_addr;
        protected string address;  //��Ӧ�̵�ַ
        protected DataConn dc = new DataConn();
        protected DataTable dt_content = new DataTable(); //��ҳ���ŵķ�������Ϣ
        protected DataTable dt_qymc = new DataTable();// ������������

        private const int Page_Size = 2; //ÿҳ�ļ�¼����
        private int CurrentPage=1;//��ǰĬ��ҳΪ��һҳ
        private int PageCount; //��ҳ��

        protected string content = "";  //��Ź�Ӧ����Ϣ
        protected string fy_list = "";  //��ŷ�ҳ��Ϣ

        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                gys_id = Request["gys_id"];   //��ȡ��Ӧ��id 

                /*��ȡ������Ϣ*/
                string str_sqlqymc = "select ����������,������������  from ���������ֵ� group by ����������,������������";
                dt_qymc = dc.GetDataTable(str_sqlqymc);                    

			    string str_sqlclgys = "select ��Ӧ��,��λ����,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gys_id+"'";            
                dt_gysxx = dc.GetDataTable(str_sqlclgys);

                //���ʼ�����1
                String str_updatecounter = "update ���Ϲ�Ӧ����Ϣ�� set ���ʼ��� = (select ���ʼ��� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+ gys_id +"')+1 where gys_id = '"+ gys_id +"'";
                dc.ExecuteSQL(str_updatecounter,true);      

                //�����ݽ����ж�
                if(dt_gysxx!=null && dt_gysxx.Rows.Count>0)
                {
                    //��ù�Ӧ�̵ĵ�λ���ͣ������̻��Ƿ�����
                    gys_type = Convert.ToString(dt_gysxx.Rows[0]["��λ����"]);		
                 }

                //�ж�gys_type�Ƿ�Ϊ��
                if(!string.IsNullOrEmpty(gys_type))
                {
                    //������Ϊ����Ʒ�ƺ��������۲���
                    if(gys_type.Equals("������")) 
                    {
                        //��ô���Ʒ����Ϣ
			            string str_sqldlppxx = "select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where fxs_id='"+gys_id+"'";           
                        dt_ppxx = dc.GetDataTable(str_sqldlppxx);
			
                        //������ڷ����Ĳ����б�
			            string str_sqlfxcl = "select ��ʾ��,cl_id from ���ϱ� where pp_id in(select pp_id from  �����̺�Ʒ�ƶ�Ӧ��ϵ�� where fxs_id ='"+gys_id+"') ";           
                        dt_clxx = dc.GetDataTable(str_sqlfxcl);
                    }
                    else   //����������ʾ����Ʒ�ƺ����ķ�����
                    {
                        //��ȡƷ����Ϣ
			            string str_sqlppxx = "select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ����� = '1' and scs_id='"+gys_id+"'";           
                        dt_ppxx = dc.GetDataTable(str_sqlppxx);
			
                        //��ȡ��������Ϣ
                        //�Ӳ�ѯǶ�� �ȸ��ݴ�������gys_id��Ʒ������  �ٴ�Ʒ���ֵ���鸴��������gys_id �����ݸ���������gys_id���������Ϣ
			            string str_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )";          
                        dt_fxsxx = dc.GetDataTable(str_fxsxx);

                        //���������·����� ��ҳ��ʾ
                           //�Ӳ�ѯ�ַ����л�ȡ"ҳ��"����
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
                
                            //�Ӳ�ѯ�ַ����л�ȡ"��ҳ��"����
                            string strC = "";
                            if(string.IsNullOrEmpty(strC))
                            {
                                double recordCount = this.GetFXSCount(); 
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
                            dt_content = this.GetPageList(gys_id,begin,end);

                            if(dt_content != null && dt_content.Rows.Count>0)//������,����б���
                            {   
                                foreach(System.Data.DataRow row in dt_content.Rows)
                                {
                                    content += "<div class='fxs2'><a href='gysxx.aspx?gys_id='"
                                        + row["gys_id"].ToString() + "><ul><li class='fxsa'>"
                                        + row["��Ӧ��"].ToString() + "</li><li>��ϵ�ˣ�"
                                        + row["��ϵ��"].ToString() + "</li><li>�绰��"
                                        + row["��ϵ���ֻ�"].ToString() + "</li><li>��ַ��"
                                        + row["��ϵ��ַ"].ToString() + "</li></ul></a></div>";
                                }

                                //��ҳ��ʾ��Ϣ
                                if(CurrentPage>1 && CurrentPage!=PageCount)
                                {
                                    fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
                                    + gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a><a href='gysxx.aspx?gys_id="
                                    + gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>��"
                                    + CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
                                }
                            }        
                        }	
                    }	
                }
        }

        //�����ݿ��ȡ��¼��������
        protected int GetFXSCount()
        {
            int i_count=0;
            try
            {
                string gys_id = Request["gys_id"];   //��ȡ��Ӧ��id
                string str_sql_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )"; 
                i_count = dc.GetRowCount(str_sql_fxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 

        //��ȡ��ҳ��Ϣ:gys_id ������id, begin ��ʼ, end ����, address ��ַ
        protected DataTable GetPageList(string gys_id, int begin, int end)
        {
            
            //ִ�з�ҳ��sql���
            string str_sqlpage = @"select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from (select ROW_NUMBER() over (order by gys_id) as RowId ,* from ���Ϲ�Ӧ����Ϣ��  where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id=@gys_id) ))t where t.RowId between @begin and @end ";
            //�����Ӧ����ֵ
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@gys_id",SqlDbType.VarChar),
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = gys_id;
            return  dc.GetDataTable(str_sqlpage,parms);
        }
     </script>

    <!-- ��ҳ ��Ӧ����Ϣ ��ʼ-->
    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_gysxx.Rows){%>
            <a href="#"><%=row["��Ӧ��"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt_gysxx.Rows){
                       gys_addr = row["��ϵ��ַ"].ToString();%>
                <p>������<%=row["��Ӧ��"].ToString() %></p>
                <p>��ַ��<%=gys_addr%></p>
                <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                <p>��ϵ�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="" onclick="NewWindowRL(<%=gys_id %>)">������δ���죬������ǵ����������챾�꣬����֮�����ά�������Ϣ</a></div>
            <div class="gyan1"><a href="" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>
        </div>		
		<div class="gydl">
            <div class="dlpp">����λ��</div>
			<div id="allmap"></div>
            <script type="text/javascript">
                // �ٶȵ�ͼAPI����
                var map = new BMap.Map("allmap");
                var point = new BMap.Point(116.331398, 39.897445);
                map.centerAndZoom(point, 15);
                // ������ַ������ʵ��
                var myGeo = new BMap.Geocoder();
                // ����ַ���������ʾ�ڵ�ͼ��,��������ͼ��Ұ
                myGeo.getPoint("<%=gys_addr %>", function (point) {
                    if (point) {
                        map.centerAndZoom(point, 13);
                        map.addOverlay(new BMap.Marker(point));
                    }
                }, "<%=gys_addr %>");
            </script>
        </div>
		
        <% if (gys_type.Equals("������")) {%>
        <!-- ����Ʒ�� ��ʼ-->
        <div class="gydl">
            <div class="dlpp">����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
              {%>
                    <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <img src="images/222_03.jpg" />
                        <span><%=row["Ʒ������"].ToString()%></span>
                    </div>
                    </a>
            <%}%>
        </div>
        <!-- ����Ʒ�� ����-->
        
        <!-- �ֻ���Ӧ ��ʼ-->
        <div class="gydl">
            <div class="dlpp">�ֻ���Ӧ</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">			
                <div class="gydl1">
			    <%	
                    string str_sqltop1 = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"+row["cl_id"]+"' and ��С='С'";
                    string imgsrc= "images/222_03.jpg";
                    object result = dc.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");			
			    %>
			    <%=row["��ʾ��"].ToString() %>
			    </div>
                </a>
            <%}%>
            </div>
        <% }else {  //������%>
            <!-- ��˾����Ʒ�� ��ʼ-->
            <div class="gydl">
            <div class="dlpp">��˾����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {   %>
                <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <img src="images/222_03.jpg" />
                        <span ><%=row["Ʒ������"].ToString()%></span>
                    </div>
                </a>
            <%}%>
         </div>
            <!-- ��˾����Ʒ�� ����-->

            <!-- ������ҳ ��ʼ-->
         <div class="gydl">
            <div class="dlpp">��˾���·�����</div>
            <div class="fxs1" style="margin-left:20px;">
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
               <!-- ��̬��ʾ ��ʼ-->
                <!-- ��Ŵ�ֵ����-->
                <input type="hidden" id="fxsid_msg" name="fxsid_msg" value="<%=gys_id %>"/>
                <input type="hidden" id="fxscount_msg" name="fxscount_msg" value="<%=GetFXSCount() %>" />
            
            <div id="fxsxx_list">
                <%=content %>
            </div>
               <!-- ��̬��ʾ ����-->
        </div>
        <div id="fy_list" style=" margin-left:34%;margin-top:40px;float:left;height:auto;width:400px;">
                <%=fy_list %>
        </div>
            <!-- ������ҳ ����-->
        <% }
        %>
        <!-- �ֻ���Ӧ ����-->
    </div>
    <!-- ��ҳ ��Ӧ����Ϣ ����-->

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

    <script language="javascript" type="text/javascript">
        function NewWindow(id) {
            var url = "scgys.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function NewWindowRL(id) {
            var url = "rlcs.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
    </script>
</body>
</html>
