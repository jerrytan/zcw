   <!--
        十大产品，用于头部
        文件名：top10product.ascx
        传入参数：无
        owner:丁传宇
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
<script runat="server">

        protected DataTable dt_Top10cp = new DataTable();//十大产品表
        protected DataConn dc = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        { 
            string str_Sql = "select top 10 显示名,cl_id,材料编码,fl_id,分类编码 from 材料表 where 是否启用=1 order by 访问计数 desc ";
		    dt_Top10cp = dc.GetDataTable(str_Sql);
        }	
		
        
</script>

<div class="gz">
    <div class="wz">
        <ul>

            <% foreach(System.Data.DataRow row in dt_Top10cp.Rows){%>
            <%
            string strs=row["显示名"].ToString();
             StringBuilder sb=new StringBuilder();
            int temp = 0;
            for (int i = 0; i < strs.Length; i++)
            {
                if ((int)strs[i]>127 && temp < 22)
                {
                    sb.Append(strs[i]);
                    temp = temp + 2;
                }
                else if ((int)strs[i]<127 && temp < 22)
                {
                    sb.Append(strs[i]);
                    temp = temp + 1;
                }
                else
                {
                    break;
                }
            }

             %>
            <li><a style="margin-left:5px; width:165px;" href="clxx.aspx?cl_id=<%=row["cl_id"]%> " class="leftToptitle" title="<%=row["显示名"].ToString() %>"  ><%=sb.ToString() %></a></li>
            <% } %>
        </ul>
    </div>
    
</div>
