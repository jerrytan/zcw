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
    <title>采购商关注材料管理页</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <style>
        #menu {
            width: 200px;
            margin: auto;
        }

            #menu h1 {
                font-size: 12px;
                margin-top: 1px;
                font-weight: 100;
            }

            #menu h2 {
                padding-left: 15px;
                font-size: 12px;
                font-weight: 100;
            }

            #menu ul {
                padding-left: 15px;
                height: 100px;
                overflow: auto;
                font-weight: 100;
            }

            #menu a {
                display: block;
                padding: 5px 0 3px 10px;
                text-decoration: none;
                overflow: hidden;
            }

                #menu a:hover {
                    color: #000;
                }

            #menu .no {
                display: none;
            }

            #menu .h1 a {
                color: #000;
            }

            #menu .h2 a {
                color: #000;
            }

            #menu h1 a {
                color: #000;
            }
    </style>

    <script language="JavaScript">
<!--//
    function ShowMenu(obj, n) {
        var Nav = obj.parentNode;
        if (!Nav.id) {
            var BName = Nav.getElementsByTagName("ul");
            var HName = Nav.getElementsByTagName("h2");
            var t = 2;
        } else {
            var BName = document.getElementById(Nav.id).getElementsByTagName("span");
            var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
            var t = 1;
        }
        for (var i = 0; i < HName.length; i++) {
            HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
            HName[i].className = "";
        }
        obj.className = "h" + t;
        for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
        if (BName[n].className == "no") {
            BName[n].className = "";
            obj.innerHTML = obj.innerHTML.replace("+", "-");
        } else {
            BName[n].className = "no";
            obj.className = "";
            obj.innerHTML = obj.innerHTML.replace("-", "+");
        }
    }
    //-->
    </script>
</head>
    
<body>

    <!-- 头部开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部结束-->


    <!-- 导航开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 导航结束-->


    <!-- banner开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner 结束-->
    <script runat="server">  
  
  public List<FLObject> Items1 { get; set; }
  public List<FLObject> Items2 { get; set; }
  public List<CLObject> Cllist { get; set; }
  public List<GYSObject> Gyslist { get; set; }
  public Boolean userIsVIP = false;
  

  protected DataTable dt = new DataTable(); //取一级分类名称
  protected String yh_id;
  protected void Page_Load(object sender, EventArgs e)
  {
        
        String QQid = Request.Cookies["QQ_id"].Value;

        String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
        String str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+QQid+"'";
        SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
        conn.Open();
        Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();
        
        if (obj_checkuserexist != null) 
        {
             int count = Convert.ToInt32(obj_checkuserexist);
             if (count ==0 )  //qq_id 不存在，需要增加用户表
             {

                   String str_insertuser = "insert into 用户表 (QQ_id) VALUES ('"+ QQid+"')";
                   SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                   cmd_insertuser.ExecuteNonQuery();
                   String str_updateuser = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+QQid+"') where QQ_id = '"+QQid+"'";
                   SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                   cmd_updateuser.ExecuteNonQuery();                  
                  
              }
              SqlDataAdapter da = new SqlDataAdapter("select 姓名,yh_id,是否验证通过,类型,等级 from 用户表 where QQ_id='"+QQid+"'", conn);
              DataSet ds = new DataSet();
              da.Fill(ds, "用户表");           
              DataTable dt = ds.Tables[0];
              yh_id = Convert.ToString(dt.Rows[0]["yh_id"]);
              Session["yh_id"] = yh_id;
                      
               
         }
         conn.Close();
                
    
        listFollowCLIDs();
  }
  protected void listFollowCLIDs()
  {
    
	  string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
    
   
    yh_id = Session["yh_id"].ToString();
    //yh_id ="20";
  	string querySQL = 
  		"select distinct a.分类编码,a.显示名字 from 材料分类表 as a , " + 
   		"	(select distinct c.分类编码 as flbm " + 
   		"    from 采购商关注材料表 as b ,材料表 as c  " +
      "   where b.yh_id='"  + yh_id  +  "' and b.cl_id=c.cl_id  ) as  d " + 
  		" where a.分类编码=d.flbm  " + 
     	" 	 or a.分类编码=left(d.flbm,2)";
         
    SqlDataAdapter da = new SqlDataAdapter(querySQL, conn);
    DataSet ds = new DataSet();
    da.Fill(ds, "材料分类表");  
    dt = ds.Tables[0];
      
    querySQL = 
   		"	select b.cl_id ,分类编码,显示名 " + 
   		"   from 采购商关注材料表 as a ,材料表 as b  " +
      "  where a.yh_id='" + yh_id + "' and a.cl_id=b.cl_id order by b.cl_id";
         
    da = new SqlDataAdapter(querySQL, conn);
    DataSet clds = new DataSet();
    da.Fill(clds, "材料表"); 
    DataTable cldt = new DataTable();
    cldt = clds.Tables[0];
    
    querySQL = 
   		"	select a.gys_id ,a.供应商 " + 
   		"   from 材料供应商信息表 as a ,采购商关注供应商表 as b  " +
      "  where b.yh_id='" + yh_id + "' and a.gys_id=b.gys_id order by a.gys_id";
      
    da = new SqlDataAdapter(querySQL, conn);
    DataSet clgysds = new DataSet();
    da.Fill(clgysds, "材料供应商信息表"); 
    DataTable clgysdt = new DataTable();
    clgysdt = clgysds.Tables[0];
    
    conn.Close(); 
    
		
    ////分类表DataTable转集合                  
    this.Items1 = new List<FLObject>();
    this.Items2 = new List<FLObject>();
    //材料DataTable转集合
    this.Cllist = new List<CLObject>();
    this.Gyslist = new List<GYSObject>();
       
    for(int x=0;x<dt.Rows.Count;x++)
    {
    	DataRow dr2 = dt.Rows[x];                         
      if (Convert.ToString(dr2["分类编码"]).Length == 2 ) 
      {
      	FLObject item = new FLObject();
        item.Name = Convert.ToString(dr2["显示名字"]);
        item.flbm = Convert.ToString(dr2["分类编码"]);
        this.Items1.Add(item);
      }
      if (Convert.ToString(dr2["分类编码"]).Length == 4 ) 
      {
      	FLObject item = new FLObject();
        item.Name = Convert.ToString(dr2["显示名字"]);
        item.flbm = Convert.ToString(dr2["分类编码"]);
        this.Items2.Add(item);
      }
		}       
    
    for(int x=0;x<cldt.Rows.Count;x++)
    {
    	DataRow dr2 = cldt.Rows[x];                         
      CLObject item = new CLObject();
      item.Name = Convert.ToString(dr2["显示名"]);
      item.flbm = Convert.ToString(dr2["分类编码"]);
      item.clid = Convert.ToString(dr2["cl_id"]);
      this.Cllist.Add(item);
    } 
    
    for(int x=0;x<clgysdt.Rows.Count;x++)
    {
    	DataRow dr2 = clgysdt.Rows[x];                         
      GYSObject item = new GYSObject();
      item.gysname = Convert.ToString(dr2["供应商"]);
      item.gysid = Convert.ToString(dr2["gys_id"]);
      this.Gyslist.Add(item);
    } 
    CancelFollowButton.Attributes.Add("onClick", "return confirm('您真的要取消对这些材料或供应商的关注吗？');");
  }
  public class FLObject
  { //属性
  	public string flbm { get; set; }
    public string Name { get; set; }
    //public string Uid { get; set; }   
  }
  
  public class CLObject
  { //属性
  	public string flbm { get; set; }
    public string Name { get; set; }
    public string clid { get; set; }
  }
  public class GYSObject
  {
  	//属性
  	public string gysid { get; set; }
    public string gysname { get; set; }
  }
  
  
  
  
  
  protected void dumpFollowCLs(object sender, EventArgs e)
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
  	string yh_id = Session["yh_id"].ToString();
  	//yh_id = "20";
  	string str_queryallcl = "select b.* from 采购商关注材料表 as  a ,材料表 as b " + 
  	                        " where a.yh_id='"  + yh_id + "'  and a.cl_id = b.cl_id " ;
  	
  	SqlDataAdapter da = new SqlDataAdapter(str_queryallcl, conn);
    DataSet clds = new DataSet();
    da.Fill(clds, "材料表"); 
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
    }
    </script>

    <div class="dlqqz">
        <div class="dlqqz1">
            <img src="images/sccp.jpg" />
        </div>


        <form id="form1" runat="server">

            <script runat="server">
  void cancelFollows(object sender, EventArgs e)
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
  	string yh_id;
  	yh_id = Session["yh_id"].ToString();
  	//yh_id = "20";
  	string clidstr =Request.Form["clid"];
  	//clidstr = ",21,100";
  	//clidstr =clidstr.Substring(1);
  	string str_cancelfollow = "delete 采购商关注材料表 where yh_id ='" +  yh_id + "' and cl_id in (" + clidstr + ")" ;
  	SqlCommand cmd_cancelfollow = new SqlCommand(str_cancelfollow, conn);         
    cmd_cancelfollow.ExecuteNonQuery();
    
    string gysids = Request.Form["gysid"];
    string sql_cancelfollowgys = "delete 采购商关注供应商表 where yh_id ='" +  yh_id + "' and gys_id in (" + gysids + ")" ;
  	
  	cmd_cancelfollow = new SqlCommand(sql_cancelfollowgys, conn);         
    cmd_cancelfollow.ExecuteNonQuery();
    label1.Text=sql_cancelfollowgys;
  	conn.Close();
    listFollowCLIDs();
  }
  
  
            </script>

            <div class="dlqqz2">
                <div id="menu">
                    <% 
 	   int firstlevel = 0;
     foreach (var menu1 in this.Items1){
                    %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
                        <img src="images/biao2.jpg" /><%=menu1.Name%> &gt;</a></h1>
                    <span class="no">
                        <% 
 	    int secondlevel = 0;
 		  foreach (var menu2 in this.Items2){
 	   	if ( (menu2.flbm).Substring(0,2) == menu1.flbm ){  
                        %>
                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=menu2.Name%></a></h2>
                        <ul class="no">
                            <% 
            foreach (var cl in this.Cllist){
      	        if ( (cl.flbm).Substring(0,4) == menu2.flbm ){
                            %>
                            <a href="javascript:void(0)"><%=cl.Name %><input type="checkbox" name="clid" value="<%=cl.clid%>" />选中</a>
                            <% 	
   			    }
   		    }
   		    secondlevel++;
                            %>
                        </ul>
                        <% 	
        } 
  	}
                        %>
                    </span>
                    <% 
 		firstlevel++;
   } 
                    %>
 <h1 onClick="javascript:ShowMenu(this,1)"><a href="javascript:void(0)"><img src="images/biao2.jpg" /> 供应商列表 &gt;</a></h1>
 <span class="no">
  <h2 onClick="javascript:ShowMenu(this,0)"><a href="javascript:void(0)">+ 材料供应商</a></h2>
  <ul class="no">
   <%
   foreach (var gys in this.Gyslist){
   %>
   <a href="javascript:void(0)"><%=gys.gysname %><input type="checkbox" name="gysid" value="<%=gys.gysid%>" />选中</a>
   <% } %>
  </ul>
 </span>
                </div>
            </div>
            <div class="dlqqz3">
                &nbsp;&nbsp;<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg" runat="server" OnClick="cancelFollows" />
            </div>
            <asp:Label ID="label1" runat="server" Text="" />

            <%
	if (userIsVIP){
            %>
            <div class="dlex1">
                <div class="dlex1">
                    <asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
                </div>
            </div>
            <%
	}else {
            %>
            
            <div class="dlex1">
                您也可以把您收藏的材料数据和供应商数据导出为excel，供线下使用
                <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
            </div>
            <%
	}	
            %>
    </div>
    </form>
    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->

    </div>
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</div>
</div>


</div>

  
</html>
