<%@ WebHandler Language="C#" Class="AddclsxzHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.IO;
using System.Text;

public class AddclsxzHandler : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain;";
        context.Request.ContentEncoding = Encoding.UTF8 ;
        
        string flbm = context.Request.Params["flbm"];//分类编码
        string sxmc = context.Request.Params["sxmc"];//属性名称
        
        string newsxz = context.Request["newz"];//
        string ppid = context.Request["ppid"];
        var dwid = context.Session["dwid"];
        if (dwid!=null)
        {
            string SeleSql = "select * from 材料分类属性值表 where 分类编码='" + flbm + "' and len(分类编码)=len('" + flbm + "') and  属性名称='" + sxmc + "' and 编号 in(select MAX(编号) from 材料分类属性值表 where 分类编码='" + flbm + "' and len(分类编码)=len('" + flbm + "') and 属性名称='" + sxmc + "')";
            DataTable dt = MySqlHelper.GetTable(SeleSql);
            if (dt.Rows.Count > 0)
            {
                string flid = dt.Rows[0]["fl_id"].ToString();
                string flsxid = dt.Rows[0]["flsx_id"].ToString();
                string flmc = dt.Rows[0]["分类名称"].ToString();
                string sxbm = dt.Rows[0]["属性编码"].ToString();
                string bh = dt.Rows[0]["编号"].ToString();
                string newbh = string.Empty;

                if (Convert.ToInt32(bh[2].ToString()) == 9)
                {
                    int num2 = 0;
                    int num1 = Convert.ToInt32(bh[1].ToString()) + 1;
                    newbh = bh[0].ToString() + num1.ToString() + num2.ToString();
                }
                else
                {
                    newbh = bh[0].ToString() + bh[1].ToString() + (Convert.ToInt32(bh[2].ToString()) + 1).ToString();
                }
                string insertSql = "insert into 材料分类属性值表(fl_id,分类编码,是否启用,flsx_id,updatetime,分类名称,属性名称,属性编码,编号,属性值,gysid,number) values('"+flid+"','" + flbm + "',1,'" + flsxid + "','" + DateTime.Now.ToString() + "','" + flmc + "','" + sxmc + "','" + sxbm + "','" + newbh + "','" + newsxz + "','" + dwid + "',0)";
                int state = MySqlHelper.ExecuteNonQuery(insertSql);

                string updateSql = "update 材料分类属性值表 set flsxz_id =(select myId from 材料分类属性值表 where 分类编码='" + flbm + "' and len(分类编码)=len('" + flbm + "') and 属性名称='" + sxmc + "' and 编号='" + newbh + "') where 分类编码='" + flbm + "' and len(分类编码)=len('" + flbm + "') and 属性名称='" + sxmc + "' and 编号='" + newbh + "'";
                int stateUpdate=MySqlHelper.ExecuteNonQuery(updateSql);
                if ((state + stateUpdate) == 2)
                {
                    ////清空缓存
                    DataTable dttemp=new DataTable();
                    context.Cache["dtbm"] = dttemp;
                    string returnNew = " <a href='javascript:void(0)' style='float: left;background-color: rgb(255, 255, 255); color: rgb(112, 112, 112);' onclick=\"AddSXZ(this,'" + sxbm + "','" + newbh + "','" + newsxz + "','" + sxmc + "," + sxbm + "," + flsxid + "," + newsxz + "," + newbh + "," + flsxid + "," + (sxbm + newbh) + "," + flid + "," + flmc + ",clid,clmc,clbm')\" >" + newsxz + @"&nbsp;&nbsp;</a>";
                    
                    context.Response.Write("0*添加属性值：" + newsxz + ";成功！*"+returnNew);
                }
                else
                {
                    context.Response.Write("1*添加属性值：" + newsxz + ";失败！");
                }
            }
        }
        else
        {
            context.Response.Write("添加失败！您的登陆状态已经丢失！请重新登陆！");
        }


//        string aa = @"
//        <a href='javascript:void(0)' style='float: left; background-color: rgb(72, 118, 255); color: rgb(255, 255, 255);' onclick='AddSXZ(this,'F','F03','散装LZP','包装方式,F,2683,散装LZP,F03,2683,FF03,1629,水泥,clid,clmc,clbm') '>散装LZP&nbsp;&nbsp;</a>
//        ";

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}