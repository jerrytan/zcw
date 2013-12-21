<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

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
<title>�ɹ��̲��Ϲ���ҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
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
  
  public List<FLObject> Items1 { get; set; }
  public List<FLObject> Items2 { get; set; }
  public List<CLObject> Cllist { get; set; }
  public Boolean userIsVIP = true;

  protected DataTable dt = new DataTable(); //ȡһ����������
  protected void Page_Load(object sender, EventArgs e)
  {

		string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
    
    string yh_id = Request["yh_id"];
    yh_id="10";
  	string querySQL = 
  		"select a.�������,a.��ʾ���� from ���Ϸ���� as a , " + 
   		"	(select distinct left(�������,6) as flbm " + 
   		"    from �ɹ��̹�ע���ϱ� as b ,���ϱ� as c  " +
      "   where b.yh_id='"  + yh_id  +  "' and b.cl_id=c.cl_id  ) as  d " + 
  		" where a.�������=d.flbm  " + 
     	" 	 or a.�������=left(d.flbm,2)";
      //"    or a.�������=left(d.flbm,2) " ;
         
    SqlDataAdapter da = new SqlDataAdapter(querySQL, conn);
    DataSet ds = new DataSet();
    da.Fill(ds, "���Ϸ����");  
    dt = ds.Tables[0];
      
    querySQL = 
   		"	select b.cl_id ,�������,��ʾ�� " + 
   		"   from �ɹ��̹�ע���ϱ� as a ,���ϱ� as b  " +
      "  where a.yh_id='" + yh_id + "' and a.cl_id=b.cl_id";
         
    da = new SqlDataAdapter(querySQL, conn);
    DataSet clds = new DataSet();
    da.Fill(clds, "���ϱ�"); 
    conn.Close(); 
    DataTable cldt = new DataTable();
    cldt = clds.Tables[0];
		
    ////�����DataTableת����                  
    this.Items1 = new List<FLObject>();
    this.Items2 = new List<FLObject>();
    //����DataTableת����
    this.Cllist = new List<CLObject>();
       
    for(int x=0;x<dt.Rows.Count;x++)
    {
    	DataRow dr2 = dt.Rows[x];                         
      if (Convert.ToString(dr2["�������"]).Length == 2 ) 
      {
      	FLObject item = new FLObject();
        item.Name = Convert.ToString(dr2["��ʾ����"]);
        item.flbm = Convert.ToString(dr2["�������"]);
        this.Items1.Add(item);
      }
      if (Convert.ToString(dr2["�������"]).Length == 4 ) 
      {
      	FLObject item = new FLObject();
        item.Name = Convert.ToString(dr2["��ʾ����"]);
        item.flbm = Convert.ToString(dr2["�������"]);
        this.Items2.Add(item);
      }
		}       
    
    for(int x=0;x<cldt.Rows.Count;x++)
    {
    	DataRow dr2 = cldt.Rows[x];                         
      CLObject item = new CLObject();
      item.Name = Convert.ToString(dr2["��ʾ��"]);
      item.flbm = Convert.ToString(dr2["�������"]);
      item.clid = Convert.ToString(dr2["cl_id"]);
      this.Cllist.Add(item);
		} 
	}
	public class FLObject
  { //����
  	public string flbm { get; set; }
    public string Name { get; set; }
    //public string Uid { get; set; }   
  }
  
  public class CLObject
  { //����
  	public string flbm { get; set; }
    public string Name { get; set; }
    public string clid { get; set; }
  }
  
  
  void cancelFollow()
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
    
  	string yhid = Request["yh_id"];
  	string clidstr =Request.Form["clid"];
  	string[] listclid = clidstr.Split(',');
  	foreach (var clid in listclid)
  	{
  		string str_cancelfollow = "delete from �ɹ��̹�ע���ϱ� where yh_id ='" +  yhid + "' and cl_id='" + clid + "'";
  		SqlCommand cmd_cancelfollow = new SqlCommand(str_cancelfollow, conn);         
      cmd_cancelfollow.ExecuteNonQuery();
  	}
  	conn.Close();
  }
  
  protected void dumpFollowCLs(object sender, EventArgs e)
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
  	string yhid = Request["yh_id"];
  	yhid="10";
  	string str_queryallcl = "select b.* from �ɹ��̹�ע���ϱ� as  a ,���ϱ� as b " + 
  	                        " where a.yh_id='"  + yhid + "'  and a.cl_id = b.cl_id " ;
  	
  	SqlDataAdapter da = new SqlDataAdapter(str_queryallcl, conn);
    DataSet clds = new DataSet();
    da.Fill(clds, "���ϱ�"); 
    conn.Close();
    DataTable cldt = new DataTable();
    cldt = clds.Tables[0];
    outToExcel(cldt);
  }
  private StringBuilder  AppendCSVFields(StringBuilder argSource, string argFields)
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
        
  public void outToExcel(DataTable followcls) {
  	
        StringWriter swCSV = new StringWriter();
        StringBuilder sbText = new StringBuilder();
        for (int i = 0; i < followcls.Columns.Count; i++)
        {
        	AppendCSVFields(sbText,followcls.Columns[i].ColumnName);
        }
        sbText.Remove(sbText.Length - 1, 1);
        swCSV.WriteLine(sbText.ToString());
        
        for (int i = 0; i < followcls.Rows.Count; i++)
        {
        	sbText.Clear();
        	for (int j = 0; j < followcls.Columns.Count; j++)
          {
          	AppendCSVFields(sbText,followcls.Rows[i][j].ToString());
          }
          sbText.Remove(sbText.Length - 1, 1);
        	swCSV.WriteLine(sbText.ToString());
        }
        string fileName = Path.GetRandomFileName();
        DownloadFile(Response, swCSV.GetStringBuilder(), fileName +".csv");
        swCSV.Close();
        Response.End();
        /*
        string fileName = Global.getRamFileName();
        fileName = System.Web.HttpContext.Current.Server.MapPath(".") + "//excel//" + fileName + ".xls";
        workbook.SaveCopyAs(fileName); 
        workbook.Close(false, null, null);
        excel.Quit();

        System.IO.FileInfo file = new System.IO.FileInfo(fileName);
        System.Web.HttpContext.Current.Response.Clear();
        System.Web.HttpContext.Current.Response.Charset = "UTF-8";
        System.Web.HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8; 
        //����ͷ��Ϣ��Ϊ"�ļ�����/����Ϊ"�Ի���ָ��Ĭ���ļ���
        System.Web.HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + System.Web.HttpContext.Current.Server.UrlEncode(file.Name)); 
        //����ͷ��Ϣ��ָ���ļ���С����������ܹ���ʾ���ؽ���
        System.Web.HttpContext.Current.Response.AddHeader("Content-Length",file.Length.ToString());

        // ָ�����ص���һ�����ܱ��ͻ��˶�ȡ���������뱻����
        System.Web.HttpContext.Current.Response.ContentType = "application/ms-excel";

        // ���ļ������͵��ͻ���
        System.Web.HttpContext.Current.Response.WriteFile(file.FullName); 
        //ֹͣҳ���ִ��

        System.Web.HttpContext.Current.Response.End();
        //CheckBoxList1.Items.Clear();
        */
    }
</script>



<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>

<form id="form1" runat="server">
	
<div class="dlqqz2"><div id="menu">
	
 <% foreach (var menu1 in this.Items1){%>
 <h1 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /> <%=menu1.Name%> &gt;</a></h1>
 <span class="no">
 	<% foreach (var menu2 in this.Items2){
 	   	if ( (menu2.flbm).Substring(0,2) == menu1.flbm ){
 	    
 	%>
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ <%=menu2.Name%></a></a></h2>
  <ul class="no">
   <% foreach (var cl in this.Cllist){
      	if ( (cl.flbm).Substring(0,4) == menu2.flbm ){
   %>
   		<a href="javascript:void(0)"><%=cl.Name %> 
   		<input type="checkbox" name="clid" value="<%=cl.clid%>" /> ѡ��</a>
   <% 	}
   		}
   %>
   </ul>
  <% 	} 
  	}
  %>
 </span>
 <% } %>       
  
</div></div>
<div class="dlqqz3"><a href="#"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;&nbsp;<a href="#"><img src="images/scxzcl.jpg" border="0" /></a></div>
<%
	if (userIsVIP){
%>
<div class="dlex1"><div class="dlex1">
	<asp:Button  runat="server" ID="button1" Text ="ѡ�����ݽ��������ڲ�ϵͳ" onclick="dumpFollowCLs"/></div>
</div>
<%
	}else {
%>
<div class="dlex1">
	<asp:Button  runat="server" ID="button2" Text ="ȫ������ΪEXCEL" onclick="dumpFollowCLs"/>
</div>
<%
	}	
%>
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


</div>
</div>


</div>





<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<script type="text/javascript">
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
</body>
</html>