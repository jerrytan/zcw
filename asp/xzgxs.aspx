<!--
      新增分供销商页面  生产商或 新增分销商  分销商认领 找不到公司 新增 分销商	  
	  文件名:  xzgxs.aspx        
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
    <script src="js/SJLD_New.js" type="text/javascript"></script>
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
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
     .style2
     {
         width: 120px;
         height: 16px;
     }
     .style3
     {
         height: 16px;
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
        public string qymc = "";
        public string gxs_id = "";
        public DataTable dt_fxpp = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
            {
                s_yh_id = Session["GYS_YH_ID"].ToString();
            }
                
            if (Request["xzlx"]!=null&&Request["xzlx"].ToString()!="")
            {
                xzlx = Request["xzlx"].ToString();
                if (xzlx.Trim()=="scs")
                {
                    xzlx = "生产商";
                }
                else if (xzlx.Trim() == "fxs")
                {
                    xzlx = "分销商";
                }
               
            }
            if (Request["gxs_id"]!=null&&Request["gxs_id"].ToString()!="")
            {
                gxs_id = Request.QueryString["gxs_id"].ToString();
                Response.Write("供应商编号："+gxs_id);//253
            }           
           
                if (xzlx=="分销商")  //当前用户是生产商
                {
                    if (gxs_id!="")
                    {
                        sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where scs_id='" + gxs_id + "'";
                        dt_ppxx = objConn.GetDataTable(sSQL);
                    }
                    else
                    {
                        sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典";
                        dt_ppxx = objConn.GetDataTable(sSQL);
                    }
                   
                }
                    //else
                    //{                 
                    //    sSQL = "select pp_id from 分销商和品牌对应关系表 where fxs_id='" + gxs_id + "'";
                    //    dt_fxpp = objConn.GetDataTable(sSQL);
           
                    //    string pp_id = dt_fxpp.Rows[0]["pp_id"].ToString();
                    //    sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where pp_id=" + pp_id;
                    //    dt_ppxx = objConn.GetDataTable(sSQL);
                    
                    //}
             sSQL = "select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'";//取大类的数据
            dt_yjfl = objConn.GetDataTable(sSQL);

          
            sSQL = "select 分类编码,显示名字 from 材料分类表 where 是否启用=1";
            dt_clfl = objConn.GetDataTable(sSQL);
         }
        protected void updateUserInfo(object sender, EventArgs e)
        {
            //蒋，2014年8月21日
            string pp_id = dt_ppxx.Rows[0]["pp_id"].ToString();	    //品牌id	
            string pp_name = dt_ppxx.Rows[0]["品牌名称"].ToString();  //品牌名称
            Response.Write("品牌编号 :" + pp_id);
            Response.Write("品牌名 :" + pp_name);
            sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where scs_id='" + gxs_id + "'";
            dt_ppxx = objConn.GetDataTable(sSQL);
            qymc = this.s0.Value + this.s1.Value + this.s2.Value + this.s3.Value;
            if (this.gys.Value == "")
            {
                Response.Write("<script>window.alert('供应商不能为空！')</" + "script>");
                this.gys.Focus();
                return;
            }
           else if (this.zzjgbh.Value == "")
            {
                Response.Write("<script>window.alert('组织机构编号不能为空！')</" + "script>");
                this.zzjgbh.Focus();
                return;
            }
            else if (this.lx.Value == "")
            {
                Response.Write("<script>window.alert('单位类型不能为空！')</" + "script>");
                this.lx.Focus();
                return;
            }           
            else if (qymc != "")
            {
                Response.Write("<script>window.alert('地区名称不能为空！')</" + "script>");
                this.s1.Focus();
                return;
            }
            else if (this.lxr.Value == "")
            {
                Response.Write("<script>window.alert('联系人不能为空！')</" + "script>");
                this.lxr.Focus();
                return;
            }
            else if (this.lxrsj.Value == "")
            {
                Response.Write("<script>window.alert('联系人手机不能为空！')</" + "script>");
                this.lxrsj.Focus();
                return;
            }
            else if (this.lxdz.Value == "")
            {
                Response.Write("<script>window.alert('联系地址不能为空！')</" + "script>");
                this.lxdz.Focus();
                return;
            }
            else if (this.jyfw.Value == "")
            {
                Response.Write("<script>window.alert('经营范围不能为空！')</" + "script>");
                this.jyfw.Focus();
                return;
            }
            else
            {
                string id = "";
                id = save();
                bool b = xzpp(id);
                if (b)
                {
                    Response.Write("<script>window.alert('添加成功！');</" + "script>");
                    //蒋，2014年8月21日，当前品牌信息录入材料供应商信息从表 
                    string addppxx = "insert into 材料供应商信息从表(pp_id,品牌名称,是否启用,gys_id,等级,范围,供应商,updatetime)"+
                        "values('" + pp_id + "','" + dt_ppxx.Rows[0]["品牌名称"] + "',1,'" + gys_id + "','" + dt_ppxx.Rows[0]["等级"] + "','" + dt_ppxx.Rows[0]["范围"] + "'," +
                        "'" + this.gys.Value + "',(select getdate()))";
                    objConn.ExecuteSQL(addppxx, true);
                    string update = "update 材料供应商信息从表 set uid=(select myID from 材料供应商信息表 where 供应商 ='"+this.gys.Value+"')";
                    objConn.ExecuteSQL(update,true);
                    Response.Write("<script>window.location.href='gyszym.aspx';</" + "script>");
                    //string update = "u";
                }
                else
                {
                    Response.Write("<script>window.alert('添加失败！');window.location.href='gyszym.aspx';</" + "script>");
                }
            }
         
        }
        public bool xzpp(string gys_id)
        {
            bool b = false;
            //蒋，2014年8月19日，
            //if (xzlx == "生产商")
            //{
            //    // string gys_id = Request.Form["gys_id_hid"];
            //    string brandname = Request.Form["brandname"];            //品牌名称
            //    string yjflname = Request.Form["yjflname"];              //大级分类名称               
            //    string ejflname = Request.Form["ejflname"];              //二级分类名称
            //    string grade = Request.Form["grade"];               //等级
            //    string scope = Request.Form["scope"];                    //范围       
            //    string flname = Request.Form["ejflname"];
            //    sSQL = "insert into  品牌字典 (品牌名称,是否启用,scs_id,分类编码,等级,范围) values('" + brandname + "',1,'" + gys_id + "','" + flname + "','" + grade + "','" + scope + "') ";

            //    b = objConn.ExecuteSQL(sSQL, false);
            //    if (b)
            //    {
            //        string str_update = "update 品牌字典 set pp_id= (select myID from 品牌字典 where 品牌名称='" + brandname + "'),"
            //        + " fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
            //        + " 生产商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + gys_id + "'),"
            //        + " 分类名称 = (select 显示名字 from 材料分类表 where 分类编码 = '" + flname + "'),updatetime=(select getdate())"
            //        + " where 品牌名称='" + brandname + "'";
            //        int ret1 = objConn.ExecuteSQLForCount(str_update, false);
            //        sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,yh_id,updatetime) values('" + " (select myID from 品牌字典 where 品牌名称='" + brandname + "')" + "','" + brandname + "', 1,'" + gys_id + "','" + s_yh_id + "',(select getdate()) ) ";
            //        int ret = objConn.ExecuteSQLForCount(sSQL, true);
            //        if (ret < 1 || ret1 < 1)
            //        {
            //            b = false;
            //        }
            //    }

            //}
            //else if (xzlx == "分销商")
            if(xzlx=="分销商")//当前用户是生产商
            {
                //  string fxs_id = Request["gys_id_hid"]; 	//分销商id	
                string pp_id = Request["pp_id"];	    //品牌id	
                string pp_name = Request["pp_name"];   //品牌名称
                //蒋，2014年8月21日，
                //sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,updatetime) values('" + pp_id + "','" + pp_name + "', 1,'" + gys_id + "',(select getdate()) ) ";   
                sSQL = "insert into  分销商和品牌对应关系表 (pp_id, 品牌名称, 是否启用,fxs_id,分销商,updatetime) values('" + pp_id + "','" + pp_name + "', 1,'" + gys_id + "','"+this.gys.Value+"',(select getdate()) ) ";
                b = objConn.ExecuteSQL(sSQL, true);
                
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
            if (qyygrs == "")
            {
                qyygrs = "null";
            }
            string zczj = "";//注册资金
            zczj = this.zczj.Value;
            if (zczj == "")
            {
                zczj = "null";
            }
            qymc = this.s0.Value + this.s1.Value + this.s2.Value + this.s3.Value;
            //蒋，2014年8月20日 注释该条sql语句，添加了一条新语句        
            //sSQL = "insert into 材料供应商信息表 " +
            //    "(供应商,主页,地址,电话,传真,联系人,联系人手机,联系人QQ,是否启用,单位类型,组织机构编号,单位简称,地区名称," +
            //    "法定代表人,注册资金,联系地址,邮编,电子邮箱,开户银行,银行账户,账户名称,资质等级,经营范围,备注,注册日期," +
            //    "企业员工人数,资产总额,注册级别,企业类别,营业执照注册号,是否审核通过)values('" +
            //    this.gys.Value + "','" + this.zy.Value + "','" + this.dz.Value + "','" + this.dh.Value + "','" + this.cz.Value + "','" + this.lxr.Value + "','" + this.lxrsj.Value +
            //    "','" + this.lxrqq.Value + "'," + sfqy + ",'" + this.lx.Value + "','" + this.zzjgbh.Value + "','" + this.dwjc.Value + "','" + qymc + "','" + this.fddbr.Value + "'," +
            //     zczj+ ",'" + this.lxdz.Value + "','" + this.yb.Value + "','" + this.dzyx.Value + "','" + this.khyh.Value + "','" + this.yhzh.Value + "','" + this.zhmc.Value +
            //    "','" + this.zzdj.Value + "','" + this.jyfw.Value + "','" + this.bz.Value + "','" + this.zcrq.Value + "'," + qyygrs+ ",'" + this.zcze.Value + "','" + this.zcjb.Value +
            //    "','" + this.qylb.Value + "','" + this.yyzzzch.Value+"','待审核')";
            sSQL = "insert into 材料供应商信息表(供应商,组织机构编号,地区名称,联系人手机,联系地址,联系人,单位类型,经营范围,"+
                "单位简称,法定代表人,注册资金,注册日期,企业类别,联系人QQ,传真,主页,地址,开户银行,银行账户,备注,营业执照注册号," +
                "企业员工人数,资产总额,注册级别,资质等级,是否启用,邮编,电子邮箱,电话,账户名称,审批结果)values"+
                "('" + this.gys.Value + "','" + this.zzjgbh.Value + "','" + qymc + "','" + this.lxrsj.Value + "',"+
                "'" + this.lxdz.Value + "','" + this.lxr.Value + "','" + this.lx.Value + "','" + this.jyfw.Value + "',"+
                "'" + this.dwjc.Value + "','" + this.fddbr.Value + "','" + zczj + "','" + this.zcrq.Value + "',"+
                "'" + this.qylb.Value + "','" + this.lxrqq.Value + "','" + this.cz.Value + "','" + this.zy.Value + "',"+
                "'" + this.dz.Value + "','" + this.khyh.Value + "','" + this.yhzh.Value + "','" + this.bz.Value + "',"+
                "'" + this.yyzzzch.Value + "','" + qyygrs + "','" + this.zcze.Value + "','" + this.zcjb.Value + "',"+
                "'" + this.zzdj.Value + "','" + sfqy + "',' "+this.yb.Value+"','" + this.dzyx.Value + "',"+
                "'" + this.dh.Value + "','" + this.zhmc.Value + "','通过')";
            if (objConn.ExecuteSQL(sSQL, false))
            {
                //蒋，2014年8月21日更改sql语句
                //sSQL = "update 材料供应商信息表 set gys_id=myID,updatetime=(select getdate()) where 供应商='" + this.gys.Value + "' and 营业执照注册号='" + this.yyzzzch.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
                sSQL = "update 材料供应商信息表 set gys_id=myID,updatetime=(select getdate()) where 供应商='" + this.gys.Value + "' and 联系人手机='" + this.lxrsj.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
                b = objConn.ExecuteSQL(sSQL, true);
                if (!b)
                { objConn.MsgBox(this.Page, sSQL); }
            }
            else
            {
                objConn.MsgBox(this.Page, sSQL);
            }
            sSQL = "select gys_id from 材料供应商信息表 where 供应商='" + this.gys.Value + "' and 联系人手机='" + this.lxrsj.Value + "' and 组织机构编号='" + this.zzjgbh.Value + "'";
            gys_id = objConn.DBLook(sSQL);
            this.gys_id_hid.Value = gys_id;
            Response.Write("<b/>" + gys_id);
            return gys_id;
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

     function updateFLfxs(id)
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
          xmlhttp.onreadystatechange = function () {
              if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                  var array = new Array();           //声明数组
                  array = xmlhttp.responseText;     //接收替换返回的json字符串
                  var json = array;
                  var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 	
                  for (var i = 0; i < myobj.length; i++) {  //遍历,将ajax返回的数据填充到文本框中				

                      document.getElementById('scs').innerHTML = myobj[i].scs;
                      document.getElementById('grade').innerHTML = myobj[i].dj
                      document.getElementById('scope').innerHTML = myobj[i].fw;
                      document.getElementById('fl_name').innerHTML = myobj[i].flname;
                      document.getElementById('pp_id').innerHTML = myobj[i].pp_id;
                      document.getElementById('pp_name').innerHTML = myobj[i].ppname;
                  }
              }
          }
          xmlhttp.open("GET", "xzgxs2.aspx?id=" + id, true);
          xmlhttp.send();  
        }    
 </script>
<body >
    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <div class="fxsxx">
    
<form id="Form1" runat="server">
    <%if (xzlx == "分销商")
  {%>
 <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">*品牌名称：
                    </td>
                    <td align="left">
                        <select id="ppmc" name="" style="width: 200px" onchange="updateFLfxs(this.options[this.options.selectedIndex].value)">
                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {%>
                               <option value='<%=dt_ppxx.Rows[i]["pp_id"].ToString() %>'><%=dt_ppxx.Rows[i]["品牌名称"]%></option>
                           <% }%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style="color: Blue" class="style2">*生产商：
                    </td>
                    <td align="left" class="style3">
                        <div id="scs"><%=dt_ppxx.Rows[0]["生产商"] %></div>
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
<%}%>
<%--蒋，2014年8月20日，注释新增类型为生产商的操作--%>
<%--<%
  else if (xzlx == "生产商")
  { %>
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
                    <td style="color: Blue" class="style1">*二级分类名称：
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
--%>





<table>
<tr>
<%--蒋，2014年8月20日，注释新增类型为生产商的操作--%>
<%--<%if (xzlx == "生产商")
  { %>
      <td  colspan="4"  style="text-align:center; padding-bottom:20px; font-size:16px; font-weight:bold; color:Black">新增生产厂商</td>
  <%}
  else--%>
  <%if(xzlx=="分销商")
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
   <td colspan="4">
    <select id="s0" class="fu1" runat="server"><option></option></select> 
    <select id="s1" class="fu1" runat="server"><option></option></select>
                <select id="s2" class="fu2" runat="server"><option></option></select> 
                <select id="s3" class="fu3" runat="server"><option></option></select>
                <script type="text/javascript"  language ="javascript" > 
                    <!--
                    //** Power by Fason(2004-3-11) 
                    //** Email:fason_pfx@hotmail.com
                    var s = ["s0","s1", "s2", "s3"];
                    var opt0 = ["-区域-","-省(市)-", "-地级市、区-", "-县级市、县、区-"];
                    for (i = 0; i < s.length - 1; i++)
                        document.getElementById(s[i]).onchange = new Function("change(" + (i + 1) + ")");
                    change(0);
                    //--> 
                </script>
   </td>               
       <%-- <td colspan="3"><input type="text" id="dqmc" runat="server" /></td>--%>
</tr>
<tr><td colspan="4"></td></tr>
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
</div>
<div class="foot">
<span class="foot2"><a href="#">网站合作</a>  |<a href="#"> 内容监督</a> | <a href="#"> 商务咨询</a> |  <a href="#">投诉建议010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012众材网版权所有      京ICP证0000111号      京公安网备110101000005号</p>
<p>地址：北京市海淀区天雅大厦11层  联系电话：010-87654321    技术支持：京企在线</p></span>
</div>
</body>
</html>
