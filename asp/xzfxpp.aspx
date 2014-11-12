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
<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">

        function updateFL(obj,id)
        {
            var ppidname;
            if (id.indexOf("|"))
            {
                ppidname = id.split("|");
            }
            var ppname = ppidname[1] == undefined ? "" : ppidname[1];
            var ppid = ppidname[0] == undefined ? "" : ppidname[0];
            document.getElementById("pp_id").value = ppid;
            document.getElementById("pp_name").value = ppname;
            var fxsid = document.getElementById("fxs_id").value;
            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    if (xmlhttp.responseText != "" && xmlhttp.responseText != undefined)
                    {
                        var ppxq = xmlhttp.responseText;
                        if (ppxq != "" && ppxq != undefined)
                        {
                            var value = ppxq.split("|");
                            document.getElementById("scs").innerHTML = value[0] == undefined ? "" : value[0];
                            document.getElementById("grade").innerHTML = value[1] == undefined ? "" : value[1];
                            document.getElementById("scope").innerHTML = value[2] == undefined ? "" : value[2];
                            document.getElementById("scsid").value = value[3] == undefined ? "" : value[3];
                        }
                    }
                }
            }
            var url = "xzfxpp3.aspx?ppid=" + ppid + "&ppname="+ppname+"&fxsid="+fxsid;
            xmlhttp.open("GET", url, true);
            xmlhttp.send(); 
        }
    </script>
</head>
<body>
<script runat="server">

        protected DataTable dt_ppxx = new DataTable();   //品牌字典
		protected string gys_id="";
        protected string s_yh_id="";
        public DataConn objConn=new DataConn();
        public DataTable dt_clfl=new DataTable();
        public string s_dwlx="";
        public string source1 = "";
        public DataTable dt_scs = new DataTable();  //生产商
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
            this.fxs_id.Value = gys_id;
            if (Request["source"] != null && Request["source"].ToString() != "")
            {
                source1 = Request["source"].ToString();
            }
            this.source.Value = source1;
             string sSQL="";
             sSQL = "select pp_id,品牌名称,生产厂商ID from 分销商和品牌对应关系表 where fxs_id='"+gys_id+"' and isnull(是否启用,'')<>'1'";
             dt_ppxx = objConn.GetDataTable(sSQL);          
         }

</script>

    <center>

        <form action="xzfxpp2.aspx" method="post">
        <input type="hidden" id="scsid" />
           <input type="hidden" id="pp_id" />
           <input type="hidden"  runat="server" id="fxs_id" />
              <input type="hidden" id="pp_name" />
            <div id="myDiv"></div>
            <table border="0" width="600px">
            <tr>
               <td height="34" colspan="2" align="center" bgcolor="#cadbff"><strong>增加新分销品牌</strong></td>
                  </tr>
                     
                <tr>
                    <td style="width: 120px; color:Black">品牌名称：
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this,this.options[this.options.selectedIndex].value)">
                        <option value='-1'>请选择品牌</option>
                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {
                                Response.Write("<option value='"+dt_ppxx.Rows[i]["pp_id"]+"|"+dt_ppxx.Rows[i]["品牌名称"]+"'>"+dt_ppxx.Rows[i]["品牌名称"]+"</option>");
                            }%>
                        </select>
                    </td>
                </tr>

                 <tr>
                    <td style="width: 120px; color: Black">生产商：
                    </td>
                    <td align="left">
                        <div id="scs"> </div>
                    </td>
                </tr>
            
                <tr>
                    <td style="width: 120px; color: Black">等级：
                    </td>
                    <td align="left">
                        <div id="grade"></div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Black">范围：
                    </td>
                    <td align="left">
                        <div id="scope"></div>
                    </td>
                </tr>              
                <tr>
                    <td>
                    <input  type="hidden" runat="server" id="source"/>
                        <input type="hidden" id="lx" name="lx" value="<%=s_dwlx %>"  />
                    </td>
                    <td align="left">
                    <input type="submit" id="send" value="保存"style="width:86px; background-color:#cadbff" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" id="close" value="关闭" onclick="window.close();" 
                            style="width: 80px;background-color:#cadbff" />
                    </td>
                </tr>
            </table>
         
        </form>
    </center>
</body>
</html>
