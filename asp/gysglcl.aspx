<!--
       供应商管理材料页面 可以删除选中的材料,可也增加新的材料
	   文件名:  gysglcl.aspx   
       传入参数：s_yh_id 用户id 
       author:张新颖
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
<title>供应商收藏页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<link href="css/gl.css" rel="stylesheet" type="text/css" />
<script src="js/gysglcl.js" type="text/javascript"></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>


</head>

<body>

<!-- 头部开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部结束-->


<script runat="server">

    public Boolean userIsVIP = false;
    protected DataTable dt_cl = new DataTable();    //根据供应商id查询显示名,分类编码(材料表)
    protected DataTable dt_yjfl = new DataTable();  //取一级分类显示名称(材料分类表)
    protected DataTable dt_ejfl = new DataTable();  //取二级分类显示名称(材料分类表)
    public string sSQL = "";
    public string s_yh_id = "";                     //用户ID
    public string gys_id = "";                      //供应商id
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
        //根据用户id 查询供应商id
        sSQL = "select gys_id from 材料供应商信息表 where yh_id='" + s_yh_id + "' ";   //141           
        DataTable dt_gys = objConn.GetDataTable(sSQL);
    
        if (dt_gys != null && dt_gys.Rows.Count > 0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }

        //根据供应商id 查询材料信息
        sSQL = "select cl_id,显示名,分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' ";
        dt_cl = objConn.GetDataTable(sSQL);

      

        //取二级分类名称
        sSQL="select 显示名字,分类编码 from 材料分类表 where 分类编码 in(select 分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' )";
        dt_ejfl = objConn.GetDataTable(sSQL);

     
        CancelFollowButton.Attributes.Add("onClick", "return confirm('您确定要删除该选中的材料吗？');");
    }

    protected void dumpFollowCLs(object sender, EventArgs e)
    {

        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        string gys_id = "";
        //根据用户id 查询供应商id
        sSQL = "select gys_id from 材料供应商信息表 where yh_id='" + s_yh_id + "' ";
        DataTable dt_gys = objConn.GetDataTable(sSQL);
        if (dt_gys != null && dt_gys.Rows.Count > 0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }
        //根据gys_id 查询材料表相关的数据 以便导出excel 表格
        sSQL = "select*from 材料表 where gys_id='" + gys_id + "' ";

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
            argResp.AppendHeader("Content-Disposition", strResHeader);//attachment说明以附件下载，inline说明在线打开
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
        //根据用户id 查询供应商id
        sSQL = "select gys_id from 材料供应商信息表 where yh_id='" + s_yh_id + "' ";    
        DataTable dt_gys =objConn.GetDataTable(sSQL);
        if (dt_gys!=null&&dt_gys.Rows.Count>0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }
      
        //获取复选框选中的cl_id
        string clidstr = Request.Form["clid"];

        //通过获取的供应商id和cl_id进行删除
        sSQL = "update 材料表 set 是否启用='0' where gys_id ='" + gys_id + "' and cl_id in (" + clidstr + ")";
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
			    string code = row["分类编码"].ToString().Substring(0, 2);
			    sSQL = "select  显示名字 from 材料分类表 where 分类编码='" + code + "' ";
			    dt_yjfl = objConn.GetDataTable(sSQL);
			    foreach (System.Data.DataRow R_yjfl in dt_yjfl.Rows)
			    {
				%>
					<h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
					<img src="images/biao2.jpg" /><%=R_yjfl["显示名字"].ToString()%> &gt;</a></h1>
					<span class="no">
						<% 
						int secondlevel = 0;
						foreach (System.Data.DataRow R_ejfl in dt_ejfl.Rows)
						{
						%>
							<h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=R_ejfl["显示名字"].ToString()%></a></h2>
							<ul class="no">
								<% 
								//二级下的分类产品要根据,具体的二级分类编码进行查询				  
								string s_flbm = R_ejfl["分类编码"].ToString();
								sSQL = "select cl_id,显示名,分类编码 from 材料表 where gys_id='" + gys_id + "'and 分类编码='" + s_flbm + "'";
								System.Data.DataSet ds_cls = new System.Data.DataSet();                          
								System.Data.DataTable dt_cls = objConn.GetDataTable(sSQL);
								foreach (System.Data.DataRow R_cls in dt_cls.Rows)
								{						
								%>
									<input type="checkbox" name="clid" value="<%=R_cls["cl_id"].ToString()%>" />                           
									<a href="clbj.aspx?cl_id=<%=R_cls["cl_id"].ToString()%>"><%=R_cls["显示名"].ToString()%></a>
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
			<asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
		</div>
     <%
	}
	else 
	{
    %>
		<div class="dlex1">
			您可以把你管理的材料数据导出为excel，供下线使用
			 <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
        </div>
    <%
	}	
    %>

</div>
</form> 

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->



</body>
</html>



