﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asp_gyszc : System.Web.UI.Page
{
    public string qymc = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void Submit1_Click(object sender, ImageClickEventArgs e)
    {
        DataConn dc = new DataConn();
        string sqlIsExist = "select * from 用户表 where QQ号码='"+this.txt_gsQQ.Value+"' ";


        qymc = this.s1.Value + this.s2.Value + this.s3.Value;


        if (string.IsNullOrEmpty(this.txt_gsmc.Value))
        {
            Response.Write("<script>window.alert('请输入公司名称！');</script>");
            this.txt_gsmc.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.txt_gsQQ.Value))
        {
            Response.Write("<script>alert('请输入公司QQ')</script>");
            this.txt_gsQQ.Focus();
            return;
        }
        else
        {
            if (dc.GetRowCount(sqlIsExist) > 0)
            {
                Response.Write("<script>window.alert('该用户已存在');</script>");
                this.txt_gsQQ.Focus();
                return;
            }
        }
        if (string.IsNullOrEmpty(this.txt_yyzzzch.Value))
        {
            Response.Write("<script>window.alert('请输入营业执照注册号');</script>");
            this.txt_yyzzzch.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.dwlx.Value))
        {
            Response.Write("<script>window.alert('请选择单位类型');</script>");
            this.dwlx.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.txt_gsdz.Value))
        {
            Response.Write("<script>window.alert('请输入公司地址');</script>");
            this.txt_gsdz.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.txt_gsdh.Value))
        {
            Response.Write("<script>window.alert('请输入公司电话');</script>");
            this.txt_gsdh.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.jyfw.Value))
        {
            Response.Write("<script>window.alert('请输入经营范围');</script>");
            this.jyfw.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.txt_xm.Value))
        {
            Response.Write("<script>window.alert('请输入联系人姓名');</script>");
            this.txt_xm.Focus();
            return;
        }
        if (string.IsNullOrEmpty(this.txt_sj.Value))
        {
            Response.Write("<script>window.alert('请输入联系人手机号');</script>");
            this.txt_sj.Focus();
            return;
        }
        if(string.IsNullOrEmpty(this.txt_lxdz.Value))
        {
            Response.Write("<script>window.alert('请输入联系人地址');</script>");
            this.txt_lxdz.Focus();
            return;
        }



        //string sqlAddUser = "insert into 用户表 (QQ号码,手机,类型,updatetime,注册时间,等级,姓名,公司名称,公司地址,"
        //+ "公司主页,公司电话) values ('" + this.txt_gsQQ.Value + "','" + this.txt_sj.Value + "','" + this.dwlx.Value + "',"
        //+ "GETDATE(),GETDATE(),'" + this.zzdj.Value + "','" + this.txt_xm.Value + "','" + this.txt_gsmc.Value + "',"
        //+ "'" + this.txt_gsdz.Value + "','" + this.txt_gszy.Value + "','" + this.txt_gsdh.Value + "');";

        //string sqlAddYh_id = "update 用户表 set yh_id=myID where QQ号码='" + this.txt_gsQQ.Value + "';";


        string sqlAddGys = "insert into 材料供应商信息表 (供应商,主页,地址,电话,传真,联系人,联系人手机,是否启用,单位类型,"
        + "单位简称,地区名称,法定代表人,注册资金,联系地址,邮编,电子邮箱,开户银行,银行账户,账户名称,资质等级,经营范围,"
        + "备注,注册日期,企业员工人数,资产总额,注册级别,企业类别,营业执照注册号,updatetime,单位QQ号)"
        + " values ('" + this.txt_gsmc.Value + "','" + this.txt_gszy.Value + "','" + this.txt_gsdz.Value + "','" + this.txt_gsdh.Value + "','" + this.txt_gscz.Value + "',"
        + "'" + this.txt_xm.Value + "','" + this.txt_sj.Value + "',1,'" + this.dwlx.Value + "','" + this.txt_gsjc.Value + "','"+qymc+"',"
        + "'" + this.txt_fddbr.Value + "','" + this.txt_zczj.Value + "','" + this.txt_lxdz.Value + "','" + this.txt_gsyb.Value + "','" + this.txt_yx.Value + "',"
        + "'" + this.txt_khyh.Value + "','" + this.txt_yhzh.Value + "','" + this.txt_zhmc.Value + "','" + this.zzdj.Value + "','" + this.jyfw.Value + "','" + this.txt_bz.Value + "',"
        + "GETDATE(),'" + this.txt_qyrs.Value + "','" + this.txt_zcze.Value + "',"
        + "'" + this.zcjb.Value + "','" + this.qylb.Value + "','" + this.txt_yyzzzch.Value + "',"
        + "GETDATE(),'" + this.txt_gsQQ.Value + "')";

        string sqlAddGys_id = "update 材料供应商信息表 set gys_id=myID where 单位QQ号='" + this.txt_gsQQ.Value + "';";

        string sqlAll = sqlAddGys + sqlAddGys_id;


        if (dc.RunSqlTransaction(sqlAll))
        {
            Response.Write("<script>window.alert('注册信息已提交,请等待审核');</script>");
            return;
        }
        else
        {
            Response.Write("<script>window.alert('注册失败');</script>");
            return;
        }
    }






}