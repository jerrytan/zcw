<!--      
	  
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <title>�����������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 132px;
        }
    </style>
</head>
	
<script runat="server">
    public DataConn objConn = new DataConn();
    public string gys="";//���մ������Ĺ�Ӧ�̹�˾����
    public string fxs_id="";
    public DataTable dt_lx=new DataTable();
    public DataTable dt_gys = new DataTable();//���Ϲ�Ӧ����Ϣ��
     public List<Option_gys> Items { get; set; }

        public class Option_gys
        {//����
            public string gys { get; set; }       //�ȼ�
            public string zy { get; set; }    //��Χ
            public string dz { get; set; }        //��������
            public string cz { get; set; }   //����id
            public string dh { get; set; }        //������
            public string lxr { get; set; }       //������id
            public string lxrsj { get; set; }
            public string dwlx { get; set; }      
            public string zzjgbh { get; set; }
            public string qymc { get; set; }
            public string lxdz { get; set; }
            public string jyfw { get; set; }
            public string zcrq { get; set; }
            public string yyzzzch { get; set; }
                        
        }
    protected void Page_Load(object sender, EventArgs e)
    {
        gys=Request.QueryString["gys_id"];
         
    }
</script>

<body>
	  <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
 <form>



 </form>
     <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  
</body>
</html>



