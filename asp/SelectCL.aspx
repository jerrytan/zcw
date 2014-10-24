<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content="IE=11.0000" http-equiv="X-UA-Compatible">     
<META http-equiv="Content-Type" content="text/html; charset=utf-8">     
<TITLE>供应商产品列表</TITLE>     
<LINK href="css/css.css" rel="stylesheet" type="text/css">   
<LINK href="css/all of.css" rel="stylesheet" type="text/css">  
<link href="css/cllb.css" rel="stylesheet" type="text/css" />  
<META name="GENERATOR" content="MSHTML 11.00.9600.17239">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://malsup.github.io/jquery.form.js"></script>
<script type="text/javascript">
//列表数
     function ShowMenu(obj, n)
     {  
         var Nav = obj.parentNode;
         if (!Nav.id)
         {
             var BName = Nav.getElementsByTagName("ul");
             var HName = Nav.getElementsByTagName("h2");
             var t = 2;
         } else
         {
             var BName = document.getElementById(Nav.id).getElementsByTagName("span");
             var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
             var t = 1;
         }
         for (var i = 0; i < HName.length; i++)
         {
             HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
             HName[i].className = "";
         }
         obj.className = "h" + t;
         for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
         if (BName[n].className == "no")
         {
             BName[n].className = "";
             obj.innerHTML = obj.innerHTML.replace("+", "-");
         } else
         {
             BName[n].className = "no";
             obj.className = "";
             obj.innerHTML = obj.innerHTML.replace("-", "+");
         }
     }
 </script>

<script type="text/javascript">
    var value;
    //点击选择属性值
    function AddSXZ(obj,sxbm,bh,sxz)
    {      
        var td = obj.parentNode;
        var a = td.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.backgroundColor = "#FFFFFF";
            a[i].style.color = "#707070";
        }
        obj.style.backgroundColor = "#4876FF";
        obj.style.color = "#FFFFFF";
        var flbm_cl = document.getElementById("flbm").value;
        var tr = obj.parentNode.parentNode;
        var tds = tr.cells;
        tds[2].innerHTML = sxz;
        tds[3].innerHTML = sxbm+bh;
        var table = document.getElementById("sx");
        var tr = table.getElementsByTagName("tr");
        var ggxh = "";
        var clbh = flbm_cl;
        for (var i = 0; i < tr.length; i++)
        {        
            var tds = tr[i].cells;
            ggxh = ggxh + tr[i].cells[2].innerHTML;
            clbh +=  tr[i].cells[3].innerHTML;
        }
        document.getElementById("clbm").value = clbh;
        document.getElementById("clmcjgg").value = ggxh;
        document.getElementById("ggxh").value = document.getElementById("clmcjgg").value;
    }
    //将组合的属性属性值 和对应材料信息 添加到材料列表中
    function AddValue()
    {
        var html;   
       var table = document.getElementById("cl");
       var tr = table.getElementsByTagName("tr");
       var clbm= document.getElementById("clbm").value;
       var clm= document.getElementById("clmc").value;
       var ggjxh = document.getElementById("ggxh").value;
       var wd = document.getElementById("dw").value;
       var bh = tr.length;
       bh = bh + 1;
       if (ggjxh == "" || ggjxh==undefined)
       {
           alert("请重新选择规格");
           return;
       }
       var table = document.getElementById("cl");
       var tr = table.getElementsByTagName("tr");
       if (tr.length == 0)
       {
           html = "<tr>"
		    + " <td align='center' bgcolor='#FFFFFF'>" + bh + "</td>"
		    + " <td height='24' align='center' bgcolor='#FFFFFF'>" + clbm + "</td>"
		    + " <td align='left' bgcolor='#FFFFFF'>" + clm + "</td>"
		    + " <td bgcolor='#FFFFFF'>" + ggjxh + "</td>"
		    + " <td align='center' bgcolor='#FFFFFF'>" + wd + "</td>"
		    + " <td align='center' bgcolor='#FFFFFF'>&nbsp;</td>"
		    + " <td align='center' bgcolor='#FFFFFF'><input type='checkbox' name='checkbox' checked='checked' />"
		    + " <label for='checkbox11'></label></td>"
            + " </tr>";
           table.innerHTML = table.innerHTML + html;
       }
       else
       {
           var value;
           for (var i = 0; i < tr.length; i++)
           {
               if (value == "" || value == undefined)
               {
                   value = tr[i].cells[1].innerHTML + ",";
               }
               else
               {
                   value += tr[i].cells[1].innerHTML + ",";
               }
           }          
           if (value.indexOf(clbm) >= 0)
           {
               alert("材料重复！");
           }
           else
           {
               html = "<tr>"
		                + " <td align='center' bgcolor='#FFFFFF'>" + bh + "</td>"
		                + " <td height='24' align='center' bgcolor='#FFFFFF'>" + clbm + "</td>"
		                + " <td align='left' bgcolor='#FFFFFF'>" + clm + "</td>"
		                + " <td bgcolor='#FFFFFF'>" + ggjxh + "</td>"
		                + " <td align='center' bgcolor='#FFFFFF'>" + wd + "</td>"
		                + " <td align='center' bgcolor='#FFFFFF'>&nbsp;</td>"
		                + " <td align='center' bgcolor='#FFFFFF'><input type='checkbox' name='checkbox' checked='checked' />"
		                + " <label for='checkbox11'></label></td>"
                        + " </tr>";
               table.innerHTML = table.innerHTML + html;
           }
       } 
    }
</script>
<script type="text/javascript">
//点击左侧列表数
    function lbs(obj,flbm,mc,dw)
    {
        var h = obj.parentNode.parentNode;
        var a = h.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.color = "#707070";
        }
        obj.style.color = "#4876FF";
        document.getElementById("ggxh").value = "";
        document.getElementById("clmcjgg").value = "";
        document.getElementById("flbm").value = flbm;
        document.getElementById("clmc").value = mc;
        document.getElementById("dw").value = dw;
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
                document.getElementById("sx").innerHTML = xmlhttp.responseText;
            }
        }
        var url = "sxzclall.aspx?flbm=" + flbm;
        xmlhttp.open("GET",url, true);
        xmlhttp.send();
    }
    //提交
    function btnFilter_Click(obj)
    {
        var Value = "";
        var table = document.getElementById(obj);
        var chks = table.getElementsByTagName("input");
        var SQL = "";
       
        for (var i = 0; i < chks.length; i++)
        {           
            if (chks[i].type == "checkbox" && chks[i].checked)
            {
                var tr = chks[i].parentNode.parentNode;
                
                if (value != "" && value != undefined)
                {
                    value += tr.cells[1].innerHTML + "◆" + tr.cells[2].innerHTML + "◆" + tr.cells[3].innerHTML + "◆" +
                    tr.cells[4].innerHTML + "◆" + tr.cells[5].innerHTML + "▼";
                }
                else
                {
                    value = tr.cells[1].innerHTML + "◆" + tr.cells[2].innerHTML + "◆" + tr.cells[3].innerHTML + "◆" +
                    tr.cells[4].innerHTML + "◆" + tr.cells[5].innerHTML + "▼";
                }              
            }
        }
        if (value == "" || value == undefined)
        {
            alert("没有需要提交的内容，请重新选择");
            return;
        }
       
        document.getElementById("HTML").value = value;        
       
    }
    function saveReport()
    {
        // jquery 表单提交
        $("#form1").ajaxSubmit(function (message)
        {
            // 对于表单提交成功后处理，message为提交页面saveReport.htm的返回内容 
            if (message == "1")
            {
                alert("提交成功");
                //  $("#cl").empty();
                //关闭
                window.opener = null;
                window.open("", "_self");
                window.close(); 
            }
            else
            {
                alert("提交失败");
            }
        });
        return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转 
    }    
</script>
<%--FL--%>
<script type="text/javascript">
    function FL()
    {
        document.getElementById("menu_lb").style.display = "block";
        document.getElementById("menu_lb1").style.display = "none";
        document.getElementById("sccl").style.display = "none";
        document.getElementById("allcl").style.display = "block";
        document.getElementById("sx").innerHTML = "";
        document.getElementById("Li1").style.backgroundColor = "#7dbdf2";
        document.getElementById("Li2").style.backgroundColor = "#fff";

    }
    function FL1()
    {
        document.getElementById("allcl").style.display = "none";
        document.getElementById("sccl").style.display = "block";
        document.getElementById("menu_lb").style.display = "none";
        document.getElementById("menu_lb1").style.display = "block";
        document.getElementById("scclxq").innerHTML = "";
        document.getElementById("ggxh").value = "";
        document.getElementById("clmcjgg").value = "";
        document.getElementById("Li1").style.backgroundColor = "#fff";
        document.getElementById("Li2").style.backgroundColor = "#7dbdf2";

    }
</script>
<%--收藏材料--%>
<script type="text/javascript">
    function sccl(obj, flbm)
    {
        var h = obj.parentNode.parentNode;
        var a = h.getElementsByTagName("a");
        for (var i = 0; i < a.length; i++)
        {
            a[i].style.color = "#707070";
        }
        obj.style.color = "#4876FF";
    var dw_id=document.getElementById("DW_ID").value;
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
               document.getElementById("scclxq").innerHTML=xmlhttp.responseText;
            }
        }
       var url = "dwsccl.aspx?flbm=" + flbm + "&DWID=" + dw_id;
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }
    //确定
    function qd_Click()
    {
        var Html = "";
        var tablesc = document.getElementById("scclxq");
        var chks = tablesc.getElementsByTagName("input");
        var bh;
        bh = 0;
        var table = document.getElementById("cl");
        var tr = table.getElementsByTagName("tr");
        if (tr.length == 0)
        {
            for (var i = 0; i < chks.length; i++)
            {
                if (chks[i].type == "checkbox" && chks[i].checked)
                {
                    bh++;
                    var trck = chks[i].parentNode.parentNode;
                    html = "<tr>"
		            + " <td align='center' bgcolor='#FFFFFF'>" + bh + "</td>"
		            + " <td height='24' align='center' bgcolor='#FFFFFF'>" + trck.cells[1].innerHTML + "</td>"
		            + " <td align='left' bgcolor='#FFFFFF'>" + trck.cells[2].innerHTML + "</td>"
		            + " <td bgcolor='#FFFFFF'>" + trck.cells[3].innerHTML + "</td>"
		            + " <td align='center' bgcolor='#FFFFFF'>" + trck.cells[4].innerHTML + "</td>"
		            + " <td align='center' bgcolor='#FFFFFF'>" + trck.cells[5].innerHTML + "</td>"
		            + " <td align='center' bgcolor='#FFFFFF'><input type='checkbox' name='checkbox'checked='checked'  />"
		            + " <label for='checkbox11'></label></td>"
                    + " </tr>";
                    table.innerHTML = table.innerHTML + html;
                }
            }
        }
        else
        {
            bh = tr.length;
            var value;
            var pp;
            for (var i = 0; i < tr.length; i++)
            {
                if (value == "" || value == undefined)
                {
                    value = tr[i].cells[1].innerHTML + ",";
                }
                else
                {
                    value += tr[i].cells[1].innerHTML + ",";
                }
                if (pp == "" || pp == undefined)
                {
                    pp = tr[i].cells[5].innerHTML + ",";
                }
                else
                {
                    pp += tr[i].cells[5].innerHTML + ",";
                }
            }
            for (var i = 0; i < chks.length; i++)
            {
                if (chks[i].type == "checkbox" && chks[i].checked)
                {

                    var trck = chks[i].parentNode.parentNode;
                    if (value.indexOf(trck.cells[1].innerHTML) >= 0 && pp.indexOf(trck.cells[5].innerHTML) >= 0)
                    {
                        alert("材料编码为：" + trck.cells[1].innerHTML + " 品牌名称为：" + trck.cells[5].innerHTML + " 的材料已存在！")
                    }
                    else
                    {
                        bh++;
                        var tr = chks[i].parentNode.parentNode;
                        html = "<tr>"
		                    + " <td align='center' bgcolor='#FFFFFF'>" + bh + "</td>"
		                    + " <td height='24' align='center' bgcolor='#FFFFFF'>" + trck.cells[1].innerHTML + "</td>"
		                    + " <td align='left' bgcolor='#FFFFFF'>" + trck.cells[2].innerHTML + "</td>"
		                    + " <td bgcolor='#FFFFFF'>" + trck.cells[3].innerHTML + "</td>"
		                    + " <td align='center' bgcolor='#FFFFFF'>" + trck.cells[4].innerHTML + "</td>"
		                    + " <td align='center' bgcolor='#FFFFFF'>" + trck.cells[5].innerHTML + "</td>"
		                    + " <td align='center' bgcolor='#FFFFFF'><input type='checkbox' name='checkbox'checked='checked'  />"
		                    + " <label for='checkbox11'></label></td>"
                            + " </tr>";
                        table.innerHTML = table.innerHTML + html;
                    }
                }
            }
        }

    }
</script>
</HEAD> 
<BODY> 
<form runat="server" id="form1"  action="creathtml.aspx" method="post" onsubmit="return saveReport();">
<script runat="server">
public DataTable dt_sx = new DataTable();
public DataTable dt_sxz = new DataTable();
public string DWID = "";
public string DWLX = "";
protected void Page_Load(object sender, EventArgs e)
{ 
        string CompanyID = "";  //营业注册号
       
        if (Request["CompanyID"] != null && Request["CompanyID"].ToString() != "")
        {
            CompanyID= Request["CompanyID"].ToString();
        }
    //    CompanyID = "234657890";
        //验证 CompanyID
        bool b = false;

        string sSQL = "select cgs_id as id,单位类型 from 采购商基本信息 where 营业执照注册号='"+CompanyID+
            "' and 审批结果='通过'union select gys_id as id,单位类型 from 材料供应商信息表 where 营业执照注册号='"+CompanyID+"' and  审批结果='通过'";

        DataTable dt_yz = new DataTable();
        dt_yz = Conn(sSQL);
        if (dt_yz!=null&&dt_yz.Rows.Count>0)
        {
             DWID = dt_yz.Rows[0]["id"].ToString();
             DWLX = dt_yz.Rows[0]["单位类型"].ToString();
             b = true;
             this.DW_ID.Value = DWID;
        }
        if (!b)
        {
            //地址为超链接
            Response.Write("<script" + ">" + "alert('贵公司未在众材网(www.zhcnet.cn)成功注册，此功能禁用！');window.location.href='http://www.zhcnet.cn';" + "</" + "script>");
        }
        else
        {
            this.wjj.Value = CompanyID;
            if (Request["HtmlMC"] != null && Request["HtmlMC"].ToString() != "")
            {
                this.htmlmc.Value = Request["HtmlMC"].ToString();
            }
        }
    
}     
public DataTable Conn(string sql)
{
DataTable dt = new DataTable();
SqlConnection _con = new SqlConnection("server=192.168.1.32; database=mywt_mis_ZhongCaiWang01;uid=mywtadmin; pwd=admin");
using (SqlCommand _cmd = new SqlCommand(sql, _con))
{
    _con.Open();
    SqlDataAdapter sda = new SqlDataAdapter();
    sda.SelectCommand = _cmd;
    sda.Fill(dt);
    _con.Close();
}
return dt;
}

</script>
 <div class="lib_Menubox2">
<ul>
   <li id="Li1" onclick="FL()" style=" background-color:#7dbdf2;" ><a href="javascript:void(0)" >材料类别表</a></li>
   <li id="Li2" onclick="FL1()" style=" background-color:#fff;"  ><a href="javascript:void(0)">收藏材料类别表</a></li>
</ul>
</div> 

<DIV class="box" id="cllbb"><!-- 头部结束-->     
    <DIV class="dlqqz5"  style="border:1px solid #4ea6ee; padding-top:10px; margin: -2px 0 0 0;">
    <DIV class="dlqqz2">
  <!--  列表数开始-->
<div id="menu_lb">
 
        <%string sSQL=""; %>
        <% sSQL="select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=2";%>
        <%DataTable dt1=new DataTable();%>
        <%dt1=Conn(sSQL); %>
        <%if(dt1!=null&&dt1.Rows.Count>0) %>
        <%{ %>
        <%int   firstlevel = 0; %>
                <%foreach (DataRow dryj in dt1.Rows)%>
                <%{%>
                        <%sSQL = ""; %>
                            <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=4 and  SUBSTRING(分类编码,1,2)="+dryj["分类编码"]; %>
                            <%DataTable dt2 = new DataTable(); %>
                            <%dt2 = Conn(sSQL); %>
                            <%if (dt2 != null && dt2.Rows.Count > 0) %>
                            <%{ %>
                             <% int secondlevel = 0; %>
                                    <h1 onClick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)"><img src="images/biao2.jpg" alt="" /> <%=dryj["显示名字"]%></a></h1>
                                   
                                    <span class="no">
                                     <%foreach (DataRow drej in dt2.Rows)%>
                                        <%{%>
                                            <%sSQL = ""; %>
                                            <%sSQL = "select 显示名字,分类编码,单位 from 材料分类表 where LEN(分类编码)=6 and SUBSTRING(分类编码,1,4)="+drej["分类编码"]; %>
                                            <%DataTable dt3 = new DataTable(); %>
                                            <%dt3 = Conn(sSQL); %>                                                                                                       
                                                <%if (dt3 != null && dt3.Rows.Count > 0) %>
                                                <%{ %>        
                                                 <h2 onClick="javascript:ShowMenu(this,<%=secondlevel %>)"><a href="javascript:void(0)"><%=drej["显示名字"]%></a></h2>
                                                           <ul class="no">                           
                                                        <%  foreach (DataRow drsj in dt3.Rows)%>
                                                        <%  {%>                                       
                                                                <li><a href="javascript:void(0)" onclick="lbs(this,'<%=drsj["分类编码"]%>','<%=(drsj["显示名字"])%>','<%=drsj["单位"]%>')"><%=drsj["显示名字"]%></a></li>                                                       
                                                        <%  } %>
                                                           </ul>
                                                <%} %>
                                                <%else %>
                                                <%{ %>
                                                 <h2><a href="javascript:void(0)"onclick="lbs(this,'<%=drej["分类编码"]%>','<%=(drej["显示名字"])%>','<%=drej["单位"]%>')"><%=drej["显示名字"]%></a></h2>
                                                 <ul class="no"></ul>
                                                <%} %>
                                            <%secondlevel++; %>       
                                         <%} %>
                                   </span>
                            <%} %> 
                            <%else %>
                            <%{ %>
                                <h1><a href="javascript:void(0)"onclick="lbs(this,'<%=dryj["分类编码"]%>','<%=(dryj["显示名字"])%>','<%=dryj["单位"]%>')"><%=dryj["显示名字"]%></a></h1>
                                <span class="no"></span>
                            <%} %>
                            <% firstlevel++;  %>
                <%} %>
        <%} %>
    </div>
  <!--列表数结束-->
<div id="menu_lb1" style=" display:none;">
        <% string sSQLsc=""; %>
   
            <% sSQLsc = " select a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct SUBSTRING(c.分类编码,1,2) as 分类编码 from 采购商关注的材料表 as b ,材料表 as c where  b.cl_id=c.cl_id and b.材料编码=c.材料编码 and b.dw_id='" + DWID + "') as  d where LEN(a.分类编码)=2 and a.分类编码=d.分类编码";%>
      
        <%DataTable dt_sc=new DataTable();%>
        <%dt_sc = Conn(sSQLsc); %>
        <%if (dt_sc != null && dt_sc.Rows.Count > 0) %>
        <%{ %>
        <%int firstlevelcl = 0; %>
                <%foreach (DataRow dryj in dt_sc.Rows)%>
                <%{%>
                        <%sSQLsc = ""; %>
                            <%sSQLsc = "select a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct SUBSTRING(c.分类编码,1,4) as 分类编码 from 采购商关注的材料表 as b ,材料表 as c where  b.cl_id=c.cl_id and b.材料编码=c.材料编码 and b.dw_id='" + DWID + "') as  d where LEN(a.分类编码)=4 and a.分类编码=d.分类编码 and  SUBSTRING(d.分类编码,1,2)='" + dryj["分类编码"] + "'";%>
                            <%DataTable dt2 = new DataTable(); %>
                            <%dt2 = Conn(sSQLsc); %>
                            <%if (dt2 != null && dt2.Rows.Count > 0) %>
                            <%{ %>
                             <% int secondlevelcl = 0; %>
                                    <h1 onClick="javascript:ShowMenu(this,<%=firstlevelcl %>)"><a href="javascript:void(0)"><img src="images/biao2.jpg" alt="" /> <%=dryj["显示名字"]%></a></h1>
                                   
                                    <span class="no">
                                     <%foreach (DataRow drej in dt2.Rows)%>
                                        <%{%>
                                            <%sSQLsc = ""; %>
                                            <%sSQLsc = " select a.分类编码,a.显示名字 from 材料分类表 as a ,(select distinct SUBSTRING(c.分类编码,1,6) as 分类编码 from 采购商关注的材料表 as b ,材料表 as c where  b.cl_id=c.cl_id and b.材料编码=c.材料编码 and b.dw_id='" + DWID + "') as  d where LEN(a.分类编码)=6 and a.分类编码=d.分类编码 and  SUBSTRING(d.分类编码,1,4)='" + drej["分类编码"] + "'"; %>
                                            <%DataTable dt3 = new DataTable(); %>
                                            <%dt3 = Conn(sSQLsc); %>                                                                                                       
                                                <%if (dt3 != null && dt3.Rows.Count > 0) %>
                                                <%{ %>      
                                                 <h2 onClick="javascript:ShowMenu(this,<%=secondlevelcl %>)"><a href="javascript:void(0)"><%=drej["显示名字"]%></a></h2>
                                                           <ul class="no">                           
                                                        <%  foreach (DataRow drsj in dt3.Rows)%>
                                                        <%  {%>     
                                                                 <li><a href="javascript:void(0)" onclick="sccl(this,'<%=drsj["分类编码"]%>')"><%=drsj["显示名字"]%></a></li>                                                        
                                                        <%  } %>
                                                           </ul>
                                                <%} %>
                                                <%else %>
                                                <%{ %>
                                                 <h2><a href="javascript:void(0)"onclick="sccl(this,'<%=drej["分类编码"]%>')"><%=drej["显示名字"]%></a></h2>
                                                 <ul class="no"></ul>
                                                <%} %>
                                            <%secondlevelcl++; %>       
                                         <%} %>
                                   </span>
                            <%} %> 
                            <%else %>
                            <%{ %>
                                <h1><a href="javascript:void(0)"onclick="sccl(this,'<%=dryj["分类编码"]%>')"><%=dryj["显示名字"]%></a></h1>
                                <span class="no"></span>
                            <%} %>
                            <% firstlevelcl++;  %>
                <%} %>
        <%} %>
    </div>

<div id="Div3" style="width:775px; min-height:400px; margin-left:202px;">
<div id="allcl">
 <table  width="740" border="0" cellpadding="0" cellspacing="1" bgcolor="#dddddd" style="table-layout：fixed ;word-wrap：break-word">
    <thead>
        <tr>
          <th width="70" height="30" align="center" bgcolor="#E3ECFF"><strong>属性名称</strong></th>
          <th align="center" bgcolor="#E3ECFF"><strong>规格\型号</strong></th>
          <th width="80" align="center" bgcolor="#E3ECFF"><strong>选中项</strong></th>
        </tr>
      </thead>
         <tbody id="sx">      
       </tbody> 
       <tfoot>
        <tr>
        <td width="120" height="32" align="right" bgcolor="#FFFFFF">名称及规则：</td>
        <td align="left" bgcolor="#FFFFFF"><input type="text" id="clmcjgg" style=" width: 293px; "/></td>
        <td width="80" align="center" bgcolor="#FFFFFF">
        <input type="Button" name="btnDocNew" value="确定" onClick="AddValue()"  class="filter" style="color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;" /></td>
      </tr>
       </tfoot>
  </table>
</div>
<div id="sccl" style="display:none;">
 <table  width="740" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#dddddd"  style="  table-layout：fixed ;word-wrap：break-word">
    <thead>
      <tr>
        <th width="42" height="30" align="center" bgcolor="#E3ECFF"><strong>序 号</strong></th>
        <th width="125" height="24" align="center" bgcolor="#E3ECFF"><strong>材料编码</strong></th>
        <th width="150" align="center" bgcolor="#E3ECFF"><strong>材料名称</strong></th>
        <th width="100" align="center" bgcolor="#E3ECFF"><strong>规格\型号</strong></th>
        <th width="55" align="center" bgcolor="#E3ECFF"><strong>单 位</strong></th>
        <th width="80" align="center" bgcolor="#E3ECFF"><strong>品 牌</strong></th>
        <th width="50" align="center" bgcolor="#E3ECFF">选 项</th>
      </tr>
    </thead>    
    <tbody id="scclxq">     
    </tbody>
     <tfoot>
     <tr>
        <td  height="40" align="right" bgcolor="#FFFFFF" colspan="7" style="padding-right:20px;">
            <input type="button" id="btnFilter2" value="确定" onClick="qd_Click()" style="height: 20px;
                width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" />
         </td>
      </tr>
     </tfoot>
</table>
</div>
<table width="740" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#dddddd"  style="table-layout：fixed ;word-wrap：break-word">
    <thead>
      <tr>
        <th width="42" height="30" align="center" bgcolor="#E3ECFF"><strong>序 号</strong></th>
        <th width="125" height="24" align="center" bgcolor="#E3ECFF"><strong>材料编码</strong></th>
        <th width="150" align="center" bgcolor="#E3ECFF"><strong>材料名称</strong></th>
        <th width="100" align="center" bgcolor="#E3ECFF"><strong>规格\型号</strong></th>
        <th width="55" align="center" bgcolor="#E3ECFF"><strong>单 位</strong></th>
        <th width="80" align="center" bgcolor="#E3ECFF"><strong>品 牌</strong></th>
        <th width="50" align="center" bgcolor="#E3ECFF">选 项</th>
      </tr>
    </thead>    
    <tbody id="cl">     
    </tbody>
     <tfoot>
     <tr>
        <td  height="40" align="right" bgcolor="#FFFFFF" colspan="7" style="padding-right:20px;">
 
            <input type="submit" id="btnFilter" value="提交选项" onClick="btnFilter_Click('cl')" style="height: 20px;
                width: 64px; border-style: none; font-family: 宋体; font-size: 12px; cursor:pointer;" />
         </td>
      </tr>
     </tfoot>
</table>
</div>
    </DIV>                
</DIV>
<DIV class="cgdlqq"></DIV>  </DIV>

<input type="hidden"  runat="server" id="flbm"/>    <%--分类编码  --%>
<input type="hidden"  runat="server" id="clbm"/>    <%--  材料编码--%>
<input type="hidden"  runat="server" id="ggxh"/>    <%--规格型号  --%>
<input type="hidden"  runat="server" id="clmc"/>    <%--材料名称  --%>
<input type="hidden"  runat="server" id="dw"/>      <%--单位      --%>
<input type="hidden"  runat="server" id="wjj"/>     <%-- 文件夹   --%>
<input type="hidden"  runat="server" id="htmlmc"/>  <%-- Html名称 --%>
<input type="hidden"  runat="server" id="HTML"/>    <%--返回的html--%>
<input type="hidden"  runat="server" id="SQL"/>     <%-- SQL语句  --%>
<input type="hidden"  runat="server" id="DW_ID"/>   <%-- 单位id   --%>
</form>
</BODY></HTML>
