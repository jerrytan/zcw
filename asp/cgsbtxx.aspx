<!--
    �ɹ��̲�����Ϣҳ��
    �ļ�����cgsbtxx.aspx
    ���������Session["yh_id"]  �û�id 
	author������ӱ
-->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>�ɹ��̲�����Ϣҳ</title>
	<link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/cgsbtxx.js" type="text/javascript"></script>
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
	public string s_yh_id = "";
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["yh_id"]!=null&&Session["yh_id"].ToString()!="")
            {
                s_yh_id = Session["yh_id"].ToString();
            }
            
            string sSQL_yh = "select * from �û��� where yh_id='" + s_yh_id + "'";
            DataTable dt_yh = new DataTable();
            dt_yh = objConn.GetDataTable(sSQL_yh);
            if (dt_yh != null && dt_yh.Rows.Count > 0)
            {
                this.companyname.Value = dt_yh.Rows[0]["��˾����"].ToString();
                this.companyaddress.Value = dt_yh.Rows[0]["��˾��ַ"].ToString();
                this.companytel.Value = dt_yh.Rows[0]["��˾�绰"].ToString();
                this.contactorname.Value = dt_yh.Rows[0]["����"].ToString();
                this.contactortel.Value = dt_yh.Rows[0]["�ֻ�"].ToString();
                this.contactorqqid.Value = dt_yh.Rows[0]["QQ����"].ToString();
                if (dt_yh.Rows[0]["����"].ToString() == "������")
                {
                    this.gxs.Checked = true;
                }
                else if (dt_yh.Rows[0]["����"].ToString() == "������")
                {
                    this.scs.Checked = true;
                }
            }
        }      
    }

    protected void updateUserInfo(object sender, EventArgs e)
    {      
		if(Session["yh_id"]!=null&&Session["yh_id"].ToString()!="") 
		{
		  s_yh_id = Session["yh_id"].ToString();
		}
        string s_lx="";
        if (this.gxs.Checked)
        {
            s_lx = "������";
        }
        else if (this.scs.Checked)
        {
            s_lx = "������";
        }
        string s_updateUserinfo = " update �û���   set �ֻ�='" +this.contactortel.Value + "', ����='" +this.contactorname.Value +
                                  "',��˾����='" + this.companyname.Value + "',��˾��ַ='"+this.companyaddress.Value+
                                  "',��˾�绰='" + this.companytel.Value + "',QQ����='"+this.contactorqqid.Value+
                                  "',����='"+s_lx+"' where yh_id='" + s_yh_id + "'";
        objConn.ExecuteSQL(s_updateUserinfo, true);
    }
		</script>

<form runat="server">
	
	<div class="cggytb">

		<div class="cggybtl"><img src="images/www_03.jpg" /></div>
		<div class="cggybtr">
			<dl>
				<dd>��˾���ƣ�</dd>  	<dt><input id="companyname" name="companyname" type="text" class="cgggg" runat="server"  /></dt>
				<dd>��˾��ַ��</dd>  	<dt><input id="companyaddress" name="companyaddress" type="text" class="cgggg" runat="server" /></dt>
				<dd>��˾�绰��</dd>  	<dt><input id="companytel" name="companytel" type="text" class="ggg" runat="server" /></dt>
				<dd>��˾�ǣ�</dd>    		<dt><input  id="scs" name="select" type="radio" value="������" runat="server" validationgroup="select" />������  
											<input id="gxs"  runat="server" name="select"  type="radio" value="������" validationgroup="select" />������ </dt>
				<dd>����������</dd>    		<dt><input  id="contactorname" name="contactorname" type="text" class="cgggg" runat="server"/></dt>
				<dd>���ĵ绰��</dd>    		<dt><input id="contactortel" name="contactortel" type="text" class="cgggg"  runat="server"/></dt>			
				<dd>����QQ���룺</dd>   	<dt><input id="contactorqqid" name="contactorqqid" type="text" class="cgggg" runat="server" /></dt>
				<dd>��˾��Ӫҵִ�գ� 	</dd><dt><input name="" type="text" class="ggg" /> <a href="#"><img src="images/sc_03.jpg" /></a></dt>
				<dd>��˾������֤�飺 	</dd><dt><input name="" type="text" class="ggg" /> <a href="#"><img src="images/sc_03.jpg" /></a></dt>
			</dl>
			<span class="cggybtan"><asp:ImageButton runat="server" ID="updateButtion" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
		</div>
	</div>
</form>
	<div>
	<!-- �������� ������ Ͷ�߽��� ��ʼ-->
	<!-- #include file="static/aboutus.aspx" -->
	<!-- �������� ������ Ͷ�߽��� ����-->
	</div>
	<div>
	<!--  footer ��ʼ-->
	<!-- #include file="static/footer.aspx" -->
	<!-- footer ����-->
	</div>

</body>
</html>
