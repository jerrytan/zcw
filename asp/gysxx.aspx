<!--
        ��Ӧ����Ϣҳ��
        �ļ�����gysxx.aspx
        ���������gys_id    ��Ӧ�̱��
        ������:����       
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=8ee0deb4c10c8fb4be0ac652f83e8f5d"></script>
	<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/index.aspx" charset="utf8"></script>
		
    <title>���Ϲ�Ӧ����Ϣ</title>
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        $(function () {
            $("#s1").change(function () {
                $("#region").val($("#s0").children('option:selected').val() + $("#s1").children('option:selected').val());
            });
        });
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            var url = "gysxx_ajax.aspx";
            var fxsmsg = $j("#fxsid_msg").val();
            var fxscount = $j("#fxscount_msg").val();
            $j("#s1").change(function () {
                var item1 = $j("#s1 option:selected").text();
                var data = { address: item1, gys_id: fxsmsg};
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
                var data = { address: item2, gys_id: fxsmsg};
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
                var data = { address: item3, gys_id: fxsmsg };
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
        protected string gys_addr="";
        protected string address;  //��Ӧ�̵�ַ
        protected DataConn dc = new DataConn();
        protected DataTable dt_content = new DataTable(); //��ҳ���ŵķ�������Ϣ
        protected DataTable dt_qymc = new DataTable();// ������������

        private const int Page_Size = 2; //ÿҳ�ļ�¼����
        private int CurrentPage=1;//��ǰĬ��ҳΪ��һҳ
        private int PageCount; //��ҳ��

        protected string content = "";  //��Ź�Ӧ����Ϣ
        protected string fy_list = "";  //��ŷ�ҳ��Ϣ
		
		public string yh_id = "";
		public string QQ_id="";
		private string pass="";
		
        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                gys_id = Request["gys_id"];   //��ȡ��Ӧ��id 

			    string str_sqlclgys = "select ��Ӧ��,��λ����,��ϵ��,��ϵ���ֻ�,��ַ,����,��ҳ from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gys_id+"'";            
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
			            string str_fxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )";          
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
									content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                                        + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                                        + row["��Ӧ��"].ToString() + "</li><li>��ϵ�ˣ�"
                                        + row["��ϵ��"].ToString() + "</li><li>�绰��"
                                        + row["��ϵ���ֻ�"].ToString() + "</li><li>"
                                        + SubStrings.GetWidth(20,"��ַ��"+row["��ַ"].ToString(),"��ַ��"+row["��ַ"].ToString()) + "</li></ul></a></div>";
                                }

                               //��ҳ��ʾ��Ϣ
								if((CurrentPage <= 1) && (PageCount <=1)) { //һҳ
									 fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>��һҳ</font>&nbsp;<font style='color:Gray'>��һҳ</font>&nbsp;&nbsp;��"
									+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";

								}
								else if((CurrentPage<= 1)  && (PageCount>1)) {//��ҳ 
									fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>��һҳ</font>&nbsp;<a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
									+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
								}   
								else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //��ҳ
									fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
									+ CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
								}
								else if((CurrentPage == PageCount) && (PageCount > 1)){  //ĩҳ
									fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
									+ gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<font style='color:Gray'>��һҳ</font>&nbsp;&nbsp;��"
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
				string str_sql_fxsxx = "";
				str_sql_fxsxx = "select gys_id, ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ַ from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )";
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
            string str_sqlpage = @"select gys_id,��Ӧ��,��ϵ��,��ϵ���ֻ�,��ַ from (select ROW_NUMBER() over (order by gys_id) as RowId ,* from ���Ϲ�Ӧ����Ϣ��  where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id=@gys_id) ))t where t.RowId between @begin and @end ";
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
            <% if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
               {
                   gys_addr = dt_gysxx.Rows[0]["��ַ"].ToString();%>
 <ul>
   <li>������<a href="#" class="fxsa"><%=dt_gysxx.Rows[0]["��Ӧ��"].ToString()%></a></li>
   <li>��ϵ�ˣ�<%=dt_gysxx.Rows[0]["��ϵ��"].ToString()%></li>
   <li>�绰��<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"].ToString()%></li> 
   <li>���棺<%=dt_gysxx.Rows[0]["����"].ToString()%></li>
   <li>��ҳ��<%=dt_gysxx.Rows[0]["��ҳ"].ToString()%></li>  
   <li>��ַ��<%=gys_addr%></li></ul>
 <%} %>
            </div>
            <%if (Request.Cookies["GYS_QQ_ID"] != null || Request.Cookies["CGS_QQ_ID"] != null)
              { %>
            <%
                //��Ӧ��
                HttpCookie GYS_QQ_id = Request.Cookies["GYS_QQ_ID"];
                Object GYS_YH_id = Session["GYS_YH_ID"];

                HttpCookie CGS_QQ_id = Request.Cookies["CGS_QQ_ID"];
                Object CGS_YH_id = Session["CGS_YH_ID"];

                if (Request.Cookies["GYS_QQ_ID"] != null && Request.Cookies["GYS_QQ_ID"].Value.ToString() != "")
                {
                    QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
                }
                if (QQ_id != "")
                {
                    string str_sqlyhid = "select dw_id from �û��� where QQ_id = '" + QQ_id + "'";
                    string dwid = dc.DBLook(str_sqlyhid);
                    if (dwid != "")
                    {
                        string sql = "select count(*) from �ɹ��̹�ע��Ӧ�̱� where dw_id='" + dwid + "' and gys_id='" + gys_id + "'";
                        int count = Convert.ToInt32(dc.DBLook(sql));
                        if (count > 0)
                        {%>
            <span class="xx4_1" style="display: block; margin-left: 40%; margin-right: auto;"><a
                href="javascript:void(0)">���ղ�</a> </span>
            <%}
              else
              { %>
            <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>
            <% }
          }
      }
    }%>
            <%else
                { %>
            <%
                //��Ӧ��                     
                string YH_id = "";
                if (Session["GYS_YH_ID"] != null)
                {
                    YH_id = Session["GYS_YH_ID"].ToString();
                }


                if (Session["CGS_YH_ID"] != null)
                {
                    YH_id = Session["CGS_YH_ID"].ToString();
                }
                string str_sqlyhid = "select dw_id from �û��� where yh_id = '" + YH_id + "'";
                string dwid = dc.DBLook(str_sqlyhid);
                if (dwid != "")
                {
                    string sql = "select count(*) from �ɹ��̹�ע��Ӧ�̱� where dw_id='" + dwid + "' and gys_id='" + gys_id + "'";
                    int count = Convert.ToInt32(dc.DBLook(sql));
                    if (count > 0)
                    {%>
            <span class="xx4_1" style="display: block; margin-left: 40%; margin-right: auto;"><a
                href="javascript:void(0)">���ղ�</a> </span>
            <%	}

          else
          {%>
            <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>
            <%}
      }
else
	{%>
             <div class="gyan1">
                <a href="javascript:void(0)" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>        
	<%}
      }%>

		<div class="ditu">
            <div class="ditu_zi">����λ��</div>
			<div id="allmap"></div>
            <script>
                // �ٶȵ�ͼAPI����
                var map = new BMap.Map("allmap");
                var point = new BMap.Point(116.331398, 39.897445);
                map.centerAndZoom(point, 15);
                // ������ַ������ʵ��
                var myGeo = new BMap.Geocoder();
                // ����ַ���������ʾ�ڵ�ͼ��,��������ͼ��Ұ
                myGeo.getPoint'<%=gys_addr %>', function (point) {
                    if (point) {
                        map.centerAndZoom(point, 13);
                        map.addOverlay(new BMap.Marker(point));
                    }
                }, '<%=gys_addr %>');
            </script>
        </div>	
        </div>		
		
		
        <% if (gys_type.Equals("������")) {%>
        <!-- ����Ʒ�� ��ʼ-->
        <div class="gydl2">
            
            <%
                if (dt_gysxx.Rows[0]["��λ����"].ToString()=="������")
                {
                    Response.Write("<div class='dlpp'>��˾�����Ʒ��</div>");
                }
                else if (dt_gysxx.Rows[0]["��λ����"].ToString()=="������")
                {
                    Response.Write("<div class='dlpp'>��˾����Ʒ��</div>");
                }
                %>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
              {%>
                    <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <%--<img src="images/222_03.jpg" />--%>
                        <span><%=row["Ʒ������"].ToString()%></span>
                    </div>
                    </a>
            <%}%>
        </div>
        <!-- ����Ʒ�� ����-->
        
        <!-- �ֻ���Ӧ ��ʼ-->
        <div class="gydl2">
            <div class="dlpp">�ֻ���Ӧ</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">			
                <div class="gydl1">
			    <%	
                    string str_sqltop1 = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"+row["cl_id"]+"'";
                    string imgsrc= "images/222_03.jpg";
                    object result = dc.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    imgsrc = MyHelper.GetCrossDomainServer("../App_Code/config.xml") + "/" + imgsrc;
                    string strs = row["��ʾ��"].ToString();
                    StringBuilder sb = new StringBuilder();
                    int temp = 0;
                    for (int i = 0; i < strs.Length; i++)
                    {
                        if ((int)strs[i] > 127 && temp < 21)
                        {
                            sb.Append(strs[i]);
                            temp = temp + 2;
                        }
                        else if ((int)strs[i] < 127 && temp < 21)
                        {
                            sb.Append(strs[i]);
                            temp = temp + 1;
                        }
                        else
                        {
                            sb.Append("...");
                            break;
                        }
                    }
                  
                    Response.Write("<img src="+imgsrc+ " width=156px height=156px />");			
			    %>
			    <lable style=" width:156px;"><%=sb.ToString() %></lable>
			    </div>
                </a>
            <%}%>
            </div>
        <% }else {  //������%>
            <!-- ��˾����Ʒ�� ��ʼ-->
            <div class="gydl2">
            <div class="dlpp">��˾����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {   %>
                <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <%--<img src="images/222_03.jpg" />--%>
                        <span ><%=row["Ʒ������"].ToString()%></span>
                    </div>
                </a>
            <%}%>
         </div>
            <!-- ��˾����Ʒ�� ����-->

            <!-- ������ҳ ��ʼ-->
         <div class="gydl2">
            <div class="dlpp">��˾���·�����</div>
            <div class="fxs1" style="margin-left:20px;">
            <select id="s0" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>ʡ���У�
                        <select id="s1" style=" width:130px;" class="fu1" runat="server" value="">
                        </select>�ؼ���
                        <input type="hidden" id="region"  value="������" runat="server" />
                        <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
                            <script src="Scripts/Address.js" type="text/javascript"></script>
                <%--<select id="s1" class="fu1"><option></option></select> ʡ���У�
                <select id="s2" class="fu2"><option></option></select> �ؼ���
                <select id="s3" class="fu3"><option></option></select> �С��ؼ��С���
                <script type="text/javascript"  language ="javascript"> 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s1", "s2", "s3"];
                    var opt0 = ["-ʡ(��)-", "-�ؼ��С���-", "-�ؼ��С��ء���-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script> --%>
            </div>
               <!-- ��̬��ʾ ��ʼ-->
                <!-- ��Ŵ�ֵ����-->
                <input type="hidden" id="fxsid_msg" name="fxsid_msg" value="<%=gys_id %>"/>
            
            <div class="fxsxx_list">
                <%=content %>
            </div>
               <!-- ��̬��ʾ ����-->
        <div id="fy_list" style=" margin-left:34%;margin-top:10px;float:left;height:auto;width:400px;margin-bottom:10px;">
                <%=fy_list %>
        </div>
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
           //window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
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
                    var value = xmlhttp.responseText;

                    if (value == "1")
                    {
                        alert("�ղسɹ���");
                        window.location.reload();
                    }
                    else if (value == "0")
                    { 
                       window.open("cgsdl.aspx", "", "height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes");
                    }
                    else
                    {
                        alert(value);
                    }
                }
            }
             
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
           
        }
    </script>
</body>
</html>
