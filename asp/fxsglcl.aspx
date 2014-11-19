<!--
       供应商管理材料页面 可以删除选中的材料文件名:  gysglcl.aspx   
       传入参数：s_yh_id 用户id 
       author:张新颖 新增分销商管理材料页面 
      
-->
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>
<%@ Page Language="C#"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>分销商管理材料页面</title>
    <META content="IE=10.000" http-equiv="X-UA-Compatible">
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/gysglcl.js" type="text/javascript"></script>
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script> 
 
   <%-- 点击左侧列表数，右侧填值--%>
    <script type="text/javascript">
        function lbs(obj,ppid,ppmc,scs)
        {
            var h = obj.parentNode.parentNode;
            var a = h.getElementsByTagName("a");
            for (var i = 0; i < a.length; i++)
            {
                a[i].style.color = "#707070";
            }
            obj.style.color = "#4876FF";
            document.getElementById("ppid").value = ppid;
            document.getElementById("ppmc").value = ppmc;
            document.getElementById("scsid").value = scs;
            var fxs_id = document.getElementById("fxsid").value;
//            var xmlhttp;
//            if (window.XMLHttpRequest)
//            {// code for IE7+, Firefox, Chrome, Opera, Safari
//                xmlhttp = new XMLHttpRequest();
//            }
//            else
//            {// code for IE6, IE5
//                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//            }
//            xmlhttp.onreadystatechange = function ()
//            {
//                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//                {
//                    $("#table4").empty();
//                    $("#table4").append(xmlhttp.responseText);
//                }
//            }
            var url = "fxsglclcl.aspx?ppid=" + ppid + "&ppmc=" + ppmc + "&scs=" + scs + "&fxs_id=" + fxs_id;
            document.getElementById("frame1").src = url;
//            xmlhttp.open("GET", url, true);
//            xmlhttp.send();
        }
    </script>
 
</head>
<body>
    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <script runat="server">
        protected string gys_id = "";
        public DataTable dt_gys = new DataTable();
        public DataConn objConn = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
            {
                gys_id = Request["gys_id"].ToString();
            }
            this.fxsid.Value = gys_id;          
        }      
        
    </script>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="scsid" />
    <input type="hidden" runat="server" id="ppid" />
    <input type="hidden" runat="server" id="ppmc" />
    <input type="hidden" runat="server" id="fxsid" />
    <DIV class="dlqqz5" style="border:1px solid #4ea6ee; padding-top:10px; margin-bottom:10px; ">
     <div id="menu2">
     <div class="dlqqz1_2" style="margin-left:10px;">您的生产商品牌列表</div>
     <%if (gys_id != "") %>
     <%{ %>
         <%string sSQL = ""; %>
         <% sSQL = "select  distinct a.gys_id as 生产商Id,a.供应商 as 生产商 from 材料供应商信息表 a left join (select * from  品牌字典  where pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='" + gys_id + "'))b on a.gys_id=b.scs_id where pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='" + gys_id + "'  and isnull(是否启用,'')='1')";%>
         <% dt_gys = objConn.GetDataTable(sSQL); %>
         <%if (dt_gys != null && dt_gys.Rows.Count > 0) %>
         <%{ %>
             <%int   firstlevel = 0; %>
             <%foreach (DataRow drgys in dt_gys.Rows)%>
             <% {%>
                   <%sSQL = ""; %>
                   <%sSQL = "select 品牌名称,pp_id from 品牌字典 where scs_id='" + drgys["生产商Id"] + "' and pp_id in (select pp_id from 分销商和品牌对应关系表  where fxs_id='" + gys_id + "'  and isnull(是否启用,'')='1')"; %>
                   <%DataTable dtpp = new DataTable(); %>
                   <%dtpp = objConn.GetDataTable(sSQL); %>
                   <%if (dtpp != null && dtpp.Rows.Count > 0) %>
                   <%{ %>
                        <% int secondlevel = 0; %>
                        <h1 onClick="javascript:ShowMenu(this,<%=firstlevel %>)">
                            <a href="javascript:void(0)"><img src="images/biao2.jpg" alt="" /> <%=drgys["生产商"]%></a></h1>                                   
                                    <span class="no">
                        <%foreach (DataRow drpp in dtpp.Rows) %>
                        <%{ %>
                             <h2><a href="javascript:void(0)" onclick="lbs(this,'<%=drpp["pp_id"] %>','<%=drpp["品牌名称"]%>','<%=drgys["生产商Id"]%>')"><%=drpp["品牌名称"]%></a></h2>
                               <ul class="no"></ul>
                        <%} %>
                        </span>
                   <%} %>
                   <%else %>
                   <%{ %>
                    <h1><a href="javascript:void(0)" ><%=drgys["生产商"]%></a></h1>
                                <span class="no"></span>
                   <%} %>
                   <%firstlevel++; %>
             <% } %>
         <%} %>
     <%} %>
     <%else %>
     <%{ %>
     <%} %>
     </div>

     <div id="cgs_lb" style="width:755px; margin-left:232px;">
        <iframe id="frame1" src="fxsglclcl.aspx?fxs_id=<%=gys_id %>" frameborder="0" marginheight="0"  style=" width:100%; height:450px; padding:0px; margin:0px; border:0px; " > 
       </iframe> 
</div>
     </DIV>
    </form>
</body>
</html>
