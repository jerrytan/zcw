
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            DataConn objConn=new DataConn();
             string s_yh_id="";
             string sSQL="";
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
            else
            {
                if (Request.Cookies["GYS_YH_ID"]!=null&& Request.Cookies["GYS_YH_ID"].Value.ToString()!="")
                {
                     s_yh_id= Request.Cookies["GYS_YH_ID"].Value.ToString();
                }
            }

            //新增分销品牌写入数据库
           if(s_yh_id!="") {
                
                 string dwlx=Request["lx"];
                 string fxs_id = Request["fxs_id"]; 		
                 string pp_id = Request["pp_id"];		
                 string pp_name = Request["pp_name"];                
                if(dwlx=="生产商")
                {
                   string clfl=Request["clfl"];
                   string ppmc=Request["ppmc"];
                   string fw=Request["fw"];
                   string dj=Request["dj"];
                  sSQL="update 品牌字典 set 品牌名称=c.品牌名称,是否启用=c.是否启用,等级=c.等级,分类编码=c.分类编码,分类名称=c.分类名称,fl_id=c.fl_id,范围=c.范围,生产商=c.供应商,备注=c.备注
from 材料供应商信息从表 c,品牌字典 p where c.uid=[myid] and c.myid=p.标识id";
                }
                else
                {
                    
                    string str_insert = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id) values('"+ pp_id + "','"+pp_name+"', 1,'"+fxs_id+"','" +s_yh_id+"' ) ";
                    objConn.ExecuteSQL(str_insert,true);
                }
                Response.Write(str_insert);
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">恭喜您，新增分销品牌成功，请点击我返回。</a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





