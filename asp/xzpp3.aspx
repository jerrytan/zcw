<!--
      生产商新增品牌
	  文件名:  xzpp3.aspx   
      传入参数:用户id 
	  author:张新颖         
-->
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
            //新增品牌写入数据库
             string yh_id="";
         int ret;
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
                {
                    yh_id =Session["GYS_YH_ID"].ToString();   //获取用户id
                }  

                  string  source=Request.Form["source"];
             
                string gys_id = Request.Form["gys_id"]; 				
                string brandname = Request.Form["brandname"];            //品牌名称
                string yjflname = Request.Form["yjflname"];              //大级分类名称               
                string ejflname = Request.Form["ejflname"];              //二级分类名称
                string grade = Request.Form["grade"];               //等级
                string scope = Request.Form["scope"];                    //范围       
                string flname = Request.Form["ejflname"];
                if (flname.Equals("0"))  flname = Request.Form["yjflname"];

                string sSQL = "select count(*) from 品牌字典 where 品牌名称='" + brandname + "'";
                string count = objConn.DBLook(sSQL);
                if (count=="0")
                {
                    string str_insert = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围,yh_id) values('" + brandname + "',1,'" + gys_id + "','" + flname + "','" + grade + "','" + scope + "','" + yh_id + "' ) ";

                    objConn.ExecuteSQL(str_insert, false);
                    string str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='" + brandname + "'),"
                        + " fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
                        + " 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + gys_id + "'),"
                        + " 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '" + flname + "')"
                        + " where 品牌名称='" + brandname + "'";

                     ret = objConn.ExecuteSQLForCount(str_update, true);
                    if (ret == 0)
                    {
                        string sql = "delete 品牌字典 where 品牌名称='" + brandname + "' and 是否启用=1 and scs_id='" + gys_id + "' and 分类编码='" + flname + "' and yh_id='" + yh_id + "'";
                        objConn.ExecuteSQL(sql, true);
                    }
                }
                else
                {
                    ret = 2;
                    Response.Write("该品牌已经存在，请重新填写!");
                }                             
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       <%if(ret!=0&&ret!=2) {%>
        <a style="color: Red" onclick="clickMe()">恭喜您，新增品牌成功，请返回; </a>
        <%}else if(ret==0){ %>
         <a style="color: Red" onclick="clickMe()">新增品牌失败，页面将跳转到主页！</a>
             
        <%} %>
        <script defer="defer" type="text/javascript">
            function doload()
            {
            <%if(source=="xzym") {%>
              window.close();
                opener.location.href="gyszym.aspx";
            <%} else {%>
                window.close();
                opener.location.reload();
                <%} %>
            }
            setTimeout("doload()", 2000);
        </script>
        <script type="text/javascript">
            function clickMe() {
                window.close();
                opener.location.reload();
            }
        </script>
        

    </body>
    </html>




