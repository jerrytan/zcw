<%@ WebHandler Language="C#" Class="userManager" %>

using System;
using System.Web;
using System.Text;
public class userManager : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        if (action == "scsAdd")
        {
            //"action":"scsAdd",
            //            "qq":$("#newQQ").val();,
            //            "name":$("#newName").val(),
            //            "phone":$("#newPhone").val(),
            //            "email":$("#newEmail").val(),
            //            "scm":scm,
            //            "fxm":fxm,
            //            "clm":clm
            string newQQ = context.Request["qq"] == null ? "" : context.Request["newQQ"].ToString();
            string newName = context.Request["name"] == null ? "" : context.Request["newName"].ToString();
            string newPhone = context.Request["phone"] == null ? "" : context.Request["newPhone"].ToString();
            string newEmail = context.Request["email"] == null ? "" : context.Request["newEmail"].ToString();
            string scm = context.Request["scm"] == null ? "" : context.Request["scm"].ToString();
            string fxm = context.Request["fxm"] == null ? "" : context.Request["fxm"].ToString();
            string clm = context.Request["clm"] == null ? "" : context.Request["clm"].ToString();
            StringBuilder sb = new StringBuilder();

            context.Response.Write(newQQ+","+newName+","+newPhone+","+newEmail+","+scm+","+fxm+","+clm);
            if (scm != "0")
            {
                sb.Append("管理生产商");
            }
            if (fxm != "0")
            {
                sb.Append("管理分销商");
            }
            if (clm != "0")
            {
                sb.Append("管理材料信息");
            }
            //string sqlIsExistQQ = "select * from 用户表 where QQ号码='" + newQQ + "' "; //查询QQ是否存在
            //string dw_id = context.Request.QueryString["gys_dw_id"];

            //string sql_Add = "insert into 用户表 (QQ号码,姓名,手机,邮箱,等级,角色权限,dw_id,类型,注册时间,updatetime) values ('" + newQQ + "'"
            //+ ",'" + newName + "','" + newPhone + "','" + newEmail + "','普通用户','" + sb + "',"
            //+ "'" + dw_id + "','" + "生产商" + "',getdate(),getdate())";

            //context.Response.Write(sql_Add);
            //string sql_Add += "update 用户表 set yh_id=myID where QQ号码='" + this.txt_QQ.Value + "';";
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}