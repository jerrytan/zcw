using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class asp_gysglcl_2 : System.Web.UI.Page
{
    protected DataTable dt_cl = new DataTable();
    public string gys_id = "";//接收传过来的gys_id
    public string ejfl = "";
    public string s_yh_id;
    public string sSQL;
    public DataConn objConn = new DataConn();
    DataView objDv = null;
    DataTable objDt = null;
    public int PageSize = 10;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();            
        }
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            gys_id = Request["gys_id"].ToString();
            ejfl = Request["ejfl"].ToString();
        }
      
        if (ejfl != "" && gys_id != "")
        {
            sSQL = "select cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商,是否启用 from 材料表 where 是否启用=1 and 分类名称='" + ejfl + "' and gys_id='" + gys_id + "' order by updatetime desc ";
            dt_cl = objConn.GetDataTable(sSQL);
            Session["SQLsource"] = sSQL;
            string sSearchCondition="分类名称='"+ejfl+"'";
            MyDataBind(true, sSQL, sSearchCondition);
        }
        else
        {
            if (!IsPostBack)
            {
                sSQL = "select  dw_id from 用户表 where yh_id='"+s_yh_id+"'";
                DataTable dt_yh = objConn.GetDataTable(sSQL);
                string gy = dt_yh.Rows[0]["dw_id"].ToString();
                sSQL = "select top 10 cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商,是否启用 from 材料表 where 是否启用=1   order by updatetime desc";
                dt_cl = objConn.GetDataTable(sSQL);
                this.lblgys_id.Value = gy;
                this.dic.Visible = false;
            }
        } 
    }

    int intPageIndex;//当前页
    public void PagerButtonClick(Object sender, CommandEventArgs e)
    {
        this.divtable.Visible = true;
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
                if (intPageIndex > 0)
                {
                    intPageIndex--;
                    lblCurPage.Text = Convert.ToString(intPageIndex);
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
            objDt = objConn.GetDataTable(sSQL);
            dt_cl = objDt;
        }
        catch
        {

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
            this.lblhint.Visible = true;
            this.lblhint.Text = "请输入材料名称";
        }
        else
        {
            string sql = "select  COUNT(*)  from 材料表 where gys_id='" + gys_id + "' and 显示名 like '%" + this.txtKeyWord.Value + "%'";
            int count = Convert.ToInt32(objConn.DBLook(sql));
            if (count == 0)
            {
                Response.Write("<script>alert('没有您要的材料信息!')</" + "script>");
                this.txtKeyWord.Value = "";
            }
            else
            {
                this.lblhint.Visible = false;
                string gsxx = "select cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商 from 材料表 " +
                    "where left(是否启用,1) like '%1%' and 显示名 like '%" + this.txtKeyWord.Value + "%' and gys_id='" + gys_id + "' order by cl_id";
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
                dt_cl = objConn.GetDataTable(gsxx);
                Session["SQLsource"] = gsxx;
                string sSQL = "select cl_id, 显示名,品牌名称,规格型号,材料编码,生产厂商 from 材料表" +
                    " where left(是否启用,1) like '%1%' and 分类名称 like '%" + this.txtKeyWord.Value + "%' order by cl_id";
                string sSearchCondition = "分类名称 like '%" + this.txtKeyWord.Value + "%'";
                MyDataBind(true, sSQL, sSearchCondition);
                this.txtKeyWord.Value = "";
            }
        }
    }
    
}