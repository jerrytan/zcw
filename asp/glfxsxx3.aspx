<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">


            public List<Option_gys> Items { get; set; }

            public class Option_gys
            {//属性
                public string gys_name { get; set; }       //供应商
                public string gys_address { get; set; }    //地址
                public string gys_tel { get; set; }        //电话
				public string gys_homepage { get; set; }   //主页
				public string gys_fax { get; set; }        //传真
                public string gys_area { get; set; }       //地区名称
                public string gys_user { get; set; }       //联系人
				public string gys_user_phone { get; set; }       //联系人手机 
                public string gys_id { get; set; }       //供应商id				
            }
		   protected DataTable dt_gysxx = new DataTable();	
		   protected void Page_Load(object sender, EventArgs e)
           {
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string fxs_id = Request["id"];   //获取下拉框传过来的分销商id

            String str_gysxx = "select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机,gys_id from 材料供应商信息表 where  gys_id='"+fxs_id+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
            dt_gysxx = ds_gysxx.Tables[0]; 
			
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			this.Items = new List<Option_gys>();  //数据表DataTable转集合  
			   for(int x=0;x<dt_gysxx.Rows.Count;x++)
               {
                  DataRow dr2 = dt_gysxx.Rows[x];              
                  
		          Option_gys item = new Option_gys();
				  
				  item.gys_name = Convert.ToString(dr2["供应商"]);   
                  item.gys_address = Convert.ToString(dr2["地址"]);
                  item.gys_tel = Convert.ToString(dr2["电话"]);
				  item.gys_homepage = Convert.ToString(dr2["主页"]);   
                  item.gys_fax = Convert.ToString(dr2["传真"]);
                  item.gys_area = Convert.ToString(dr2["地区名称"]);
				  item.gys_user = Convert.ToString(dr2["联系人"]);   
                  item.gys_user_phone = Convert.ToString(dr2["联系人手机"]);
				  item.gys_id = Convert.ToString(dr2["gys_id"]);
                 
                  this.Items.Add(item);                
			   }
			
			   string jsonStr = serializer.Serialize(Items); 
			   Response.Clear(); 
			   Response.Write(jsonStr);   //向前端glscsxx.aspx输出json字符串
			   Response.End();
			  }

</script>

