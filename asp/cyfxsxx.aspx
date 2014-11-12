<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #txt_zcze
        {
            margin-top: 0px;
        }
    </style>
</head>
<BODY>
<script runat="server">
 public DataTable dt_gys = new DataTable();//材料供应商信息表
    public DataConn objConn = new DataConn();
    public string s_yh_id = "";
    public string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["gys_id"] != null && Request["gys_id"] != "")
        {
            string gys_id = Request["gys_id"];
            sSQL ="select 供应商,地区名称,联系人手机,联系地址,联系人,单位类型,经营范围," +
                 "单位简称,法定代表人,注册资金,注册日期,企业类别,联系人QQ,单位QQ号,传真,主页,地址,开户银行,银行账户,备注," +
                 "营业执照注册号,企业员工人数,资产总额,注册级别,资质等级,是否启用,邮编,电子邮箱,电话,账户名称" +
                 " from 材料供应商信息表 where gys_id ='" + gys_id + "'";
            dt_gys = objConn.GetDataTable(sSQL);
            if (dt_gys != null)
            {
                this.yyfw.Value = dt_gys.Rows[0]["经营范围"].ToString();
                this.bz.Value = dt_gys.Rows[0]["备注"].ToString();
                this.txt_zcjb.Value = dt_gys.Rows[0]["注册级别"].ToString();
                this.txt_gsmc.Value = dt_gys.Rows[0]["供应商"].ToString();
                this.txt_yyzzzch.Value = dt_gys.Rows[0]["营业执照注册号"].ToString();
                this.txt_zcrq.Value = dt_gys.Rows[0]["注册日期"].ToString();
                this.txt_zcze.Value = dt_gys.Rows[0]["资产总额"].ToString();
                this.txt_zzdj.Value = dt_gys.Rows[0]["资质等级"].ToString();
                this.txt_khyh.Value = dt_gys.Rows[0]["开户银行"].ToString();
                this.txt_zhmc.Value = dt_gys.Rows[0]["账户名称"].ToString();
                this.txt_gsszd.Value = dt_gys.Rows[0]["地区名称"].ToString();
                this.txt_gsdz.Value = dt_gys.Rows[0]["联系地址"].ToString();

                this.txt_gszy.Value = dt_gys.Rows[0]["主页"].ToString();
                this.txt_gscz.Value = dt_gys.Rows[0]["传真"].ToString();
                this.txt_xm2.Value = dt_gys.Rows[0]["联系人"].ToString();
                this.txt_sj2.Value = dt_gys.Rows[0]["联系人手机"].ToString();
                this.txt_yx2.Value = dt_gys.Rows[0]["电子邮箱"].ToString();
                this.txt_szbm2.Value = dt_gys.Rows[0]["地址"].ToString();
                this.txt_gsyb.Value = dt_gys.Rows[0]["邮编"].ToString();
                this.txt_gsdh.Value = dt_gys.Rows[0]["电话"].ToString();

                this.txt_qyygrs.Value = dt_gys.Rows[0]["企业员工人数"].ToString();
                this.txt_yhzh.Value = dt_gys.Rows[0]["银行账户"].ToString();
                this.txt_dwlx.Value = dt_gys.Rows[0]["单位类型"].ToString();
                this.txt_qylb.Value = dt_gys.Rows[0]["企业类别"].ToString();
                this.txt_zczj.Value = dt_gys.Rows[0]["注册资金"].ToString();
                this.txt_fddbr.Value = dt_gys.Rows[0]["法定代表人"].ToString();
                this.txt_gsQQ.Value = dt_gys.Rows[0]["单位QQ号"].ToString();
            }
        }
    }
</script>
<DIV class=box>
<table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
  <tr>
    <td height="34" colspan="6" align="center" bgcolor="#d9e5fd" style="font-size:14px; font-weight:bold;">新增分销商信息</td>
  </tr>
  <tr>
    <td height="20" colspan="6" align="right"></td>
  </tr>
  <tr>
    <td width="50" height="30">&nbsp;</td>
    <td width="120">公司名称：</td>
    <td width="329"><label for="textfield"></label>
      <input name="txt_gsmc" type="text" class="hyzhc_shrk" id="txt_gsmc" runat="server"/></td>
    <td width="50" align="right"></td>
    <td width="120">公司简称：</td>
    <td width="329"><input name="txt_gsjc" type="text" class="hyzhc_shrk" id="txt_gsjc" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>营业执照注册号：</td>
    <td><input name="txt_yyzzzch" type="text" class="hyzhc_shrk" id="txt_yyzzzch" runat="server"/></td>
    <td>&nbsp;</td>
    <td>公司QQ号：</td>
    <td><input name="txt_gsQQ" type="text" class="hyzhc_shrk" id="txt_gsQQ" runat="server"/></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>公司注册日期：</td>
    <td><input name="txt_zcrq" type="text" class="hyzhc_shrk" id="txt_zcrq" runat="server"/></td>
    <td>&nbsp;</td>
    <td>法定代表人：</td>
    <td><input name="txt_fddbr" type="text" class="hyzhc_shrk" id="txt_fddbr" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>资产总额（万元）：</td>
    <td><input name="txt_zcze" type="text" class="hyzhc_shrk" id="txt_zcze" runat="server"/></td>
    <td>&nbsp;</td>
    <td>注册资金（万元）：</td>
    <td><input name="txt_zczj" type="text" class="hyzhc_shrk" id="txt_zczj" runat="server"/></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>资质等级</td>
    <td><input type="text" class="hyzhc_shrk" id="txt_zzdj" runat="server"/></td>
    <td>&nbsp;</td>
    <td>注册级别</td>
    <td><input type="text" class="hyzhc_shrk" id="txt_zcjb" runat="server"/></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>开户银行：</td>
    <td><input name="txt_khyh" type="text" class="hyzhc_shrk" id="txt_khyh" runat="server" /></td>
    <td>&nbsp;</td>
    <td>企业类别</td>
    <td><input type="text" class="hyzhc_shrk" id="txt_qylb" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>账户名称：</td>
    <td><input name="txt_zhmc" type="text" class="hyzhc_shrk" id="txt_zhmc" runat="server"/></td>
    <td>&nbsp;</td>
    <td>单位类型：</td>
    <td><input type="text" class="hyzhc_shrk" id="txt_dwlx" runat="server"/></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>公司所在地：</td>
    <td><span class="fl">
      <input type="text" class="hyzhc_shrk" id="txt_gsszd" runat="server"/>
      
    </span></td>
    <td>&nbsp;</td>
    <td>银行账户：</td>
    <td><input name="txt_yhzh" type="text" class="hyzhc_shrk" id="txt_yhzh" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>公司地址：</td>
    <td><input name="txt_gsdz" type="text" class="hyzhc_shrk" id="txt_gsdz" runat="server" /></td>
    <td>&nbsp;</td>
    <td>企业员工人数：</td>
    <td><input name="txt_qyygrs" type="text" class="hyzhc_shrk" id="txt_qyygrs" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>公司主页：</td>
    <td><input name="txt_gszy" type="text" class="hyzhc_shrk" id="txt_gszy" runat="server" /></td>
    <td>&nbsp;</td>
    <td>公司电话：</td>
    <td><input name="txt_gsdh" type="text" class="hyzhc_shrk" id="txt_gsdh" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>公司传真：</td>
    <td><input name="txt_gscz" type="text" class="hyzhc_shrk" id="txt_gscz" runat="server"/></td>
    <td>&nbsp;</td>
    <td>公司邮编：</td>
    <td><input name="txt_gsyb" type="text" class="hyzhc_shrk" id="txt_gsyb" runat="server" /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>联系人姓名：</td>
    <td><input name="txt_xm2" type="text" class="hyzhc_shrk" id="txt_xm2" runat="server" /></td>
    <td>&nbsp;</td>
    <td>联系人地址：</td>
    <td><input name="txt_szbm2" type="text" class="hyzhc_shrk" id="txt_szbm2" runat="server"  /></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td>联系人手机：</td>
    <td><input name="txt_sj2" type="text" class="hyzhc_shrk" id="txt_sj2" runat="server" /></td>
    <td>&nbsp;</td>
    <td>联系人邮箱：</td>
    <td><input name="txt_yx2" type="text" class="hyzhc_shrk" id="txt_yx2" runat="server" /></td>
  </tr>
  <tr>
    <td height="40">&nbsp;</td>
    <td>经营范围：</td>
    <td colspan="4" height="90px"><label for="textfield21"></label>
      <textarea class="hyzhc_shrk2" cols="40" id="yyfw" name="yyfw" runat="server"  rows="6" style="30%" ></textarea></td>
  </tr>
  <tr>
    <td height="66">&nbsp;</td>
    <td>备 注：</td>
    <td colspan="4" height="60px"><textarea class="hyzhc_shrk3" runat="server" cols="40" id="bz" name="bz" rows="6" style="30%"></textarea></td>
  </tr>
</table>
</BODY>
</html>
