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
    public string[] yjflbm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
        }
        Products_gys_cl();
        if(!IsPostBack)
        {
           sSQL = "select 公司名称,公司地址,公司电话,公司主页,类型,手机,类型,QQ号码,姓名,是否验证通过 from 用户表 where  yh_id='"+s_yh_id+"' ";
           DataTable dt_yh=objConn.GetDataTable(sSQL);
           if(dt_yh!=null&&dt_yh.Rows.Count>0)
           {
                string lx="";
                this.companyname.Value = dt_yh.Rows[0]["公司名称"].ToString();
                this.companytel.Value = dt_yh.Rows[0]["公司地址"].ToString();
                this.companyaddress.Value = dt_yh.Rows[0]["公司电话"].ToString();
                this.contactorname.Value = dt_yh.Rows[0]["姓名"].ToString();
                this.contactortel.Value = dt_yh.Rows[0]["手机"].ToString();
                this.QQ_id.Value = dt_yh.Rows[0]["QQ号码"].ToString();
                lx=dt_yh.Rows[0]["类型"].ToString();
                if(lx=="生产商")
                {
                     this.scs.Checked = true;  
                }
                else if(lx=="分销商")
                {
                    this.gxs.Checked = true;
                }
           }
        }
       
    }
    protected void Products_gys_cl()
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
        }
        sSQL = "select 等级 from 用户表 where yh_id='" + s_yh_id + "' ";   //141           
        string vip = objConn.DBLook(sSQL);
        if(vip=="VIP用户")
        {
            userIsVIP=true;
        }
        //根据用户id 查询供应商id
        sSQL = "select gys_id from 材料供应商信息表 where yh_id='" + s_yh_id + "' ";   //141           
        DataTable dt_gys = objConn.GetDataTable(sSQL);
    
        if (dt_gys != null && dt_gys.Rows.Count > 0)
        {
            gys_id = dt_gys.Rows[0]["gys_id"].ToString();
        }

        // 取 二级分类编码
         sSQL="select 显示名字,分类编码 from 材料分类表 where 分类编码 in(select 分类编码 from 材料表 where gys_id='" + gys_id + "'and 是否启用='1' )";
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
     
        CancelFollowButton.Attributes.Add("onClick", "return confirm('您确定要删除该选中的材料吗？');");
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
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
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
        if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
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
    protected void updateUserInfo(object sender, EventArgs e)
    {      
		if(Session["CGS_YH_ID"]!=null&&Session["CGS_YH_ID"].ToString()!="") 
		{
		  s_yh_id = Session["CGS_YH_ID"].ToString();
		}
         if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
        {
             s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
        }
        string s_lx="";
        if (this.gxs.Checked)
        {
            s_lx = "分销商";
        }
        else if (this.scs.Checked)
        {
            s_lx = "生产商";
        }
		    if (this.contactortel.Value == "")
        {
            objConn.MsgBox(this.Page, "手机不能为空,请填写!");
            this.contactortel.Focus();
            return;
        }
        if (this.contactorname.Value == "")
        {
            objConn.MsgBox(this.Page, "姓名不能为空,请填写!");
            this.contactorname.Focus();
            return;
        }
        if (this.companyname.Value == "")
        {
            objConn.MsgBox(this.Page, "公司名称不能为空,请填写!");
            this.companyname.Focus();
            return;
        }
        if (this.companyaddress.Value == "")
        {
            objConn.MsgBox(this.Page, "公司地址不能为空,请填写!");
            this.companyaddress.Focus();
            return;
        }
        if (this.companytel.Value == "")
        {
            objConn.MsgBox(this.Page, "公司电话不能为空,请填写!");
            this.companytel.Focus();
            return;
        }
        string s_updateUserinfo = " update 用户表   set 手机='" +this.contactortel.Value + "', 姓名='" +this.contactorname.Value +
                                  "',公司名称='" + this.companyname.Value + "',公司地址='"+this.companyaddress.Value+
                                  "',公司电话='" + this.companytel.Value + "',QQ号码='"+this.QQ_id.Value+
                                  "',类型='"+s_lx+"',是否验证通过='待审核' where yh_id='" + s_yh_id + "'";
         if(!objConn.ExecuteSQL(s_updateUserinfo, true))
        {
            objConn.MsgBox(this.Page, "更新失败，请重试！");
        }
        else
        {
            Response.Redirect("gyszym.aspx");
        }
    }
    </script>
    <form id="form1" runat="server">
    <div class="dlqqz">
        <div class="dlqqz1">
            <img src="images/sccp.jpg" /></div>
        <span class="dlqqz4">
            <img src="images/wz_03.jpg" width="530" height="300" /></span>
        <div class="dlqqz2">
            <div id="menu">
                <% 
 	            int firstlevel = 0;
			    foreach (string yjfl in yjflbm)
			    {
                      string[] yj=new string[2];
                      yj=yjfl.Split('|');//yj[0]  一级编码  yj[1] 一级显示名字
                %>
                         <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)">
                             <a href="javascript:void(0)">
                             <img src="images/biao2.jpg" /><%=yj[1]%> &gt;</a>
                        </h1>
                        <span class="no">
                            <% 
						        int secondlevel = 0;
						        foreach (System.Data.DataRow R_ejfl in dt_ejfl.Rows)
						        {
                                    if(yj[0]==R_ejfl["分类编码"].ToString().Substring(0,2))
                                    {
                            %>
                                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )">
                                          <a href="javascript:void(0)">+<%=R_ejfl["显示名字"].ToString()%></a></h2>
                                        <ul class="no">
                                               <% 
								                //二级下的分类产品要根据,具体的二级分类编码进行查询				  
								                string s_flbm = R_ejfl["分类编码"].ToString();
								                sSQL = "select cl_id,显示名,分类编码 from 材料表 where gys_id='" + gys_id + "'and 分类编码='" + s_flbm + "' and 是否启用='1'";
								                System.Data.DataSet ds_cls = new System.Data.DataSet();                          
								                System.Data.DataTable dt_cls = objConn.GetDataTable(sSQL);
								                foreach (System.Data.DataRow R_cls in dt_cls.Rows)
								                { %>
                                                    <input type="checkbox" name="clid" value="<%=R_cls["cl_id"].ToString()%>" />
                                                    <a href="clbj.aspx?cl_id=<%=R_cls["cl_id"].ToString()%>"><%=R_cls["显示名"].ToString()%></a>
                                              <%} %>
                                        </ul>
                                       
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
        </div>
        <div class="dlqqz3" style="width: 260px;">
            <a href="xzclym.aspx?gys_id=<%=gys_id %>">
                <img src="images/xzcl.jpg" border="0" /></a>&nbsp;
            <asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg" runat="server"
                OnClick="Delete_cl" />
        </div>
    </div>
    <div class="dlex">
        <%
	if (userIsVIP){
        %>
        <div class="dlex1">
            <asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
        </div>
        <%}else { %>
        <div class="dlex1">
            您可以把你管理的材料数据导出为excel，供下线使用
            <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
        </div>
        <%
	}	
        %>
    </div>
 
   <div class="cgdlqq">
		    <div class="cgdlex">
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
		    </div>
	    </div>

    </form>
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
