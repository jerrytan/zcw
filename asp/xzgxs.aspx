<!--
      新增分供销商页面  生产商或 新增分销商  分销商认领 找不到公司 新增 分销商	  
	  文件名:  xzgxs.aspx        
	  传入参数:用户id	  
     author:张新颖
--> 
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>  
    <script src="js/SJLD_New.js" type="text/javascript"></script>
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />

</head>
 <script runat="server">
        protected DataTable dt_yjfl = new DataTable();   //材料分类大类
        public DataConn objConn = new DataConn();
        public string sSQL="";
        public string xzlx = "";
        public string gys_id = "";
        public DataTable dt_ppxx;
        public DataTable dt_clfl;
        public string s_yh_id = "";
        public string gxs_id = "";
        public string fxs_id = "";
        public DataTable dt_fxpp = new DataTable();
        public DataTable dt_gys = new DataTable();//材料供应商信息表
        public int PageSize = 10;
        DataView objDv = null;
        DataTable objDt = null;
        public DataTable dt_gsxx = new DataTable();
        protected DataTable dt_content = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
                this.xxpp.Visible = true;
                this.divtable.Visible = false;
                if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
                {
                    s_yh_id = Session["GYS_YH_ID"].ToString();
                }
                if (Request["xzlx"] != null && Request["xzlx"].ToString() != "")
                {
                    xzlx = Request["xzlx"].ToString();
                    if (xzlx.Trim() == "scs")
                    {
                        xzlx = "生产商";
                    }
                    else if (xzlx.Trim() == "fxs")
                    {
                        xzlx = "分销商";
                    }

                }
                if (Request["gxs_id"] != null && Request["gxs_id"].ToString() != "")
                {
                    gxs_id = Request.QueryString["gxs_id"].ToString();
                }
                gys_id = gxs_id;
                if (xzlx == "分销商")  //当前用户是生产商
                {
                    if (gxs_id != "")
                    {
                        sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where scs_id='" + gxs_id + "'";
                        dt_ppxx = objConn.GetDataTable(sSQL);
                    }
                    else
                    {
                        sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典";
                        dt_ppxx = objConn.GetDataTable(sSQL);
                    }
                }
                //else
                //{                 
                //    sSQL = "select pp_id from 分销商和品牌对应关系表 where fxs_id='" + gxs_id + "'";
                //    dt_fxpp = objConn.GetDataTable(sSQL);

                //    string pp_id = dt_fxpp.Rows[0]["pp_id"].ToString();
                //    sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where pp_id=" + pp_id;
                //    dt_ppxx = objConn.GetDataTable(sSQL);

                //}
                sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";//取大类的数据
                dt_yjfl = objConn.GetDataTable(sSQL);
                sSQL = "select 分类编码,显示名字 from 材料分类表 where 是否启用=1";
                dt_clfl = objConn.GetDataTable(sSQL);
                if (!IsPostBack)
                {
                    this.divtable.Visible = false;
                } 
         }
        public void MyDataBind(bool bpostback, string sSQL, string sCondition)
        {
            int TotalPage;          //总页数
            DataTable objDt = null;
            Session["ADDSQL"] = sSQL;
            TotalPage = 0;
            if (sCondition != "")
            {
                sSQL = sSQL.Replace("1=2", "1=1");
                sSQL = GetAddConditionSQL(sSQL, sCondition);
                Session["SQLsource"] = sSQL;
                TotalPage = objConn.GetRowCount(sSQL);
                if (TotalPage > PageSize)
                {
                    int TotalPage1 = TotalPage / PageSize;
                    if (TotalPage % PageSize != 0)
                    {
                        TotalPage1++;
                    }
                    this.lblPageCount.Text = TotalPage1.ToString();
                    this.lblCurPage.Text = "1";
                    this.btnPrev.Enabled = false;
                }
                else
                {
                    this.lblCurPage.Text = "1";
                    this.lblPageCount.Text = "1";
                    this.btnNext.Enabled = false;
                    this.btnPrev.Enabled = false;
                }
            }
            else
            {
                sSQL = GetAddConditionSQL(sSQL, "1=2");
                string SQLTJ = "";
                int order = sSQL.ToUpper().IndexOf("ORDER BY");
                if (order > 0)
                {
                    int begin;
                    string right = sSQL.Substring(order, sSQL.Length - order);
                    begin = right.IndexOf(",");
                    string a = "ORDER BY";
                    if (begin > 0)
                    {
                        string left = right.TrimStart().Substring(a.Length, begin - a.Length - 1);
                        SQLTJ = "select *," + left + " as 编号 from (" + sSQL.Substring(0, order) + ")#t " + right;
                    }
                    else
                    {
                        SQLTJ = "select *," + right.Substring(a.Length, right.Length - a.Length) + " as 编号 from (" + sSQL.Substring(0, order) + ")#t " + right;
                    }
                }
                else
                {
                    DataTable order_dt = objConn.GetDataTable(sSQL);
                    if (order_dt != null)
                    {
                        string name = order_dt.Columns[0].ColumnName.ToString();
                        SQLTJ = "select *," + name + " as 编号 from(" + sSQL + ")#t";                    
                    }
                }
                Session["dgLieBiaoShuSQL"] = SQLTJ;
                if (bpostback)
                {
                    this.lblPageCount.Text = "0";
                    this.lblCurPage.Text = "0";
                    this.btnPrev.Enabled = false;
                    this.btnNext.Enabled = false;
                }
            }
            if (bpostback)
            {
                if (sSQL.ToUpper().Contains("ORDER BY"))
                {
                    int a = sSQL.ToUpper().IndexOf("ORDER BY");
                    sSQL = "select * from(select *,row_number() over(" + sSQL.Substring(a, sSQL.Length - a) + ") as 编号 from (" + sSQL.Substring(0, a) + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
                }
                else
                {
                    DataTable order_dt = objConn.GetDataTable("select top 1 * from (" + sSQL + ")#t");
                    if (order_dt != null)
                    {
                        string name = order_dt.Columns[0].ColumnName.ToString();
                        sSQL = "select * from(select *,row_number() over( order by " + name + ") as 编号 from (" + sSQL + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
                    }
                }
            }
            try
            {
                objDt = objConn.GetDataTable(sSQL);
                Session["sSearchSql"] = sSQL;
            }
            catch
            {

            }
            //try
            //{
            //    if (objDt != null)
            //    {
            //        objDt = GetAdjustDt(objDt);
            //        objDv = objDt.DefaultView;
            //    }
            //}
            //catch (Exception err)
            //{
            //    Response.Write("<script>alert('加载数据源失败！')</" + "script>");
            //}
            //GridView1.DataSource = objDv;
            //GridView1.Columns[1].Visible = false;
            //GridView1.Columns[10].Visible = false;
            //GridView1.Columns[11].Visible = false;
            //this.GridView1.DataBind();
        }
        public DataTable GetAdjustDt(DataTable objDataTable)
        {
            if (objDataTable != null)
            {
                for (int i = 0; i < objDataTable.Rows.Count; i++)
                {
                    for (int j = 0; j < objDataTable.Columns.Count; j++)
                    {
                        try
                        {
                            if (objDataTable.Rows[i][j] != null && objDataTable.Rows[i][j].ToString().Length > 43)
                                objDataTable.Rows[i][j] = objDataTable.Rows[i][j].ToString().Substring(0, 40) + "...";
                            
                            if (objDataTable.Columns[j].DataType.Name.ToUpper().Trim() == "DATETIME")
                            {
                                //只取日期
                                DateTime objDtmTemp;
                                string sDtmTemp;
                                if (objDataTable.Rows[i][j].ToString().Trim() != "")
                                {
                                    objDtmTemp = (DateTime)objDataTable.Rows[i][j];
                                    sDtmTemp = objDtmTemp.ToShortDateString().ToString().Trim();
                                    if (objDtmTemp.ToString().Trim() == sDtmTemp)
                                    {
                                        objDataTable.Rows[i][j] = sDtmTemp;
                                    }
                                    else
                                    {
                                        objDataTable.Rows[i][j] = objDtmTemp;
                                    }
                                }
                            }
                        }
                        catch (Exception err)
                        {
                            continue;
                        }
                    }
                }
            }
            return objDataTable;
        }
        /// <summary>
        /// 得到带条件的sql语句
        /// </summary>
        /// <param name="strSQL"></param>
        /// <param name="strTimeSpan"></param>
        /// <returns></returns>
        public string GetAddConditionSQL(string strSQL, string sExpression)
        {
            strSQL = strSQL.Replace(" ", " ");
            if (sExpression.IndexOf("＋") >= 0)
            {
                sExpression = sExpression.Replace("＋", "+");
            }
            if (strSQL.ToUpper().IndexOf("JOIN") > 0)
            {
                int order = strSQL.ToUpper().IndexOf("ORDER BY");
                if (order > 0)
                {
                    if ((strSQL.Substring(strSQL.LastIndexOf(")"), strSQL.Length - strSQL.LastIndexOf(")"))).ToUpper().IndexOf("ORDER BY") >= 0)
                    {
                        string orderby = strSQL.Substring(order);

                        strSQL = "select * from ( " + strSQL.Substring(0, strSQL.Length - orderby.Length) + " )#temp where " + sExpression + orderby;
                    }
                }
                else
                {
                    strSQL = "select * from (" + strSQL + ")#temp where " + sExpression;
                }
            }
            else
            {
                int intIndexOrderBy = strSQL.ToUpper().IndexOf("ORDER BY");
                if (strSQL.LastIndexOf(")") >= 0)
                {
                    if ((strSQL.Substring(strSQL.LastIndexOf(")"), strSQL.Length - strSQL.LastIndexOf(")"))).ToUpper().IndexOf("ORDER BY") >= 0)
                    {
                        string orderby = strSQL.Substring(intIndexOrderBy);
                        strSQL = "select * from ( " + strSQL.Substring(0, strSQL.Length - orderby.Length) + " )#temp20100704edit " + orderby;
                        if (strSQL.ToUpper().Contains("WHERE"))
                        {
                            strSQL = strSQL.Insert(strSQL.ToUpper().IndexOf("WHERE") + 5, " " + sExpression + " and ");
                        }
                        else
                        {
                            strSQL = strSQL.Insert(strSQL.ToUpper().IndexOf(")#"), " where " + sExpression + " ");
                        }
                    }
                    else
                    {
                        strSQL = "select * from ( " + strSQL + " )#temp20100704edit ";
                        if (strSQL.ToUpper().Contains("WHERE"))
                        {
                            strSQL = strSQL.Insert(strSQL.ToUpper().IndexOf("WHERE") + 5, " " + sExpression + " and ");
                        }
                        else
                        {
                            strSQL = strSQL.Insert(strSQL.ToUpper().IndexOf(")#"), " where " + sExpression);
                        }
                    }
                }
                else
                {
                    if (intIndexOrderBy >= 0)
                    {
                        int intIndexWhere = strSQL.ToUpper().LastIndexOf("WHERE");
                        if (intIndexWhere >= 0)//有where子句
                        {
                            strSQL = strSQL.Insert(intIndexWhere + 5, " " + sExpression + " and ");
                        }
                        else
                        {
                            strSQL = strSQL.Insert(intIndexOrderBy, " where " + sExpression + " ");
                        }

                    }
                    else
                    {
                        //strSQL = strSQL.Insert(strSQL.Length, " where " + sExpression);
                        int intIndexWhere = strSQL.ToUpper().LastIndexOf("WHERE");
                        if (intIndexWhere >= 0)//有where子句
                        {
                            strSQL = strSQL.Insert(intIndexWhere + 5, " " + sExpression + " and ");
                        }
                        else
                        {
                            strSQL = strSQL.Insert(strSQL.Length, " where " + sExpression);
                        }

                    }
                }
            }
            return strSQL;
        }
        int intPageIndex;//当前页
        public void PagerButtonClick(Object sender, CommandEventArgs e)
        {
            this.divtable.Visible=true;
            btnNext.Enabled = true;
            btnPrev.Enabled = true;
            string strArg = e.CommandArgument.ToString();
            int intPageCount = 0;//总页数
            intPageCount = Int32.Parse(lblPageCount.Text.ToString()); 
            intPageIndex = Int32.Parse(lblCurPage.Text.ToString()) - 1;
            switch (strArg)
            {
                case "Next":
                    if (intPageIndex < intPageCount - 1)
                        intPageIndex++;
                    break;
                case "Prev":
                    if (intPageIndex > 0)
                        intPageIndex--;
                    break;
            }

            //如果是首页，则上一页和首页按钮不能用
            if (intPageIndex <= 0)
            {
                btnPrev.Enabled = false;
            }

            //如是末页，则末页和下一页不能用
            if (intPageIndex == intPageCount - 1)
            {
                btnNext.Enabled = false;
            }
            //判断当前页码是否有效，若无效则返回
            if (intPageIndex < 0 || intPageIndex > intPageCount)
            {
                return;
            }
            lblCurPage.Text = Convert.ToString(intPageIndex + 1);
            if (Session["SQLsource"] != null)
            {
                int begin = intPageIndex * PageSize + 1;
                int end = begin + PageSize - 1;
                string sSQL = "";
                string sql = Session["SQLsource"].ToString();
                int order = sql.ToUpper().IndexOf("ORDER BY");
                if (order > 0)
                {

                    string left = sql.Substring(0, order);
                    string right = sql.Substring(order, sql.Length - order);
                    sSQL = "select * from (select *,row_number() over (" + right + ")as 编号 from (" + left + ")tb) T where T.编号 between " + begin.ToString() + " and " + end.ToString();
                }
                else
                {
                    DataTable order_dt = objConn.GetDataTable("select top 1 * from (" + sql + ")#t");
                    if (order_dt != null)
                    {
                        string name = order_dt.Columns[0].ColumnName.ToString();
                        sSQL = "select * from (select *,row_number() over ( order by " + name + ") as 编号 from(" + sql + ")tb)T where T.编号 between " + begin.ToString() + " and " + end.ToString();
                    }
                }
                
                MyDataBind2(sSQL, "");
            }
        }

        protected void MyDataBind2(string sSQL, string sCondition)
        {
            if (sCondition != "")
            {
                sSQL = GetAddConditionSQL(sSQL, sCondition);
            }
            try
            {
                objDt = objConn.GetDataTable(sSQL);
                dt_gsxx = objDt;
            }
            catch
            {

            }
            //if (objDt != null)
            //{
            //    objDt = GetAdjustDt(objDt);
            //    objDv = objDt.DefaultView;
            //}
            //GridView1.DataSource = objDv;
            //GridView1.Columns[1].Visible = false;
            //GridView1.Columns[10].Visible = false;
            //GridView1.Columns[11].Visible = false;
            //this.GridView1.DataBind(); 
        }
        protected void Clear(object sender, EventArgs e)
        {
            this.xxpp.Visible = true;
            this.gys.Value = "";
            this.lx.Value = "";
            this.qymc.Value = "";
            this.lxr.Value = "";
            this.lxrsj.Value = "";
            this.lxdz.Value = "";
            this.jyfw.Value = "";
            this.zcrq.Value = "";
        }
     //蒋，2014年9月1日，添加事件
        protected void CheckGys(object sender, EventArgs e)
        {
            this.xxpp.Visible = true;
            if (this.txt_gys.Value == "")
            {
                this.lblhint.Text = "请输入公司名称！";
            }
            else
            {
                this.divtable.Visible = true;
                this.gxsform.Visible = false;
                this.ImageButton1.Visible = false;
                this.ImageButton2.Visible = false;
                this.xxpp.Visible = true;
                string sql = " select COUNT(*) from 材料供应商信息表 where 供应商 like '%" + this.txt_gys.Value + "%'";
                int count = Convert.ToInt32(objConn.DBLook(sql));
                if (count != 0)
                {
                    Response.Write("<script>alert('该分销商已存在,请查看')</" + "script>");
                    string gsxx = "select gys_id,供应商,主页,地址,电话,传真,联系人,联系人手机,单位类型,注册日期 "+
                        "from 材料供应商信息表 where left(单位类型,3) like '%商%' and 供应商 like '%" + this.txt_gys.Value + "%' order by gys_id";
                    if (gsxx.ToUpper().Contains("ORDER BY"))
                    {
                        int a = gsxx.ToUpper().IndexOf("ORDER BY");
                        gsxx = "select * from(select *,row_number() over(" + gsxx.Substring(a, gsxx.Length - a) + ") as 编号 from (" + gsxx.Substring(0, a) + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
                    }
                    else
                    {
                        DataTable order_dt = objConn.GetDataTable("select top 1 * from (" + gsxx + ")#t");
                        if (order_dt != null)
                        {
                            string name = order_dt.Columns[0].ColumnName.ToString();
                            gsxx = "select * from(select *,row_number() over( order by " + name + ") as 编号 from (" + gsxx + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
                        }
                    }
                    dt_gsxx = objConn.GetDataTable(gsxx);
                    Session["SQLsource"] = gsxx;
                    string sSQL = "select gys_id,供应商,主页,地址,电话,传真,联系人,联系人手机,单位类型,注册日期 " +
                                    "from 材料供应商信息表 where left(单位类型,3) like '%商%' order by gys_id";
                    string sSearchCondition = "供应商 like '%" + this.txt_gys.Value + "%'";
                    MyDataBind(true, sSQL, sSearchCondition);
                    
                }
                else
                {
                    Response.Write("<script>alert('对不起，没有您要搜索的公司信息!');window.location.href='glfxsxx.aspx?gys_id=" + gys_id + "';</" + "script>");
                    this.txt_gys.Value = "";
                }
            }
        }
        protected void updateUserInfo(object sender, EventArgs e)
        {
            this.xxpp.Visible = true;
            //蒋，2014年8月21日 ,注释
            //string pp_id =Request["pp_id"];	//品牌id	
            //qymc = this.s0.Value + this.s1.Value + this.s2.Value + this.s3.Value;
           // if (this.gys.Value == "")
           // {
           //     Response.Write("<script>alert('供应商不能为空！')</" + "script>");
           //     this.gys.Focus();
           //     return;
           // }
           //else if (this.zzjgbh.Value == "")
           // {
           //     Response.Write("<script>window.alert('组织机构编号不能为空！')</" + "script>");
           //     this.zzjgbh.Focus();
           //     return;
           // }
           // else if (this.lx.Value == "")
           // {
           //     Response.Write("<script>window.alert('单位类型不能为空！')</" + "script>");
           //     this.lx.Focus();
           //     return;
           // }           
           // else if (this.qymc.v != "")
           // {
           //     Response.Write("<script>window.alert('地区名称不能为空！')</" + "script>");
           //     this.s1.Focus();
           //     return;
           // }
           // else if (this.lxr.Value == "")
           // {
           //     Response.Write("<script>window.alert('联系人不能为空！')</" + "script>");
           //     this.lxr.Focus();
           //     return;
           // }
           // else if (this.lxrsj.Value == "")
           // {
           //     Response.Write("<script>window.alert('联系人手机不能为空！')</" + "script>");
           //     this.lxrsj.Focus();
           //     return;
           // }
           // else if (this.lxdz.Value == "")
           // {
           //     Response.Write("<script>window.alert('联系地址不能为空！')</" + "script>");
           //     this.lxdz.Focus();
           //     return;
           // }
           // else if (this.jyfw.Value == "")
           // {
           //     Response.Write("<script>window.alert('经营范围不能为空！')</" + "script>");
           //     this.jyfw.Focus();
           //     return;
           // }
            //else
            //{
            if (xzlx == "分销商")
            {
                if (this.gys.Value == "")
                {
                    Response.Write("您还没有选定分销公司!");
                }
                else
                {
                    string dt_fxs_id = "select gys_id from 材料供应商信息表 where 供应商='" + this.gys.Value + "'";
                    DataTable dt_fxs = objConn.GetDataTable(dt_fxs_id);
                    string fxs_id = dt_fxs.Rows[0]["gys_id"].ToString();
                    sSQL = "insert into  分销商和品牌对应关系表 (pp_id,品牌名称,是否启用,fxs_id,分销商,updatetime)" +
                   " values('" + this.txt_ppid.Value + "','" + this.txt_ppname.Value + "',1,'" + fxs_id + "','" + this.gys.Value + "',(select getdate()) ) ";
                    objConn.ExecuteSQL(sSQL, true);
                    //string id = "";
                    //id = save();
                    //bool b = xzpp(id);
                    //if (b)
                    //{
                    //蒋，2014年8月21日，当前品牌信息录入材料供应商信息从表 
                    string addppxx = "insert into 材料供应商信息从表(pp_id,品牌名称,是否启用,gys_id,等级,范围,供应商,updatetime)" +
                        "values('" + this.txt_ppid.Value + "','" + this.txt_ppname.Value + "',1,'" + fxs_id + "','" + dt_ppxx.Rows[0]["等级"] + "','" + dt_ppxx.Rows[0]["范围"] + "'," +
                        "'" + this.gys.Value + "',(select getdate()))";
                    objConn.ExecuteSQL(addppxx, true);
                    string update = "update 材料供应商信息从表 set uid=(select myID from 材料供应商信息从表 where 供应商 ='" + this.gys.Value + "' and 品牌名称='" + this.txt_ppname.Value + "') where 供应商='" + this.gys.Value + "' and 品牌名称='" + this.txt_ppname.Value + "'";
                    if (objConn.ExecuteSQL(update, true))
                    {
                        Response.Write("<script>alert('添加成功！');window.location.href='glfxsxx.aspx?gys_id=" + gxs_id + "'</" + "script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('添加失败！');window.location.href='glfxsxx.aspx?gys_id=" + gxs_id + "'</" + "script>");
                    }
                }
            }
            else
            {
                Response.Write("<script>window.alert('添加失败！');window.location.href='gyszym.aspx'</" + "script>");
            }
        }
        //public bool xzpp(string gys_id)
        //{
        //    bool b = false;
            //蒋，2014年8月19日，
            //if (xzlx == "生产商")
            //{
            //    // string gys_id = Request.Form["gys_id_hid"];
            //    string brandname = Request.Form["brandname"];            //品牌名称
            //    string yjflname = Request.Form["yjflname"];              //大级分类名称               
            //    string ejflname = Request.Form["ejflname"];              //二级分类名称
            //    string grade = Request.Form["grade"];               //等级
            //    string scope = Request.Form["scope"];                    //范围       
            //    string flname = Request.Form["ejflname"];
            //    sSQL = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围) values('" + brandname + "',1,'" + gys_id + "','" + flname + "','" + grade + "','" + scope + "') ";

            //    b = objConn.ExecuteSQL(sSQL, false);
            //    if (b)
            //    {
            //        string str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='" + brandname + "'),"
            //        + " fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
            //        + " 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + gys_id + "'),"
            //        + " 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '" + flname + "'),updatetime=(select getdate())"
            //        + " where 品牌名称='" + brandname + "'";
            //        int ret1 = objConn.ExecuteSQLForCount(str_update, false);
            //        sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id,updatetime) values('" + " (select myID from 品牌字典 where 品牌名称='" + brandname + "')" + "','" + brandname + "', 1,'" + gys_id + "','" + s_yh_id + "',(select getdate()) ) ";
            //        int ret = objConn.ExecuteSQLForCount(sSQL, true);
            //        if (ret < 1 || ret1 < 1)
            //        {
            //            b = false;
            //        }
            //    }

            //}
            //else if (xzlx == "分销商")
            //if(xzlx=="分销商")//当前用户是生产商
            //{
        //string fxs_id = Request["gys_id_hid"]; 	//分销商id	
            //    //蒋，2014年8月25日，注释获取品牌名和pp_id
            //    //string pp_id = Request["pp_id"];	    //品牌id
            //    //string pp_name = Request["pp_name"];   //品牌名称
            //    //蒋，2014年8月21日，
            //    //sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,updatetime) values('" + pp_id + "','" + pp_name + "', 1,'" + gys_id + "',(select getdate()) ) ";   
            //    sSQL = "insert into  分销商和品牌对应关系表 (pp_id,品牌名称,是否启用,fxs_id,分销商,updatetime)"+
            //        " values('" + this.txt_ppid.Value + "','"+this.txt_ppname.Value+"',1,'" + gys_id + "','" + this.gys.Value + "',(select getdate()) ) ";
            //    b = objConn.ExecuteSQL(sSQL, true);
            //}
        //    return b;
        //}
     
        //public string save()
        //{           
        //    bool b = false;          
        //    string sfqy = "";  //是否启用
        //    if (this.sfqy.Checked)
        //    {
        //        sfqy = "1";
        //    }
        //    else
        //    {
        //        sfqy = "0";
        //    }
        //    string qyygrs ="";
        //    qyygrs = this.qyygrs.Value;
        //    if (qyygrs == "")
        //    {
        //        qyygrs = "null";
        //    }
        //    string zczj = "";//注册资金
        //    zczj = this.zczj.Value;
        //    if (zczj == "")
        //    {
        //        zczj = "null";
        //    }
        //    qymc = this.s0.Value + this.s1.Value + this.s2.Value + this.s3.Value;
            //蒋，2014年8月20日 注释该条sql语句和if-else语句，添加了一条新语句        
            //sSQL = "insert into 材料供应商信息表(供应商,组织机构编号,地区名称,联系人手机,联系地址,联系人,单位类型,经营范围,"+
            //    "单位简称,法定代表人,注册资金,注册日期,企业类别,联系人QQ,传真,主页,地址,开户银行,银行账户,备注,营业执照注册号," +
            //    "企业员工人数,资产总额,注册级别,资质等级,是否启用,邮编,电子邮箱,电话,账户名称,审批结果)values"+
            //    "('" + this.gys.Value + "','" + this.zzjgbh.Value + "','" + qymc + "','" + this.lxrsj.Value + "',"+
            //    "'" + this.lxdz.Value + "','" + this.lxr.Value + "','" + this.lx.Value + "','" + this.jyfw.Value + "',"+
            //    "'" + this.dwjc.Value + "','" + this.fddbr.Value + "','" + zczj + "','" + this.zcrq.Value + "',"+
            //    "'" + this.qylb.Value + "','" + this.lxrqq.Value + "','" + this.cz.Value + "','" + this.zy.Value + "',"+
            //    "'" + this.dz.Value + "','" + this.khyh.Value + "','" + this.yhzh.Value + "','" + this.bz.Value + "',"+
            //    "'" + this.yyzzzch.Value + "','" + qyygrs + "','" + this.zcze.Value + "','" + this.zcjb.Value + "',"+
            //    "'" + this.zzdj.Value + "','" + sfqy + "',' "+this.yb.Value+"','" + this.dzyx.Value + "',"+
            //    "'" + this.dh.Value + "','" + this.zhmc.Value + "','通过')";
            //if (objConn.ExecuteSQL(sSQL, false))
            //{
                //蒋，2014年8月21日更改sql语句
                //sSQL = "update 材料供应商信息表 set gys_id=myID,updatetime=(select getdate()) where 供应商='" + this.gys.Value + "' and 营业执照注册号='" + this.yyzzzch.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
                //sSQL = "update 材料供应商信息表 set gys_id=myID,updatetime=(select getdate()) where 供应商='" + this.gys.Value + "' and 联系人手机='" + this.lxrsj.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
                //b = objConn.ExecuteSQL(sSQL, true);
                //if (!b)
                //{ objConn.MsgBox(this.Page, sSQL); }
            //}
            //else
            //{
            //    objConn.MsgBox(this.Page, sSQL);
            //}
            //sSQL = "select gys_id from 材料供应商信息表 where 供应商='" + this.gys.Value + "' and 联系人手机='" + this.lxrsj.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
            //gys_id = objConn.DBLook(sSQL);
            //this.gys_id_hid.Value = gys_id;
            //return gys_id;
        //}
        protected void CY_Click(object sender, EventArgs e)
        {
            this.xxpp.Visible = true;
            this.gxsform.Visible = true;
            this.divtable.Visible = false;
            this.ImageButton1.Visible = true;
            this.ImageButton2.Visible = true;
            string gsxx = "select 供应商,地区名称,联系人手机,联系地址,联系人,单位类型,经营范围," +
                 "单位简称,法定代表人,注册资金,注册日期,企业类别,联系人QQ,传真,主页,地址,开户银行,银行账户,备注," +
                 "营业执照注册号,企业员工人数,资产总额,注册级别,资质等级,是否启用,邮编,电子邮箱,电话,账户名称" +
                 " from 材料供应商信息表 where 供应商 ='" + this.gsmc.Value + "'";
            DataTable dt_gs = objConn.GetDataTable(gsxx);
            this.gys.Value = dt_gs.Rows[0]["供应商"].ToString();
            this.qymc.Value = dt_gs.Rows[0]["地区名称"].ToString();
            this.lxrsj.Value = dt_gs.Rows[0]["联系人手机"].ToString();
            this.lxdz.Value = dt_gs.Rows[0]["联系地址"].ToString();
            this.lxr.Value = dt_gs.Rows[0]["联系人"].ToString();
            this.lx.Value = dt_gs.Rows[0]["单位类型"].ToString();
            this.jyfw.Value = dt_gs.Rows[0]["经营范围"].ToString();
            this.dwjc.Value = dt_gs.Rows[0]["单位简称"].ToString();
            this.fddbr.Value = dt_gs.Rows[0]["法定代表人"].ToString();
            this.zczj.Value = dt_gs.Rows[0]["注册资金"].ToString();
            this.zcrq.Value = dt_gs.Rows[0]["注册日期"].ToString();
            this.qylb.Value = dt_gs.Rows[0]["企业类别"].ToString();
            this.lxrqq.Value = dt_gs.Rows[0]["联系人QQ"].ToString();
            this.cz.Value = dt_gs.Rows[0]["传真"].ToString();
            this.zy.Value = dt_gs.Rows[0]["主页"].ToString();
            this.dz.Value = dt_gs.Rows[0]["地址"].ToString();
            this.khyh.Value = dt_gs.Rows[0]["开户银行"].ToString();
            this.yhzh.Value = dt_gs.Rows[0]["银行账户"].ToString();
            this.bz.Value = dt_gs.Rows[0]["备注"].ToString();
            this.yyzzzch.Value = dt_gs.Rows[0]["营业执照注册号"].ToString();
            this.qyygrs.Value = dt_gs.Rows[0]["企业员工人数"].ToString();
            this.zcze.Value = dt_gs.Rows[0]["资产总额"].ToString();
            this.zcjb.Value = dt_gs.Rows[0]["注册级别"].ToString();
            this.zzdj.Value = dt_gs.Rows[0]["资质等级"].ToString();
            this.yb.Value = dt_gs.Rows[0]["邮编"].ToString();
            this.dzyx.Value = dt_gs.Rows[0]["电子邮箱"].ToString();
            this.dh.Value = dt_gs.Rows[0]["电话"].ToString();
            this.zhmc.Value = dt_gs.Rows[0]["账户名称"].ToString();
        }
</script>
   
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
     function updateFL(id)
     {
         var xmlhttp;
         if (window.XMLHttpRequest)
         {// code for IE7+, Firefox, Chrome, Opera, Safari
             xmlhttp = new XMLHttpRequest();
         }
         else
         {// code for IE6, IE5
             xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
         }
         xmlhttp.onreadystatechange = function ()
         {
             if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
             {
                 //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                 document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
             }
         }
         xmlhttp.open("GET", "xzpp2.aspx?id=" + id, true);
         xmlhttp.send();
     }

     function updateFLfxs(ID,pp_name) {
        <%-- //蒋，2014年8月25日，添加--%>
         document.getElementById("txt_ppid").value = ID;
         document.getElementById("txt_ppname").value=pp_name;
          var xmlhttp;
          if (window.XMLHttpRequest)
          {// code for IE7+, Firefox, Chrome, Opera, Safari
              xmlhttp = new XMLHttpRequest();
          }
          else
          {// code for IE6, IE5
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.onreadystatechange = function () {
              if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                  var array = new Array();           //声明数组
                  array = xmlhttp.responseText;     //接收替换返回的json字符串
                  var json = array;
                  var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 	
                  for (var i = 0; i < myobj.length; i++) {  //遍历,将ajax返回的数据填充到文本框中				
                      document.getElementById('scs').innerHTML = myobj[i].scs;
                      document.getElementById('grade').innerHTML = myobj[i].dj
                      document.getElementById('scope').innerHTML = myobj[i].fw;
                      document.getElementById('fl_name').innerHTML = myobj[i].flname;
                      document.getElementById('pp_id').innerHTML = myobj[i].pp_id;
                      document.getElementById('pp_name').innerHTML = myobj[i].ppname;
                  }
              }
          }
          xmlhttp.open("GET", "xzgxs2.aspx?id=" + ID, true);
          xmlhttp.send();  
        } 
     function Add(obj)
      {
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        var gsmc = Trim(tds[0].innerHTML);
        document.getElementById("gsmc").value=gsmc;
      }

      function onloadEvent(func)
      {
	    var one=window.onload
	    if(typeof window.onload!='function')
        {
		    window.onload=func
	    }
	    else
        {
		    window.onload=function()
            {
			    one();
			    func();
		    }
	    }
    }
function showtable(){
	var tableid='table';		//表格的id
	var overcolor='#fff0e9';	//鼠标经过颜色
	var color1='#f2f6ff';		//第一种颜色
	var color2='#fff';		//第二种颜色
	var tablename=document.getElementById(tableid)
	var tr=tablename.getElementsByTagName("tr")
	for(var i=1 ;i<tr.length;i++){
		tr[i].onmouseover=function(){
			this.style.backgroundColor=overcolor;
		}
		tr[i].onmouseout=function(){
			if(this.rowIndex%2==0){
				this.style.backgroundColor=color1;
			}else{
				this.style.backgroundColor=color2;
			}
		}
		if(i%2==0){
			tr[i].className="color1";
		}else{
			tr[i].className="color2";
		}
	}
}
onloadEvent(showtable); 
 </script>
<body background="images/ZYM_lb_an1.gif" >
    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <div class="fxsxx" style="width:1211px">
    
<form id="Form1" runat="server">
<div runat="server" id="xxpp">
    <%if (xzlx == "分销商")
  {%>
<table width="999" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #ddd; background-color:#f7f7f7; margin-top:10px;">
 
                <tr>
                    <td width="120" height="50" style="font-size:12px" align="right"><strong>品牌名称：</strong></td>
                    <td width="200" style="padding-left:10px;">
                        <select id="ppmc" name="" style="width: 200px" onchange="updateFLfxs(this.options[this.options.selectedIndex].value,this.options[this.options.selectedIndex].text)">
                        <option  value="0">请选择品牌</option> 
                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {%>
                               <option value='<%=dt_ppxx.Rows[i]["pp_id"].ToString() %>'><%=dt_ppxx.Rows[i]["品牌名称"]%></option>
                           <%}%>
                        </select>
                        <%--蒋，2014年8月25日，添加--%>
                        <input type="hidden" id="txt_ppid" value="" runat="server" />
                        <input type="hidden" id="txt_ppname" value="" runat="server" /> 
                    </td>
                    <td width="60" align="right" style="font-size:12px"><strong>生产商：</strong></td>
                    <td width="200" style="padding-left:10px;font-size:12px"><div id="scs"><%=dt_ppxx.Rows[0]["生产商"] %></div></td>
                    <td width="50" align="right" style="font-size:12px"><strong>等级：</strong></td>
                    <td>
                        <div id="grade" style="font-size:12px"><%=dt_ppxx.Rows[0]["等级"] %> </div>
                    </td>
                    <td width="50" style="font-size:12px"><strong>范围：</strong></td>
                    <td>
                        <div id="scope" style="font-size:12px"><%=dt_ppxx.Rows[0]["范围"] %>  </div>
                    </td>
                    <td width="50" style="font-size:12px"><strong>分类：</strong></td>
                    <td>
                        <div id="fl_name" style="font-size:12px"><%=dt_ppxx.Rows[0]["分类名称"] %> </div>
                    </td>
                </tr>
            </table>

            <input type="hidden" id="pp_id" name="pp_id" value="<%=dt_ppxx.Rows[0]["pp_id"] %> " />
            <input type="hidden" id="pp_name" name="pp_name" value="<%=dt_ppxx.Rows[0]["品牌名称"] %> " />
<%}%>
</div>
<%--蒋，2014年8月20日，注释新增类型为生产商的操作--%>
<%--<%
  else if (xzlx == "生产商")
  { %>
       <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">*一级分类名称：
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                           <option value="0">请选择一级分类</option>
                            <% foreach(System.Data.DataRow row in dt_yjfl.Rows){%>

                            <option value="<%=row["分类编码"] %>"><%=row["显示名字"]%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="color: Blue" class="style1">*二级分类名称：
                    </td>
                    <td align="left">
                        <select id="ejflname" name="ejflname" style="width: 250px">
                            <option value="">请选择二级分类</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">*品牌名称：
                    </td>
                    <td align="left">
                        <input type="text" id="" name="brandname" value="" />
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">*等级：
                    </td>
                    <td align="left">
                        <select name="grade" id="grade" >
                            <option value="一等">一等</option>
                            <option value="二等">二等</option>
                            <option value="三等">三等</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td valign="top" style="color: Blue">*范围：
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" >
                            <option value="全国">全国</option>
                            <option value="地区">地区</option>                        
                        </select>
                    </td>
                </tr>      
            </table>
<%} %>
--%>


<div id="jiansuo" style="margin-bottom:20px; height:90px;">
<table align="center" style="margin-top:0px;" >
<tr>
<td style="WIDTH: 50px;font-size:12px; text-align:center"  >供应商：</td>
<td colspan="4"><input class="hyzhc_shrk" type="text" id="txt_gys" runat="server" /></td>
<td align="right" style="WIDTH: 50px;font-size:12px">地区：</td>
<td colspan="4" class="style4" style="width:400px;">
    <select id="Select1" class="fu1" runat="server"><option></option></select> 
    <select id="Select2" class="fu1" runat="server"><option></option></select>
                <select id="Select3" class="fu2" runat="server"><option></option></select> 
                <select id="Select4" class="fu3" runat="server"><option></option></select>
                <script type="text/javascript"  language ="javascript" > 
                    var s = ["s0", "s1", "s2", "s3"];
                    var opt0 = ["-区域-", "-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                </script>
   </td><td><span class="cggg"><asp:ImageButton runat="server" ID="ImageButton3" style="color:#fff;" ImageUrl="images/sousuo.jpg" OnClick="CheckGys" Width="60px" Height="20px"/></span></td>
</tr>
<tr><td colspan="5"><asp:Label Text="" runat="server" ID="lblhint" ForeColor="Red"></asp:Label></td></tr></table>
</div>
<%--蒋，2014年9月3日，添加（未完成）--%>
<div runat="server" id="divtable" style="width:1000px; font-size:12px;" >
<table id="table"  style="font-size:12px; border:1px;" >
 <thead>
 <tr><td colspan="8" style="text-align:center; font-size:16px; background-color:#e3ebfe">新增分销商信息</td></tr>
                <tr>
                    <th align="center">公司名称</th>
                    <th align="center">地址</th>
                    <th align="center">主页</th>
                    <th align="center">电话</th>
                    <th align="center">联系人</th>
                    <th align="center" class="style12">联系人手机</th>
                    <th align="center" class="style1">单位类型</th>
                    <th align="center">操作</th>
                </tr>
            </thead>
            <tbody id="tbody">
            <%if (dt_gsxx != null && dt_gsxx.Rows.Count > 0)
              { %>
                <%for (int i = 0; i < dt_gsxx.Rows.Count; i++)
                  { %> 
                    <tr>
                    <td align="center"><%=dt_gsxx.Rows[i]["供应商"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["地址"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["主页"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["电话"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["联系人"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["联系人手机"]%></td>
                    <td align="center"><%=dt_gsxx.Rows[i]["单位类型"]%></td>
                    <td align="center">
                    <asp:Button ID="CY" runat="server" Text="查阅" OnClientClick="Add(this)"  onclick="CY_Click"/>
                     <input type="hidden" id="gsmc" runat="server" value="" /></td>
                    </tr>
                <%} %>
            <%}%> 
            </tbody>
</table>
 <div style="text-align:center">
          <asp:LinkButton ID="btnPrev" runat="server" CommandArgument="Prev" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">上页</asp:LinkButton>&nbsp;
             <asp:LinkButton ID="btnNext" runat="server" CommandArgument="Next" CommandName="Pager"
                        OnCommand="PagerButtonClick" ForeColor="Black">下页</asp:LinkButton>&nbsp;
            第<asp:Label ID="lblCurPage"  runat="server"  Text="0"  ForeColor="Blue">Label</asp:Label>/
              <asp:Label ID="lblPageCount"  runat="server"  Text="0"  ForeColor="Blue">Label</asp:Label>页
    </div>
</div>
<div runat="server" id="gxsform">

<%--蒋，2014年8月20日，注释新增类型为生产商的操作--%>
<%--<%if (xzlx == "生产商")
  { %>
      <td  colspan="4"  style="text-align:center; padding-bottom:20px; font-size:16px; font-weight:bold; color:Black">新增生产厂商</td>
  <%}
  else--%>
  <table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
  <%if(xzlx=="分销商")
  { %>
<tr><td  height="34" colspan="6" align="center" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">新增分销商信息</td>
<%} %>
</tr>
    <tr>
    <td height="20" colspan="6" align="right"></td>
  </tr>
<tr>
<td width="50" height="30">&nbsp;</td>
    <td width="120" style="font-size:12px">公司名称：</td>
    <td width="329"><label for="textfield"></label>
      <input name="txt_gsmc" type="text" runat="server" class="hyzhc_shrk" id="gys" disabled /></td>
    <td width="50" align="right"></td>
    <td width="120" style="font-size:12px">公司简称：</td>
    <td width="329"><input name="txt_gsjc" runat="server" type="text" class="hyzhc_shrk" id="dwjc" disabled /></td>
</tr>
<tr>
<td height="30">&nbsp;</td>
    <td style="font-size:12px">营业执照注册号：</td>
    <td><input name="txt_yyzzzch" type="text" runat="server" class="hyzhc_shrk" id="yyzzzch" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">公司QQ号：</td>
    <td><input name="txt_gsQQ" type="text" runat="server" class="hyzhc_shrk" id="lxrqq" disabled /></td>
</tr>
 <tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">公司注册日期：</td>
    <td><input name="txt_zcrq" type="text" runat="server" class="hyzhc_shrk" id="zcrq" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">法定代表人：</td>
    <td><input name="txt_fddbr" type="text" runat="server" class="hyzhc_shrk" id="fddbr" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">资产总额(万元)：</td>
    <td><input name="txt_zcze" type="text" runat="server" class="hyzhc_shrk" id="zcze" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">注册资金(万元)：</td>
    <td><input name="txt_zczj" type="text" runat="server" class="hyzhc_shrk" id="zczj" disabled /></td>
  </tr>
<tr><td colspan="4"></td></tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">资质等级：</td>
    <td><input name="txt_zczj" type="text" runat="server" class="hyzhc_shrk" id="zzdj" disabled/></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">注册级别：</td>
    <td><input name="txt_zczj" type="text" runat="server" class="hyzhc_shrk" id="zcjb" disabled/></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">开户银行：</td>
    <td><input name="txt_khyh" type="text" runat="server" class="hyzhc_shrk" id="khyh" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">企业类别：</td>
    <td><input name="txt_khyh" type="text" runat="server" class="hyzhc_shrk" id="qylb" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">账户名称：</td>
    <td><input name="txt_zhmc" type="text" runat="server" class="hyzhc_shrk" id="zhmc" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">单位类型：</td>
    <td><input name="txt_zhmc" type="text" runat="server" class="hyzhc_shrk" id="lx" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">公司所在地：</td>
    <td><input name="txt_zhmc" type="text" runat="server" class="hyzhc_shrk" id="qymc" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">银行账户：</td>
    <td><input name="txt_yhzh" type="text" runat="server" class="hyzhc_shrk" id="yhzh" disabled /></td>
  </tr>
 <tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">公司地址：</td>
    <td><input name="txt_gsdz" type="text" runat="server" class="hyzhc_shrk" id="dz" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">企业员工人数：</td>
    <td><input name="txt_qyygrs" type="text" runat="server" class="hyzhc_shrk" id="qyygrs" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">公司主页：</td>
    <td><input name="txt_gszy" type="text"  runat="server" class="hyzhc_shrk" id="zy"  disabled/></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">公司电话：</td>
    <td><input name="txt_gsdh" type="text"  runat="server" class="hyzhc_shrk" id="dh" disabled /></td>
  </tr>
 <tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">公司传真：</td>
    <td><input name="txt_gscz" type="text" runat="server" class="hyzhc_shrk" id="cz" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">公司邮编：</td> 
    <td><input name="txt_gsyb" type="text" runat="server" class="hyzhc_shrk" id="yb" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">联系人姓名：</td>
    <td><input name="txt_xm2" type="text" runat="server" class="hyzhc_shrk" id="lxr" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">联系人地址：</td>
    <td><input name="txt_szbm2" type="text" runat="server" class="hyzhc_shrk" id="lxdz" disabled /></td>
  </tr>
<tr>
    <td height="30">&nbsp;</td>
    <td style="font-size:12px">联系人手机：</td>
    <td><input name="txt_sj2" type="text" runat="server" class="hyzhc_shrk" id="lxrsj" disabled /></td>
    <td>&nbsp;</td>
    <td style="font-size:12px">联系人邮箱：</td>
    <td><input name="txt_yx2" type="text" runat="server" class="hyzhc_shrk" id="dzyx"  disabled/></td>
  </tr>
  <tr>
    <td height="40">&nbsp;</td>
    <td style="font-size:12px">经验范围：</td>
    <td colspan="4" height="90px"><label for="textfield21"></label>
      <textarea class="hyzhc_shrk2" disabled runat="server" cols="40" id="jyfw" name="yyfw" rows="6" style="100%"></textarea></td>
  </tr>
   <tr>
    <td height="66">&nbsp;</td>
    <td style="font-size:12px">备 注：</td>
    <td colspan="4" height="60px">
        <textarea class="hyzhc_shrk3" disabled  runat="server" cols="40" id="bz" name="bz" rows="6" style="100%"></textarea></td>
  </tr>
</table>
</div>

<input  type="hidden" id="gys_id_hid" runat="server"/>
<input  type="hidden" id="source" runat="server" value="xzym"/>

      <%--蒋，2014年9月1日，注释--%>
      <span class="cggg" style="margin-left:100px; margin-top:30px">
      <asp:ImageButton runat="server" ID="ImageButton1" style="color:#fff;" ImageUrl="images/queding.jpg" OnClick="updateUserInfo"  />
      </span>
     <span class="cggg" style="margin-left:150px; margin-top:30px">
     <asp:ImageButton runat="server" ID="ImageButton2" style="color:#fff;" ImageUrl="images/quxiao.jpg" OnClick="Clear"  /></span>
</form>
</div>
<div class="foot">
<span class="foot2"><a href="#">网站合作</a>  |<a href="#"> 内容监督</a> | <a href="#"> 商务咨询</a> |  <a href="#">投诉建议010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012众材网版权所有      京ICP证0000111号      京公安网备110101000005号</p>
<p>地址：北京市海淀区天雅大厦11层  联系电话：010-87654321    技术支持：京企在线</p></span>
</div>
</body>
</html>
