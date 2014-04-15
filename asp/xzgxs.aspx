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
        public DataTable dt_ppxx;
        public DataTable dt_clfl;
        public string s_yh_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
                
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
                BTX();
             sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";
            dt_yjfl = objConn.GetDataTable(sSQL);

            sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where yh_id="+s_yh_id;
            dt_ppxx = objConn.GetDataTable(sSQL);
            sSQL = "select 分类编码,显示名字 from 材料分类表 where 是否启用=1";
            dt_clfl = objConn.GetDataTable(sSQL);
            
         }
        protected void updateUserInfo(object sender, EventArgs e)
        {
            string id = "";           
            id=save();
            bool b=xzpp(id);   
            if (b)
            {
                Response.Write("<script>window.alert('添加成功！');window.location.href='gyszym.aspx';</" + "script>");
            }
         
        }
        public bool xzpp(string gys_id)
        {
            bool b = false;
            if (xzlx=="生产商")
            {
               // string gys_id = Request.Form["gys_id_hid"];
                string brandname = Request.Form["brandname"];            //品牌名称
                string yjflname = Request.Form["yjflname"];              //大级分类名称               
                string ejflname = Request.Form["ejflname"];              //二级分类名称
                string grade = Request.Form["grade"];               //等级
                string scope = Request.Form["scope"];                    //范围       
                string flname = Request.Form["ejflname"];
                sSQL = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围) values('" + brandname + "',1,'" + gys_id + "','" + flname + "','" + grade + "','" + scope + "') ";

               b= objConn.ExecuteSQL(sSQL, false);
               if (b)
               {
                   string str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='" + brandname + "'),"
                   + " fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
                   + " 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + gys_id + "'),"
                   + " 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '" + flname + "')"
                   + " where 品牌名称='" + brandname + "'";
                   int ret1 = objConn.ExecuteSQLForCount(str_update, false);
                   sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id) values('" + " (select myID from 品牌字典 where 品牌名称='" + brandname + "')" + "','" + brandname + "', 1,'" + gys_id + "','"+s_yh_id+"' ) ";
                   int ret = objConn.ExecuteSQLForCount(sSQL, true);
                   if (ret<1||ret1<1)
                   {
                       b = false;
                   }
               }
               
            }
            else if(xzlx=="分销商")
            {
              //  string fxs_id = Request["gys_id_hid"]; 	//分销商id	
                
                string pp_id = Request["pp_id"];	    //品牌id	
                string pp_name = Request["pp_name"];   //品牌名称     
                sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id) values('" + pp_id + "','" + pp_name + "', 1,'" + gys_id + "' ) ";
               b= objConn.ExecuteSQL(sSQL, true);
            }
            return b;
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
            string qyygrs ="";
            qyygrs = this.qyygrs.Value;
            if (qyygrs=="")
            {
                qyygrs = "null";
            }
            string zczj = "";
            zczj = this.zczj.Value;
            if (zczj=="")
            {
                zczj = "null";
            }
           
            
            sSQL = "insert into 材料供应商信息表 " +
                "(供应商,主页,地址,电话,传真,联系人,联系人手机,联系人QQ,是否启用,单位类型,组织机构编号,单位简称,地区名称," +
                "法定代表人,注册资金,联系地址,邮编,电子邮箱,开户银行,银行账户,账户名称,资质等级,经营范围,备注,注册日期," +
                "企业员工人数,资产总额,注册级别,企业类别,营业执照注册号)values('" +
                this.gys.Value + "','" + this.zy.Value + "','" + this.dz.Value + "','" + this.dh.Value + "','" + this.cz.Value + "','" + this.lxr.Value + "','" + this.lxrsj.Value +
                "','" + this.lxrqq.Value + "'," + sfqy + ",'" + this.lx.Value + "','" + this.zzjgbh.Value + "','" + this.dwjc.Value + "','" + this.dqmc.Value + "','" + this.fddbr.Value + "'," +
                 zczj+ ",'" + this.lxdz.Value + "','" + this.yb.Value + "','" + this.dzyx.Value + "','" + this.khyh.Value + "','" + this.yhzh.Value + "','" + this.zhmc.Value +
                "','" + this.zzdj.Value + "','" + this.jyfw.Value + "','" + this.bz.Value + "','" + this.zcrq.Value + "'," + qyygrs+ ",'" + this.zcze.Value + "','" + this.zcjb.Value +
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

      function updateFLfxs(id) {

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
<body style=" text-align:center">

<form id="Form1" runat="server">

    <%if (xzlx == "分销商")
  {%>
 <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">*品牌名称：
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFLfxs(this.options[this.options.selectedIndex].value)">

                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {
                                Response.Write("<option value='"+i+"'>"+dt_ppxx.Rows[i]["品牌名称"]+"</option>");
                            }%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="width: 120px; color: Blue">*生产商：
                    </td>
                    <td align="left">
                        <div id="scs"><%=dt_ppxx.Rows[0]["生产商"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">*等级：
                    </td>
                    <td align="left">
                        <div id="grade"><%=dt_ppxx.Rows[0]["等级"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">*范围：
                    </td>
                    <td align="left">
                        <div id="scope"><%=dt_ppxx.Rows[0]["范围"] %>  </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">*分类：
                    </td>
                    <td align="left">
                        <div id="fl_name"> <%=dt_ppxx.Rows[0]["分类名称"] %> </div>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="pp_id" name="pp_id" value="<%=dt_ppxx.Rows[0]["pp_id"] %> " />
            <input type="hidden" id="pp_name" name="pp_name" value="<%=dt_ppxx.Rows[0]["品牌名称"] %> " />
<%}
  else if (xzlx == "生产商")
  { %>
       <div id="myDiv"></div>
       <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">*一级分类名称：
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
                    <td style="width: 120px; color: Blue">*二级分类名称：
                    </td>
                    <td align="left">
                        <select id="ejflname" name="ejflname" style="width: 250px">
                            <option value="">请选择二级分类</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">*品牌名称：
                    </td>
                    <td align="left">
                        <input type="text" id="" name="brandname" value="" />
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">*等级：
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
                    <td valign="top" style="color: Blue">*范围：
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" >
                            <option value="全国">全国</option>
                            <option value="地区">地区</option>                        
                        </select>
                    </td>
                </tr>      
            </table>
<%} %>






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
<tr> <td> 备注：</td></tr>
    <tr>   
        <td colspan="4" style=" width:600px">
         <textarea  runat="server" id="bz" style=" border:1px;border-style:inset; width:600px; height:100px"></textarea>
        </td>
   </tr>
</table>
<input  type="hidden" id="gys_id_hid" runat="server"/>
<input  type="hidden" id="source" runat="server" value="xzym"/>
      <dd style="width:300px; color:Red">*号的为必填项,不能为空!</dd>  
		<span class="cggg"><asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="images/aaaa_03.jpg"  OnClick="updateUserInfo"  /></span>
</form>
</body>
</html>
