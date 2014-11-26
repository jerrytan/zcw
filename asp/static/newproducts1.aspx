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

<script runat="server"> 
         
        protected DataTable dt_ClMedia = new DataTable();   //材料名字,存放地址(材料多媒体信息表)
        protected DataConn dc = new DataConn();        
        protected void Page_Load(object sender, EventArgs e)
        {
            //string str_Sql = "select 存放地址,材料名称,cl_id from 材料多媒体信息表 where  是否上头条='是' and 媒体类型 = '图片' and 大小='大'";
            string str_Sql = "select 存放地址,材料名称,cl_id from 材料多媒体信息表 where  是否上头条='是' and 媒体类型 = '图片'";
            DataSet ds_ClMedia = new DataSet();            
            dt_ClMedia = dc.GetDataTable(str_Sql); 
        }	
        
</script>

<div class="qyjs">
    <script type="text/javascript">
        var imgUrl = new Array();
        var imgtext = new Array();
        var imgLink = new Array();
	
              imgUrl[1]="../images/topImg/img/1.jpg";
    imgtext[1]="山东明水农场完成大棚果蔬种植";
    imgLink[1]=escape("#");

    imgUrl[2]="../images/topImg/img/2.jpg";
    imgtext[2]="山东明水农场完成大棚果蔬种植";
    imgLink[2]=escape("#");

    imgUrl[3]="../images/topImg/img/3.jpg";
    imgtext[3]="山东明水农场完成大棚果蔬种植";
    imgLink[3]=escape("#");
    <%
//        if (dt_ClMedia!=null&&dt_ClMedia.Rows.Count>0) {   

//		     Response.Write("imgUrl[1] = '"+dt_ClMedia.Rows[0]["存放地址"].ToString()+"';\n");
//		     Response.Write("imgtext[1] = '"+dt_ClMedia.Rows[0]["材料名称"].ToString()+"'\n");
//		     Response.Write("imgLink[1] = 'clxx.aspx?cl_id="+dt_ClMedia.Rows[0]["cl_id"].ToString()+"';\n"); 
//		     Response.Write("imgUrl[2] = '"+dt_ClMedia.Rows[1]["存放地址"].ToString()+"';\n");
//		     Response.Write("imgtext[2] = '"+dt_ClMedia.Rows[1]["材料名称"].ToString()+"';\n");
//		     Response.Write("imgLink[2] = 'clxx.aspx?cl_id="+dt_ClMedia.Rows[1]["cl_id"].ToString()+"';\n");       
//		     Response.Write("imgUrl[3] = '"+dt_ClMedia.Rows[2]["存放地址"].ToString()+"';\n");
//		     Response.Write("imgtext[3] = '"+dt_ClMedia.Rows[2]["材料名称"].ToString()+"';\n");
//		     Response.Write("imgLink[3] = 'clxx.aspx?cl_id="+dt_ClMedia.Rows[2]["cl_id"].ToString()+"';\n");       
//		    }
		%>


        var focus_width1 = 536
        var focus_height2 = 227
        var text_height2 = 0
        var swf_height1 = "227" + "0"
        var pics = "", links = "", texts = "";
        for (var i = 1; i < imgUrl.length; i++) { 
            pics = pics + ("|" + imgUrl[i]); links = links + ("|" + imgLink[i]); texts = texts + ("|" + imgtext[i]); 
        }
        pics = pics.substring(1); links = links.substring(1); texts = texts.substring(1);
        document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="" width="536" height="227">');
        document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="images/js_hz.swf"><param name="quality" value="high"><param name="bgcolor" value="#f0f0f0"><param name="color" value="#ff0000">');
        document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
        document.write('<param name="FlashVars" value="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=536&borderheight=227&textheight=0">');
        document.write('<embed src="images/js_hz.swf" wmode="opaque" FlashVars="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=536&borderheight=227&textheight=0" menu="false" bgcolor="#F0F0F0" quality="high" width="536" height="227" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="" />');
        document.write('</object>');
    </script>
</div>

<span class="gd"><a href="#"></a></span>















