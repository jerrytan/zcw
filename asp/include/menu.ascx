﻿
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<script runat="server" >

        public List<FLObject> Items1 { get; set; }
        public List<FLObject> Items2 { get; set; }
		public List<FLObject> Items3 { get; set; }

        protected DataTable dt = new DataTable(); //取一级分类名称前七条
        protected DataTable dt1 = new DataTable(); //取二级分类名称全部
		protected DataTable dt2 = new DataTable();  //取一级分类名称前七条之后的所有
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select top 7  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 ", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料分类表");           
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select distinct  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=4 ", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表");            
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 not in(select top 7 分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 )", conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "材料分类表");
            conn.Close();
            dt2 = ds2.Tables[0];

            ////数据表DataTable转集合                  
             this.Items1 = new List<FLObject>();
			 this.Items2 = new List<FLObject>();
			 this.Items3 = new List<FLObject>();
			 
             for(int x=0;x<dt.Rows.Count;x++)
              {
                  DataRow dr2 = dt.Rows[x];                   
                  
		         if (Convert.ToString(dr2["分类编码"]).Length ==2 ) 
		          {
 			        FLObject item = new FLObject();
                  	item.Name = Convert.ToString(dr2["显示名字"]);
                 	item.Sid = Convert.ToString(dr2["分类编码"]);
                  	this.Items1.Add(item);
                  }
			  }
			  for(int x=0;x<dt2.Rows.Count;x++)
              {
                  DataRow dr = dt2.Rows[x];                   
                  
		         if (Convert.ToString(dr["分类编码"]).Length ==2 ) 
		          {
 			        FLObject item = new FLObject();
                  	item.Name = Convert.ToString(dr["显示名字"]);
                 	item.Sid = Convert.ToString(dr["分类编码"]);
                  	this.Items3.Add(item);
                  }
			  }
			  for(int x=0;x<dt1.Rows.Count;x++)
              {
			     DataRow dr2 = dt1.Rows[x]; 
		         if(Convert.ToString(dr2["分类编码"]).Length==4) 
		          {
			        FLObject item = new FLObject();
                	item.Name = Convert.ToString(dr2["显示名字"]);
                	item.Sid = Convert.ToString(dr2["分类编码"]);
                	this.Items2.Add(item);					
		          }
              }               
		
        }

    public class FLObject
    { //属性
        public string Sid { get; set; }
        public string Name { get; set; }
        //public string Uid { get; set; }		
    }
   
</script>
<div class="dh">
 <ul id="myItem">
  <% foreach (var v in this.Items1){%>  
  <li>
<a href="yjfl.aspx?name=<%=v.Sid.ToString() %>"><%=v.Name%></a>
          <ul id="myItem">		  
     
     <%  foreach (var vr in this.Items2){				
          %>  
         <%if (vr.Sid.ToString().Substring(0, 2) == v.Sid.ToString())
           {%>   
          <li><a href="dls.aspx?name=<%=v.Sid %>"><%=vr.Name%></a></li>
		  
          <%} %>
      <% } %>    
          </ul>
        </li>

       <% } %>
	   
 <li><a href="#">更多</a>
          <ul>
		  <% foreach (var v1 in this.Items3){%>  
          <li><a href="yjfl.aspx?name=<%=v1.Sid.ToString() %>"><%=v1.Name%></a></li>
     
		  <% } %>
          </ul>
        </li>
	   
 </ul>
</li>
  



 
 </ul>
</div>

