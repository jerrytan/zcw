<!--
        新材料,用于首页
        文件名：newproducts.aspx
        传入参数：无
        owner:丁传宇     
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>

<div class="qyjs">
    <script type="text/javascript">
    
        window.onload = function () {
            var runimg = new runImg();
            runimg.count = 3;
    <%
            string imgtype = "*.BMP|*.JPG|*.GIF|*.PNG";
            string[] ImageType = imgtype.Split('|');
            
            string img="";
            for (int i = 0; i < ImageType.Length; i++)
            {
                string [] imgurl = Directory.GetFiles(Server.MapPath("images\\topImg\\img\\"), ImageType[i]);
                string linkStr=Server.MapPath("images\\topImg\\html\\");
               
                for (int j = 0; j < imgurl.Length; j++)
                {   
                    string[] textStr=imgurl[j].Split(new[]{'\\','.'});
                    if (j==0) {
                         img=img+"\"<img src=\\\"images/topImg/img/"+textStr[textStr.Length-2]+"."+textStr[textStr.Length-1]+"\\\" >\"";
                    }else {
                        img=img+",\"<img src=\\\"images/topImg/img/"+textStr[textStr.Length-2]+"."+textStr[textStr.Length-1]+"\\\" >\"";
                    }
                }
            }
            Response.Write("runimg.imgurl=["+img+"]");
		%>
            //runimg.imgurl = [img];
            runimg.info("#box");
            runimg.action("#box");
        }
        document.write("<div id='box' ></div>");
    </script>
</div>
<%--<span class="gd"><a href="#"></a></span>--%>















