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

<%@ PAGE Language="C#"%>
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
    <style type="text/css">
        .style1
        {
            width: 94px;
        }
    </style>
</head>
<script type="text/javascript" language="javascript">
    function Trim(str) {
        str = str.replace(/^(\s|\u00A0)+/, '');
        for (var i = str.length - 1; i >= 0; i--) {
            if (/\S/.test(str.charAt(i))) {
                str = str.substring(0, i + 1);
                break;
            }
        }
        return str;
    } 
    function Add(obj) {
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        var cl_mc = Trim(tds[1].innerHTML);
        document.getElementById("cl_mc").value = cl_mc;
    }
    function CZ(ejfl) {
    var g;
    g = document.getElementById("lblgys_id").value;
    document.getElementById("frame1").src = "gysglcl_2.aspx?gys_id=" + g + "&ejfl=" + ejfl;
}
</script>
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
    public string[] yjflbm;
    public string ejfl;
    public int PageSize = 10;
    DataView objDv = null;
    DataTable objDt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        Products_gys_cl();
       
        gys_id = Request.QueryString["gys_id"].ToString();
        this.lblgys_id.Value = gys_id;
        ejfl = Request.QueryString["ejfl"].ToString();
        if(ejfl!="")
        {
            sSQL = "select cl_id,��ʾ��,Ʒ������,����ͺ�,���ϱ���,�������� from ���ϱ� where left(�Ƿ�����,1) like '%1%' and ��������= '" + ejfl + "' order by cl_id";
            string sSearchCondition = "��ʾ��='" + ejfl + "'";
            dt_cl = objConn.GetDataTable(sSQL);
        }
        else
        {
            sSQL = "select top 10 cl_id, ��ʾ��,Ʒ������,����ͺ�,���ϱ���,��������,�Ƿ����� from ���ϱ� where �Ƿ�����=1 order by updatetime desc";
            dt_cl = objConn.GetDataTable(sSQL);
        }
        //btnDelete.Attributes.Add("onClick", "return confirm('��ȷ��Ҫɾ����ѡ�еĲ�����');");
    }

    protected void Products_gys_cl()
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        gys_id = Request.QueryString["gys_id"].ToString();
        sSQL = "select �ȼ� from �û��� where yh_id='" + s_yh_id + "' ";   //141           
        string vip = objConn.DBLook(sSQL);
        if(vip=="VIP�û�")
        {
            userIsVIP=true;
        }

        // ȡ �����������
         sSQL="select ��ʾ����,������� from ���Ϸ���� where ������� in(select ������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1')";
          dt_ejfl = objConn.GetDataTable(sSQL);
          if(dt_ejfl!=null&&dt_ejfl.Rows.Count>0)
          {
              yjflbm=new string[dt_ejfl.Rows.Count];
              for(int i=0;i<dt_ejfl.Rows.Count;i++)
              {
                    sSQL="select ��ʾ����,������� from ���Ϸ���� where �������='"+dt_ejfl.Rows[i]["�������"].ToString().Substring(0,2)+"'";
                    DataTable flbm=objConn.GetDataTable(sSQL);
                    if(flbm!=null&&flbm.Rows.Count>0)
                    {
                         yjflbm[i]=flbm.Rows[0]["�������"].ToString()+"|"+flbm.Rows[0]["��ʾ����"].ToString();
                    }
               } 
                yjflbm=GetString(yjflbm);             
          }
          else
          {
             yjflbm=new string[0];
          }
               
        //һ���������


         sSQL="select cl_id,��ʾ��,������� from ���Ϸ���� where ������� in( select ������� from ���ϱ� gys_id='" + gys_id + "'and �Ƿ�����='1') and len(�������)=2 ";
         dt_yjfl=objConn.GetDataTable(sSQL);

         sSQL="select cl_id,��ʾ��,������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1' and len(�������)=4 ";
         dt_ejfl=objConn.GetDataTable(sSQL);

        //���ݹ�Ӧ��id ��ѯ������Ϣ
        sSQL = "select cl_id,��ʾ��,������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1' ";
        dt_cl = objConn.GetDataTable(sSQL);

      

        //ȡ������������
        sSQL="select ��ʾ����,������� from ���Ϸ���� where ������� in(select ������� from ���ϱ� where gys_id='" + gys_id + "'and �Ƿ�����='1' )";
        dt_ejfl = objConn.GetDataTable(sSQL);       
        
    }
    public static string[] GetString(string[] values) 
    { 
         List<string> list = new List<string>(); 
        for (int i = 0; i < values.Length; i++)//���������Ա 
        { 
            if (list.IndexOf(values[i].ToLower()) == -1) 
            //��ÿ����Ա��һ���������ѯ���û����ȵ���ӵ������� 
            list.Add(values[i]); 
        } 
        return list.ToArray(); 
    }

    protected void dumpFollowCLs(object sender, EventArgs e)
    {

        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        gys_id = Request["gys_id"].ToString();
        
        sSQL = "select * from ���ϱ� where gys_id='" + gys_id + "' ";

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
        //����2014��8��27�գ�ע���û�idȡֵ�����gys_idȡֵ
        //if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        //{
        //    s_yh_id = Session["GYS_YH_ID"].ToString();
        //}
        
        //�����û�id ��ѯ��Ӧ��id
        gys_id = Request.QueryString["gys_id"].ToString();
        //��ȡ��ѡ��ѡ�е�cl_id
        string clidstr = Request.Form["clid"];
        if (clidstr != "" && clidstr != null)
        {
            //ͨ����ȡ�Ĺ�Ӧ��id��cl_id����ɾ��
            sSQL = "update ���ϱ� set �Ƿ�����='0' where gys_id ='" + gys_id + "' and cl_id in (" + clidstr + ")";
            objConn.ExecuteSQL(sSQL, true);
            if(ejfl=="")
            {
                Response.Write(clidstr);
                sSQL = "select top 10 cl_id, ��ʾ��,Ʒ������,����ͺ�,���ϱ���,��������,�Ƿ����� from ���ϱ� where �Ƿ�����=1 order by updatetime desc";
                dt_cl = objConn.GetDataTable(sSQL);
            }
            else
            {
                sSQL = "select top 10 cl_id, ��ʾ��,Ʒ������,����ͺ�,���ϱ���,��������,�Ƿ����� from ���ϱ� where �Ƿ�����=1 and ��������='" + ejfl + "' order by updatetime desc ";
                dt_cl=objConn.GetDataTable(sSQL);
            }
            //Products_gys_cl();
            Response.Write("<script>window.alert('ɾ���ɹ���')</" + "script>");
        }
        else
        {
            Response.Write("<script>window.alert('��û��ѡ���κβ��ϣ�')</" + "script>");
        }
    }

   
    protected void AddCL(object sender, EventArgs e)
    {
        Response.Redirect("xzclym.aspx?gys_id=" + gys_id);
    }
</script>
    <form id="form1" runat="server">
 <div class="dlqqz5"  style="border:1px solid #ddd; padding-top:10px; margin: 10px 0 0 0;">
    <div class="dlqqz2">
    
<div id="menu">
<div class="dlqqz1">���Ĳ�Ʒ�б�</div>
 <% 
 	int firstlevel = 0;
    foreach (string yjfl in yjflbm)
    {
        string[] yj = new string[2];
        yj = yjfl.Split('|');//yj[0]  һ������  yj[1] һ����ʾ����
    %>
    <h2 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)"><img src="images/biao2.jpg" />&nbsp;<%=yj[1]%></a></h2>
    <span class="no">
    <input type="hidden" id="lblgys_id" runat="server" />
    <% 
	int secondlevel = 0;
	foreach (System.Data.DataRow R_ejfl in dt_ejfl.Rows)
	{
        if(yj[0]==R_ejfl["�������"].ToString().Substring(0,2))
        {
            string value = R_ejfl["��ʾ����"].ToString();
            %>
   <h4>  
    <a href="javascript:void(0)" onclick="CZ('<%=value %>')"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=R_ejfl["��ʾ����"].ToString() %></a>
    </h4>  
            <% 	 secondlevel++;
                }      
		    }
        %>
        </span>
    <% 
	    firstlevel++;
    } %>
    <span class="no"></span>
</div>

<div id="cgs_lb" style="width:765px; margin-left:212px;">
<div id="divtable" runat="server">
<iframe id="frame1" src="gysglcl_2.aspx" frameborder="0" marginheight="0"  style=" width:100%;  height:400px; padding:0px; margin:0px; border:0px; " > 
    </iframe> 
</div>
</div>
 </div>                
 </div>
 
   <div class="cgdlqq"></div>
  <%-- ����2014��8��18��ע�͸ñ����ڻ�Աע��ʱ��˹��ˣ�����Ҫ���б���ʾ��Ϣ--%>
		   <%-- <div class="cgdlex">
			    <div class="cgdlex2">
				    <span class="cgdlex3">������Ϣ���£���������뵥�����İ�ť</span>
				    <dl>						
					    <dd>*��˾���ƣ�</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>*��˾��ַ��</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>*��˾�绰��</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
					    <dd>&nbsp;��˾��ҳ��</dd><dt><input name="gys_homepage" id="gys_homepage" type="text" class="cgdlex2text"  runat="server"/></dt>
                        <dd>*��˾�ǣ�</dd><dt><input  id="scs" name="select" type="radio" value="������" runat="server" validationgroup="select" />������  
											<input id="gxs"  runat="server" name="select"  type="radio" value="������" validationgroup="select" />������ </dt>
                        <dd>*����������  </dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>*���ĵ绰��  </dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>����QQ���룺 </dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>					  
				    </dl>
				    <asp:Label ID="label2" runat="server" Text="" />
				    <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
			    </div>
		    </div>--%>
    </form>
    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->
</body>
</html>
