<!--   
      文件名:xzclymSX.aspx
      传入参数: id (二级分类编码)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
    
           	public class Option_SX
            {
                public string SX_name { get; set; }
                public string SX_id { get; set; }
                public string SX_code { get; set; }
            }
       	    public List<Option_SX> Items { get; set; }
           protected void Page_Load(object sender, EventArgs e)
           {  
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string ejfl_id = Request["id"];   //获取小类穿过来的分类编码        
			
			
			SqlDataAdapter da_flsx = new SqlDataAdapter("select distinct 属性编码,属性名称,flsx_id "
			+"from 材料分类属性值表 where 是否启用=1 and 分类编码='"+ejfl_id+"' and flsx_id in(select flsx_id "
			+"from 材料分类属性表 where 是否启用=1 and 分类编码='"+ejfl_id+"') order by 属性编码",conn);    //分类 属性
			DataSet ds_flsx = new DataSet();
			da_flsx.Fill(ds_flsx,"材料分类属性值表");
			DataTable dt_flsx = ds_flsx.Tables[0];
			
		
			System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			this.Items = new List<Option_SX>();  //数据表DataTable转集合  
			for(int x=0;x<dt_flsx.Rows.Count;x++)
            {
                 DataRow dr2 = dt_flsx.Rows[x];              
                  
		         Option_SX item = new Option_SX();
				 item.SX_name = Convert.ToString(dr2["属性名称"]);   //将属性名称存入集合
                 item.SX_code = Convert.ToString(dr2["属性编码"]);
                 item.SX_id = Convert.ToString(dr2["flsx_id"]);
                 this.Items.Add(item);                
			}
			
			string jsonStr = serializer.Serialize(Items); 
			Response.Clear(); 
			Response.Write(jsonStr);   //向前端xzclym.aspx输出json字符串
			Response.End();
			
		
			
		
			//Response.Write("<option value='0'>请选择属性名称</option>");
            //foreach(System.Data.DataRow row in dt_flsx.Rows) 
            //{
                //Response.Write("<option value='"+row["flsx_id"]+"'>"+row["属性名称"]+"</option>");
			    
            //}
			
    }
</script>