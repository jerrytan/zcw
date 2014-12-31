/// <reference path="jquery-1.4.1.js" />
/// <reference path="MyControl.js" />

function gyszcLZP() {
    if ($("#txt_gsmc").val() == null || $("#txt_gsmc").val() == "请填写工商局注册的全称（4-40位字符）") {
        MsgShow("请输入公司名称！");
        return false;
    } else {
        $.ajax({
            type: 'get',
            //async: true, //是否同步
            data: { 'action': 'gysgsmc', 'gsmc': $("#txt_gsmc").val() },
            url: "Ashx/zcHandler.ashx",
            success: function (data) {
                if (data == "1") {
                    MsgShow("该公司已注册，请联系公司管理员");
                    window.location.href = 'index.aspx';
                }
            }
        });
    }
    if ($("#txt_gsQQ").val() == null || $("#txt_gsQQ").val() == "") {
        MsgShow("请输入公司QQ");
        return false;
    } else {
        $.ajax({
            type: 'get',
            //async: true, //是否同步
            data: { 'action': 'gysqq', 'gysqq': $("#txt_gsQQ").val() },
            url: "Ashx/zcHandler.ashx",
            success: function (data) {
                if (data == "1") {
                    MsgShow("该QQ已注册！请重新输入！");
                    return false;
                }
            }
        });
    }
    if ($("#txt_yyzzzch").val() == null || $("#txt_yyzzzch").val() == "") {
        MsgShow('请输入营业执照注册号');
        return false;
    }
    if ($("#txt_zcrq").val() == null || $("#txt_zcrq").val() == "") {
        MsgShow('请输入公司注册日期');
        return false;
    }
    if ($("#txt_zczj").val() == null || $("#txt_zczj").val() == "") {
        MsgShow('请输入注册资金');
        return false;
    }
    if ($("#dwlx").val() == null || $("#dwlx").val() == "") {
        MsgShow('请选择单位类型');
        return false;
    }
    if ($("#txt_gsdz").val() == null || $("#txt_gsdz").val() == "") {
        MsgShow('请输入公司地址');
        return false;
    }
    if ($("#txt_gsdh").val() == null || $("#txt_gsdh").val() == "") {
        MsgShow('请输入公司电话');
        return false;
    }
    if ($("#jyfw").val() == null || $("#jyfw").val() == "") {
        MsgShow('请输入经营范围');
        return false;
    }
    if ($("#txt_xm").val() == null || $("#txt_xm").val() == "") {
        MsgShow('请输入联系人姓名');
        return false;
    }
    if ($("#txt_sj").val() == null || $("#txt_sj").val() == "") {
        MsgShow('请输入联系人手机号');
        return false;
    }
}