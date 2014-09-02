<!--
          新增品牌  (生产商增加新的品牌)
		  文件名: xzpp.aspx              
		  传入参数gys_id
		  author:张新颖
         
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" />
<script type="text/javascript" language="javascript">

        function updateFL(id) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                    document.getElementById("ejflname").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "xzpp2.aspx?id=" + id, true);
            xmlhttp.send();
        }


    </script>
    

</head>
<body>


    <script runat="server">

        protected DataTable dt_yjfl = new DataTable();   //材料分类大类
		protected String gys_id="";
        public DataConn objConn=new DataConn();
        public string source1="";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
            {
                gys_id = Request["gys_id"].ToString();
             }
             if(Request["source"]!=null&&Request["source"].ToString()!="")
             {
                source1=Request["source"].ToString();
             }
             this.source.Value=source1;
               string sSQL="select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";
          
                dt_yjfl = objConn.GetDataTable(sSQL);
         }

    </script>

    

    <center>

        <form action="xzpp3.aspx" method="post">
            <div id="myDiv"></div>
            <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color:Black">一级分类名称：
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                           <option value="0">请选择一级分类</option>
                            <% foreach(System.Data.DataRow row in dt_yjfl.Rows){%>

                            <option value="<%=row["分类编码"] %>"><%=row["显示名字"]%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="width: 120px; color:Black">二级分类名称：
                    </td>
                    <td align="left">
                        <select id="ejflname" name="ejflname" style="width: 250px">
                            <option value="">请选择二级分类</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td style="color:Black">品牌名称：
                    </td>
                    <td align="left">
                        <input type="text" id="" name="brandname" value="" style="margin: 0px 10px 0px 0px; border: 1px solid Black; width: 198px; height: 20px; line-height: 20px; float: left; display: inline;"/>
                    </td>
                </tr>

                <tr>
                    <td style="color:Black">等级：
                    </td>
                    <td align="left">
                        <select name="grade" id="grade" >
                            <option value="一等">一等</option>
                            <option value="二等">二等</option>
                            <option value="三等">三等</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td valign="top" style="color:Black">范围：
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" >
                            <option value="全国">全国</option>
                            <option value="地区">地区</option>                        
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                    <input  type="hidden" runat="server" id="source"/>
                        <input type="hidden" id="gys_id" name="gys_id" value="<%=gys_id %>" />
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







