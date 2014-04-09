<!--
      新增分销商页面  生产商或 新增分销商  分销商认领 找不到公司 新增 分销商	  
	  文件名:  xzfxs.aspx        
	  传入参数:用户id	  
     author:张新颖
--> 
<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %> 
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
   

 <style type="text/css">
    input{
          border:1px;  
         border-style:solid;
        }
    table{
             padding-top:20px;
            margin-top:20px;
           } 
    tr{
             border:1px;  
             border-style:groove; 
             margin-top:10px;
             
        }
    </style>
</head>
 <script runat="server">

        protected DataTable dt_yjfl = new DataTable();   //材料分类大类
		protected String gys_id="";
        public DataConn objConn = new DataConn();
        public string sSQL="";
        protected void Page_Load(object sender, EventArgs e)
        {
               string sSQL="select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";          
               dt_yjfl = objConn.GetDataTable(sSQL);
               ListItem objItem = new ListItem();
               for (int i = 0; i < dt_yjfl.Rows.Count; i++)
               {
                   objItem = null;
                   objItem = new ListItem();
                   objItem.Text =dt_yjfl.Rows[i]["显示名字"].ToString();
                   objItem.Value = dt_yjfl.Rows[i]["分类编码"].ToString();
                   this.yjflname.Items.Add(objItem);
               }
         }
        protected void updateUserInfo(object sender, EventArgs e)
        {
            string sfqy = "";
            if (this.sfqy.Checked)
            {
                sfqy = "1";
            }
            else
            {
                sfqy = "0";
            }
            sSQL="insert into 材料供应商信息表 "+
"(供应商,主页,地址,电话,传真,联系人,联系人手机,联系人QQ,是否启用,单位类型,组织机构编号,单位简称,地区名称,"+
"法定代表人,注册资金,联系地址,邮编,电子邮箱,开户银行,银行账户,账户名称,资质等级,经营范围,备注,注册日期,"+
"企业员工人数,资产总额,注册级别,企业类别,营业执照注册号)values('"+
this.gys.Value+"','"+this.zy.Value+"','"+this.dz.Value+"','"+this.dh.Value+"','"+this.cz.Value+"','"+this.lxr.Value+"','"+this.lxrsj.Value+
"','"+this.lxrqq.Value+"','"+sfqy+"','"+this.lx.Value+"','"+this.zzjgbh.Value+"','"+this.dwjc.Value+"','"+this.dqmc.Value+"','"+this.fddbr.Value+"','"+
this.zczj.Value+"','"+this.lxdz.Value+"','"+this.yb.Value+"','"+this.dzyx.Value+"','"+this.khyh.Value+"','"+this.yhzh.Value+"','"+this.zhmc.Value+
"','"+this.zzdj.Value+"','"+this.scope.Value+"','"+this.bz.Value+"','"+this.zcrq.Value+"','"+this.qyygrs.Value+"','"+this.zcze.Value+"','"+this.zcjb.Value+
"','"+this.qylb.Value+"','"+this.yyzzzch.Value
+")";
        }
    </script>
 <script type="text/javascript" language="javascript">

     function updateFL(id)
     {

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
                 //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                 document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
             }
         }
         xmlhttp.open("GET", "xzpp2.aspx?id=" + id, true);
         xmlhttp.send();
     }
    </script>
<body>
<!-- 头部2开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部2结束-->

<form runat="server">
<table>
<tr>
<td  colspan="4"  style="text-align:center; padding-bottom:20px; font-size:16px; font-weight:bold; color:Black">新增分销商信息</td>
</tr>
<tr>
  <td style="color:Red" >*供应商：</td>
  <td colspan="3"><input type="text" id="gys" runat="server" /></td>
</tr>
<tr>
 <td style="color:Red">*组织机构编号</td>
        <td><input type="text" id="zzjgbh" runat="server" /></td>
 <td>营业执照注册号：</td>
    <td><input type="text" id="yyzzzch" runat="server" /></td>
</tr>
<tr>
 <td>单位简称：</td>
        <td><input type="text" id="dwjc" runat="server" /></td>
        <td style="color:Red">*单位类型</td>
        <td>
            <select runat="server" id="lx">
                <option value="scs">生产商</option>
                <option value="fxs">分销商</option>
            </select>
        </td>
</tr>
<tr>
  <td style="color:Red">*地区名称：</td>
        <td colspan="3"><input type="text" id="dqmc" runat="server" /></td>
</tr>
<tr>
    <td>法定代表人</td>
    <td><input type="text" id="fddbr" runat="server" /></td>
   <td>企业员工人数</td>
        <td><input type="text" id="qyygrs" runat="server" /></td>
</tr>
<tr>
  <td>注册资金</td>
    <td><input type="text" id="zczj" runat="server" /></td>
     <td>资产总额</td>
        <td><input type="text" id="zcze" runat="server" /></td>
 
</tr>
<tr>
 <td>注册日期</td>
        <td><input type="text" id="zcrq" runat="server" /></td>
     <td>注册级别</td>
        <td>
            <select runat="server" id="zcjb">
                <option value="gjj">国家级</option>
                <option value="sj">省级</option>
                <option value="dsj">地市级</option>
                <option value="qxj">区县级</option>
            </select>
        </td>   
</tr>
<tr>
<td>企业类别</td>
        <td>
         <select runat="server" id="qylb">
                <option value="gy">国有</option>
                <option value="sy">私营</option>
                <option value="gt">个体</option>
                <option value="jt">集体</option>
                <option value="sz">三资</option>
                <option value="qt">其他</option>
            </select>
        </td>
        <td>资质等级</td>
        <td>
            <select runat="server" id="zzdj">
                <option value="yj">一级</option>
                <option value="ej">二级</option>
                <option value="sj">三级</option>
            </select>
        </td>
</tr>
<tr>
<td style="color:Red">*联系人</td>
        <td><input type="text" id="lxr" runat="server" /></td>
        <td style="color:Red">*联系人手机</td>
        <td><input type="text" id="lxrsj" runat="server" /></td>
</tr>
<tr>
<td>联系人QQ</td>
        <td><input type="text" id="lxrqq" runat="server" /></td>
        <td>是否启用</td>
        <td><input type="checkbox" id="sfqy" runat="server" checked="checked" style=" border:0px" /></td>
</tr>
<tr>
 <td>传真</td>
        <td><input type="text" id="cz" runat="server" /></td>
         <td>邮编</td>
        <td><input type="text" id="yb" runat="server" /></td>
</tr>
<tr>
  <td style="color:Red">*联系地址</td>
        <td colspan="3"><input type="text" id="lxdz" runat="server" /></td>
</tr>
<tr>
 <td>主页</td>
        <td ><input type="text" id="zy" runat="server" /></td>
        <td>电子邮箱</td>
        <td><input type="text" id="dzyx" runat="server" /></td>
</tr>
<tr>
<td>地址</td>
        <td ><input type="text" id="dz" runat="server" /></td>
        <td>电话</td>
        <td><input type="text" id="dh" runat="server" /></td>
</tr>
<tr>
<td>开户银行</td>
        <td><input type="text" id="khyh" runat="server" /></td>
        <td>账户名称</td>
        <td><input type="text" id="zhmc" runat="server" /></td>
</tr>
<tr>
 <td>银行账户</td>
        <td colspan="3"><input type="text" id="yhzh" runat="server" /></td>
</tr>
<tr>
 <td style="color:Red">*经营范围</td>
        <td colspan="3" ><input type="text" id="jyfw" /></td>
</tr>
    <tr>
     <td style="width: 120px; color: Blue">一级分类名称：</td>
      <td align="left">
                        <select runat="server" id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                           <option value="0">请选择一级分类</option>                           
                        </select>
                    </td>
    </tr>
    <tr>
                    <td style="width: 120px; color: Blue">二级分类名称：
                    </td>
                    <td align="left">
                        <select  runat="server" id="ejflname" name="ejflname" style="width: 250px">
                            <option value="">请选择二级分类</option>
                        </select>
                    </td>
                </tr>
    <tr>
                    <td style="color: Blue" >品牌名称：
                    </td>
                    <td align="left">
                        <input type="text" id="ppmc" name="brandname" value="" runat="server" />
                    </td>
                </tr>
    <tr>
                    <td style="color: Blue">等级：
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
                    <td valign="top" style="color: Blue">范围：
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" runat="server" >
                            <option value="全国">全国</option>
                            <option value="地区">地区</option>                        
                        </select>
                    </td>
                </tr>
    <tr>
        <td>
            是否启用材料：
        </td>
        <td>
          <input type="checkbox" checked="checked" id="sfqycl" runat="server" style=" border:0px" />
        </td>
    </tr>
    <tr>
        <td colspan="4" style=" width:600px">
         <textarea  runat="server" id="bz" style=" border:1px;border-style:inset; width:600px; height:100px"></textarea>
        </td>
   </tr>
</table>
		<dd style="width:300px; color:Red">*号的为必填项,不能为空!</dd>
		<span class="cggg"><asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
</form>

</body>
</html>
