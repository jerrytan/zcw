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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�ɹ��̹�ע���Ϲ���ҳ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/gl.css" rel="stylesheet" type="text/css" />
    <link href="css/cgsgzl.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
     <script src="js/cgsgl2.js" type="text/javascript"></script>
    <script src="js/cgsgzl.js" type="text/javascript"></script>
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
    public Boolean userIsVIP = false;
    protected string s_yh_id="";
    public string s_QQid = "";
    public DataConn objConn = new DataConn();
    public string sSQL = "";
    public DataTable dt = new DataTable();
    public int firstlevel;
    public string xx = "";   //�Ƿ������Ϣ   
    public string sftg = "";

    protected DataTable dt_type = new DataTable();//һ�������б�    
    protected List<string> list = new List<string>();//�û��ѹ�ע����б�  
	           
    protected void Page_Load(object sender, EventArgs e)
    {
        string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
        string sqlExistQQ_id = "select * from �û��� where QQ_id='" + cgs_QQ_id + "'";
        string sql_Level = "select �ȼ� from �û��� where QQ_id='" + cgs_QQ_id + "'";
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
         if (Request.Cookies["CGS_QQ_ID"] != null && Request.Cookies["CGS_QQ_ID"].Value.ToString()!="")
        {
            s_QQid = Request.Cookies["CGS_QQ_ID"].Value.ToString();
        }
      if(s_QQid!="")
        {
            sSQL = "select count(*) from �û��� where QQ_id = '" + s_QQid + "'";
           string count = objConn.DBLook(sSQL);
           //if (Convert.ToInt32(count)==0)  //qq_id �����ڣ���Ҫ�����û���
           // {
               //2014-09-09 yuan
               // sSQL = "insert into �û��� (QQ_id) VALUES ('" + s_QQid + "')";
               //if(!objConn.ExecuteSQL(sSQL,false))
               //{
               //   objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+sSQL);
               //}
               // sSQL = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" + s_QQid + "'),����='�ɹ���' where QQ_id = '" + s_QQid + "'";
               // if(!objConn.ExecuteSQL(sSQL,false))
               //{
               //   objConn.MsgBox(this.Page,"ִ��SQL���ʧ��"+sSQL);
               //   return;
               //}

            //}
           string lx = "";
            sSQL = "select ����,yh_id,�Ƿ���֤ͨ��,����,�ȼ� from �û��� where QQ_id = '" + s_QQid + "'";
            dt = objConn.GetDataTable(sSQL);
            if (dt!=null&&dt.Rows.Count>0)
            {              
                s_yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
                string vip=dt.Rows[0]["�ȼ�"].ToString();
                if (vip=="VIP�û�")
                {
                    userIsVIP = true;
                }
                lx = dt.Rows[0]["����"].ToString();
                sftg = dt.Rows[0]["�Ƿ���֤ͨ��"].ToString();
            }

            if (lx != "�ɹ���")
            {
                string cookieName = "";
                cookieName = "CGS_YH_ID";
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie myCookie = new HttpCookie(cookieName);
                    myCookie.Expires = DateTime.Now.AddDays(-10d);
                    Response.Cookies.Add(myCookie);
                }
                Response.Write("<script>window.alert('�����ǲɹ��̣������òɹ�����ݵ�¼��');window.location.href='index.aspx';</" + "script>");
            }
            Session["CGS_YH_ID"] = s_yh_id;
         
             if (!IsPostBack)
            {
                //����2014��8��18��   
                sSQL = "select * from �û��� where yh_id='" + s_yh_id + "'";

                DataTable dt_userInfo = new DataTable();
                dt_userInfo = objConn.GetDataTable(sSQL);
                if (dt_userInfo != null && dt_userInfo.Rows.Count > 0)
                {
                    this.companyname.Value = dt_userInfo.Rows[0]["��˾����"].ToString();
                    this.companytel.Value = dt_userInfo.Rows[0]["��˾�绰"].ToString();
                    this.companyaddress.Value = dt_userInfo.Rows[0]["��˾��ַ"].ToString();
                    this.contactorname.Value = dt_userInfo.Rows[0]["����"].ToString();
                    this.contactortel.Value = dt_userInfo.Rows[0]["�ֻ�"].ToString();
                    this.QQ_id.Value = dt_userInfo.Rows[0]["QQ����"].ToString();
                    if ( dt_userInfo.Rows[0]["��˾����"].ToString()==""&&dt_userInfo.Rows[0]["��˾�绰"].ToString()==""&&dt_userInfo.Rows[0]["��˾��ַ"].ToString()==""
                        && dt_userInfo.Rows[0]["����"].ToString() == "" && dt_userInfo.Rows[0]["�ֻ�"].ToString()=="")
                    {
                        xx = "��";
                    }
                    else
                    {
                        xx = "��";
                    }
                } 
            }
            listFollowCLIDs();
        }
        else
        {
            objConn.MsgBox(this.Page,"QQ_ID�����ڣ������µ�¼��");
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
    public DataTable dt_cgsgzcl_dl = new DataTable();
    public DataTable dt_cgsgzcl_xl = new DataTable();
    public DataTable dt_clb = new DataTable();
    public DataTable dt_clgysxx = new DataTable();
    protected void listFollowCLIDs()
    {
        string sVD = Request.ApplicationPath.ToString().Substring(1);

        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
         sSQL = "select * from (select distinct a.�������,a.��ʾ���� from ���Ϸ���� as a ,(select distinct c.������� as flbm " +
                         " from �ɹ��̹�ע�Ĳ��ϱ� as b ,���ϱ� as c  " +
                         " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                        " where a.�������=d.flbm or a.�������=left(d.flbm,2))#temp where len(�������)=2";

         dt_cgsgzcl_dl = objConn.GetDataTable(sSQL);

         sSQL = "select * from (select distinct a.�������,a.��ʾ���� from ���Ϸ���� as a ,(select distinct c.������� as flbm " +
                        " from �ɹ��̹�ע�Ĳ��ϱ� as b ,���ϱ� as c  " +
                        " where b.yh_id='" + s_yh_id + "' and b.cl_id=c.cl_id  ) as  d " +
                       " where a.�������=d.flbm or a.�������=left(d.flbm,2))#temp where len(�������)=4";
         dt_cgsgzcl_xl = objConn.GetDataTable(sSQL);
      

        sSQL ="select b.cl_id ,�������,��ʾ�� from �ɹ��̹�ע�Ĳ��ϱ� as a ,���ϱ� as b  " +
             "  where a.yh_id='" + s_yh_id + "' and a.cl_id=b.cl_id order by b.cl_id";

        dt_clb = objConn.GetDataTable(sSQL);
      

        sSQL = "select a.gys_id ,a.��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� as a ,�ɹ��̹�ע��Ӧ�̱� as b  " +
               " where b.yh_id='" + s_yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
        dt_clgysxx = objConn.GetDataTable(sSQL);

      
        CancelFollowButton.Attributes.Add("onClick", "return confirm('�����Ҫȡ������Щ���ϻ�Ӧ�̵Ĺ�ע��');");

    }
   
/// <summary>
/// ��òɹ��̹�ע�Ĳ��ϱ�
/// </summary>
/// <param name="sender"></param>
/// <param name="e"></param>
    protected void dumpFollowCLs(object sender, EventArgs e)
    {
        sSQL = "select b.* from �ɹ��̹�ע�Ĳ��ϱ� as  a ,���ϱ� as b  where a.yh_id='" + s_yh_id + "'  and a.cl_id = b.cl_id ";
        dt = null;
        dt = objConn.GetDataTable(sSQL);
        outToExcel(dt);   //����Excel��
        //if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        //{
        //    s_yh_id = Session["CGS_YH_ID"].ToString();
        //}

        // sSQL="select QQ����,�ֻ�,����,����,��˾����,��˾��ַ,��˾��ҳ,��˾�绰,�Ƿ���֤ͨ�� from �û��� where yh_id='"+s_yh_id+"'";
        //DataTable dt_yhbt=objConn.GetDataTable(sSQL);
        //if(dt_yhbt!=null&&dt_yhbt.Rows.Count>0)
        //{
        //    string user_type=dt_yhbt.Rows[0]["����"].ToString();
        //    string tel=dt_yhbt.Rows[0]["�ֻ�"].ToString();
        //    string name=dt_yhbt.Rows[0]["����"].ToString();
        //    string com_name=dt_yhbt.Rows[0]["��˾����"].ToString();
        //    string com_add=dt_yhbt.Rows[0]["��˾��ַ"].ToString();
        //    string com_tel=dt_yhbt.Rows[0]["��˾�绰"].ToString();
        //    if(user_type!=""&&tel!=""&&name!=""&&com_name!=""&&com_add!=""&&com_tel!="")
        //    {
        //        if (dt_yhbt.Rows[0]["�Ƿ���֤ͨ��"].ToString()=="ͨ��")
        //        {
        //            sSQL = "select b.* from �ɹ��̹�ע�Ĳ��ϱ� as  a ,���ϱ� as b  where a.yh_id='" + s_yh_id + "'  and a.cl_id = b.cl_id ";
        //            dt = null;
        //            dt = objConn.GetDataTable(sSQL);
        //            outToExcel(dt);
        //        }
        //        else
        //        {
        //            Response.Redirect("cgsbtxx.aspx");
        //        }
        //    }
        //    else
        //    {
        //         Response.Redirect("cgsbtxx.aspx");
        //    }

        //}
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
    /// <summary>
    /// ȡ����ע����
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
   public void cancelFollows(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }   
        string s_clid = Request.Form["clid"];

        sSQL = "delete �ɹ��̹�ע�Ĳ��ϱ� where yh_id ='" + s_yh_id + "' and cl_id in (" + s_clid + ")";
        objConn.ExecuteSQL(sSQL,false);

        string s_gys_id = Request.Form["gysid"];
        sSQL = "delete �ɹ��̹�ע��Ӧ�̱� where yh_id ='" + s_yh_id + "' and gys_id in (" + s_gys_id + ")";
        objConn.ExecuteSQL(sSQL, true);
        listFollowCLIDs();
    }
        //����2014��8��18��
        protected void updateUserInfo(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
      
        if (this.contactortel.Value == "")
        {
            objConn.MsgBox(this.Page, "�ֻ�����Ϊ��,����д!");
            this.contactortel.Focus();
            return;
        }
        if (this.contactorname.Value == "")
        {
            objConn.MsgBox(this.Page, "��������Ϊ��,����д!");
            this.contactorname.Focus();
            return;
        }
        if (this.companyname.Value == "")
        {
            objConn.MsgBox(this.Page, "��˾���Ʋ���Ϊ��,����д!");
            this.companyname.Focus();
            return;
        }
        if (this.companyaddress.Value == "")
        {
            objConn.MsgBox(this.Page, "��˾��ַ����Ϊ��,����д!");
            this.companyaddress.Focus();
            return;
        }
        if (this.companytel.Value == "")
        {
            objConn.MsgBox(this.Page, "��˾�绰����Ϊ��,����д!");
            this.companytel.Focus();
            return;
        }
        string typeList = this.hid.Value.ToString();    
        sSQL   = " update �û��� " +
                " set �ֻ�='" +this.contactortel.Value + "', " +
                " ����='" +this.contactorname.Value + "',  " +
                " ��˾����='"+this.companyname.Value+"',"+
                " ��˾��ַ='"+this.companyaddress.Value+"',"+
                " ��˾�绰='"+this.companytel.Value+"',"+
                " QQ����='"+this.QQ_id.Value+"',"+
                " �Ƿ���֤ͨ��='�����'," + "�û���ע���='" + typeList + "'" +
                "  where yh_id='" + s_yh_id + "'";
        
        if (!objConn.ExecuteSQL(sSQL, true)) 
        {
            objConn.MsgBox(this.Page, "����ʧ�ܣ������ԣ�");
        }
    }
    </script>
       <form id="form1" runat="server">
       <div class="dlqqz">
        <div class="dlqqz1">
            <img src="images/sccp.jpg" />
        </div>
        
        <div class="dlqqz2">
            <div id="menu">
                <% 
 	      firstlevel = 0;
            foreach (DataRow dr_dl in dt_cgsgzcl_dl.Rows)
            { %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                    <a href="javascript:void(0)"><img src="images/biao2.jpg" /><%=dr_dl["��ʾ����"]%>&gt;</a></h1>
                    <span class="no">
                     <% 
 	                   int secondlevel = 0;
 		                      foreach (DataRow dr_xl in dt_cgsgzcl_xl.Rows)
                              {
                                  if (dr_xl["�������"].ToString().Substring(0, 2) == dr_dl["�������"].ToString())
                                  { %>
                                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                                        <a href="javascript:void(0)">+
                                    <%=dr_xl["��ʾ����"].ToString()%></a></h2>
                                     <ul class="no">
                                            <% 
                                                foreach (DataRow dr_cl in dt_clb.Rows)
                                                {
                                                    if (dr_cl["�������"].ToString().Substring(0, 4) == dr_xl["�������"].ToString())
                                                    {%>
                                                        <input type="checkbox" name="clid" value='<%=dr_cl["cl_id"].ToString()%>' />
                                                        <a  href='clxx.aspx?cl_id=<%=dr_cl["cl_id"].ToString() %>'>
                                                            <%=dr_cl["��ʾ��"].ToString().Trim()%></a><br/>
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

                <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                    <a href="javascript:void(0)">
                        <img src="images/biao2.jpg" />
                        ��Ӧ���б� &gt;</a></h1>
                <span class="no">
                    <h2 onclick="javascript:ShowMenu(this,0)">
                        <a href="javascript:void(0)">+ ���Ϲ�Ӧ��</a></h2>
                    <ul class="no">
                        <%
                  foreach (DataRow dr_gys in dt_clgysxx.Rows){
                        %>
                        <input type="checkbox" name="gysid" value='<%=dr_gys["gys_id"].ToString()%>' />
                        <a href='gysxx.aspx?gys_id=<%=dr_gys["gys_id"].ToString() %>'>
                            <%=dr_gys["��Ӧ��"].ToString()%></a><br />
                        <% } %>
                    </ul>
                </span>
            </div>
        </div>
        <div class="dlqqz3">
            &nbsp;&nbsp;<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg"
                runat="server" OnClick="cancelFollows" />
        </div>
        <asp:Label ID="label1" runat="server" Text="" />
        <%
	if (userIsVIP){
        %>
        <div class="dlex1">
            <div class="dlex1">
                <asp:Button runat="server" ID="button1" Text="ѡ�����ݽ��������ڲ�ϵͳ" OnClick="dumpFollowCLs" />
            </div>
        </div>
        <%
	}else {
        %>
        <div class="dlex1">
            ��Ҳ���԰����ղصĲ������ݺ͹�Ӧ�����ݵ���Ϊexcel��������ʹ��
            <asp:Button runat="server" ID="button2" Text="ȫ������ΪEXCEL" OnClick="dumpFollowCLs" />
        </div>
        <%
	}	
        %>
    </div>
       <div class="cgdlqq">
		    <div class="cgdlex">
			    <div class="cgdlex2">
                <%if (xx == "��")
                  {%>
                   <span class="cgdlex3">�벹��������ϸ��Ϣ</span>
                <%}
                  else
                  {
                      if (sftg == "��ͨ��")
                      {%>
                       <span class="cgdlex3">���ύ����Ϣδͨ����ˣ����޸ĺ��ύ��</span>
                      <%}
                      else
                      {
                       %>
                   <span class="cgdlex3">������Ϣ���£���������뵥�����İ�ť</span>
                <%}
                  }%>
				   
				    <dl>						
					    <dd>��˾���ƣ�</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>��˾��ַ��</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>��˾�绰��</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
                        <dd>����������</dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>���ĵ绰��</dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>����QQ�ţ�</dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>	
                        <dd>�û���ע�����</dd><dt><input type="button" name="name" value="��ѡ��" id="btn" style="background-color:#0033FF"/></dt><input type="hidden" name="hid" id="hid" value=""  runat="server"/>	
                        <div id="show"><span >��ѡ���ע�����</span><a id="clos" href="javascript:void(0)" >�ر�</a><br />
                          <% foreach(System.Data.DataRow row in dt_type.Rows){%>
                                        <% if(this.list.Count>0 &&this.list.Contains(row["�������"].ToString())){ %>
                                           <input type="checkbox"  name="item" value="<%=row["�������"].ToString() %>" checked="checked" /><%=row["��ʾ����"].ToString()%><br />
                                         <% }
                                         else
                                         {%>
                                          <input type="checkbox"  name="item" value="<%=row["�������"].ToString() %>" /><%=row["��ʾ����"].ToString()%><br />
                                        <% }                                                                            
                                    } %> 
                        <input type="button" name="name" value="����" id="btnSave" />
                        </div>
                        <div id="layer"></div>			  
				    </dl>
                    
				    <asp:Label ID="label2" runat="server" Text="" />
                    <%if (xx == "��")
                      { %>
                      <span class="cggg"><asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
                    <%}
                      else
                      { %>
                       <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
                    <%} %>				   
			    </div>
		    </div>
	    </div>
        </form>
            <div class="gyzy2"></div>
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