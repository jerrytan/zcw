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

<%@ PAGE Language="C#"%>
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
            sSQL = "select cl_id,显示名,品牌名称,规格型号,材料编码,生产厂商 from 材料表 where left(是否启用,1) like '%1%' and 分类名称= '" + ejfl + "' order by cl_id";
            string sSearchCondition = "显示名='" + ejfl + "'";
            dt_cl = objConn.GetDataTable(sSQL);
        }
        else
        {
            sSQL = "select top 10 cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商,是否启用 from 材料表 where 是否启用=1 order by updatetime desc";
            dt_cl = objConn.GetDataTable(sSQL);
        }
        //btnDelete.Attributes.Add("onClick", "return confirm('您确定要删除该选中的材料吗？');");
    }

    protected void Products_gys_cl()
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        gys_id = Request.QueryString["gys_id"].ToString();
        sSQL = "select 等级 from 用户表 where yh_id='" + s_yh_id + "' ";   //141           
        string vip = objConn.DBLook(sSQL);
        if(vip=="VIP用户")
        {
            userIsVIP=true;
        }

        // 取 二级分类编码
         sSQL="select 显示名字,分类编码 from 材料分类表 where 分类编码 in(select 分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1')";
          dt_ejfl = objConn.GetDataTable(sSQL);
          if(dt_ejfl!=null&&dt_ejfl.Rows.Count>0)
          {
              yjflbm=new string[dt_ejfl.Rows.Count];
              for(int i=0;i<dt_ejfl.Rows.Count;i++)
              {
                    sSQL="select 显示名字,分类编码 from 材料分类表 where 分类编码='"+dt_ejfl.Rows[i]["分类编码"].ToString().Substring(0,2)+"'";
                    DataTable flbm=objConn.GetDataTable(sSQL);
                    if(flbm!=null&&flbm.Rows.Count>0)
                    {
                         yjflbm[i]=flbm.Rows[0]["分类编码"].ToString()+"|"+flbm.Rows[0]["显示名字"].ToString();
                    }
               } 
                yjflbm=GetString(yjflbm);             
          }
          else
          {
             yjflbm=new string[0];
          }
               
        //一级分类编码


         sSQL="select cl_id,显示名,分类编码 from 材料分类表 where 分类编码 in( select 分类编码 from 材料表 gys_id='" + gys_id + "'and 是否启用='1') and len(分类编码)=2 ";
         dt_yjfl=objConn.GetDataTable(sSQL);

         sSQL="select cl_id,显示名,分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' and len(分类编码)=4 ";
         dt_ejfl=objConn.GetDataTable(sSQL);

        //根据供应商id 查询材料信息
        sSQL = "select cl_id,显示名,分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' ";
        dt_cl = objConn.GetDataTable(sSQL);

      

        //取二级分类名称
        sSQL="select 显示名字,分类编码 from 材料分类表 where 分类编码 in(select 分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' )";
        dt_ejfl = objConn.GetDataTable(sSQL);       
        
    }
    public static string[] GetString(string[] values) 
    { 
         List<string> list = new List<string>(); 
        for (int i = 0; i < values.Length; i++)//遍历数组成员 
        { 
            if (list.IndexOf(values[i].ToLower()) == -1) 
            //对每个成员做一次新数组查询如果没有相等的则加到新数组 
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
        
        sSQL = "select * from 材料表 where gys_id='" + gys_id + "' ";

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
        //蒋，2014年8月27日，注释用户id取值，添加gys_id取值
        //if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        //{
        //    s_yh_id = Session["GYS_YH_ID"].ToString();
        //}
        
        //根据用户id 查询供应商id
        gys_id = Request.QueryString["gys_id"].ToString();
        //获取复选框选中的cl_id
        string clidstr = Request.Form["clid"];
        if (clidstr != "" && clidstr != null)
        {
            //通过获取的供应商id和cl_id进行删除
            sSQL = "update 材料表 set 是否启用='0' where gys_id ='" + gys_id + "' and cl_id in (" + clidstr + ")";
            objConn.ExecuteSQL(sSQL, true);
            if(ejfl=="")
            {
                Response.Write(clidstr);
                sSQL = "select top 10 cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商,是否启用 from 材料表 where 是否启用=1 order by updatetime desc";
                dt_cl = objConn.GetDataTable(sSQL);
            }
            else
            {
                sSQL = "select top 10 cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商,是否启用 from 材料表 where 是否启用=1 and 分类名称='" + ejfl + "' order by updatetime desc ";
                dt_cl=objConn.GetDataTable(sSQL);
            }
            //Products_gys_cl();
            Response.Write("<script>window.alert('删除成功！')</" + "script>");
        }
        else
        {
            Response.Write("<script>window.alert('您没有选中任何材料！')</" + "script>");
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
<div class="dlqqz1">您的产品列表</div>
 <% 
 	int firstlevel = 0;
    foreach (string yjfl in yjflbm)
    {
        string[] yj = new string[2];
        yj = yjfl.Split('|');//yj[0]  一级编码  yj[1] 一级显示名字
    %>
    <h2 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)"><img src="images/biao2.jpg" />&nbsp;<%=yj[1]%></a></h2>
    <span class="no">
    <input type="hidden" id="lblgys_id" runat="server" />
    <% 
	int secondlevel = 0;
	foreach (System.Data.DataRow R_ejfl in dt_ejfl.Rows)
	{
        if(yj[0]==R_ejfl["分类编码"].ToString().Substring(0,2))
        {
            string value = R_ejfl["显示名字"].ToString();
            %>
   <h4>  
    <a href="javascript:void(0)" onclick="CZ('<%=value %>')"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=R_ejfl["显示名字"].ToString() %></a>
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
  <%-- 蒋，2014年8月18日注释该表单，在会员注册时审核过了，不需要再有表单显示信息--%>
		   <%-- <div class="cgdlex">
			    <div class="cgdlex2">
				    <span class="cgdlex3">您的信息如下，如需更改请单击更改按钮</span>
				    <dl>						
					    <dd>*贵公司名称：</dd><dt><input class="cgdlex2text" id="companyname" name="companyname" type="text"   runat="server" /></dt>
					    <dd>*贵公司地址：</dd><dt><input class="cgdlex2text"  id="companyaddress" name="companyaddress" type="text"  runat="server" /></dt>
					    <dd>*贵公司电话：</dd><dt><input class="cgdlex2text"  id="companytel" name="companytel" type="text"  runat="server"/></dt>
					    <dd>&nbsp;贵公司主页：</dd><dt><input name="gys_homepage" id="gys_homepage" type="text" class="cgdlex2text"  runat="server"/></dt>
                        <dd>*贵公司是：</dd><dt><input  id="scs" name="select" type="radio" value="生产商" runat="server" validationgroup="select" />生产商  
											<input id="gxs"  runat="server" name="select"  type="radio" value="分销商" validationgroup="select" />分销商 </dt>
                        <dd>*您的姓名：  </dd><dt><input class="cgdlex2text"  id="contactorname" name="contactorname" runat="server"/></dt>
					    <dd>*您的电话：  </dd><dt><input class="cgdlex2text"  id="contactortel" name="contactortel0" runat="server"/></dt>
					    <dd>您的QQ号码： </dd><dt><input class="cgdlex2text"  id="QQ_id" name="contactortel" runat="server"/></dt>					  
				    </dl>
				    <asp:Label ID="label2" runat="server" Text="" />
				    <span class="cggg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
			    </div>
		    </div>--%>
    </form>
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
