<!--
          新增分销品牌  (分销商增加分销新的品牌)
		  文件名: xzfxpp.aspx              
		  传入参数gys_id	  
         author:张新颖
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">

        protected DataTable dt_ppxx = new DataTable();   //品牌字典
		protected string gys_id="";
        protected string s_yh_id="";
        public DataConn objConn=new DataConn();
        public DataTable dt_clfl=new DataTable();
        public string s_dwlx="";
        protected void Page_Load(object sender, EventArgs e)
        {
            if( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
            {
                 gys_id = Request["gys_id"].ToString();
            }
            if(Session["GYS_YH_ID"]!=null&&Session["GYS_YH_ID"].ToString()!="")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }

             string sSQL="";
            
             sSQL = "select 单位类型 ,gys_id from  材料供应商信息表 where yh_id='" + s_yh_id + "' ";  //查询单位类型
              DataTable dt_type = objConn.GetDataTable(sSQL);
            if (dt_type != null && dt_type.Rows.Count > 0)
            {
                s_dwlx = dt_type.Rows[0]["单位类型"].ToString();
            }
             sSQL="select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 ";          
            dt_ppxx = objConn.GetDataTable(sSQL);
          sSQL="select 分类编码,显示名字 from 材料分类表 where 是否启用=1";
          dt_clfl=objConn.GetDataTable(sSQL);
         }

</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">

        function updateFL(id) {

            var scs_array = new Array();
            var scs_id_array = new Array();
            var grade_array = new Array();
            var scope_array = new Array();
            var fl_id_array = new Array();
            var fl_name_array = new Array();
            var fl_code_array = new Array();
            var pp_id_array = new Array();
            var pp_name_array = new Array();

            <%
                for (int i=0;i<dt_ppxx.Rows.Count;i++)
                {
                    Response.Write("            scs_array["+i+"] = '"+dt_ppxx.Rows[i]["生产商"]+"';\n");
                    Response.Write("            scs_id_array["+i+"] = '"+dt_ppxx.Rows[i]["scs_id"]+"';\n");
                    Response.Write("            grade_array["+i+"] = '"+dt_ppxx.Rows[i]["等级"]+"';\n");
                    Response.Write("            scope_array["+i+"] = '"+dt_ppxx.Rows[i]["范围"]+"';\n");
                    Response.Write("            fl_id_array["+i+"] = '"+dt_ppxx.Rows[i]["fl_id"]+"';\n");
                    Response.Write("            pp_id_array["+i+"] = '"+dt_ppxx.Rows[i]["pp_id"]+"';\n");
                    Response.Write("            fl_name_array["+i+"] = '"+dt_ppxx.Rows[i]["分类名称"]+"';\n");
                    Response.Write("            fl_code_array["+i+"] = '"+dt_ppxx.Rows[i]["分类编码"]+"';\n");
                    Response.Write("            pp_name_array["+i+"] = '"+dt_ppxx.Rows[i]["品牌名称"]+"';\n");
                }
              
            %> 
            document.getElementById("scs").innerHTML = scs_array[id];
            document.getElementById("fl_name").innerHTML = fl_name_array[id];
            document.getElementById("grade").innerHTML = grade_array[id];
            document.getElementById("scope").innerHTML = scope_array[id];

            document.getElementById("pp_id").value = pp_id_array[id];
            document.getElementById("pp_name").value = pp_name_array[id];
        }


    </script>
</head>
<body>

    <center>

        <form action="xzfxpp2.aspx" method="post">
            <div id="myDiv"></div>
            <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">品牌名称：
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">

                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {
                                Response.Write("<option value='"+i+"'>"+dt_ppxx.Rows[i]["品牌名称"]+"</option>");
                            }%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="width: 120px; color: Blue">生产商：
                    </td>
                    <td align="left">
                        <div id="scs"><%=dt_ppxx.Rows[0]["生产商"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">等级：
                    </td>
                    <td align="left">
                        <div id="grade"><%=dt_ppxx.Rows[0]["等级"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">范围：
                    </td>
                    <td align="left">
                        <div id="scope"><%=dt_ppxx.Rows[0]["范围"] %>  </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">分类：
                    </td>
                    <td align="left">
                        <div id="fl_name"> <%=dt_ppxx.Rows[0]["分类名称"] %> </div>
                    </td>
                </tr>

                

                <tr>
                    <td>
                        <input type="hidden" id="lx" name="lx" value="<%=s_dwlx %>"  />
                        <input type="hidden" id="fxs_id" name="fxs_id" value="<%=gys_id %>" />
                        <input type="hidden" id="pp_id" name="pp_id" value="<%=dt_ppxx.Rows[0]["pp_id"] %> " />
                        <input type="hidden" id="pp_name" name="pp_name" value="<%=dt_ppxx.Rows[0]["品牌名称"] %> " />
                        <input type="submit" id="send" value="保存" style="width: 100px" />
                    </td>
                    <td align="left">
                        <input type="button" id="close" value="关闭" onclick="window.close();" style="width: 100px" />
                    </td>
                </tr>
            </table>
         
        </form>
    </center>
</body>
</html>







