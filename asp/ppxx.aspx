<!--
        Ʒ������ҳ��
        �ļ�����ppxx.ascx
        ���������pp_id    Ʒ�Ʊ��
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
    <title>Ʒ����Ϣҳ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/SJLD.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var $j = jQuery.noConflict();
        $j(document).ready(function () {
            $j("#ppxfxs").show();
            $j("#ppxcp").hide();
            $j(".gydl ul li .tab1").click(function () {
                $j("#ppxfxs").show();
                $j("#ppxcp").hide();
            });
            $j(".gydl ul li .tab2").click(function () {
                $j("#ppxcp").show();
                $j("#ppxfxs").hide();
            });


            var url = "ppxx_ajax.aspx";
            var pp_id = $j("#ppfid_msg").val();
            var ppfxs_count = $j("#ppfcount_msg").val();
            $j("#s1").change(function () {
                var item1 = $j("#s1 option:selected").text();
                var data = { address: item1, pp_id: pp_id};
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var ppfxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var pp_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#ppfxs_list").html(ppfxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(pp_fy);      //�滻ɸѡ������
                    }
                }, "text");
            });
            $j("#s2").change(function () {
                var item2 = $j("#s2 option:selected").text();
                var data = { address: item2, pp_id: pp_id };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var ppfxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var pp_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#ppfxs_list").html(ppfxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(pp_fy);      //�滻ɸѡ������
                    }
                }, "text");
                
            });
            $j("#s3").change(function () {
                var item3 = $j("#s3 option:selected").text();
                var data = { address: item3, pp_id: pp_id };
                $j.post(url, data, function (msg) {
                    var content = msg;
                    if (content.indexOf("@") >= 0) {
                        var str_fxs = msg.split('@'); //���зָ�
                        var ppfxs_list = str_fxs[0];  //��Ӧ����Ϣ
                        var pp_fy = str_fxs[1];    //��ҳ��Ϣ
                        $j("#ppfxs_list").html(ppfxs_list); //�滻ɸѡ������
                        $j("#fy_list").html(pp_fy);      //�滻ɸѡ������
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
        protected DataTable dt_ppxx = new DataTable(); //Ʒ������(Ʒ���ֵ��)
		protected DataTable dt_scsxx = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_fxsxx = new DataTable(); //��������Ϣ(��Ӧ�̺ͷ�������ر�)
		protected DataTable dt_clxx = new DataTable(); //��Ʒ���µĲ�Ʒ(���ϱ�)
        protected DataConn objdc = new DataConn();
        protected string pp_id; //Ʒ��id

        protected DataTable dt_content = new DataTable();//��ҳ��Ϣ
        protected int CurrentPage=1;    
        protected int Page_Size=2;
        protected int PageCount;
        protected string content;
        protected string fy_list;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                pp_id = Request["pp_id"];  //��ȡ��������pp_id
                
                string str_sqlppxx = "select Ʒ������,scs_id  from Ʒ���ֵ� where pp_id='"+pp_id+"'";      
                dt_ppxx = objdc.GetDataTable(str_sqlppxx);				

                 //���ʼ�����1
                string str_updatecounter = "update Ʒ���ֵ� set ���ʼ��� = (select ���ʼ��� from Ʒ���ֵ� where pp_id = '"+ pp_id +"')+1 where pp_id = '"+ pp_id +"'";
                objdc.ExecuteSQL(str_updatecounter,true);

                string str_sqlscsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+pp_id+"' )";   
                dt_scsxx = objdc.GetDataTable(str_sqlscsxx);			
			
                //��ø�Ʒ�Ƶķ�����Ϣ
                string str_sqlfxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+pp_id+"')";           
                dt_fxsxx = objdc.GetDataTable(str_sqlfxsxx);
			
			    string str_sqlclxx = "select ��ʾ�� ,����ͺ�,cl_id from ���ϱ� where pp_id='"+pp_id+"'  ";        
                dt_clxx = objdc.GetDataTable(str_sqlclxx);


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
                    double recordCount = this.GetPPFXSCount(); 
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
                dt_content = this.GetPageList(pp_id,begin,end);
                if(dt_content !=null && dt_content.Rows.Count>0)
                {
                    foreach(System.Data.DataRow row in dt_content.Rows)
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
						fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>��һҳ</font>&nbsp;<a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
                        + CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
					}   
					else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //��ҳ
						fy_list += "<span style='font-size:12px;color:Black'><a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;&nbsp;��"
                        + CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>";
					}
					else if((CurrentPage == PageCount) && (PageCount > 1)){  //ĩҳ
						fy_list += "<span style='font-size:12px;color:Black'><a href='ppxx.aspx?pp_id="
                        + pp_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>��һҳ</a>&nbsp;<font style='color:Gray'>��һҳ</font>&nbsp;&nbsp;��"
                        + CurrentPage.ToString() + "ҳ/��" + PageCount.ToString() + "ҳ</span>"; 
					}
                }

            }
        }	      
        
        //�����ݿ��ȡ��¼��������
        protected int GetPPFXSCount()
        {
            int i_count=0;
            try
            {
                string ppxx_id = Request["ppxx_id"];   //��ȡƷ��id
                string str_sql_ppfxsxx = "select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+pp_id+"')"; 
                i_count = objdc.GetRowCount(str_sql_ppfxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        }    

        //��ȡ��ҳ��Ϣ:pp_id Ʒ��id, begin ��ʼ, end ����
        protected DataTable GetPageList(string pp_id, int begin, int end)
        {
            //ִ�з�ҳ��sql���
            string str_sqlpage = @"select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from(select ROW_NUMBER() over (order by gys_id) as RowId ,* from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id=@pp_id))t where t.RowId between @begin and @end ";
            //�����Ӧ����ֵ
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@pp_id",SqlDbType.VarChar)
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = pp_id;
            return  objdc.GetDataTable(str_sqlpage,parms);
        } 
    </script>
    <div class="gysxx">
        <!-- ��ҳ Ʒ����Ϣ ��ʼ-->
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp
            <% foreach(System.Data.DataRow row in dt_ppxx.Rows)
            {%>
                <a href="#"><%=row["Ʒ������"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt_scsxx.Rows)
                {%>
                <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
                    <p>������<%=row["��Ӧ��"].ToString() %></p>
                    <p>��ַ��<%=row["��ϵ��ַ"].ToString() %></p>
                    <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                    <p>�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                </a>
                <%}%>
            </div>
        </div>
         <!-- ��ҳ Ʒ����Ϣ ����-->
        <div class="gydl">
            <ul style="padding-left:20px; margin-top:4px;">
                <li style="float:left; height:28px; line-height:28px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab1"  style="border:1px solid Gray; font-size:14px;display:block">��Ʒ���·�����</a>
                </li>
                <li style="float:left; height:28px; line-height:28px; margin-right:2px;">
                    <a href="javascript:void(0)" class="tab2"  style="border:1px solid Gray; font-size:14px;display:block">��Ʒ���²�Ʒ</a>
                </li>
            </ul>
        </div>
        
        <!-- ��Ʒ�Ʒ����� ��ʼ-->
        <div class="gydl" id="ppxfxs">
            <div class="dlpp">��Ʒ�Ʒ�����</div>
            <div class="fxs1" style="margin-left:10px;">
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
                <div id="ppfxs_list">
                    <%=content %>
                </div>
           </div>
            <!-- ��Ŵ�ֵ����-->
                <input type="hidden" id="ppfid_msg" name="ppfid_msg" value="<%=pp_id %>"/>

            <!-- Ʒ�Ʒ����� ��ʾ��ʼ-->
             <div id="fy_list" style=" margin-left:34%;margin-top:10px;float:left;height:auto;width:400px;">
                    <%=fy_list %>
             </div>
            <!-- Ʒ�Ʒ����� ��ʾ����-->
        </div>
        <!-- ��Ʒ�Ʒ����� ����-->

        <!-- ��Ʒ���²�Ʒ ��ʼ-->
        <div class="gydl" id="ppxcp">
            <div class="dlpp">��Ʒ���²�Ʒ</div>
            <%foreach(System.Data.DataRow row in dt_clxx.Rows)
            {%>
            <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
                <div class="ppcp">
                    <%	    
                        string str_sqltop1 = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"+row["cl_id"]+"' and ��С='С'";
                        string imgsrc= "images/222_03.jpg";
                        object result = objdc.DBLook(str_sqltop1);
                        if (result != null) {
                            imgsrc = result.ToString();
                        }
                        Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
				    %>
                    <span class="ppcp1"><%=row["��ʾ��"].ToString() %></span>
                    <span class="ppcp2">���<%=row["����ͺ�"].ToString() %></span>
                </div>
            </a>
            <%}%>
        </div>
        <!-- ��Ʒ���²�Ʒ ����-->
    </div>

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
