<!--
        ҳ�����ƣ�	�ɹ�����Ϣҳ��
        �ļ�����	cgsgl_3.ascx
        ���������	QQid ���ڸ���QQidȡ�����Ϣ
               
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ɹ�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<script src="js/cgsgl_3.js" type="text/javascript"></script>
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
	  public string s_yh_id="";
    public string sSQL = "";
    public DataConn objConn = new DataConn();
	protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CGS_YH_ID"] != null && Session["CGS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["CGS_YH_ID"].ToString();
        }
        if (!IsPostBack)
        {           
            sSQL = "select * from �û��� where yh_id='" + s_yh_id + "'";

            DataTable dt_userInfo = new DataTable();
            dt_userInfo = objConn.GetDataTable(sSQL);
            if (dt_userInfo != null && dt_userInfo.Rows.Count > 0)
            {
                this.companyname.Value = dt_userInfo.Rows[0]["��˾����"].ToString();
                this.companytel.Value = dt_userInfo.Rows[0]["��˾��ַ"].ToString();
                this.companyaddress.Value = dt_userInfo.Rows[0]["��˾�绰"].ToString();
                this.contactorname.Value = dt_userInfo.Rows[0]["����"].ToString();
                this.contactortel.Value = dt_userInfo.Rows[0]["�ֻ�"].ToString();
                this.QQ_id.Value = dt_userInfo.Rows[0]["QQ����"].ToString();
            } 
        }
}
    protected void updateUserInfo(object sender, EventArgs e)
    {
        if (Session["yh_id"]!=null&&Session["yh_id"].ToString()!="")
        {
            s_yh_id = Session["yh_id"].ToString();
        }
        sSQL   = " update �û��� " +
                " set �ֻ�='" +this.contactortel.Value + "', " +
                " ����='" +this.contactorname.Value + "',  " +
                " ��˾����='"+this.companyname.Value+"',"+
                " ��˾��ַ='"+this.companyaddress.Value+"',"+
                " ��˾�绰='"+this.companytel.Value+"',"+
                " QQ����='"+this.QQ_id.Value+"'"+
                " where yh_id='" + s_yh_id + "'";
        objConn.ExecuteSQL(sSQL,true);
    }
	</script>
	<form runat="server">
	    <div class="cgdlqq">
		    <div class="cgdlex">
			    <div class="cgdlex2">
				    <span class="cgdlex3">������Ϣ���£���������뵥�����İ�ť</span>
				    <dl>						
					    <dd>��˾���ƣ�</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>��˾��ַ��</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>��˾�绰��</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
					    <dd>����������</dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>���ĵ绰��</dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>����QQ�ţ�</dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>
					    <dd style="width:800px">����ִ�գ�</dd><dt style="height:auto"><img src="images/qqqq_03.jpg" /></dt>
					    <dd style="width:800px">�������ʣ�</dd><dt style="height:auto"><img src="images/qqqq_03.jpg" /></dt>
				    </dl>
				    <asp:Label ID="label1" runat="server" Text="" />
				    <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
			    </div>
		    </div>
	    </div>
    </form>
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
