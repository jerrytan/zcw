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
<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" />
    <script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-1.8.3.js" type="text/javascript"></script>
    
<script type="text/javascript" language="javascript">

    function updateFL(id) {
        if ($("#brandname").val() != null || $("#brandname").val() != "") {
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
                    $("#ej").empty();
                    document.getElementById("ej").innerHTML = xmlhttp.responseText;
                    // document.getElementById("ejflname").innerHTML = xmlhttp.responseText;

                }
            }
            xmlhttp.open("GET", "xzpp2.aspx?id=" + id, true);
            xmlhttp.send();
        } else {
            alert("请填写品牌名称！");
        }

        function ISQY(obj) {
            if (this.checked) {
                document.getElementById("Isqy").value = "1";
            }
            else {
                document.getElementById("Isqy").value = "0";
            }
        }
    }
</script>
    

</head>
<body>
    <script runat="server">

        protected DataTable dt_yjfl = new DataTable();   //材料分类大类
		protected String gys_id="";
        public DataConn objConn=new DataConn();
        public string source1="";
        public string pp_id = "";
        public string pp_mc = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            if(Request["gys_id"]!=null&&Request["gys_id"].ToString()!="")
            {
                gys_id = Request["gys_id"].ToString();
             }
            if (Request["pp_id"] != null && Request["pp_id"].ToString() != "")
            {
                pp_id = Request["pp_id"].ToString();
            }
            if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
            {
                pp_mc = Request["ppmc"].ToString();
            }
            this.ppid.Value = pp_id;               
            if (pp_id != "" && pp_mc != "")
            {
                this.bj.Value = "1";
                string sql = "";
                sql = "select 品牌名称,是否启用,范围,等级 from 品牌字典 where pp_id='" + pp_id + "' and 品牌名称='" + pp_mc + "' and scs_id='" + gys_id + "'";
               
                DataTable dt = objConn.GetDataTable(sql);
                if (dt!=null&&dt.Rows.Count>0)
                {
                    this.brandname.Value = dt.Rows[0]["品牌名称"].ToString();
                    this.grade.Value = dt.Rows[0]["等级"].ToString();
                    this.scope.Value = dt.Rows[0]["范围"].ToString();
                    if (dt.Rows[0]["是否启用"].ToString() == "1")
                    {
                        this.Checkbox1.Checked = true;
                        this.Isqy.Value = "1";
                    }
                    else
                    {
                        this.Checkbox1.Checked = false;
                        this.Isqy.Value = "0";
                    }
                    this.addpp.InnerText="修改品牌信息";
                }
            }
            
         }

    </script>
 
 <br />
 <br />

        <form action="xzpp3.aspx" method="post">   
        <input type="hidden" runat="server" id="bj" />        
        <input type="hidden" runat="server" id="ppid" />        
            <div style=" text-align:center;">
            <dd  style=" text-align:center; background-color:#cadbff; line-height:24px;"><strong id="addpp" runat="server">增加新品牌</strong></dd>
             <table border="0" width="400px" style=" text-align:center;">
             <br />
               <br />
             
                <tr>
                    <td style="color:Black;height:34px;">品牌名称：
                    </td>
                    <td align="left">
                        <input type="text" id="brandname" runat="server" name="brandname" value="" style="margin: 0px 10px 0px 0px; border: 1px solid Black; width: 198px; height: 20px; line-height: 20px; float: left; display: inline;"/>
                    </td>
                </tr>

                <tr>
                    <td style="color:Black;height:34px;">等级：
                    </td>
                    <td align="left">
                        <select name="grade" id="grade" runat="server" >
                            <option value="一等">一等</option>
                            <option value="二等">二等</option>
                            <option value="三等">三等</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td valign="top" style="color:Black;height:34px;">范围：
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" runat="server">
                            <option value="全国">全国</option>
                            <option value="地区">地区</option>                        
                        </select>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="color:Black;height:34px;">是否启用：
                    </td>
                    <td align="left">                       
                        <input type="checkbox" id="Checkbox1" onclick="ISQY(this)"  checked="checked" runat="server"/>
                    </td>
                </tr>
                <tr>
                    <td></td><td align="left" style="height:34px;">
                    <input  type="hidden" runat="server" id="source"/>
                        <input type="hidden" id="gys_id" name="gys_id" value="<%=gys_id %>" />
                       <input type="submit" name="filter" value="保存" id="send" class="filter" filter="" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" />&nbsp;&nbsp;&nbsp;&nbsp;
                         <input type="button" name="filter" value="关闭" id="close" class="filter" filter="" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;"onClick="window.close();" /> 
                    </td>
                </tr>
            </table>
            </div>
           
            <input type="hidden" runat="server" id="Isqy"  value="1"/>
        </form>
 
</body>
</html>







