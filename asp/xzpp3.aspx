
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);          
            String yh_id = Session["yh_id"].ToString();
         

            //新增品牌写入数据库
            {
                conn.Open(); 
                string gys_id = Request["gys_id"]; 				
                string brandname = Request["brandname"];            //品牌名称
                string yjflname = Request["yjflname"];              //大级分类名称               
                string ejflname = Request["ejflname"];              //二级分类名称
                string grade = Request.Form["grade"];               //等级
                string scope = Request["scope"];                    //范围       
                string flname = ejflname;
                if (flname.Equals("0"))  flname = yjflname;
               
                string str_insert = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围,yh_id) values('" + brandname + "',1,'"+gys_id+"','" + flname + "','" + grade + "','" + scope + "','"+yh_id+"' ) ";
            
                //Response.Write(sql);
				SqlCommand cmd_insert= new SqlCommand(str_insert, conn);
                cmd_insert.ExecuteNonQuery();	
			
                String str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='"+brandname+"'),"  
                    +" fl_id = (select fl_id from 材料分类表 where 分类编码='"+flname+"')," 
                    +" 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '"+gys_id+"'),"
                    +" 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '"+flname+"')"
                    +" where 品牌名称='"+brandname+"'";
                SqlCommand cmd_update= new SqlCommand(str_update, conn);
                int ret = (int)cmd_update.ExecuteNonQuery();	
				//Response.Write(str_update);
                conn.Close();

    
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">恭喜您，新增品牌成功，请返回; </a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





