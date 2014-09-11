using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_QQ_dlyz : System.Web.UI.Page
{
    protected DataTable dtGys = new DataTable();
    string strRunPage;  //验证成功后要跳转的页面

    protected void Page_Load(object sender, EventArgs e)
    {
     
    }
    protected void btnCheck_Click(object sender, ImageClickEventArgs e)
    {
        DataConn dc = new DataConn();
        string QQ = Request.Form["user_qq"];
        string gys_qq_id;
        string cgs_qq_id;
        string sql_Check_QQ;
        string sql_Update_QQ_id;
        string sql_GetData;
        string sql_Level;
        string sql_dwid;

        if (Request.Cookies["GYS_QQ_ID"]!=null)
        {
            gys_qq_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            sql_Check_QQ = "select * from 用户表 where QQ号码='" + QQ + "'";
            sql_Update_QQ_id = "update 用户表 set QQ_id = '" + gys_qq_id + "',验证通过时间=getdate(),是否验证通过='通过' where QQ号码='" + QQ + "'";

            sql_GetData = "select 供应商,地址,电话,主页,单位类型,联系人,联系人手机 from 材料供应商信息表 where gys_id=(select dw_id from 用户表 where QQ_id='" + gys_qq_id + "')";

            sql_Level = "select 等级 from 用户表 where QQ_id='" + gys_qq_id + "'";
            sql_dwid = "select dw_id from 用户表 where QQ_id='" + gys_qq_id + "'";
        }
        else
        {
            cgs_qq_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
            sql_Check_QQ = "select * from 用户表 where QQ号码='" + QQ + "'";
            sql_Update_QQ_id = "update 用户表 set QQ_id = '" + cgs_qq_id + "',验证通过时间=getdate(),是否验证通过='通过' where QQ号码='" + QQ + "'";

            sql_GetData = "select 单位名称,地址,电话,主页,单位类型,联系人,联系人手机 from 采购商基本信息 where cgs_id=(select dw_id from 用户表 where QQ_id='" + cgs_qq_id + "')";

            sql_Level = "select 等级 from 用户表 where QQ_id='" + cgs_qq_id + "'";
            sql_dwid = "select dw_id from 用户表 where QQ_id='" + cgs_qq_id + "'";
        }
        


        if(dc.GetRowCount(sql_Check_QQ)>0)     //判断QQ号是否存在，即是否已经注册
        {
            //Response.Write("已经注册");
            if (dc.RunSqlTransaction(sql_Update_QQ_id))    //已经注册，则写入QQ_id
            {
                //读取数据
                dtGys = dc.GetDataTable(sql_GetData);
                if (Request.Cookies["GYS_QQ_ID"] != null)
                {
                    for (int i = 0; i < dtGys.Rows.Count; i++)
                    {
                        DataRow dr = dtGys.Rows[i];
                        this.gys_name.Value = dr["供应商"].ToString();
                        this.gys_address.Value = dr["地址"].ToString();
                        this.gys_phone.Value = dr["电话"].ToString();
                        this.gys_homepage.Value = dr["主页"].ToString();
                        this.gslx.Value = dr["单位类型"].ToString();
                        this.user_name.Value = dr["联系人"].ToString();
                        this.user_phone.Value = dr["联系人手机"].ToString();
                    }
                }
                else
                {
                    for (int i = 0; i < dtGys.Rows.Count; i++)
                    {
                        DataRow dr = dtGys.Rows[i];
                        this.gys_name.Value = dr["单位名称"].ToString();
                        this.gys_address.Value = dr["地址"].ToString();
                        this.gys_phone.Value = dr["电话"].ToString();
                        this.gys_homepage.Value = dr["主页"].ToString();
                        this.gslx.Value = dr["单位类型"].ToString();
                        this.user_name.Value = dr["联系人"].ToString();
                        this.user_phone.Value = dr["联系人手机"].ToString();
                    }
                }
                

                if (dc.DBLook(sql_Level) == "企业用户")
                {
                    strRunPage = "hyyhgl.aspx";
                }
                else if (dc.DBLook(sql_Level) == "普通用户")
                {
                    string dwid = dc.DBLook(sql_dwid);
                    if (Request.Cookies["GYS_QQ_ID"] != null)
                    {
                        strRunPage = "gyszym.aspx?dw_id=" + dwid;
                    }
                    else
                    {
                        strRunPage = "cgsgl_2.aspx?dw_id=" + dwid;
                    }
                    
                }

                Response.Write(@"<script>if(confirm('验证成功，是否现在登录？')==true)
                {window.location.href='" + strRunPage + "';}else{}</script>");

            }
        }
        else
        {
            Response.Write(@"<script>if(confirm('此账户尚未注册，是否现在注册？')==true)
            {window.location.href='hyzcsf.aspx';}else{window.opener=null;window.open('','_self');
            window.close();}</script>");
        }
    }


    //protected void btnSave_Click(object sender, ImageClickEventArgs e)
    //{
    //    DataConn dc = new DataConn();

    //    string sql_Save = "update 用户表 set 公司名称='" + this.gys_name.Value + "',公司地址='" + this.gys_address.Value + "',"
    //    + "公司电话='" + this.gys_phone.Value + "',公司主页='" + this.gys_homepage.Value + "',类型='" + this.gslx.Value + "',"
    //    + "姓名='" + this.user_name.Value + "',手机='" + this.user_phone.Value + "' where QQ号码='" + this.user_qq.Value + "'";

    //    if(dc.RunSqlTransaction(sql_Save))
    //    {
    //        Response.Write("修改成功");
    //    }
    //    else
    //    {
    //        Response.Write("修改失败");
    //    }

    //}



}