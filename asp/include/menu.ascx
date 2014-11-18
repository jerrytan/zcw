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

        protected string str_Sql1Top7 ="";  //首页导航sql
             
        protected void Page_Load(object sender, EventArgs e)
        {
          Object session_GYS= Session["GYS_YH_ID"]; //供应商
          Object session_CGS=Session["CGS_YH_ID"];//采购商
          string yh_id="";//会员id

          if(session_GYS!=null)
          {
            yh_id=Session["GYS_YH_ID"].ToString();         
           
          }
          if(session_CGS!=null)
          {
            yh_id=Session["CGS_YH_ID"].ToString(); 
          }

           string sqlType="select 用户关注类别 from 用户表 where yh_id="+yh_id; //获得用户关注的类别
           string typeStr=dc.DBLook(sqlType); 
           if(typeStr!="")//用户选择了关注类别
           {
             string sqlnav ="select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in(" + typeStr + ")";
             DataTable dt_sqlNav=dc.GetDataTable(sqlnav);
             if(dt_sqlNav.Rows.Count>=7)  //关注类别大于7个时
             {
               str_Sql1Top7 ="select top 7 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in(" + typeStr + ") order by 分类编码 desc";
             }
             else  //关注类别少于7个时
             {
               str_Sql1Top7 ="select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in(" + typeStr + ") order by 分类编码 desc";           
             }
           } 

           else //没有选择关注的类别时显示默认
           {
            str_Sql1Top7 = "select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in (08,07,02,04,05,01,06) order by 分类编码 desc";
           } 
            //暂时只显示人工挑选的7个，12-10 add by 谭中意         
			string str_Sql2All = "select distinct  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=4 ";
			string str_1After7 = "select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 not in(08,07,02,04,05,01,06 )";
            
            dt_1Top7 = dc.GetDataTable(str_Sql1Top7);
            dt_2All = dc.GetDataTable(str_Sql2All);
            dt_1After7 = dc.GetDataTable(str_1After7);
            
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

            if(this.Items1.Count<7)//如果用户关注的类别少于7个
            {
              string sqlOther="select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 not in(" + typeStr + ") and 分类编码 in(08,07,02,04,05,01,06) order by 分类编码 desc";
              DataTable dt_sqlOther=dc.GetDataTable(sqlOther);
              for(int x=0;x<dt_sqlOther.Rows.Count;x++)
                {
                    DataRow dr2 = dt_sqlOther.Rows[x]; 
		            if (Convert.ToString(dr2["分类编码"]).Length ==2&&this.Items1.Count<7) 
		            {
 			            FLObject item = new FLObject();
                        item.Name = Convert.ToString(dr2["显示名字"]);
                        item.Sid = Convert.ToString(dr2["分类编码"]);
                        this.Items1.Add(item);
                    }
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
       <li style="height:40px; line-height:40px;"><a href="yjfl.aspx?name=<%=v.Sid.ToString() %>"><%=v.Name.Length>7 ? v.Name.Substring(0,7):v.Name%></a>
            <ul style="left: -60px; width: 152px;">  
               <%int count=0;%>         
                <%  foreach (var vr in this.Items2){				
                %>               
                <%if (vr.Sid.ToString().Substring(0, 2) == v.Sid.ToString()) {%>
                <%count=count+1; %>
                <%if(count<=10){ %>
                  <li><a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a></li>
                <%} %>
               <% else{
                break;
                }}} %>
            </ul>
        </li>

        <% } %>
        <li style="height:40px; line-height:40px; width:60px"><a href="gdfl.aspx">更多</a>
            <%--<ul style="left: -677px;">
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
            </ul>--%>

        </li>
    </ul>
</div>














