<!--  
	    管理分销商信息页面   生厂商可以对代理自己品牌的分销商信息进行管理 修改保存
        文件名：glfxsxx2.aspx
        传入参数：gys_id    
		author:张新颖
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script runat="server"  >

   
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string s_gys_id = "";     //获取表单提交过来的分销商id 
        string s_yh_id = "";
        if ( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
        {       
            s_gys_id=Request.QueryString["gys_id"].ToString();
        }
        if (Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();//获取用户id
        }

        string companyname = Request.Form["companyname"];   //公司名字
        string address = Request.Form["address"];            //地址
        string tel = Request.Form["tel"];               //电话
        string homepage = Request.Form["homepage"];     //主页
        string area = Request.Form["area"];                    //传真 
        string fax = Request.Form["fax"];
        string description = Request.Form["description"];  //公司简介
        string name = Request.Form["name"];                //联系人
        string phone = Request.Form["phone"];              //联系人手机
        string Business_Scope = Request.Form["Business_Scope"];   //经营范围

        if (s_gys_id != "")
        {
            string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='" + s_gys_id + "' ";

            Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);
 
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count == 0)
                {
                    string str_insert = "insert into 供应商自己修改待审核表 (gys_id)values('" + s_gys_id + "')";
                    objConn.ExecuteSQL(str_insert, false);                 
                }
                string str_update = "update 供应商自己修改待审核表 set 贵公司名称='" + companyname + "',贵公司地址='" + address + "',"
                + "贵公司电话='" + tel + "',贵公司主页='" + homepage + "',贵公司地区='" + area + "',贵公司传真='" + fax + "',是否启用='1',"
                + "联系人姓名='" + name + "',联系人电话='" + phone + "',单位类型='分销商',经营范围='" + Business_Scope + "',"
                + "审批结果='待审核',updatetime=(select getdate()) where gys_id='" + s_gys_id + "' ";
                objConn.ExecuteSQL(str_update, true);
 
        }
        else
        {
            //如果用户"没有"点击glfxsxx.aspx 下拉框 就修改分销商信息,那么就执行如下代码,进行修改
            <%--//String yh_id = Convert.ToString(Session["GYS_YH_ID"]);   //获取用户id  76  获取的用户id有可能是生产商--%>

            <%--string str_gys_id = "select 单位类型, gys_id from 材料供应商信息表 where yh_id='" + s_yh_id + "' ";//查询供应商id	127--%>		
            string str_gys_id = "select 单位类型 from 材料供应商信息表 where gys_id='" + s_gys_id + "' ";
            DataTable dt_gys_id = objConn.GetDataTable(str_gys_id);
            string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //获取供应商id  127
            string str_gys_type = Convert.ToString(dt_gys_id.Rows[0]["单位类型"]);
            if (str_gys_type.Equals("分销商"))
            {
               string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='" + str_gysid + "' ";
                
         
                Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);

                if (obj_check_gys_exist != null)
                {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)
                    {
                        string str_insert = "insert into 供应商自己修改待审核表 (gys_id)values('" + str_gysid + "')";

                        objConn.ExecuteSQL(str_insert, false);
                    }
                    string str_update = "update 供应商自己修改待审核表 set 贵公司名称='" + companyname + "',贵公司地址='" + address + "',"
                    + "贵公司电话='" + tel + "',贵公司主页='" + homepage + "',贵公司地区='" + area + "',贵公司传真='" + fax + "',是否启用='1',"
                    + "联系人姓名='" + name + "',联系人电话='" + phone + "',单位类型='分销商',经营范围='" + Business_Scope + "',"
                    + "审批结果='待审核',updatetime=(select getdate()) where gys_id='" + s_gys_id + "'";

                    objConn.ExecuteSQL(str_update, true);
                }
            }
            if (str_gys_type.Equals("生产商"))
            {
                string str_pp_id = "select pp_id from 品牌字典 where scs_id='" + s_gys_id + "' "; //查询品牌id		

                DataTable dt_pp_id = objConn.GetDataTable(str_pp_id);
                string str_ppid = "";       //获取品牌id
                if (dt_pp_id!=null&&dt_pp_id.Rows.Count>0)
                {
                    str_pp_id = dt_pp_id.Rows[0]["pp_id"].ToString();
                }
              
                string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id in "
                + "(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='" + str_ppid + "')"; //有几个分销商,就有几个fxs_id,取第一个  139

                Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);

                if (obj_check_gys_exist != null)
                {

                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)
                    {
                        string str_insert = "insert into 供应商自己修改待审核表 (gys_id)select top 1 fxs_id from 分销商和品牌对应关系表 "
                        + "where pp_id='" + str_ppid + "'";
                        objConn.ExecuteSQL(str_insert, false);
                    }
                    string str_update = "update 供应商自己修改待审核表 set 贵公司名称='" + companyname + "',贵公司地址='" + address + "',"
                    + "贵公司电话='" + tel + "',贵公司主页='" + homepage + "',贵公司地区='" + area + "',贵公司传真='" + fax + "',是否启用='1',"
                    + "联系人姓名='" + name + "',联系人电话='" + phone + "',单位类型='分销商',经营范围='" + Business_Scope + "',"
                    + "审批结果='待审核',updatetime=(select getdate()) where gys_id in"
                    + "(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='" + str_ppid + "')";
                    objConn.ExecuteSQL(str_update, true);
                }
            }
        }
        Response.Redirect("glfxsxx.aspx?gys_id=" + s_gys_id + "");   ////获取表单提交过来的分销商id 返回到glfxsxx.aspx页

    }
</script>

</html>