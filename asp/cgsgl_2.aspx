<!--
        ҳ�����ƣ�	�ɹ��̹�ע���Ϲ���ҳ
        �ļ�����	cgsgl_2.ascx
        ���������	QQid ���ڸ���QQidȡ�����Ϣ
         author������ӱ      
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>
<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>�ɹ��̹�ע���Ϲ���ҳ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <%-- <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <link href="css/cgsgzl.css" rel="stylesheet" type="text/css" />--%>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
    <script type="text/javascript">

            
        function setTab(name, cursel, n) {
            for (i = 1; i <= n; i++) {
                var menu = document.getElementById(name + i);
                var con = document.getElementById("con_" + name + "_" + i);
                menu.className = i == cursel ? "hover" : "";
                con.style.display = i == cursel ? "block" : "none";
            }
        }


        function xscl(obj) {
            var flbm = obj;
            document.getElementById("cgsglcl_frame").src = "Cgsgzcl.aspx?s_yh_id=<%=s_yh_id %>&clbm=" + flbm;
        }
        function ppgys(obj) {
            var ppid = obj;
            document.getElementById("cgsglgys_iframe").src = "Cgsgzgys.aspx?s_yh_id=<%=s_yh_id %>&ppid=" +ppid;
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
    <script runat="server">  
        public Boolean userIsVIP = false;                //�Ƿ�ΪVIP�û�
        protected string s_yh_id = "";                   //�û�ID
        public string s_QQid = "";                       //�û�QQ_ID
        public DataConn objConn = new DataConn();        //DataHelper��
        public string sSQL = "";                         //Sql���
        public DataTable dt = new DataTable();           //��ѯ���ı�
        public int firstlevel;                           //һ���˵�
        public int flevel = 0;
        public string xx = "";                           //�Ƿ������Ϣ   
        public string sftg = "";                         //�Ƿ���֤ͨ��
        //public DataTable dt_content;                     //��ҳ��ѯ�Ľ��

        //public string tbName = "���ϱ�,�ɹ��̹�ע�Ĳ��ϱ�,���Ϲ�Ӧ����Ϣ��";   //��ҳ�õı���
        //public string fields = "��ʾ��,��������,Ʒ������,��ַ,����ͺ�";  //��Ҫ���ص�����
        //public string orderName = "��ʾ��";//�����ֶ���
        //public int pageSize = 10;    //ҳ�ߴ�
        //public int pageIndex = 1;    //ҳ��
        //public int totalCount = 0;   //���ؼ�¼����, �� 0 ֵ�򷵻�
        //public int orderType = 0;    //������������, �� 0 ֵ����
        //public string strWhere = " �ɹ��̹�ע�Ĳ��ϱ�.cl_id=���ϱ�.cl_id  and  ���Ϲ�Ӧ����Ϣ��.gys_id=���ϱ�.gys_id "; //��ѯ����

        //public int pageCounts;        //��¼������
        //public int pages;             //��ҳ��


        protected DataTable dt_type = new DataTable();   //һ�������б�    
        protected List<string> list = new List<string>();//�û��ѹ�ע����б�  
        Object yh_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            //����ע�ͣ�11��7�գ�,������IF�ж�
            //string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
            //string sqlExistQQ_id = "select myID from �û��� where QQ_id='" + cgs_QQ_id + "'";
            //string sql_Level = "select �ȼ� from �û��� where QQ_id='" + cgs_QQ_id + "'";
            if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
            {
                yh_id = Session["CGS_YH_ID"];
            }
            string sqlExistQQ_id = "select myID from �û��� where yh_id='" + yh_id + "'";
            string sql_Level = "select �ȼ� from �û��� where yh_id='" + yh_id + "'";
            if (objConn.GetRowCount(sqlExistQQ_id) > 0)
            {
                if (objConn.DBLook(sql_Level) == "��ҵ�û�")
                {
                    Response.Redirect("hyyhgl.aspx");
                }
            }
            else
            {
                Response.Redirect("QQ_dlyz.aspx");
            }
            //����20141110ע��
            //if (Request.Cookies["CGS_QQ_ID"] != null && Request.Cookies["CGS_QQ_ID"].Value.ToString() != "")
            //{
            //    s_QQid = Request.Cookies["CGS_QQ_ID"].Value.ToString();   //��ȡ�ɹ��̵�¼QQ��ID
            //}
            //if (s_QQid != "")
            //{
            if (yh_id != "")
            {
                sSQL = "select count(*) from �û��� where yh_id='" + yh_id + "'";  //����QQ_id��ѯ�û��Ƿ����
                string count = objConn.DBLook(sSQL);

                string lx = "";    //�û�����
                sSQL = "select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where yh_id='" + yh_id + "'";  //����QQ_id��ѯ�û���Ϣ
                dt = objConn.GetDataTable(sSQL);
                if (dt != null && dt.Rows.Count > 0)
                {
                    s_yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);  //��ȡ�û�ID
                    string vip = dt.Rows[0]["�ȼ�"].ToString();         //��ȡ�û��ȼ�
                    if (vip == "VIP�û�")
                    {
                        userIsVIP = true;
                    }
                    lx = dt.Rows[0]["����"].ToString();               //��ȡ�û�����
                    sftg = dt.Rows[0]["�Ƿ���֤ͨ��"].ToString();     //��ȡ�Ƿ���֤ͨ��
                }

                if (lx != "�ɹ���")        //��������ݿ��ȡ����Ϣ�������ǲɹ���
                {
                    //string cookieName = "";
                    //cookieName = "CGS_YH_ID";
                    //if (Request.Cookies[cookieName] != null)
                    //{
                    //    HttpCookie myCookie = new HttpCookie(cookieName);
                    //    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    //    Response.Cookies.Add(myCookie);   //����û�ID��Ϊ�գ����û�IDд��Cookie
                    //}
                    Response.Write("<script>window.alert('�����ǲɹ��̣������òɹ�����ݵ�¼��');window.location.href='index.aspx';</" + "script>");
                }
                Session["CGS_YH_ID"] = s_yh_id;  //���û�ID���浽session

                listFollowCLIDs();
            }
            else
            {
                objConn.MsgBox(this.Page, "QQ_ID�����ڣ������µ�¼��");
            }

            //����һ������
            string sqlType_yj = "select �������,��ʾ���� from ���Ϸ���� where LEN(�������)=2 order by �������";
            dt_type = objConn.GetDataTable(sqlType_yj);

            //���ظ��û��ѹ�ע����
            string sqlType_yj_focus = "select �û���ע��� from �û��� where yh_id='" + s_yh_id + "' ";
            string Str_type_yj_focus = objConn.DBLook(sqlType_yj_focus);
            if (Str_type_yj_focus != "")
            {
                string[] strArr = Str_type_yj_focus.Split(',');
                for (int i = 0; i < strArr.Length; i++)
                {
                    list.Add(strArr[i]);
                }
            }


        }
        public DataTable dt_cgsgzcl_dl = new DataTable();   //�ɹ��̹�ע����
        public DataTable dt_cgsgzcl_xl = new DataTable();   //�ɹ��̹�עС��
        public DataTable dt_clb = new DataTable();          //���ϱ�
        public DataTable dt_clgysxx = new DataTable();      //���Ϲ�Ӧ����Ϣ
        public DataTable dt_topcl = new DataTable();        //����Table����ǰ10������
        public DataTable dt_ppxx = new DataTable();         //Ʒ����Ϣ

        /// <summary>
        /// ���ع�ע���Ϻ͹�Ӧ��
        /// </summary>   
        protected void listFollowCLIDs()
        {
            //��ȡ��ҳ��
            //Response.Write(s_yh_id);
            //strWhere = strWhere + " and �ɹ��̹�ע�Ĳ��ϱ�.yh_id='" + s_yh_id + "'";
            // DataTable dt_pageCount =  GetProductFormDB(tbName, fields, orderName, pageSize, pageIndex, 1, orderType, strWhere);
            // dt_pageCount.Rows[0]["Total"].ToString();
            // Response.Write(dt_pageCount.Rows[0]["Total"].ToString());



            string strFlmc = Request["strFlmc"];
            string sVD = Request.ApplicationPath.ToString().Substring(1);

            if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
            {
                s_yh_id = Session["CGS_YH_ID"].ToString();
            }
            //20141030 С���޸�  ȡ��λ�ղ�
            string sql_dwid = "select dw_id from �ɹ��̹�ע�Ĳ��ϱ� where yh_id='" + s_yh_id + "'";
            string dwid = objConn.DBLook(sql_dwid);
            //�����û�ID�������������ʾ����
            sSQL = "select * from (select distinct a.�������,a.��ʾ���� from ���Ϸ���� as a ,(select distinct c.������� as flbm " +
                            " from �ɹ��̹�ע�Ĳ��ϱ� as b ,���ϱ� as c  " +
                            " where b.yh_id in(select yh_id from �û��� where dw_id='" + dwid + "') and b.cl_id=c.cl_id  ) as  d " +
                           " where a.�������=d.flbm or a.�������=left(d.flbm,2))#temp where len(�������)=2";


            dt_cgsgzcl_dl = objConn.GetDataTable(sSQL);  //�ɹ��̹�ע���� һ������

            sSQL = "select * from (select distinct a.�������,a.��ʾ���� from ���Ϸ���� as a ,(select distinct c.������� as flbm " +
                           " from �ɹ��̹�ע�Ĳ��ϱ� as b ,���ϱ� as c  " +
                           " where b.yh_id in(select yh_id from �û��� where dw_id='" + dwid + "') and b.cl_id=c.cl_id  ) as  d " +
                          " where a.�������=d.flbm or a.�������=left(d.flbm,2))#temp where len(�������)=4";
            dt_cgsgzcl_xl = objConn.GetDataTable(sSQL);  //�ɹ��̹�ע���� ��������


            sSQL = "select b.cl_id ,�������,��ʾ�� from �ɹ��̹�ע�Ĳ��ϱ� as a ,���ϱ� as b  " +
                "  where a.yh_id in(select yh_id from �û��� where dw_id='" + dwid + "') and a.cl_id=b.cl_id order by b.cl_id";
            dt_clb = objConn.GetDataTable(sSQL);
          
//            if (string.IsNullOrEmpty(strFlmc))
//            {
//                sSQL = @"select top 10 ���ϱ�.cl_id,��ʾ��,��������,Ʒ������,��ַ,����ͺ� from �ɹ��̹�ע�Ĳ��ϱ�   
//                    left join ���ϱ� on �ɹ��̹�ע�Ĳ��ϱ�.cl_id=���ϱ�.cl_id  
//                    left join ���Ϲ�Ӧ����Ϣ�� on ���Ϲ�Ӧ����Ϣ��.gys_id=���ϱ�.gys_id 
//                    where �ɹ��̹�ע�Ĳ��ϱ�.yh_id='" + s_yh_id + "' ";          //���ز���ǰ10����Ϣ
//                dt_topcl = objConn.GetDataTable(sSQL);
//            }
//            else
//            {
//                sSQL = @"select  ���ϱ�.cl_id,��ʾ��,��������,Ʒ������,��ַ,����ͺ� from �ɹ��̹�ע�Ĳ��ϱ�   
//                    left join ���ϱ� on �ɹ��̹�ע�Ĳ��ϱ�.cl_id=���ϱ�.cl_id  
//                    left join ���Ϲ�Ӧ����Ϣ�� on ���Ϲ�Ӧ����Ϣ��.gys_id=���ϱ�.gys_id 
//                    where �ɹ��̹�ע�Ĳ��ϱ�.yh_id='" + s_yh_id + "' and ��������='" + strFlmc + "' ";          //���ز���ǰ10����Ϣ
//                dt_topcl = objConn.GetDataTable(sSQL);
//            }


            //sSQL = "select a.gys_id ,a.��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� as a ,�ɹ��̹�ע��Ӧ�̱� as b  " +
            //       " where b.yh_id='" + s_yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
            sSQL = "select distinct gys_id,��Ӧ������,�ղ���,�ղ���QQ from �ɹ��̹�ע��Ӧ�̱� where yh_id in(select yh_id from �û��� where dw_id='" + dwid + "') and �Ƿ�����='1'";
            dt_clgysxx = objConn.GetDataTable(sSQL);
 
            //CancelFollowButton.Attributes.Add("onClick", "return confirm('�����Ҫȡ������Щ���ϻ�Ӧ�̵Ĺ�ע��');");

        }

        /// <summary>
        /// ��òɹ��̹�ע���ϱ�
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void dumpFollowCLs(object sender, EventArgs e)
        {
            //20141030 С���޸�  ȡ��λ�ղ�
            string sql_dwid = "select dw_id from �ɹ��̹�ע�Ĳ��ϱ� where yh_id='" + s_yh_id + "'";
            string dwid = objConn.DBLook(sql_dwid);
            sSQL = "select b.* from �ɹ��̹�ע�Ĳ��ϱ� as  a ,���ϱ� as b  where a.yh_id in(select yh_id from �û��� where dw_id='" + dwid + "')  and a.cl_id = b.cl_id ";
            dt = null;
            dt = objConn.GetDataTable(sSQL);
            outToExcel(dt);   //����Excel��


        }
        private StringBuilder AppendCSVFields(StringBuilder argSource, string argFields)
        {
            return argSource.Append(argFields.Replace(",", " ").Trim()).Append(",");
        }

        public static void DownloadFile(HttpResponse argResp, StringBuilder argFileStream, string strFileName)
        {
            try
            {
                string strResHeader = "attachment; filename=" + Guid.NewGuid().ToString() + ".csv";
                if (!string.IsNullOrEmpty(strFileName))
                {
                    strResHeader = "inline; filename=" + strFileName;
                }
                argResp.AppendHeader("Content-Disposition", strResHeader);//attachment˵���Ը������أ�inline˵�����ߴ�
                argResp.ContentType = "application/ms-excel";
                argResp.ContentEncoding = Encoding.GetEncoding("GB2312");
                argResp.Write(argFileStream);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// ����excel
        /// </summary>
        /// <param name="followcls">׼��������DataTable</param>
        public void outToExcel(DataTable followcls)
        {

            StringWriter swCSV = new StringWriter();
            StringBuilder sbText = new StringBuilder();
            for (int i = 0; i < followcls.Columns.Count; i++)
            {
                AppendCSVFields(sbText, followcls.Columns[i].ColumnName);
            }
            sbText.Remove(sbText.Length - 1, 1);
            swCSV.WriteLine(sbText.ToString());

            for (int i = 0; i < followcls.Rows.Count; i++)
            {
                sbText.Clear();
                for (int j = 0; j < followcls.Columns.Count; j++)
                {
                    AppendCSVFields(sbText, followcls.Rows[i][j].ToString());
                }
                sbText.Remove(sbText.Length - 1, 1);
                swCSV.WriteLine(sbText.ToString());
            }
            string fileName = Path.GetRandomFileName();
            DownloadFile(Response, swCSV.GetStringBuilder(), fileName + ".csv");
            swCSV.Close();
            Response.End();
        }

        //���ݲ���,��ȡ���ݿ��з�ҳ�洢���̵Ľ��
        //private DataTable GetProductFormDB(string tbName, string fields, string orderName, int pageSize, int pageIndex, int totalCount, int orderType, string strWhere)
        //{
        //    SqlParameter[] spt = new SqlParameter[]
        //    {
        //        new SqlParameter("@tbName",tbName),
        //        new SqlParameter("@strGetFields",fields),
        //        new SqlParameter("@orderName",orderName),
        //        new SqlParameter("@pageSize",pageSize),
        //        new SqlParameter("@pageIndex",pageIndex),
        //        new SqlParameter("@totalCount",totalCount),
        //        new SqlParameter("@orderType",orderType),
        //        new SqlParameter("@strWhere",strWhere)
        //    };
        //    return dt_content = objConn.ExecuteProcForTable("Public_Paging", spt);
        //}

        /// <summary>
        /// ȡ����ע����
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //public void cancelFollows(object sender, EventArgs e)
        //{
        //    if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
        //    {
        //        s_yh_id = Session["CGS_YH_ID"].ToString();
        //    }
        //    string s_clid = Request.Form["clid"];

        //    sSQL = "delete �ɹ��̹�ע�Ĳ��ϱ� where yh_id ='" + s_yh_id + "' and cl_id in (" + s_clid + ")";
        //    objConn.ExecuteSQL(sSQL, false);

        //    string s_gys_id = Request.Form["gysid"];
        //    sSQL = "delete �ɹ��̹�ע��Ӧ�̱� where yh_id ='" + s_yh_id + "' and gys_id in (" + s_gys_id + ")";
        //    objConn.ExecuteSQL(sSQL, true);
        //    listFollowCLIDs();
        //}
    </script>
    <form id="form1" runat="server">
    <div class="dlqqz">
      <%--  <div class="dlqqz3">
            &nbsp;&nbsp;<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg"
                runat="server" OnClick="cancelFollows" />
        </div>--%>
        <asp:Label ID="label1" runat="server" Text="" />
        <%
            if (userIsVIP)
            {
        %>
        <div class="dlex1">
            <div class="dlex1">
                <asp:Button runat="server" ID="button1" Text="ѡ�����ݽ��������ڲ�ϵͳ" OnClick="dumpFollowCLs" />
            </div>
        </div>
        <%
            }
            else
            {
        %>
        <div class="dlex1">
            ��Ҳ���԰����ղصĲ������ݺ͹�Ӧ�����ݵ���Ϊexcel��������ʹ��
            <asp:Button runat="server" ID="button2" Text="ȫ������ΪEXCEL" OnClick="dumpFollowCLs" />
        </div>
        <%
            }	
        %>
    </div>
    </form>
    <div class="gyzy2">
    </div>
    <div>
        <div class="lib_Menubox">
            <ul>
                <li id="two1" onclick="setTab('two',1,2)" class="hover">�����б�</li>
                <li id="two2" onclick="setTab('two',2,2)">��Ӧ���б�</li>
            </ul>
        </div>
        <div class="dlqqz5" id="con_two_1" style="border: 1px solid #4ea6ee; padding-top: 10px;
            margin-bottom: 10px;">
            <div class="dlqqz2">
                <div id="menu">
                    <% 
                        firstlevel = 0;
                        foreach (DataRow dr_dl in dt_cgsgzcl_dl.Rows)
                        { %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                        <a href="javascript:void(0)">
                            <img src="images/biao2.jpg" /><%=dr_dl["��ʾ����"]%></a></h1>
                    <span class="no">
                        <%                          
                            int secondlevel = 0;
                            foreach (DataRow dr_xl in dt_cgsgzcl_xl.Rows)
                            {
                                if (dr_xl["�������"].ToString().Substring(0, 2) == dr_dl["�������"].ToString())
                                { %>
                                                    <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                                                        <a href="javascript:void(0)" onclick="xscl('<%=dr_xl["�������"].ToString()%>')">
                                                            <%=dr_xl["��ʾ����"].ToString()%></a></h2>
                                                    <ul class="no">
                                                        <% 
                                                            foreach (DataRow dr_cl in dt_clb.Rows)
                                                            {
                                                                if (dr_cl["�������"].ToString().Substring(0, 4) == dr_xl["�������"].ToString())
                                                                {%>
                                                        <%-- <input type="checkbox" name="clid" value='<%=dr_cl["cl_id"].ToString()%>' />--%>
                                                       <%-- <li><a href='clxx.aspx?cl_id=<%=dr_cl["cl_id"].ToString() %>'>
                                                            <%=dr_cl["��ʾ��"].ToString().Trim()%></a></li>--%>
                                                        <%}
                                                                        }
                                                                        secondlevel++;%>
                                                    </ul>
                                                    <%}
                                            } %>
                   </span>
                                                <% 
                            firstlevel++;

                    }%>
                </div>
                <div id="cgs_lb1" class="cgs_lb"  style="width:795px; margin-left:182px;" > 
                <iframe id="cgsglcl_frame" width="100%" height="370" src="Cgsgzcl.aspx?s_yh_id=<%=s_yh_id %>" frameborder="0"></iframe>
             
                </div>
            </div>
        </div>
        <div class="dlqqz5" id="con_two_2" style="border: 1px solid #4ea6ee; padding-top: 10px;
            margin-bottom: 10px; display: none;">
            <div id="menu2" >
                <% 
                    flevel = 0;
                        foreach (DataRow dr_gys in dt_clgysxx.Rows)
                        { %>
                <h1 onclick="javascript:ShowMenu(this,<%=flevel %>)">
                  <a href="javascript:void(0)">
                        <img src="images/biao2.jpg" />
                        <%=dr_gys["��Ӧ������"].ToString()%></a></h1>
                       
             <span class="no">
                     <% string gys_Id = dr_gys["gys_id"].ToString();
                        string sql_ppxx = "select * from Ʒ���ֵ� where scs_id='" + gys_Id + "'";
                        dt_ppxx = objConn.GetDataTable(sql_ppxx);
                            %>
                    <%      int secondlevel = 0;
                            foreach (DataRow drpp in dt_ppxx.Rows)
                      {%>
                    <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %>)">
                        <a href="javascript:void(0)" onclick="ppgys('<%=drpp["pp_id"].ToString()%>')"><%=drpp["Ʒ������"] %></a></h2>
                        <%} %>
                <ul class="no">
                  <%--  <%
                        foreach (DataRow dr_gys in dt_clgysxx.Rows)
                        {   
                        %>
                     <input type="checkbox" name="gysid" value='<%=dr_gys["gys_id"].ToString()%>' />
                   <li><a href='gysxx.aspx?gys_id=<%=dr_gys["gys_id"].ToString() %>'>
                        <%=dr_gys["��Ӧ������"].ToString()%></a></li>
                    <% } %> --%>
                    <% secondlevel++;%>
                </ul>
                 </span>
                  <%flevel++; }%>
            </div>
            <div id="cgs_lb" class="cgs_lb"  style="width:755px; margin-left:232px;">
                <iframe id="cgsglgys_iframe" width="100%" height="370" src="Cgsgzgys.aspx?s_yh_id=<%=s_yh_id %>" frameborder="0"></iframe>
            </div>
        </div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>
    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->
</body>
</html>
