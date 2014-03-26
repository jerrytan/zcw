//清空省
function ClearPOptions() {
    document.getElementById("s2").options.length = 0;
}
//根据地区得到省       
function GetProvince(pid,gysid) {
    ClearPOptions(); //先清空所有选项
    var gysid = gysid.toString();
    var answer;
    var pid = pid.toString();
    var xmlHttp;
    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //注册事件处理程序
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            //获取应答文本
            answer = xmlHttp.responseText;
            ShowOptions(answer);
        }
    };
    xmlHttp.open("get", "gysxx_ajax.aspx?type=1&pid=" + pid + "&r=" + Math.random +"&gysid="+gysid, true);
    xmlHttp.send();
}

//显示所有省
function ShowOptions(answer) {
    var str = answer.toString();
    var str_value;
    var str_pv;
    var option;
    var sheng;
    if (str.indexOf("@") > 0) //有连接符
    {
        str = str.substring(0, str.lastIndexOf("@"));//进行截取和分割
        str_value = str.split('@'); //进行分割
        for (var i = 0; i < str_value.length; i++) {
            str_value[i] = str_value[i].toString(); //转成字符串
            if (str_value[i] != null && str_value[i].indexOf("_") > 0)//不为空，并且存在对应组
            {
                str_pv = str_value[i].split('_'); //分割：31_上海市
                option = new Option(str_pv[1].toString(), str_pv[0].toString()); //创建option元素
                sheng = document.getElementById("s2");
                sheng.options.add(option); //将生成的option标签，加入到option下面
            }
        }
    }
}

//清除市
function ClearCOptions() {
    document.getElementById("s3").options.length = 0;
}
//根据省得到市
function GetCity(cid, gysid) {
    ClearCOptions(); //先清空所有选项
    var answer;
    var cid = cid.toString();
    var xmlHttp;
    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //注册事件处理程序
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            //获取应答文本
            answer = xmlHttp.responseText;
            ShowCitys(answer);
        }
    };
    xmlHttp.open("get", "gysxx_ajax.aspx?type=2&cid=" + cid + "&r=" + Math.random +"&gysid=" + gysid, true);
    xmlHttp.send();
}

//显示省下面的市
function ShowCitys(answer) {
    var str = answer.toString();
    var str_param;
    var str_value;
    var str_pv;
    var option;
    var city;

    var str_gv;

    if (str.indexOf("#") > 0) {
        str_param = str.split('#');
        if (str_param[0].indexOf("@") > 0) //有连接符
        {
            str_value = str_param[0].split('@'); //进行分割
            for (var i = 0; i < str_value.length; i++) {
                str_value[i] = str_value[i].toString(); //转成字符串
                if (str_value[i] != null && str_value[i].indexOf("_") > 0)//不为空，并且存在对应组
                {
                    str_pv = str_value[i].split('_'); //分割
                    option = new Option(str_pv[1].toString(), str_pv[0].toString()); //创建option元素
                    city = document.getElementById("s3");
                    city.options.add(option); //将生成的option标签，加入到option下面
                }
            }
        }
        if (str_param[1].indexOf("$") > 0)//分割供应商信息
        {
            str_gysxx = str_param[1].split('$');
            for (var j = 0; j < str_gysxx.length; i++) {
                str_gysxx[j] = str_gysxx[j].toString();
                if (str_gysxx[j] != null && str_gysxx[j].indexOf("|") > 0) {
                    str_gv = str_gysxx[j].split('|'); //辽宁阜新建材有限公司|张老板|13999192345|辽宁阜新市海州区 $
                    var array = [""];
                    array.push("<a href='gysxx.aspx?gys_id='");
                    array.push(str_gv[4].toString());
                    array.push("><div class='fxs2'><ul><li class='fxsa'>");
                    array.push(str_gv[0].toString());
                    array.push("</li><li>联系人:");
                    array.push(str_gv[1].toString());
                    array.push("</li><li>电话:");
                    array.push(str_gv[2].toString());
                    array.push("</li><li>地址:");
                    array.push(str_gv[3].toString());
                    array.push("</li></ul></div></a>");
                    var html = array.join("");
                    document.getElementById("fxs1").innerHTML = html;
                }
            }
        }
    }
}