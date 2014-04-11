<!--
      新增分供销商页面  生产商或 新增分销商  分销商认领 找不到公司 新增 分销商	  
	  文件名:  xzgxs.aspx        
	  传入参数:用户id	  
     author:张新颖
--> 

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

 <style type="text/css">
    input{
          border:1px;  
         border-style:solid;
        }
    table{
        text-align:center;
             padding-top:20px;
            margin-top:20px;
           } 
    tr{
             border:1px;  
             border-style:groove; 
             margin-top:10px;
             text-align:left;
             
        }
    </style>
</head>
 <script runat="server">

        protected DataTable dt_yjfl = new DataTable();   //材料分类大类
        public DataConn objConn = new DataConn();
        public string sSQL="";
        public string xzlx = "";
        public string gys_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["xzlx"]!=null&&Request["xzlx"].ToString()!="")
            {
                xzlx = Request["xzlx"].ToString();
                if (xzlx=="scs")
                {
                    xzlx = "生产商";
                }
                else if (xzlx == "fxs")
                {
                    xzlx = "分销商";
                }
                
            }
            xzlx = "生产商";
            if (IsPostBack)
            {
                BTX();
            }
            sSQL = "select gys_id from 材料供应商信息表 where  供应商='" + this.gys.Value + "' and 营业执照注册号='" + this.yyzzzch.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
            gys_id = objConn.DBLook(sSQL);
            this.gys_id_hid.Value = gys_id;
         }
        protected void updateUserInfo(object sender, EventArgs e)
        {
            string id = "";        
            id=save();
         
        }
        public string save()
        {           
            bool b = false;          
            string sfqy = "";  //是否启用
            if (this.sfqy.Checked)
            {
                sfqy = "1";
            }
            else
            {
                sfqy = "0";
            }
            sSQL = "insert into 材料供应商信息表 " +
                "(供应商,主页,地址,电话,传真,联系人,联系人手机,联系人QQ,是否启用,单位类型,组织机构编号,单位简称,地区名称," +
                "法定代表人,注册资金,联系地址,邮编,电子邮箱,开户银行,银行账户,账户名称,资质等级,经营范围,备注,注册日期," +
                "企业员工人数,资产总额,注册级别,企业类别,营业执照注册号)values('" +
                this.gys.Value + "','" + this.zy.Value + "','" + this.dz.Value + "','" + this.dh.Value + "','" + this.cz.Value + "','" + this.lxr.Value + "','" + this.lxrsj.Value +
                "','" + this.lxrqq.Value + "'," + sfqy + ",'" + this.lx.Value + "','" + this.zzjgbh.Value + "','" + this.dwjc.Value + "','" + this.dqmc.Value + "','" + this.fddbr.Value + "'," +
                this.zczj.Value + ",'" + this.lxdz.Value + "','" + this.yb.Value + "','" + this.dzyx.Value + "','" + this.khyh.Value + "','" + this.yhzh.Value + "','" + this.zhmc.Value +
                "','" + this.zzdj.Value + "','" + this.jyfw.Value + "','" + this.bz.Value + "','" + this.zcrq.Value + "'," + this.qyygrs.Value + ",'" + this.zcze.Value + "','" + this.zcjb.Value +
                "','" + this.qylb.Value + "','" + this.yyzzzch.Value
                + "')";
            if (objConn.ExecuteSQL(sSQL, false))
            {
                sSQL = "update 材料供应商信息表 set gys_id=myid where 供应商='" + this.gys.Value + "' and 营业执照注册号='" + this.yyzzzch.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
                b = objConn.ExecuteSQL(sSQL, true);
                if (!b)
                { objConn.MsgBox(this.Page, sSQL); }
            }
            else
            {
                objConn.MsgBox(this.Page, sSQL);
            }
            sSQL = "select gys_id from 材料供应商信息表 where 供应商='" + this.gys.Value + "' and 营业执照注册号='" + this.yyzzzch.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
            gys_id = objConn.DBLook(sSQL);
            this.gys_id_hid.Value = gys_id;
            return gys_id;
        }
        protected void BTX()
        {
            if (this.gys.Value=="")
            {
                objConn.MsgBox(this.Page,"供应商不能为空！");
                this.gys.Focus();
                return;
            }
             if (this.zzjgbh.Value=="")
            {
                objConn.MsgBox(this.Page,"组织机构编号不能为空！");
                this.zzjgbh.Focus();
                return;
            }
             if (this.lx.Value=="")
            {
                objConn.MsgBox(this.Page,"单位类型不能为空！");
                this.lx.Focus();
                return;
            }
             if (this.dqmc.Value=="")
            {
                objConn.MsgBox(this.Page,"地区名称不能为空！");
                this.dqmc.Focus();
                return;
            }
             if (this.lxr.Value=="")
            {
                objConn.MsgBox(this.Page,"联系人不能为空！");
                this.lxr.Focus();
                return;
            }
             if (this.lxrsj.Value=="")
            {
                objConn.MsgBox(this.Page, "联系人手机不能为空！");
                this.lxrsj.Focus();
                return;
            }
             if (this.lxdz.Value == "")
             {
                 objConn.MsgBox(this.Page, "联系地址不能为空！");
                 this.lxdz.Focus();
                 return;
             }
             if (this.jyfw.Value == "")
             {
                 objConn.MsgBox(this.Page, "经营范围不能为空！");
                 this.jyfw.Focus();
                 return;
             }
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
     function AddNewBrand(type)
     {
         var id = document.getElementById("gys_id_hid").value;
         if (id == "")
         {
             window.alert("请先保存新增信息，再添加品牌！");
         }
         else
         {
             var url;
             if (type == "生产商")
             {
                 url = "xzpp.aspx?gys_id=" + id + "&source=xzym";
             }
             else
             {
                 url = "xzfxpp.aspx?gys_id=" + id+"&source=xzym";
             }
             window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
         }
     }

 </script>
<body style=" text-align:center">

<form id="Form1" runat="server">
<table>
<tr>
<%if (xzlx == "生产商")
  { %>
      <td  colspan="4"  style="text-align:center; padding-bottom:20px; font-size:16px; font-weight:bold; color:Black">新增生产厂商</td>
  <%}
  else
  { %>
    <td  colspan="4"  style="text-align:center; padding-bottom:20px; font-size:16px; font-weight:bold; color:Black">新增分销商信息</td>
<%} %>
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
        <%if (xzlx == "生产商")
          {
              this.lx.Value = "生产商";             
           }
          else
          {
              this.lx.Value = "分销商";        
          } 
            
            %>
          <input type="text" id="lx" runat="server" value="" readonly="readonly"/>
<%--            <select runat="server" id="lx">
                <option value="scs">生产商</option>
                <option value="fxs">分销商</option>
            </select>--%>
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
                <option value="国家级">国家级</option>
                <option value="省级">省级</option>
                <option value="地市级">地市级</option>
                <option value="区县级">区县级</option>
            </select>
        </td>   
</tr>
<tr>
<td>企业类别</td>
        <td>
         <select runat="server" id="qylb">
                <option value="国有">国有</option>
                <option value="私营">私营</option>
                <option value="个体">个体</option>
                <option value="集体">集体</option>
                <option value="三资">三资</option>
                <option value="其他">其他</option>
            </select>
        </td>
        <td>资质等级</td>
        <td>
            <select runat="server" id="zzdj">
                <option value="一级">一级</option>
                <option value="二级">二级</option>
                <option value="三级">三级</option>
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
        <td colspan="3" ><input type="text" id="jyfw" runat="server" /></td>
</tr>


    <tr>
        <td colspan="4" style=" width:600px">
         <textarea  runat="server" id="bz" style=" border:1px;border-style:inset; width:600px; height:100px"></textarea>
        </td>
   </tr>
</table>
<input  type="hidden" id="gys_id_hid" runat="server"/>
      <dd style="width:300px; color:Red">*号的为必填项,不能为空!</dd>
      <%if (xzlx == "分销商")
  {%>
<span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand('分销商')">增加分销品牌</a></span>
<%}
  else if (xzlx == "生产商")
  { %>
  <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand('生产商')">增加品牌</a></span>
<%} %>
		<span class="cggg"><asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
</form>
</body>
</html>
