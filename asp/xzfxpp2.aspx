
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
         

            //新增分销品牌写入数据库
            {
                conn.Open(); 
                string fxs_id = Request["fxs_id"]; 		
                string pp_id = Request["pp_id"];		
                string pp_name = Request["pp_name"];
   
    		 
                string str_insert = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id) values('"+ pp_id + "','"+pp_name+"', 1,'"+fxs_id+"','" +yh_id+"' ) ";
            
                //Response.Write(str_insert);
				SqlCommand cmd_insert= new SqlCommand(str_insert, conn);
                cmd_insert.ExecuteNonQuery();	
			
                conn.Close();    
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





