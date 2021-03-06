<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Page Language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible" />
    <title>管理分销商信息3</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<script runat="server">
    public DataTable dt_gys = new DataTable();//材料供应商信息表
    public DataConn objConn = new DataConn();
    public DataTable dt_ppxx = new DataTable();//品牌字典表
    public string s_yh_id = "";
    public string sSQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request["lx"] == "fxs")
        {
            if (Request["gsmc"] != null && Request["gsmc"] != "")
            {
                string gys_mc = Request["gsmc"];
                sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where 供应商='" + gys_mc + "'";
                dt_gys = objConn.GetDataTable(sSQL);
                sSQL = "select pp_id,品牌名称 from 品牌字典  where 生产商='" + gys_mc + "'";
                dt_ppxx = objConn.GetDataTable(sSQL);
                if (dt_ppxx == null)
                {
                    this.ggspp.Visible = false;
                }
                else
                {
                    this.ggspp.Visible = true;
                }
            }
        }
    }
</script>
<body>
    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <form id="form1" action="#">
    <table width="1000" border="0" align="left" cellspacing="0" style="border: 1px solid #dddddd;
        font-size: 12px;">
        <tr>
            <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size: 14px;
                font-weight: bold;">
                &nbsp;&nbsp;该公司的信息如下
            </td>
        </tr>
        <tr>
            <td height="20" colspan="6" align="right">
            </td>
        </tr>
        <tr>
            <td width="50" height="30">
                &nbsp;
            </td>
            <td class="style11">
                公司名称：
            </td>
            <td width="329">
                <label for="textfield">
                </label>
                <input name="companyname" type="text" readonly id="companyname" class="fxsxx3" value="<%=dt_gys.Rows[0]["供应商"]%>" />
            </td>
            <td width="50" align="right">
            </td>
            <td class="style12">
                公司地址：
            </td>
            <td>
                <input name="address" type="text" readonly id="address" class="fxsxx3" value="<%=dt_gys.Rows[0]["联系地址"]%>" />
            </td>
        </tr>
        <tr>
            <td height="30">
                &nbsp;
            </td>
            <td class="style11">
                公司电话：
            </td>
            <td>
                <input name="tel" type="text" id="tel" readonly class="fxsxx3" value="<%=dt_gys.Rows[0]["电话"]%>" />
            </td>
            <td>
                &nbsp;
            </td>
            <td class="style12">
                公司主页:
            </td>
            <td>
                <input name="homepage" type="text" readonly id="homepage" class="fxsxx3" value="<%=dt_gys.Rows[0]["主页"]%>" />
            </td>
        </tr>
        <tr>
            <td height="30">
                &nbsp;
            </td>
            <td class="style11">
                公司传真：
            </td>
            <td>
                <input name="fax" type="text" id="fax" readonly class="fxsxx3" value="<%=dt_gys.Rows[0]["传真"]%>" />
            </td>
            <td>
                &nbsp;
            </td>
            <td class="style12">
                公司地区：
            </td>
            <td>
                <input name="area" type="text" id="area" readonly class="fxsxx3" value="<%=dt_gys.Rows[0]["地区名称"]%>" />
            </td>
        </tr>
        <tr>
            <td height="30">
                &nbsp;
            </td>
            <td class="style11">
                联系人姓名：
            </td>
            <td>
                <input name="name" type="text" id="name" readonly class="fxsxx3" value="<%=dt_gys.Rows[0]["联系人"]%>" />
            </td>
            <td>
                &nbsp;
            </td>
            <td class="style12">
                联系人电话：
            </td>
            <td>
                <input name="phone" type="text" id="phone" readonly class="fxsxx3" value="<%=dt_gys.Rows[0]["联系人手机"]%>" />
            </td>
        </tr>
        <tr>
            <td height="40">
                &nbsp;
            </td>
            <td class="style11">
                经验范围：
            </td>
            <td colspan="4" height="90px">
                <label for="textfield21">
                </label>
                <%--<input name="Business_Scope" readonly style="height: 70px; width: 770px;" type="text"
                    id="Business_Scope" class="fxsxx3" value="<%=dt_gys.Rows[0]["经营范围"]%>" />--%>
                <textarea name="Business_Scope" id="Business_Scope" class="fxsxx3" style=" width:775px; height:65px;" readonly cols="110" rows="6"><%=dt_gys.Rows[0]["经营范围"]%></textarea>
            </td>
        </tr>
    </table>
    <div class="ggspp" runat="server" id="ggspp">
        <div style="font-size: 14px; font-weight: bold; line-height: 36px; float: left; width: 100%;
            background-color: #f7f7f7;">
            &nbsp;&nbsp;贵公司分销代理的品牌如下</div>
        <%foreach (System.Data.DataRow row in dt_ppxx.Rows)
          {%>
        <div class="fgstp">
            <img src="images/wwwq_03.jpg" />
            <span class="fdlpp1">
                <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                <%=row["品牌名称"].ToString() %>
            </span>
        </div>
        <%} %>
    </div>
    </form>
    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
</body>
</html>
