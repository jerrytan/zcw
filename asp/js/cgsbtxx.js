function menuFix() {
    var sfEls = document.getElementById("nav").getElementsByTagName("li");
    for (var i = 0; i < sfEls.length; i++) {
        sfEls[i].onmouseover = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onMouseDown = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onMouseUp = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onmouseout = function () {
            this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
        }
    }
}
window.onload = menuFix;

var speed = 9//速度数值越大速度越慢
var demo = document.getElementById("demo");
var demo2 = document.getElementById("demo2");
var demo1 = document.getElementById("demo1");
demo2.innerHTML = demo1.innerHTML
function Marquee() {
    if (demo2.offsetWidth - demo.scrollLeft <= 0)
        demo.scrollLeft -= demo1.offsetWidth
    else {
        demo.scrollLeft++
    }
}
var MyMar = setInterval(Marquee, speed)
demo.onmouseover = function () { clearInterval(MyMar) }
demo.onmouseout = function () { MyMar = setInterval(Marquee, speed) }

function menuFix() {
    var sfEls = document.getElementById("nav").getElementsByTagName("li");
    for (var i = 0; i < sfEls.length; i++) {
        sfEls[i].onmouseover = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onMouseDown = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onMouseUp = function () {
            this.className += (this.className.length > 0 ? " " : "") + "sfhover";
        }
        sfEls[i].onmouseout = function () {
            this.className = this.className.replace(new RegExp("( ?|^)sfhover\\b"),
"");
        }
    }
}
window.onload = menuFix;