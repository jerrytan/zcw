
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
            String gys_id = Request["gys_id"];        

            //新增材料写入数据库
            {
                conn.Open(); 
                				
                string cl_name = Request["cl_name"];                //材料名称
                string cl_type = Request["cl_type"];                //规格型号              
                string cl_bit = Request["cl_bit"];                  //计量单位
                string cl_volumetric = Request["cl_volumetric"];        //单位体积
				string cl_height = Request["cl_height"];                //单位重量
                string cl_instruction = Request["cl_instruction"];      //说明       
                string brand = Request["brand"];                        //品牌id(获取的是下拉列表中value的值)
                
				
                string str_xzcl = "insert into  材料表(显示名,规格型号,计量单位,单位体积,单位重量,说明,是否启用,pp_id) "
				+"values('" + cl_name + "','"+cl_type+"','" + cl_bit + "','" + cl_volumetric + "', "
				+" '" + cl_height + "','"+cl_instruction+"','1','"+brand+"' ) ";          
                //更新材料表
				SqlCommand cmd_insert= new SqlCommand(str_xzcl, conn);
                cmd_insert.ExecuteNonQuery();	
			    
				//补全材料表信息
				string yjflname = Request["yjflname"];              //大级分类名称 (获取的是下拉列表中value的值 分类编码 两位)              
                string ejflname = Request["ejflname"];              //二级分类名称  (分类编码 4位)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				
				SqlDataAdapter ad_cl = new SqlDataAdapter ("select 分类名称,属性编码,编号 from 材料分类属性值表 where 分类编码='"+flname+"' ",conn);
				DataSet ds_cl = new  DataSet();
				DataTable dt_cl = new DataTable();
				ad_cl.Fill(ds_cl,"材料分类属性值表");
				dt_cl = ds_cl.Tables[0];
				string cl_clbm = Convert.ToString(dt_cl.Rows[0]["属性编码"]);  //材料编码
				string cl_clbh = Convert.ToString(dt_cl.Rows[0]["编号"]);      //材料编号
				string cl_clflname = Convert.ToString(dt_cl.Rows[0]["分类名称"]);      //分类名称
				
                string cl_update = "update 材料表 set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from 材料表 where 显示名='"+cl_name+"'),"
				+"fl_id = (select fl_id from 材料分类表 where 分类编码='"+flname+"'),"
				+"生产厂商 = (select 供应商 from 材料供应商信息表 where gys_id = '"+gys_id+"'),"
				+"材料编码 ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , 分类编码 = '"+flname+"', 分类名称='"+cl_clflname+"', "
				+"品牌名称=(select 品牌名称 from 品牌字典 where pp_id='"+brand+"' ) where 显示名='"+cl_name+"' ";
                SqlCommand cmd_update= new SqlCommand(cl_update, conn);
                int ret = (int)cmd_update.ExecuteNonQuery();	
				 
				
                conn.Close();    
            }	                    
		
     %>

    <body>
        <p>
        </p>             
        <a href="gysglcl.aspx" style="color: Blue" onclick="clickMe() ">新增材料成功!请返回; </a>
        <script>
            //function clickMe() 
			{
                //window.close();
                //opener.location.reload();
            }
        </script>
        

    </body>