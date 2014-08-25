<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hyyhgl_wh.aspx.cs" Inherits="asp_hyyhgl_wh" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>维护用户信息</title>
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <link href="css/css.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="yhxx">
        <div id="yhxx_top">
            维护用户信息</div>
        <div class="yhxx_cont">
            <dl>
                <dd>
                    QQ号：</dd>
                <dt>
                    <label for="textfield">
                    </label>
                    <input name="QQ" type="text" class="shuru" id="txt_QQ" runat="server"/>
                </dt>
                <dd>
                    姓名：</dd>
                <dt>
                    <label for="textfield3">
                    </label>
                    <input type="text" name="txt_name" class="shuru" id="txt_name" runat="server"/>
                </dt>
                <dd>
                    手机号码：</dd>
                <dt>
                    <label for="textfield2">
                    </label>
                    <input type="text" name="txt_phone" class="shuru" id="txt_phone" runat="server"/>
                </dt>
                <dd>
                    邮箱：</dd>
                <dt>
                    <label for="textfield4">
                    </label>
                    <input type="text" name="txt_Email" class="shuru" id="txt_Email" runat="server"/>
                </dt>
                <dd>
                    角色权限：</dd>
                <dt>
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理生产商" id="cbx1" runat="server"/>
                        管理生产商</label>
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理分销商" id="cbx2" runat="server"/>
                        管理分销商</label>
                    <label>
                        <input type="checkbox" name="CheckboxGroup1" value="管理材料信息" id="cbx3" runat="server"/>
                        管理材料信息</label></dt>
            </dl>
        </div>
        <div id="yhxx_bottom">
            <asp:Button ID="btnSubmit" runat="server" Text="提交" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" onclick="btnSubmit_Click"/>
            <%--<input type="submit" name="btnDocNew" value="提交" 
                id="btnDocNew" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" />--%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%--<input type="submit" name="btnDocNew" value="取消" onclick="return VerifyMyIMP();"
                id="btnDocNew" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" />--%>
            <asp:Button ID="btnCancel" runat="server" Text="取消" class="filter" style="color: Black; border-style: None; font-family: 宋体;
                font-size: 12px; height: 20px; width: 37px;" onclick="btnCancel_Click"/>

        </div>
    </div>
    </form>
</body>
</html>
