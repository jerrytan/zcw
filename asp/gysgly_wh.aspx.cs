using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_gysgly_wh : System.Web.UI.Page
{
    DataConn dc = new DataConn();
    public DataTable dt_info = new DataTable();
    public DataTable dt_Yh = new DataTable(); //用户名字(用户表)   

    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie QQ_id;
        if (Request.Cookies["GYS_QQ_ID"] == null)
        {
            QQ_id = Request.Cookies["CGS_QQ_ID"];
        }
        else
        {
            QQ_id = Request.Cookies["GYS_QQ_ID"];
        }
        if (QQ_id != null)
        {
            string str_Sql = "select 姓名,yh_id from 用户表 where QQ_id='" + QQ_id.Value + "'";
            dt_Yh = dc.GetDataTable(str_Sql);
        }
        if(!IsPostBack)
        {
            string gysid = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            string sqlGetInfo = @"select * from 材料供应商信息表 left join 用户表 on 用户表.dw_id = 材料供应商信息表.gys_id 
            where QQ_id='" + gysid + "' and 等级='企业用户'";
            dt_info = dc.GetDataTable(sqlGetInfo);
            DataRow dr = dt_info.Rows[0];
            this.txt_gsmc.Value = dr["供应商"].ToString();
            this.txt_gsjc.Value = dr["单位简称"].ToString();
            this.txt_yyzzzch.Value = dr["营业执照注册号"].ToString();
            this.txt_gsQQ.Value = dr["单位QQ号"].ToString();
            this.txt_fddbr.Value = dr["法定代表人"].ToString();
            this.txt_zcrq.Value = dr["注册日期"].ToString();
            this.txt_zczj.Value = dr["注册资金"].ToString();
            this.txt_zcze.Value = dr["资产总额"].ToString();
            this.zcjb.Value = dr["注册级别"].ToString();
            this.zzdj.Value = dr["资质等级"].ToString();
            this.qylb.Value = dr["企业类别"].ToString();
            this.txt_khyh.Value = dr["开户银行"].ToString();
            this.dwlx.Value = dr["单位类型"].ToString();
            this.txt_zhmc.Value = dr["账户名称"].ToString();
            this.txt_yhzh.Value = dr["银行账户"].ToString();
            this.txt_qyrs.Value = dr["企业员工人数"].ToString();
            this.txt_gsdz.Value = dr["地址"].ToString();
            this.txt_gsdh.Value = dr["电话"].ToString();
            this.txt_gszy.Value = dr["主页"].ToString();
            this.txt_gsyb.Value = dr["邮编"].ToString();
            this.txt_gscz.Value = dr["传真"].ToString();
            this.jyfw.Value = dr["经营范围"].ToString();
            this.txt_bz.Value = dr["备注"].ToString();
            this.txt_xm.Value = dr["联系人"].ToString();
            this.txt_sj.Value = dr["联系人手机"].ToString();
            this.txt_yx.Value = dr["电子邮箱"].ToString();
        }
        

        this.txt_gsmc.Disabled = true;
        this.txt_yyzzzch.Disabled = true;
        this.txt_gsQQ.Disabled = true;
        this.txt_zcrq.Disabled = true;
        this.txt_zczj.Disabled = true;
        this.dwlx.Disabled = true;
        this.txt_gsdz.Disabled = true;
        this.txt_gsdh.Disabled = true;
        this.jyfw.Disabled = true;
        this.txt_xm.Disabled = true;
        this.txt_sj.Disabled = true;

    }
    protected void Submit1_Click(object sender, ImageClickEventArgs e)
    {
        string gys_qqid = Request.Cookies["GYS_QQ_ID"].Value.ToString();
        string sql_dwid = "select dw_id  from 用户表 where QQ_id='" + gys_qqid + "'";
        string dwid = dc.DBLook(sql_dwid);
        string sqlUpdate = @"update 材料供应商信息表 set 单位简称='" + this.txt_gsjc.Value + "',法定代表人='"
        + this.txt_fddbr.Value + "',资产总额='" + this.txt_zcze.Value + "',注册级别='"+this.zcjb.Value+"',资质等级='"
        + this.zzdj.Value + "',企业类别='" + this.qylb.Value + "',开户银行='" + this.txt_khyh.Value + "',账户名称='"
        + this.txt_zhmc.Value + "',银行账户='" + this.txt_yhzh.Value + "',企业员工人数='" + this.txt_qyrs.Value + "',主页='"
        + this.txt_gszy.Value + "',邮编='" + this.txt_gsyb.Value + "',传真='" + this.txt_gscz.Value + "',备注='"
        + this.txt_bz.Value + "',电子邮箱='" + this.txt_yx.Value + "' where gys_id='" + dwid + "'";

        if (dc.RunSqlTransaction(sqlUpdate))
        {
            Response.Write("<script>window.alert('修改成功');</script>");
        }
        else
        {
            Response.Write("<script>window.alert('修改失败');</script>");
            return;
        }


    }
}