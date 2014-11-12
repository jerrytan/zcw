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
    public string sSQL;
    public DataConn objConn = new DataConn();
    public int PageSize = 10;
    public string gys_id = "";//接收传过来的gys_id
    public string pp_mc = "";
    public string s_yh_id;
    DataTable objDt = null;
    DataView objVe = null;
    public DataTable dt_gxs = new DataTable();//材料供应商信息表
    public DataTable dt_yh = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        //蒋
        //if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        //{
        //    gys_id = Request["gys_id"].ToString();
        //    pp_mc = Request["pp_mc"].ToString();
        //}

        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            gys_id = Request["gys_id"].ToString();
            pp_mc = Request["pp_mc"].ToString();
        }
        this.ppmc.Value = pp_mc;
        string pp_id = "";
        if (Request["pp_id"] != null && Request["pp_id"].ToString() != "")
        {
            pp_id = Request["pp_id"].ToString();             
        }
        this.ppid.Value = pp_id;
        //sSQL = "select dw_id from 用户表 where yh_id=" + s_yh_id + "";
        //dt_yh = objConn.GetDataTable(sSQL);
        this.lblgys_id.Value = gys_id;
        if (pp_mc != "" && gys_id != "")
        {
            sSQL = "select gys_id,供应商,地区名称,注册日期,注册资金,电话 from 材料供应商信息表 where gys_id in " +
                "(select fxs_id from 分销商和品牌对应关系表 where 品牌名称='" + pp_mc + "') order by gys_id desc";
            dt_gxs = objConn.GetDataTable(sSQL);
            Session["SQLsource"] = sSQL;
            string sSearchCondition = "gys_id='" + gys_id + "'";
            MyDataBind(true, sSQL, sSearchCondition); 
        }
        else
        {
            if (!IsPostBack)
            {
                //蒋，，，把lsgys_id改成s_yh_id
                sSQL = "select top 10 gys_id,供应商,地区名称,注册日期,注册资金,电话 from 材料供应商信息表 where gys_id in (select distinct fxs_id from 分销商和品牌对应关系表 where pp_id in (select pp_id from 品牌字典 where scs_id='" + s_yh_id + "')) order by updatetime desc";
                //sSQL = "select top 10 gys_id,供应商,地区名称,注册日期,注册资金,电话 from 材料供应商信息表 where 是否启用=1 order by updatetime desc";
                dt_gxs = objConn.GetDataTable(sSQL);
                Response.Write(sSQL);
                this.dic.Visible = false;
            }
        }
    }
    int intPageIndex;//当前页
    public void PagerButtonClick(Object sender, CommandEventArgs e)
    {
        btnNext.Enabled = true;
        btnPrev.Enabled = true;
        btnhead.Enabled = true;
        btnNext.Enabled = true;
        string strArg = e.CommandArgument.ToString();
        int intPageCount = 0;//总页数
        intPageCount = Int32.Parse(lblPageCount.Text.ToString());
        intPageIndex = Int32.Parse(lblCurPage.Text.ToString());
        switch (strArg)
        {
            case "Next":
                if (intPageIndex < intPageCount)
                {
                    intPageIndex++;//1,2
                    lblCurPage.Text = Convert.ToString(intPageIndex);
                }
                break;
            case "Prev":
                if (intPageIndex > 1)
                {
                    intPageIndex--;
                    lblCurPage.Text = Convert.ToString(intPageIndex);
                }
                else if (intPageIndex == 1)
                {
                    btnPrev.Enabled = false;
                    btnhead.Enabled = false;
                    btnNext.Enabled = true;
                    btnfoot.Enabled = true;
                }
                break;
            case "Head":
                if (intPageIndex <= intPageCount)
                {
                    intPageIndex = 1;
                    btnPrev.Enabled = false;
                    btnhead.Enabled = false;
                    lblCurPage.Text = Convert.ToString(intPageIndex);
                }
                break;
            case "Foot":
                if (intPageIndex <= intPageCount)
                {
                    intPageIndex = intPageCount;
                    btnNext.Enabled = false;
                    btnfoot.Enabled = false;
                    lblCurPage.Text = Convert.ToString(intPageIndex);
                }
                break;
        }

        if (intPageIndex < 0 || intPageIndex > intPageCount)
        {
            return;
        }
        //lblCurPage.Text = Convert.ToString(intPageIndex + 1);
        if (Session["SQLsource"] != null)
        {
            int begin = (intPageIndex - 1) * PageSize + 1;
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
    public void MyDataBind(bool bpostback, string sSQL, string sCondition)
    {
        int TotalPage;          //总页数
        Session["ADDSQL"] = sSQL;
        TotalPage = 0;
        if (sCondition != "")
        {
            sSQL = sSQL.Replace("1=2", "1=1");
            sSQL = GetAddConditionSQL(sSQL, sCondition);
            Session["SQLsource"] = sSQL;
            TotalPage = objConn.GetRowCount(sSQL);
            if (TotalPage >= PageSize)
            {
                int TotalPage1 = TotalPage / PageSize;
                if (TotalPage % PageSize != 0)
                {
                    TotalPage1++;
                }
                this.lblPageCount.Text = TotalPage1.ToString();
                this.lblCurPage.Text = "1";
                this.btnPrev.Enabled = false;
                this.btnfoot.Enabled = true;
                this.btnhead.Enabled = false;
                this.btnNext.Enabled = true;
            }
            else
            {
                this.lblCurPage.Text = "1";
                this.lblPageCount.Text = "1";
                this.btnNext.Enabled = false;
                this.btnPrev.Enabled = false;
                this.btnfoot.Enabled = false;
                this.btnhead.Enabled = false;
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
    }
    protected void JianSuo(object sender, EventArgs e)
    {
        if (this.txtKeyWord.Value == "")
        {
            Response.Write("<script>alert('请输入公司名称')</"+"script>");
        }
        else
        {
            string sql = "select COUNT(*) from 材料供应商信息表 where 供应商 like '%" + this.txtKeyWord.Value + "%'";
            int count = Convert.ToInt32(objConn.DBLook(sql));
            if (count == 0)
            {
                Response.Write("<script>alert('没有您要搜索的公司信息!')</" + "script>");
                this.txtKeyWord.Value = "";
            }
            else
            {
                string gsxx = "select gys_id, 供应商,地区名称,注册日期,注册资金,电话 from 材料供应商信息表 where left(单位类型,3)" +
                    " like '%商%' and 供应商 like '%" + this.txtKeyWord.Value + "%' and 是否启用=1 order by updatetime desc";
                dt_gxs = objConn.GetDataTable(gsxx);
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
                Session["SQLsource"] = gsxx;
                string sSQL = "select gys_id,供应商,地区名称,注册日期,注册资金,电话 from 材料供应商信息表 where left(单位类型,3)" +
                    " like '%商%' and 是否启用=1 order by gys_id desc";
                string sSearchCondition = "供应商 like '%" + this.txtKeyWord.Value + "%'";
                MyDataBind(true, sSQL, sSearchCondition);
                this.txtKeyWord.Value = "";
                this.dic.Visible = true;
            }
        }
    }
}
