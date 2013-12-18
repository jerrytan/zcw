<!--
        十大厂商，用于头部
        文件名：top10manu.ascx
        传入参数：无        
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
        public List<Manufacturer> Items { get; set; }    
		public class Manufacturer
        {
            public string Gys_id { get; set; }
            public string Type { get; set; }
            public string Manufacturers { get; set; }
        }
        protected DataTable dt = new DataTable(); //最受关注的供应商(材料供应商信息表)	
        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                SqlConnection conn = new SqlConnection(constr);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter("select distinct top 10 供应商 ,gys_id,单位类型 from 材料供应商信息表 where 是否启用=1 order by gys_id", conn);
                DataSet ds = new DataSet();
                da.Fill(ds, "材料供应商信息表");
                conn.Close();
                dt = ds.Tables[0];
			
			    this.Items = new List<Manufacturer>();
                for (int x = 0; x < dt.Rows.Count; x++)
                {
                    DataRow dr = dt.Rows[x];
                    Manufacturer mf = new Manufacturer();
                    mf.Manufacturers = Convert.ToString(dr["供应商"]);
                    mf.Type = Convert.ToString(dr["单位类型"]);
                    mf.Gys_id = Convert.ToString(dr["gys_id"]);
                    this.Items.Add(mf);
                }
            }		
        }
</script>

<div class="gz1">
    <div class="wz1">
        <ul>
            <% foreach(var v  in  Items){%>

            
            <li><a href="gysxx.aspx?gys_id=<%=v.Gys_id%>"><%=v.Manufacturers %></a></li>

            <%} %>
           

        </ul>
    </div>
</div>
