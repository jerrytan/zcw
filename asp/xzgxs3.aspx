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
    <title>管理分销商信息</title>
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
    public string gys="";//接收传过来的供应商公司名称
    public string fxs_id="";
    public DataTable dt_lx=new DataTable();
    public DataTable dt_gys = new DataTable();//材料供应商信息表
     public List<Option_gys> Items { get; set; }

        public class Option_gys
        {//属性
            public string gys { get; set; }       //等级
            public string zy { get; set; }    //范围
            public string dz { get; set; }        //分类名称
            public string cz { get; set; }   //分类id
            public string dh { get; set; }        //生产商
            public string lxr { get; set; }       //生产商id
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
	  <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
 <form>



 </form>
     <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->  
</body>
</html>



