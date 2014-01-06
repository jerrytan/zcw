<!--   
      文件名:xzclymSX2.aspx
      传入参数: id (分类属性id)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
    
           	public class Option_SXZ
            {//属性
                public string SXZ_name { get; set; }  //属性值
                public string SXZ_id { get; set; }    //属性值id
                public string SXZ_code { get; set; }  //编号
            }
			public List<Option_SXZ> Items { get; set; }
		    protected void Page_Load(object sender, EventArgs e)
            {
               String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
               SqlConnection conn = new SqlConnection(constr);

               string flsx_id = Request["id"];   //获取分类名称传过来的分类id 
               //先根据传过来的flsx_id 查出分类编码			
               SqlDataAdapter da_flsxid = new SqlDataAdapter("select 分类编码 from 材料分类属性值表 where flsx_id='"+flsx_id+"'",conn);    //分类 属性
			   DataSet ds_flsxid = new DataSet();
			   da_flsxid.Fill(ds_flsxid,"材料分类属性值表");
			   DataTable dt_flsxid = ds_flsxid.Tables[0];	
               string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["分类编码"]);	  //获取分类编码		
			
			   //以分类编码   和分类名称传过来的分类id 查询属性值 
			   SqlDataAdapter da_flsx_id = new SqlDataAdapter("select 编号,属性值,flsxz_id from 材料分类属性值表 where 是否启用=1 and 分类编码='"+clflsx_id+"' and flsx_id='"+flsx_id+"' order by 属性编码,编号",conn);    //分类 属性
			   DataSet ds_flsx_id = new DataSet();
			   da_flsx_id.Fill(ds_flsx_id,"材料分类属性值表");
			   DataTable dt_flsx_id = ds_flsx_id.Tables[0];
			
			   System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			   this.Items = new List<Option_SXZ>();  //数据表DataTable转集合  
			   for(int x=0;x<dt_flsx_id.Rows.Count;x++)
               {
                  DataRow dr2 = dt_flsx_id.Rows[x];              
                  
		          Option_SXZ item = new Option_SXZ();
				  item.SXZ_name = Convert.ToString(dr2["属性值"]);   //将属性值存入集合
                  item.SXZ_code = Convert.ToString(dr2["编号"]);
                  item.SXZ_id = Convert.ToString(dr2["flsxz_id"]);
                  this.Items.Add(item);                
			   }
			
			   string jsonStr = serializer.Serialize(Items); 
			   Response.Clear(); 
			   Response.Write(jsonStr);   //向前端xzclym.aspx输出json字符串
			   Response.End();
			
			
			   //Response.Write("<option value='0'>请选择属性值</option>");
               //foreach(System.Data.DataRow row in dt_flsx_id.Rows) 
               //{
                    //Response.Write("<option value='"+row["flsxz_id"]+"'>"+row["属性值"]+"</option>");
               //}
	
            }

</script>










	
			