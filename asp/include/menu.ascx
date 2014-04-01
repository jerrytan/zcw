<!--
        材料分类的导航，用于头部
        文件名：menu.ascx
        传入参数：无
        owner:丁传宇
        
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">

        public List<FLObject> Items1 { get; set; }
        public List<FLObject> Items2 { get; set; }
		public List<FLObject> Items3 { get; set; }

        protected DataTable dt_1Top7 = new DataTable(); //取一级分类名称前七条
        protected DataTable dt_2All = new DataTable(); //取二级分类名称全部
		protected DataTable dt_1After7 = new DataTable();  //取一级分类名称前七条之后的所有
        protected DataConn dc = new DataConn();

        protected void Page_Load(object sender, EventArgs e)
        {

            //暂时只显示人工挑选的7个，12-10 add by 谭中意
            string str_Sql1Top7 = "select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in (08,07,02,04,05,01,06) order by 分类编码 desc";
			string str_Sql2All = "select distinct  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=4 ";
			string str_1After7 = "select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 not in(08,07,02,04,05,01,06 )";
            
            dt_1Top7 = dc.GetDataTable(str_Sql1Top7);
            dt_2All = dc.GetDataTable(str_Sql2All);
            dt_1Top7 = dc.GetDataTable(str_Sql1Top7);

            
            ////数据表DataTable转集合                  
            this.Items1 = new List<FLObject>();
			this.Items2 = new List<FLObject>();
			this.Items3 = new List<FLObject>();
			 
            for(int x=0;x<dt_1Top7.Rows.Count;x++)
            {
                DataRow dr2 = dt_1Top7.Rows[x];                   
                  
		        if (Convert.ToString(dr2["分类编码"]).Length ==2 ) 
		        {
 			        FLObject item = new FLObject();
                    item.Name = Convert.ToString(dr2["显示名字"]);
                    item.Sid = Convert.ToString(dr2["分类编码"]);
                    this.Items1.Add(item);
                }
			}
			for(int x=0;x<dt_1After7.Rows.Count;x++)
            {
                DataRow dr = dt_1After7.Rows[x];                   
                  
		        if (Convert.ToString(dr["分类编码"]).Length ==2 ) 
		        {
 			        FLObject item = new FLObject();
                    item.Name = Convert.ToString(dr["显示名字"]);
                    item.Sid = Convert.ToString(dr["分类编码"]);
                    this.Items3.Add(item);
                }
			}
			for(int x=0;x<dt_2All.Rows.Count;x++)
            {
			    DataRow dr2 = dt_2All.Rows[x]; 
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
    <ul>
        <% foreach (var v in this.Items1){%>
        <li><a href="yjfl.aspx?name=<%=v.Sid.ToString() %>"><%=v.Name%></a>
            <ul style="left: -39px; width: 152px;">  
               <%int count=0;%>         
                <%  foreach (var vr in this.Items2){				
                %>               
                <%if (vr.Sid.ToString().Substring(0, 2) == v.Sid.ToString()) {%>
                <%count=count+1; %>
                <%if(count<=5){ %>
                  <li><a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a></li>
                <%} %>
                <%else{%>
                <%break; %>
                <%} %>
                <%} %>
              
                <%} %>
            </ul>
        </li>

        <% } %>


        <li><a href="#">更多</a>

            <ul style="left: -677px;">
                <li></li>
                <li></li>
                <% foreach (var v1 in this.Items3){%>
                <li><a class="hide" href="yjfl.aspx?name=<%=v1.Sid.ToString() %>" style="background: url(images/dh_04.jpg); color: #FFF"><%=v1.Name%></a>
                    <ul style="left: -11px;">
                        <%  foreach (var vr in this.Items2){				
                        %>
                        <%if (vr.Sid.ToString().Substring(0, 2) == v1.Sid.ToString())
           {%>
                        <li><a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a></li>
                        <%} %>
                        <% } %>
                    </ul>
                </li>
                <% } %>
            </ul>

        </li>
    </ul>
</div>















