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
        
        string QQ = Request.Form["user_qq"];
        string gys_qq_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
        DataConn dc = new DataConn();

        string sql_Check_QQ = "select * from 用户表 where QQ号码='" + QQ+"'";
        string sql_Update_QQ_id = "update 用户表 set QQ_id = '" + gys_qq_id + "' where QQ号码='" + QQ + "'";
        string sql_GetData = "select 公司名称,公司地址,公司电话,公司主页,类型,姓名,手机 from 用户表 where QQ号码='"+QQ+"'";
        string sql_Level = "select 等级 from 用户表 where QQ_id='" + gys_qq_id + "'";

        if(dc.GetRowCount(sql_Check_QQ)>0)     //判断QQ号是否存在，即是否已经注册
        {
            //Response.Write("已经注册");
            if (dc.RunSqlTransaction(sql_Update_QQ_id))    //已经注册，则写入QQ_id
            {
                //读取数据
                dtGys = dc.GetDataTable(sql_GetData);
                for (int i = 0; i < dtGys.Rows.Count; i++)
                {
                    DataRow dr = dtGys.Rows[i];
                    this.gys_name.Value = dr["公司名称"].ToString();
                    this.gys_address.Value = dr["公司地址"].ToString();
                    this.gys_phone.Value = dr["公司电话"].ToString();
                    this.gys_homepage.Value = dr["公司主页"].ToString();
                    this.gslx.Value = dr["类型"].ToString();
                    this.user_name.Value = dr["姓名"].ToString();
                    this.user_phone.Value = dr["手机"].ToString();
                }

                if (dc.DBLook(sql_Level) == "企业用户")
                {
                    strRunPage = "hyyhgl.aspx";
                }
                else if (dc.DBLook(sql_Level) == "普通用户")
                {
                    strRunPage = "gyszym.aspx";
                }

                Response.Write(@"<script>if(confirm('验证成功，是否现在登录？')==true)
                {window.location.href='"+strRunPage+"';}else{window.opener=null;window.open('','_self'); window.close();}</script>");

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