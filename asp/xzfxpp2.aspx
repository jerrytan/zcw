
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<%
            DataConn objConn=new DataConn();
             string s_yh_id="";
             string sSQL="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
            string source = Request["source"];

            //新增分销品牌写入数据库
           if(s_yh_id!="") {
                
                 string dwlx=Request["lx"];             //单位类型
                 string fxs_id = Request["fxs_id"]; 	//分销商id	
                 string pp_id = Request["pp_id"];	    //品牌id	
                 string pp_name = Request["pp_name"];   //品牌名称     

                if(dwlx=="生产商")
                {
                   string clfl=Request["clfl"];         //
                   string ppmc=Request["ppmc"];
                   string fw=Request["fw"];
                   string dj=Request["dj"];
                   sSQL = "select count(*) from 品牌字典 where 品牌名称='" + pp_name + "'";
                   string count = objConn.DBLook(sSQL);
                   if (count == "0")
                   {
                       sSQL = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围,yh_id) values('" +
                          pp_name + "',1,'" + fxs_id + "','" + clfl + "','" + dj + "','" + fw + "','" + s_yh_id + "' ) ";

                       objConn.ExecuteSQL(sSQL, false);
                       string str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='" + pp_name + "'),"
                           + " fl_id = (select fl_id from 材料分类表 where 分类编码='" + clfl + "'),"
                           + " 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + fxs_id + "'),"
                           + " 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '" + clfl + "'),updatetime=(select getdate())"
                           + " where 品牌名称='" + pp_name + "'";

                       int ret = objConn.ExecuteSQLForCount(str_update, true);
                       Response.Write(" <a style='color: Red' onclick=\"clickMe()\">恭喜您，新增品牌成功，请点击我返回。</a>");
                   }
                   else
                   {
                       Response.Write(" <a style='color: Red' >该品牌名称已存在，请重新添加！</a>");
                   }
              
                }
                else
                {
                    sSQL = "select count(*) from 分销商和品牌对应关系表 where pp_id='" + pp_id + "' and 品牌名称='" + pp_name + "' and 是否启用='1' and fxs_id='" + fxs_id + "' and yh_id='" + s_yh_id + "'";
                    string count = objConn.DBLook(sSQL);
                    if (count=="0")
                    {
                        sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id,updatetime) values('" + pp_id + "','" + pp_name + "', 1,'" + fxs_id + "','" + s_yh_id + "',(select getdate()) ) ";
                        objConn.ExecuteSQL(sSQL, true);
                        Response.Write(" <a style='color: Red' onclick=\"clickMe()\">恭喜您，新增分销品牌成功，请点击我返回。</a>");
                    }
                    else
                    {
                        Response.Write(" <a style='color: Red' onclick=\"clickMe()\">您已经代理了该品牌，请选择其他品牌。</a>");
                    }
                  
                }
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        
         <script defer="defer" type="text/javascript">
             function doload()
             {
             <%if(source=="xzym"){ %>
                  window.close();
                 opener.location.href="gyszym.aspx";
             <%}else{ %>
                 window.close();
                 opener.location.reload();
                 <%
                 } %>
             }
             setTimeout("doload()", 1000);
        </script>
    </body>

</html>
