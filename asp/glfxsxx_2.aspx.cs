using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class asp_glfxsxx_2 : System.Web.UI.Page
{
    public static int pageTemp;
    public int pageAll;
    public string sSQL;
    public DataConn objConn = new DataConn();
    public int PageSize = 10;
    public string gys_id = "";//接收传过来的gys_id
    public string pp_mc = "";
    public string s_yh_id;
    public string pp_id = "";
    DataTable objDt = null;
    DataView objVe = null;
    public DataTable dt_gxs = new DataTable();//材料供应商信息表
    public DataTable dt_yh = new DataTable();
    public DataTable dt_js = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            gys_id = Request["gys_id"].ToString();

        }
        else
        {
            string sql = "select dw_id from 用户表 where yh_id='" + s_yh_id + "'";
            gys_id = objConn.DBLook(sql);
        }
        if (Request["pp_mc"] != null)
        {
            pp_mc = Request["pp_mc"].ToString();
        }
        this.ppmc.Value = pp_mc;

        if (Request["pp_id"] != null && Request["pp_id"].ToString() != "")
        {
            pp_id = Request["pp_id"].ToString();
        }
        this.ppid.Value = pp_id;

        this.lblgys_id.Value = gys_id;
        if (pp_mc != "" && gys_id != "")
        {
            //sSQL = " select c.gys_id,c.供应商,c.地区名称,c.注册日期,c.注册资金,c.电话,f.是否启用 from 材料供应商信息表 c left join 分销商和品牌对应关系表 f on f.fxs_id=c.gys_id where  品牌名称='" +pp_mc + "' and pp_id='" + pp_id + "' and 生产厂商ID='" + gys_id + "' order by f.updatetime desc ";
            //获取点击的页码
            string pageIndex = this.pageI.Value == "" ? "1" : this.pageI.Value;
            //获取每页多少条数据
            string pageSize = this.pageS.Value == "" ? "10" : this.pageS.Value;
            sSQL = " select top " + Convert.ToInt32(pageSize) + " gys_id,供应商,地区名称,注册日期,注册资金,电话,是否启用 from dbo.Viewglfxsxx where gys_id not in (select top " + (((Convert.ToInt32(pageIndex) - 1) * Convert.ToInt32(pageSize)) + 1) + " gys_id from dbo.Viewglfxsxx where  品牌名称='" + pp_mc + "' and pp_id='" + pp_id + "' and 生产厂商ID='" + gys_id + "'  order by updatetime desc) and 品牌名称='" + pp_mc + "' and pp_id='" + pp_id + "' and 生产厂商ID='" + gys_id + "'  order by updatetime desc ";
            dt_gxs = objConn.GetDataTable(sSQL);
            //数据总条数
            string totalsql = "select count(*) from Viewglfxsxx where  品牌名称='" + pp_mc + "' and pp_id='" + pp_id + "' and 生产厂商ID='" + gys_id + "'  ";
            int total = Convert.ToInt32(MySqlHelper.ExecuteScalar(totalsql));
            if (total % 10 > 0)
            {
                this.lblPageCount.InnerText = (total / 10 + 1).ToString();
                this.lblCurPage.InnerText = pageIndex.ToString();
                this.pageI.Value = pageIndex.ToString();
            }
            else
            {
                this.lblPageCount.InnerText = (total / 10).ToString();
                this.lblCurPage.InnerText = pageIndex.ToString();
                this.pageI.Value = pageIndex.ToString();
            }
            
        }
        else
        {
            //获取点击的页码
            int pageIndex = Request["pageIndex"] == null ? 1 : int.Parse(Request["pageIndex"]);
            //获取每页多少条数据
            int pageSize = Request["pageSize"] == null ? 10 : int.Parse(Request["pageSize"]);
            //数据总条数
            string totalsql = "select count(*) from Viewglfxsxx where  生产厂商ID='" + gys_id + "' ";
            int total = Convert.ToInt32(MySqlHelper.ExecuteScalar(totalsql));
            //分页
            string paging = PagingHelper.ShowPageNavigate(pageIndex, pageSize, Convert.ToInt32(total));
            //sSQL = " select top 10 c.gys_id,c.供应商,c.地区名称,c.注册日期,c.注册资金,c.电话,f.是否启用 from 材料供应商信息表 c left join 分销商和品牌对应关系表 f on f.fxs_id=c.gys_id where  生产厂商ID='" + gys_id + "' order by f.updatetime desc ";
            sSQL = " select top 10 gys_id,供应商,地区名称,注册日期,注册资金,电话,是否启用 from Viewglfxsxx where  生产厂商ID='" + gys_id + "' order by updatetime desc ";
            this.dic.InnerHtml = paging;
            dt_gxs = objConn.GetDataTable(sSQL);
            this.dic.Visible = false;
        }
        if (!IsPostBack)
        {
            createlm(dt_gxs);
        }
    }


    //*****************************小张新增检索功能开始********************************* 
    protected void filter_Click(object sender, System.EventArgs e)
    {
        string strCondition = "";
        string sColumName, sTempColumnName;
        string sOperator;
        string sKeyWord;
        string sFieldType;
        string sSQL;
        DataTable objDt = null;

        sColumName = lieming.SelectedItem.Value.ToString().Trim();
        sOperator = yunsuanfu.SelectedItem.Value.ToString().Trim();
        sKeyWord = txtKeyWord.Text.ToString().Trim();
        if (sColumName == "全部")
        {
            sColumName = "";
            sOperator = "";
            sKeyWord = "";
            txtKeyWord.Text = "";
        }
        if (sColumName == "状态")
        {
            sColumName = "是否启用";
            if (sKeyWord == "是" || sKeyWord == "启用" || sKeyWord == "1")
            {
                sKeyWord = "1";
            }
            else
            {
                sKeyWord = "0";
            }
        }
        string sql_js = "";
        if (pp_id != "" && gys_id != "" && pp_mc != "")
        {
            sql_js = " select c.gys_id,c.供应商,c.地区名称,c.注册日期,c.注册资金,c.电话,f.是否启用 from 材料供应商信息表 c left join 分销商和品牌对应关系表 f on f.fxs_id=c.gys_id where  品牌名称='" +
                pp_mc + "' and pp_id='" + pp_id + "' and 生产厂商ID='" + gys_id + "'";
        }
        else
        {
            sql_js = " select top 10 c.gys_id,c.供应商,c.地区名称,c.注册日期,c.注册资金,c.电话,f.是否启用 from 材料供应商信息表 c left join 分销商和品牌对应关系表 f on f.fxs_id=c.gys_id where  生产厂商ID='" + gys_id + "'";
        }
        if (sColumName == "" && sOperator == "" && sKeyWord == "")
        {
            strCondition = "";
        }
        else
        {
            //得到要筛选字段的类型

            sSQL = "select * from (" + sql_js + ")#temp where 1=0";
            objDt = objConn.GetDataTable(sSQL);
            for (int i = 0; i < objDt.Columns.Count; i++)
            {
                sTempColumnName = objDt.Columns[i].ColumnName.ToString().Trim();
                if (sTempColumnName == sColumName)
                {
                    sFieldType = objDt.Columns[i].DataType.Name.ToString().Trim();
                    switch (sFieldType.ToUpper().Trim())
                    {
                        case "STRING":
                            sFieldType = "字符串型";

                            if (sOperator.Trim() == "like")
                                strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                            else
                                strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";
                            break;
                        case "DATETIME":
                            sFieldType = "日期型";

                            if (sOperator.Trim() == "like")
                                strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                            else
                                strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                            break;
                        case "INT32":
                            sFieldType = "整型";

                            if (sOperator.Trim() == "like")
                                strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                            else
                                strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                            break;
                        case "DECIMAL":
                            sFieldType = "货币型";

                            if (sOperator.Trim() == "like")
                            {
                                Response.Write("<script>alert(\"字段：" + sFieldType + " 不允许用 包含 筛选\")</" + "script>");
                                return;
                            }
                            else
                                strCondition = sColumName + " " + sOperator + sKeyWord;

                            break;
                        case "DOUBLE":
                            sFieldType = "浮点型";

                            if (sOperator.Trim() == "like")
                                strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                            else
                                strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                            break;
                        default:
                            sFieldType = "字符串型";

                            if (sOperator.Trim() == "like")
                                strCondition = sColumName + " " + sOperator + " '%" + sKeyWord + "%'";
                            else
                                strCondition = sColumName + " " + sOperator + " '" + sKeyWord + "'";

                            break;
                    }
                    break;
                }
            }
        }
        if (strCondition == "")
        {
            string sql = sql_js;
            dt_gxs = objConn.GetDataTable(sql);
        }
        else
        {
            string sql = sql_js;
            sql = "select * from (" + sql + ")#temp where " + strCondition;
            dt_gxs = objConn.GetDataTable(sql);
        }
    }
    private void createlm(DataTable objDt)
    {
        ListItem objItem = null;
        if (objDt != null)
        {
            objItem = null;
            objItem = new ListItem();
            objItem.Text = "全部";
            lieming.Items.Add(objItem);
            for (int i = 0; i < objDt.Columns.Count; i++)
            {
                switch (objDt.Columns[i].ColumnName)
                {
                    case "gys_id":
                        break;
                    case "是否启用":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "状态";
                        lieming.Items.Add(objItem);
                        break;
                    default:
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = objDt.Columns[i].ColumnName;
                        lieming.Items.Add(objItem);
                        break;
                }
            }
        }
    }
    //*****************************小张新增检索功能结束*********************************
    public int intPageIndex;//当前页
    public void PagerButtonClick(Object sender, CommandEventArgs e)
    {
        #region MyRegion
        //btnNext.Enabled = true;
        //btnPrev.Enabled = true;
        //btnhead.Enabled = true;
        //btnNext.Enabled = true;
        //string strArg = e.CommandArgument.ToString();
        //int intPageCount = 0;//总页数
        //intPageCount = Int32.Parse(lblPageCount.Text.ToString());
        //intPageIndex = Int32.Parse(lblCurPage.Text.ToString());
        //switch (strArg)
        //{
        //    case "Next":
        //        if (intPageIndex < intPageCount)
        //        {
        //            intPageIndex++;//1,2
        //            lblCurPage.Text = Convert.ToString(intPageIndex);
        //        }
        //        break;
        //    case "Prev":
        //        if (intPageIndex > 1)
        //        {
        //            intPageIndex--;
        //            lblCurPage.Text = Convert.ToString(intPageIndex);
        //        }
        //        else if (intPageIndex == 1)
        //        {
        //            btnPrev.Enabled = false;
        //            btnhead.Enabled = false;
        //            btnNext.Enabled = true;
        //            btnfoot.Enabled = true;
        //        }
        //        break;
        //    case "Head":
        //        if (intPageIndex <= intPageCount)
        //        {
        //            intPageIndex = 1;
        //            btnPrev.Enabled = false;
        //            btnhead.Enabled = false;
        //            lblCurPage.Text = Convert.ToString(intPageIndex);
        //        }
        //        break;
        //    case "Foot":
        //        if (intPageIndex <= intPageCount)
        //        {
        //            intPageIndex = intPageCount;
        //            btnNext.Enabled = false;
        //            btnfoot.Enabled = false;
        //            lblCurPage.Text = Convert.ToString(intPageIndex);
        //        }
        //        break;
        //}

        //if (intPageIndex < 0 || intPageIndex > intPageCount)
        //{
        //    return;
        //}
        ////lblCurPage.Text = Convert.ToString(intPageIndex + 1);
        //if (Session["SQLsource"] != null)
        //{
        //    int begin = (intPageIndex - 1) * PageSize + 1;
        //    int end = begin + PageSize - 1;
        //    string sSQL = "";
        //    string sql = Session["SQLsource"].ToString();
        //    int order = sql.ToUpper().IndexOf("ORDER BY");
        //    if (order > 0)
        //    {
        //        string left = sql.Substring(0, order);
        //        string right = sql.Substring(order, sql.Length - order);
        //        sSQL = "select * from (select *,row_number() over (" + right + ")as 编号 from (" + left + ")tb) T where T.编号 between " + begin.ToString() + " and " + end.ToString();
        //    }
        //    else
        //    {
        //        DataTable order_dt = objConn.GetDataTable("select top 1 * from (" + sql + ")#t");
        //        if (order_dt != null)
        //        {
        //            string name = order_dt.Columns[0].ColumnName.ToString();
        //            sSQL = "select * from (select *,row_number() over ( order by " + name + ") as 编号 from(" + sql + ")tb)T where T.编号 between " + begin.ToString() + " and " + end.ToString();
        //        }
        //    }
        //    MyDataBind2(sSQL, "");
        //} 
        #endregion
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
    protected void MyDataBind2(string sSQL, string sCondition)
    {
        if (sCondition != "")
        {
            sSQL = GetAddConditionSQL(sSQL, sCondition);
        }
        try
        {
            dt_gxs = objConn.GetDataTable(sSQL);
            //objDt =objConn.GetDataTable(sSQL);
            //Session["sSearchSql"] = sSQL;
        }
        catch
        {

        }
    }
    //public void MyDataBind(bool bpostback, string sSQL, string sCondition)
    //{
    //    int TotalPage;          //总页数
    //    Session["ADDSQL"] = sSQL;
    //    TotalPage = 0;
    //    if (sCondition != "")
    //    {
    //        sSQL = sSQL.Replace("1=2", "1=1");
    //        sSQL = GetAddConditionSQL(sSQL, sCondition);
    //        Session["SQLsource"] = sSQL;
    //        TotalPage = objConn.GetRowCount(sSQL);
    //        if (TotalPage >= PageSize)
    //        {
    //            int TotalPage1 = TotalPage / PageSize;
    //            if (TotalPage % PageSize != 0)
    //            {
    //                TotalPage1++;
    //            }
    //            this.lblPageCount.Text = TotalPage1.ToString();
    //            this.lblCurPage.Text = "1";
    //            this.btnPrev.Enabled = false;
    //            this.btnfoot.Enabled = true;
    //            this.btnhead.Enabled = false;
    //            this.btnNext.Enabled = true;
    //        }
    //        else
    //        {
    //            this.lblCurPage.Text = "1";
    //            this.lblPageCount.Text = "1";
    //            this.btnNext.Enabled = false;
    //            this.btnPrev.Enabled = false;
    //            this.btnfoot.Enabled = false;
    //            this.btnhead.Enabled = false;
    //        }
    //    }
    //    else
    //    {
    //        sSQL = GetAddConditionSQL(sSQL, "1=2");
    //        string SQLTJ = "";
    //        int order = sSQL.ToUpper().IndexOf("ORDER BY");
    //        if (order > 0)
    //        {
    //            int begin;
    //            string right = sSQL.Substring(order, sSQL.Length - order);
    //            begin = right.IndexOf(",");
    //            string a = "ORDER BY";
    //            if (begin > 0)
    //            {
    //                string left = right.TrimStart().Substring(a.Length, begin - a.Length - 1);
    //                SQLTJ = "select *," + left + " as 编号 from (" + sSQL.Substring(0, order) + ")#t " + right;
    //            }
    //            else
    //            {
    //                SQLTJ = "select *," + right.Substring(a.Length, right.Length - a.Length) + " as 编号 from (" + sSQL.Substring(0, order) + ")#t " + right;
    //            }
    //        }
    //        else
    //        {
    //            DataTable order_dt = objConn.GetDataTable(sSQL);
    //            if (order_dt != null)
    //            {
    //                string name = order_dt.Columns[0].ColumnName.ToString();
    //                SQLTJ = "select *," + name + " as 编号 from(" + sSQL + ")#t";
    //            }
    //        }
    //        Session["dgLieBiaoShuSQL"] = SQLTJ;
    //        if (bpostback)
    //        {
    //            this.lblPageCount.Text = "0";
    //            this.lblCurPage.Text = "0";
    //            this.btnPrev.Enabled = false;
    //            this.btnNext.Enabled = false;
    //        }
    //    }
    //    if (bpostback)
    //    {
    //        if (sSQL.ToUpper().Contains("ORDER BY"))
    //        {
    //            int a = sSQL.ToUpper().IndexOf("ORDER BY");
    //            sSQL = "select * from(select *,row_number() over(" + sSQL.Substring(a, sSQL.Length - a) + ") as 编号 from (" + sSQL.Substring(0, a) + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
    //        }
    //        else
    //        {
    //            DataTable order_dt = objConn.GetDataTable("select top 1 * from (" + sSQL + ")#t");
    //            if (order_dt != null)
    //            {
    //                string name = order_dt.Columns[0].ColumnName.ToString();
    //                sSQL = "select * from(select *,row_number() over( order by " + name + ") as 编号 from (" + sSQL + ") tb ) T  where T.编号 between 1 and " + PageSize.ToString();
    //            }
    //        }
    //    }
    //    try
    //    {
    //        objDt = objConn.GetDataTable(sSQL);
    //        Session["sSearchSql"] = sSQL;
    //    }
    //    catch
    //    {

    //    }
    //}


    protected void btnNext_Click(object sender, EventArgs e)
    {
    }
    protected void btnPrev_Click(object sender, EventArgs e)
    {
    }
}
