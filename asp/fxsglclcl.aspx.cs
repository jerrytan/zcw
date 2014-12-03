using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_fxsglclcl : System.Web.UI.Page
{
    DataConn objConn = new DataConn();
    public DataTable dtcl = new DataTable();
    public string ppid1 = "";  //品牌id
    public string ppmc1 = "";  //品牌名称
    public string scs = "";   //生产商
    public string fxs_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (Request["ppid"] != null && Request["ppid"].ToString() != "")
        {
            ppid1 = Request["ppid"].ToString();
        }
        if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
        {
            ppmc1 = Request["ppmc"].ToString();
        }
        if (Request["scs"] != null && Request["scs"].ToString() != "")
        {
            scs = Request["scs"].ToString();
        }
        this.ppmc.Value = ppmc1;
        this.ppid.Value = ppid1;
        this.scsid.Value = scs;
        if (Request["fxs_id"] != null && Request["fxs_id"].ToString() != "")
        {
            fxs_id = Request["fxs_id"].ToString();
        }
        this.fxsid.Value = fxs_id;
        string sSQL = "";
        if (ppid1=="")
        {
            sSQL = "select cl_id,材料编码,显示名 as 材料名称,规格型号,计量单位,生产厂商,price,品牌名称 from  供应商材料表 where fxs_id=" + fxs_id;
            dtcl = objConn.GetDataTable(sSQL);
        }
        else
        {
            sSQL = "select cl_id,材料编码,显示名 as 材料名称,规格型号,计量单位,生产厂商,price,品牌名称 from  供应商材料表 where pp_id='" + ppid1 + "' and fxs_id=" + fxs_id;
            dtcl = objConn.GetDataTable(sSQL);
        }
        if (!IsPostBack)
        {           
            createlm(dtcl);
        }
    }
    protected void filter_Click(object sender, System.EventArgs e)
    {
        string strCondition = "";
        string sColumName;
        string sOperator;
        string sKeyWord;
        string sFieldType;
        string sSQL;
        DataTable objDt = null;

        sColumName = lieming.SelectedItem.Value.ToString().Trim();
        sOperator = yunsuanfu.SelectedItem.Value.ToString().Trim();
        sKeyWord = txtKeyWord.Text.ToString().Trim();
        if (sColumName == "价格")
        {
            sColumName = "price";
        }
        //得到要筛选字段的类型
        string SQL = "";
        if (ppid1 == "")
        {
            SQL = "select cl_id,材料编码,显示名 as 材料名称,规格型号,计量单位,生产厂商,price,品牌名称 from  供应商材料表 where fxs_id=" + fxs_id;
        }
        else
        {
            SQL = "select cl_id,材料编码,显示名 as 材料名称,规格型号,计量单位,生产厂商,price,品牌名称 from  供应商材料表 where pp_id='" + ppid1 + "' and fxs_id=" + fxs_id;
        }
       sSQL = "select * from (" + SQL + ")#temp where 1=0";
        objDt = objConn.GetDataTable(sSQL);
        for (int i = 0; i < objDt.Columns.Count; i++)
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
        string sql = SQL;       
        sql = "select * from (" + sql + ")#temp where " + strCondition;
        dtcl = objConn.GetDataTable(sql);
    }

    private void createlm(DataTable objDt)
    {
        ListItem objItem = null;
        if (objDt != null)
        {
            for (int i = 0; i < objDt.Columns.Count; i++)
            {
                switch (objDt.Columns[i].ColumnName)
                {
                    case "cl_id":
                        break;
                    case "price":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "价格";                   
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
}