
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
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�����������Ϣ3</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>
<script runat="server">
    public string sSQL = "";
    public DataTable dt_gysxx = new DataTable();//���Ϲ�Ӧ����Ϣ��
    public DataConn objConn = new DataConn();
    public DataTable dt_ppxx = new DataTable();//Ʒ���ֵ��
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request["xl"] == "scs")
        {
            if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
            {
                string gys_id = Request["gys_id"];
                sSQL = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,ע������,ע���ʽ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where ��Ӧ��='" + gys_id + "'";
                dt_gysxx = objConn.GetDataTable(sSQL);
                sSQL = "select pp_id,Ʒ������ from Ʒ���ֵ�  where scs_id='"+gys_id+"'";
                dt_ppxx = objConn.GetDataTable(sSQL);
            }
        }
    }
    </script>
<body>
	  <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->
    <form id="form1" action="">
    <table width="1000" border="0" align="left" cellspacing="0" style="border:1px solid #dddddd; font-size:12px;">
    <tr>
      <td height="34" colspan="6" align="left" bgcolor="#f7f7f7" style="font-size:14px; font-weight:bold;">&nbsp;&nbsp;�ù�˾����Ϣ����</td>
    </tr>
    <tr>
      <td height="20" colspan="6" align="right"></td>
    </tr>
    <tr>
      <td width="50" height="30">&nbsp;</td>
      <td class="style11">��˾���ƣ�</td>
      <td width="329"><label for="textfield"></label>
        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" onclick="return companyname_onclick()" /></td>
      <td width="50" align="right"></td>
      <td class="style12">��˾��ַ��</td>
      <td width="329"><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��˾�绰��</td>
      <td><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/></td>
      <td>&nbsp;</td>
      <td class="style12">��˾��ҳ��</td>
      <td><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��˾���棺</td>
      <td><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">��˾������</td>
      <td><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" /></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td class="style11">��ϵ��������</td>
      <td><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" /></td>
      <td>&nbsp;</td>
      <td class="style12">��ϵ�˵绰��</td>
      <td><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" /></td>
    </tr>
    <tr>
      <td height="40">&nbsp;</td>
      <td class="style11">���鷶Χ��</td>
      <td colspan="4" height="90px"><label for="textfield21"></label>
         <input name="Business_Scope" style="height:70px; width:795px;" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" /></td>
    </tr>
  </table>
                      <div class="ggspp" runat="server" id="ggspp">
                        <div style="font-size:14px; font-weight:bold; line-height:36px; float:left; width:100%; background-color:#f7f7f7;">&nbsp;&nbsp;��˾���������Ʒ������</div>
                                <%foreach (System.Data.DataRow row in dt_ppxx.Rows)
                                  {%>
                                   <div class="fgstp">
                                        <img src="images/wwwq_03.jpg" />
                                        <span class="fdlpp1">
                                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                                            <%=row["Ʒ������"].ToString() %>
                                        </span>
                                    </div>
                                 <%} %>     
                    </div>	
    </form>
     <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  
</body>
</html>



