/// <reference path="jquery-1.4.1.js" />
function AddFxsPrice(obj) {
    _this = $(obj);
    var newPrice = _this.val().trim();
    var oldPrice = _this.next().text().trim();
    if (newPrice!=oldPrice) {
        if (confirm("是否更改实时报价？")) {
            var strs = _this.next().next().text().split(";");
            var clid = strs[0];
            var gysid = strs[1];
            var fxsid = strs[2];
            var gysPrice = _this.parent().prev().text();
            $.get("Ashx/AddFxsPrice.ashx", { "clid": clid, "gysid": gysid, "fxsid": fxsid, "newPrice": newPrice, "gysPrice": gysPrice }, function (data) {
                if (data == "0") {
                    alert("修改成功！");
                    _this.next().text(newPrice);
                } else {
                    alert("修改失败！");
                }
            });

        } else {
            _this.val(oldPrice);
        }
    }
}