﻿<!--
	热销产品， 首页使用
	文件名：rxcp.aspx
	传入参数：无
    owner:丁传宇
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">        
	
        protected DataTable dt_Cltp = new DataTable();   //材料名字,存放地址(材料多媒体信息表)  
        protected DataConn dc = new DataConn();      
        protected void Page_Load(object sender, EventArgs e)
        {	     
            string str_Sql = "select 存放地址,材料名称,cl_id from 材料多媒体信息表 where  是否上头条='是' and 媒体类型 = '图片' and cl_id in(select cl_id from 材料表 where 类型='主打')";         
            dt_Cltp = dc.GetDataTable(str_Sql);	
        }		

</script>



<div class="rxcp">
    <div class="rxcp1">
        <div class="rxcp2">
            <img src="images/biao_03.jpg" />热销产品</div>
        <span class="more"><a href="#">
            <img src="images/more_03.jpg" /></a></span></div>
    <div class="rxcp3">
        <div id="demo" style="overflow: hidden; width: 960px;">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td id="demo1" valign="top" align="center">
                        <table cellpadding="2" cellspacing="0" border="0" class="tu1">
						
                            <tr align="center">
                                <%
                                foreach(System.Data.DataRow row in this.dt_Cltp.Rows)
                                {
                                %>
                                <td>
                                    <div class="pii"><a  style="font-size:12px;width:180px;" href="clxx.aspx?cl_id=<%=row["cl_id"].ToString()%>" >
                                        <img src="<%=row["存放地址"].ToString() %>" width="167" height="159" /><%=row["材料名称"].ToString() %></a></div>
                                </td>
                                <%}%>

                            </tr>
							
                        </table>
                    </td>
                    <td id="demo2" valign="top"></td>
                </tr>
            </table>
        </div>
    </div>
</div>

