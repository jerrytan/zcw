using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_Cgsgzgys : System.Web.UI.Page
{
    public DataTable dt_topfxs = new DataTable();        //材料Table加载前10条数据
    public DataConn objConn = new DataConn();           //DataHelper类
    public string sSQL = "";                            //Sql语句
    public string strScr;
    public string strScrQQ;
    public string s_yh_id = "";
    public string ppid = "";//用户ID
    public string dwid1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Request["s_yh_id"] != null)
        {
            s_yh_id = Request["s_yh_id"].ToString();
            s_yh_id = Session["CGS_YH_ID"].ToString();
            string sql_dwid = "select dw_id from 用户表 where yh_id='" + s_yh_id + "'";
            dwid1 = objConn.DBLook(sql_dwid);
        }
        else
        {
            HttpCookie CGS_QQ_ID = null;
            if (Request.Cookies["CGS_QQ_ID"] != null)
            {
                CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
                string sql_dwid = "select dw_id from 用户表 where QQ_ID='" + CGS_QQ_ID.Value.ToString() + "'";
                dwid1 = objConn.DBLook(sql_dwid);
            }
            else
            {
                if (Session["CGS_YH_ID"] != null)
                {
                    s_yh_id = Session["CGS_YH_ID"].ToString();
                    string sql_dwid = "select dw_id from 用户表 where yh_id='" + s_yh_id + "'";
                    dwid1 = objConn.DBLook(sql_dwid);
                }

            }
        }
        this.dwid.Value = dwid1;          
       
        strScr = Request["scr"];
        strScrQQ= Request["scrQQ"];
        if (Request["ppid"]!=null&&Request["ppid"].ToString()!="")
        {
            ppid = Request["ppid"].ToString();
        } 
        string sSQL = "";
        if (ppid=="")
        {
            sSQL = "select top 10 gys_id,供应商,主页,地区名称 from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where yh_id='"+s_yh_id+"')";
            
            dt_topfxs = objConn.GetDataTable(sSQL);
        }
        else
        {
            //sSQL = "select gys_id,供应商,主页,地区名称 from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id='" + ppid + "')";
            //----------------------李宗鹏分页开始-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            string msgSql = "select * from dbo.品牌字典 where pp_id='"+ppid+"'";

            DataTable dt = MySqlHelper.GetTable(msgSql);
            string scsid=dt.Rows[0]["scs_id"].ToString();
            string ppmc = dt.Rows[0]["品牌名称"].ToString();

            //获取当前页和每页多少条
            int pageIndex = Request["pageIndex"] == null ? 1 : int.Parse(Request["pageIndex"]);
            int pageSize = Request["pageSize"] == null ? 10 : int.Parse(Request["pageSize"]);
            //总条数
            int total = Convert.ToInt32(MySqlHelper.ExecuteScalar("select count(*) from Viewglfxsxx where  品牌名称='" + ppmc + "' and pp_id='" + ppid + "' and 生产厂商ID='" + scsid + "'  "));

            string pageHtml = PagingHelper.ShowPageNavigate(pageIndex, pageSize, total);

            sSQL = " select top " + pageSize + " gys_id,供应商,地区名称,注册日期,注册资金,电话,是否启用,主页 from dbo.Viewglfxsxx where gys_id not in (select top " + ((pageIndex - 1) * pageSize) + " gys_id from dbo.Viewglfxsxx where  品牌名称='" + ppmc + "' and pp_id='" + ppid + "' and 生产厂商ID='" + scsid + "'  order by updatetime desc) and 品牌名称='" + ppmc + "' and pp_id='" + ppid + "' and 生产厂商ID='" + scsid + "'  order by updatetime desc ";
            this.ppidT.Value = ppid;
            this.pageDiv.InnerHtml = pageHtml;
            //----------------------李宗鹏分页结束-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
           
            dt_topfxs = objConn.GetDataTable(sSQL);
        }
        if (!IsPostBack)
        {
            createlm(dt_topfxs);
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
        if (sColumName=="地区")
        {
            sColumName = "地区名称";
        }
        if (sColumName == "分销商")
        {
            sColumName = "供应商";
        }
        string sql_js = "";
        if (ppid == "")
        {
            sql_js = "select top 10 gys_id,供应商,主页,地区名称 from 材料供应商信息表 where gys_id in(select gys_id from 采购商关注供应商表 where dw_id='" + dwid1 + "')";
        }
        else
        {
            sql_js = " select gys_id,供应商,主页,地区名称 from 材料供应商信息表 where gys_id in (select gys_id from 采购商关注供应商表 where gys_id in(select scs_id from 品牌字典 where pp_id='" + ppid + "') and dw_id='" + dwid1 + "' ) ";
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
                sFieldType = objDt.Columns[i].DataType.Name.ToString().Trim();
                if (sColumName == sTempColumnName)
                {
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
            dt_topfxs = objConn.GetDataTable(sql);
        }
        else
        {
            string sql = sql_js;
            sql = "select * from (" + sql + ")#temp where " + strCondition;
            dt_topfxs = objConn.GetDataTable(sql);
        }
    }

    private void createlm(DataTable objDt)
    {
        ListItem objItem = null;
        if (objDt != null)
        {
            objItem = null;
            objItem = new ListItem();
            objItem.Text = "分销商";
            lieming.Items.Add(objItem);
            for (int i = 0; i < objDt.Columns.Count; i++)
            {
                switch (objDt.Columns[i].ColumnName)
                {
                    case "gys_id":
                        break;
                    case "地区名称":
                         objItem = null;
                        objItem = new ListItem();
                        objItem.Text ="地区";
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
            objItem = null;
            objItem = new ListItem();
            objItem.Text = "全部";
            lieming.Items.Add(objItem);
        }
    }
    //*****************************小张新增检索功能结束*********************************
}