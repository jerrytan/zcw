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

    protected void Page_Load(object sender, EventArgs e)
    {
        string s_yh_id = Request["s_yh_id"];
        string strFlmc = Request["strFlmc"];
        
        if (string.IsNullOrEmpty(strFlmc))
            {
                sSQL = @"select top 10 收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where 采购商关注的材料表.yh_id='" + s_yh_id + "' ";          //加载材料前10条信息
                dt_topcl = objConn.GetDataTable(sSQL);
            }
            else
            {
                sSQL = @"select  收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where 采购商关注的材料表.yh_id='" + s_yh_id + "' and 分类名称='" + strFlmc + "' ";          //加载材料前10条信息
                dt_topcl = objConn.GetDataTable(sSQL);
            }


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string s_yh_id = Request["s_yh_id"];
        sSQL = @"select  收藏人QQ,收藏人,材料表.cl_id,显示名,生产厂商,品牌名称,地址,规格型号 from 采购商关注的材料表   
                    left join 材料表 on 采购商关注的材料表.cl_id=材料表.cl_id  
                    left join 材料供应商信息表 on 材料供应商信息表.gys_id=材料表.gys_id 
                    where 采购商关注的材料表.yh_id='" + s_yh_id + "' and 显示名 like '%" + this.txt_search.Value.Trim() + "%' ";          //加载材料前10条信息
        dt_topcl = objConn.GetDataTable(sSQL);
    }
}