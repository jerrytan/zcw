<!--
        新材料,用于首页
        文件名：newproducts.aspx
        传入参数：无     
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"> 
         
		 

        protected DataTable dt = new DataTable();   //材料名字,存放地址(材料多媒体信息表)        
        protected void Page_Load(object sender, EventArgs e)
        {		      
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter("select 存放地址,材料名称,cl_id from 材料多媒体信息表 where  是否上头条='是' and 媒体类型 = '图片' and 大小='大'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料多媒体信息表");            
            dt = ds.Tables[0];     		
			
          
		   
        }		
        
</script>

<div class="qyjs">
    <script type="text/javascript">
        var imgUrl = new Array();
        var imgtext = new Array();
        var imgLink = new Array();
	<% 
		 Response.Write("imgUrl[1] = '"+dt.Rows[0]["存放地址"].ToString()+"';\n");
		 Response.Write("imgtext[1] = '"+dt.Rows[0]["材料名称"].ToString()+"'\n");
		 Response.Write("imgLink[1] = 'clxx.aspx?cl_id="+dt.Rows[0]["cl_id"].ToString()+"';\n"); 
		 Response.Write("imgUrl[2] = '"+dt.Rows[1]["存放地址"].ToString()+"';\n");
		 Response.Write("imgtext[2] = '"+dt.Rows[1]["材料名称"].ToString()+"';\n");
		 Response.Write("imgLink[2] = 'clxx.aspx?cl_id="+dt.Rows[1]["cl_id"].ToString()+"';\n");       
		 Response.Write("imgUrl[3] = '"+dt.Rows[2]["存放地址"].ToString()+"';\n");
		 Response.Write("imgtext[3] = '"+dt.Rows[2]["材料名称"].ToString()+"';\n");
		 Response.Write("imgLink[3] = 'clxx.aspx?cl_id="+dt.Rows[2]["cl_id"].ToString()+"';\n");       
		     
		%>


        var focus_width1 = 536
        var focus_height2 = 227
        var text_height2 = 0
        var swf_height1 = focus_height2 + text_height2
        var pics = "", links = "", texts = "";
        for (var i = 1; i < imgUrl.length; i++) { pics = pics + ("|" + imgUrl[i]); links = links + ("|" + imgLink[i]); texts = texts + ("|" + imgtext[i]); }
        pics = pics.substring(1); links = links.substring(1); texts = texts.substring(1);
        document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="" width="' + focus_width1 + '" height="' + swf_height1 + '">');
        document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="images/js_hz.swf"><param name="quality" value="high"><param name="bgcolor" value="#f0f0f0"><param name="color" value="#ff0000">');
        document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
        document.write('<param name="FlashVars" value="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width1 + '&borderheight=' + focus_height2 + '&textheight=' + text_height2 + '">');
        document.write('<embed src="images/js_hz.swf" wmode="opaque" FlashVars="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width1 + '&borderheight=' + focus_height2 + '&textheight=' + text_height2 + '" menu="false" bgcolor="#F0F0F0" quality="high" width="' + focus_width1 + '" height="' + focus_height2 + '" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="" />');
        document.write('</object>');
    </script>
</div>

<span class="gd"><a href="#">查看更多材料...</a></span>















