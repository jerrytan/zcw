using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_static_Cgsgzcl : System.Web.UI.Page
{
    public DataTable dt_topcl = new DataTable();        //材料Table加载前10条数据
    public DataConn objConn = new DataConn();           //DataHelper类
    public string sSQL = "";                            //Sql语句
    //public string s_yh_id = "";                         //用户ID
   public string clbm = "";
   public string dwid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
            string s_yh_id = Request["s_yh_id"];            
            string sql_dwid = "select dw_id from 用户表 where yh_id='"+s_yh_id+"'";
              dwid = objConn.DBLook(sql_dwid);
            
            if (Request["clbm"]!=null&&Request["clbm"].ToString()!="")
            {
                clbm = Request["clbm"].ToString();
            }
            if (string.IsNullOrEmpty(clbm))
            {
                sSQL = @"select top 10 收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地区名称,地址,规格型号,采购商关注的材料表.收藏时间 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where isnull(材料表.cl_id,'')<>'' and isnull(采购商关注的材料表.材料名称,'')<>'' and isnull(采购商关注的材料表.材料编码,'')<>'' and 采购商关注的材料表.dw_id='" + dwid + "' order by 采购商关注的材料表.收藏时间 desc";          //加载材料前10条信息
                dt_topcl = objConn.GetDataTable(sSQL);
                
            }
            else
            {
                sSQL = @"select  收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,地区名称,品牌名称,地址,规格型号,采购商关注的材料表.收藏时间 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where isnull(材料表.cl_id,'')<>'' and isnull(采购商关注的材料表.材料名称,'')<>'' and isnull(采购商关注的材料表.材料编码,'')<>'' and 采购商关注的材料表.dw_id='" + dwid + "' and SUBSTRING(材料表.材料编码,1," + clbm.Length + ")= " + clbm + "  order by 采购商关注的材料表.收藏时间 desc";        //加载材料前10条信息
                dt_topcl = objConn.GetDataTable(sSQL);
                 
            }
            if (!IsPostBack)
            {
                createlm(dt_topcl);
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
        if (sColumName == "地区")
        {
            sColumName = "地址";
        }
        if (sColumName == "供应商")
        {
            sColumName = "生产厂商";
        }
        if (sColumName == "名称")
        {
            sColumName = "显示名";
        }
        string sql_js = "";
        if (string.IsNullOrEmpty(clbm))
        {
            sql_js = @"select top 10 收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号,采购商关注的材料表.收藏时间 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where isnull(材料表.cl_id,'')<>'' and isnull(采购商关注的材料表.材料名称,'')<>'' and isnull(采购商关注的材料表.材料编码,'')<>'' and 采购商关注的材料表.dw_id='" + dwid + "'";          //加载材料前10条信息            
        }
        else
        {
            sql_js = @"select  收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号,采购商关注的材料表.收藏时间 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where isnull(材料表.cl_id,'')<>'' and isnull(采购商关注的材料表.材料名称,'')<>'' and isnull(采购商关注的材料表.材料编码,'')<>'' and 采购商关注的材料表.dw_id='" + dwid + "' and SUBSTRING(材料表.材料编码,1," + clbm.Length + ")= " + clbm;        //加载材料前10条信息

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
            string sql ="select * from ("+ sql_js+")#temp order by 收藏时间";
            dt_topcl = objConn.GetDataTable(sql);
        }
        else
        {
            string sql = sql_js;
            sql = "select * from (" + sql + ")#temp where " + strCondition+" order by 收藏时间";
            dt_topcl = objConn.GetDataTable(sql);
        }
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
                    case "收藏时间":
                        break;
                    case "地址":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "地区";
                        lieming.Items.Add(objItem);
                        break;
                    case "显示名":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "名称";
                        lieming.Items.Add(objItem);
                        break;
                    case "生产厂商":
                        objItem = null;
                        objItem = new ListItem();
                        objItem.Text = "供应商";
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