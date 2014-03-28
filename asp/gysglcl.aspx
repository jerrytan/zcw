<!--
       ��Ӧ�̹������ҳ�� ����ɾ��ѡ�еĲ���,��Ҳ�����µĲ���
	   �ļ���:  gysglcl.aspx   
       ���������s_yh_id �û�id 
       author:����ӱ
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ӧ���ղ�ҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<link href="css/gl.css" rel="stylesheet" type="text/css" />
<script src="js/gysglcl.js" type="text/javascript"></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>


</head>

<body>

<!-- ͷ����ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ������-->


<script runat="server">

    public Boolean userIsVIP = false;
    protected DataTable dt_cl = new DataTable();    //���ݹ�Ӧ��id��ѯ��ʾ��,�������(���ϱ�)
    protected DataTable dt_yjfl = new DataTable();  //ȡһ��������ʾ����(���Ϸ����)
    protected DataTable dt_ejfl = new DataTable();  //ȡ����������ʾ����(���Ϸ����)
    public string sSQL = "";
    public string s_yh_id = "";                     //�û�ID
    public string gys_id = "";                      //��Ӧ��id
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        Products_gys_cl();
    }

    protected void Products_gys_cl()
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        //�����û�id ��ѯ��Ӧ��id
        sSQL = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='" + s_yh_id + "' ";   //141           
        DataTable dt_gys = objConn.GetDataTable(sSQL);
    
        if (dt_gys != null && dt_gys.Rows.Count > 0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }

        //���ݹ�Ӧ��id ��ѯ������Ϣ
        sSQL = "select cl_id,��ʾ��,������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1' ";
        dt_cl = objConn.GetDataTable(sSQL);

      

        //ȡ������������
        sSQL="select ��ʾ����,������� from ���Ϸ���� where ������� in(select ������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1' )";
        dt_ejfl = objConn.GetDataTable(sSQL);

     
        CancelFollowButton.Attributes.Add("onClick", "return confirm('��ȷ��Ҫɾ����ѡ�еĲ�����');");
    }

    protected void dumpFollowCLs(object sender, EventArgs e)
    {

        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        string gys_id = "";
        //�����û�id ��ѯ��Ӧ��id
        sSQL = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='" + s_yh_id + "' ";
        DataTable dt_gys = objConn.GetDataTable(sSQL);
        if (dt_gys != null && dt_gys.Rows.Count > 0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }
        //����gys_id ��ѯ���ϱ���ص����� �Ա㵼��excel ���
        sSQL = "select*from ���ϱ� where gys_id='" + gys_id + "' ";

        DataTable cldt = new DataTable();
        cldt = objConn.GetDataTable(sSQL);
        outToExcel(cldt);
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
    public void Delete_cl(object sender, EventArgs e)
    {

        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
         string gys_id="";
        //�����û�id ��ѯ��Ӧ��id
        sSQL = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='" + s_yh_id + "' ";    
        DataTable dt_gys =objConn.GetDataTable(sSQL);
        if (dt_gys!=null&&dt_gys.Rows.Count>0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }
      
        //��ȡ��ѡ��ѡ�е�cl_id
        string clidstr = Request.Form["clid"];

        //ͨ����ȡ�Ĺ�Ӧ��id��cl_id����ɾ��
        sSQL = "update ���ϱ� set �Ƿ�����='0' where gys_id ='" + gys_id + "' and cl_id in (" + clidstr + ")";
        objConn.ExecuteSQL(sSQL, true);
        Products_gys_cl();
    }
   
</script>


<form id="form1" runat="server">

   <div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2">
<div id="menu">

 <% 
 	   int firstlevel = 0;
       if (dt_cl!=null&&dt_cl.Rows.Count>0)
       {
		   foreach (System.Data.DataRow row in dt_cl.Rows)
		   {
			    string code = row["�������"].ToString().Substring(0, 2);
			    sSQL = "select  ��ʾ���� from ���Ϸ���� where �������='" + code + "' ";
			    dt_yjfl = objConn.GetDataTable(sSQL);
			    foreach (System.Data.DataRow R_yjfl in dt_yjfl.Rows)
			    {
				%>
					<h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
					<img src="images/biao2.jpg" /><%=R_yjfl["��ʾ����"].ToString()%> &gt;</a></h1>
					<span class="no">
						<% 
						int secondlevel = 0;
						foreach (System.Data.DataRow R_ejfl in dt_ejfl.Rows)
						{
						%>
							<h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=R_ejfl["��ʾ����"].ToString()%></a></h2>
							<ul class="no">
								<% 
								//�����µķ����ƷҪ����,����Ķ������������в�ѯ				  
								string s_flbm = R_ejfl["�������"].ToString();
								sSQL = "select cl_id,��ʾ��,������� from ���ϱ� where gys_id='" + gys_id + "'and �������='" + s_flbm + "'";
								System.Data.DataSet ds_cls = new System.Data.DataSet();                          
								System.Data.DataTable dt_cls = objConn.GetDataTable(sSQL);
								foreach (System.Data.DataRow R_cls in dt_cls.Rows)
								{						
								%>
									<input type="checkbox" name="clid" value="<%=R_cls["cl_id"].ToString()%>" />                           
									<a href="clbj.aspx?cl_id=<%=R_cls["cl_id"].ToString()%>"><%=R_cls["��ʾ��"].ToString()%></a>
								<%    			    
								}
								secondlevel++;
								%>
							</ul>
						<% 	         
						}
						%>
					</span>
	<% 
					firstlevel++;
			   }
			}
       }
    %>

        
 
 <span class="no">
 

 </span>
  
</div></div>
<div class="dlqqz3" style="width:260px;">

<a href="xzclym.aspx?gys_id=<%=gys_id %>"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;

<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg" runat="server" OnClick="Delete_cl" />

</div>
</div>


<div class="dlex">
    <%
	if (userIsVIP){
    %>            
		<div class="dlex1">
			<asp:Button runat="server" ID="button1" Text="ѡ�����ݽ��������ڲ�ϵͳ" OnClick="dumpFollowCLs" />
		</div>
     <%
	}
	else 
	{
    %>
		<div class="dlex1">
			�����԰������Ĳ������ݵ���Ϊexcel��������ʹ��
			 <asp:Button runat="server" ID="button2" Text="ȫ������ΪEXCEL" OnClick="dumpFollowCLs" />
        </div>
    <%
	}	
    %>

</div>
</form> 

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->



</body>
</html>



