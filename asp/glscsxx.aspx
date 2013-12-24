<!--      
	   管理生产商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glscsxx.aspx 
       传入参数：无    
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理生厂商信息</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>


<script runat="server">

       
        protected DataTable dt_gysxx = new DataTable();  //分销商信息(材料供应商信息表)
        protected DataTable dt_ppxx = new DataTable();  //分销商信息(材料供应商信息表)
        protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            String yh_id = Convert.ToString(Session["yh_id"]);
         
			
            String str_gysxx = "select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机,gys_id from 材料供应商信息表 where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "品牌字典");
            dt_gysxx = ds_gysxx.Tables[0]; 

            if (dt_gysxx.Rows.Count == 0) Response.Redirect("gyszym.aspx");

            gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
							
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,pp_id from 品牌字典 where 是否启用='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "品牌字典");
            dt_ppxx = ds_ppxx.Tables[0];   
			       
            conn.Close();              
            
        }

       		
	
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
        <div class="fxsxx">
            <span class="fxsxx1">贵公司的详细信息如下</span>

            <div class="fxsxx2">
                <dl>
                    <dd>贵公司名称：</dd>
                    <dt>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" /></dt>
                    <dd>贵公司地址：</dd>
                    <dt>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地址"] %>"/></dt>
                    <dd>贵公司电话：</dd>
                    <dt>
                        <input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["电话"] %>"/></dt>
                    <dd>贵公司主页：</dd>
                    <dt>
                        <input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" /></dt>
                    <dd>贵公司传真：</dd>
                    <dt>
                        <input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["传真"] %>"/></dt>
                    <dd>贵公司地区：</dd>
                    <dt>
                        <input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地区名称"] %>"/></dt>
                    

                    <!--
     <dd>贵公司logo：</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>贵公司图片：</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />选中删除</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
    
    -->



                    <dd>联系人姓名：</dd>
                    <dt>
                        <input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人"] %>" /></dt>
                    <dd>联系人电话：</dd>
                    <dt>
                        <input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" />

                    </dt>


                </dl>
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["gys_id"] %>"/>
                    <input type="submit" value="保存" />

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">贵公司品牌如下</span>
                    
                    <% foreach (System.Data.DataRow row in dt_ppxx.Rows){%>
                    <div class="fgstp">
                        <img src="images/wwwq_03.jpg" />
                        <span class="fdlpp1">
                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                            <%=row["品牌名称"].ToString() %>
                        </span>
                    </div>

                    <%} %>
                    
                </div>
            </div>
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">删除选中品牌</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新品牌</a></span>
        </div>
    



	  

    <script>
        function AddNewBrand(id)
        {
             var url = "xzpp.aspx?gys_id=" + id;
             window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand()
        {
            var r = confirm("请确认您将删除此品牌!");
            if (r == true) {

                var brand_str = "?pp_id=";
                var brands = document.getElementsByName("brand");

                for (var i = 0; i < brands.length; i++) {
                    if (brands[i].checked) {

                        brand_str = brand_str + "," + brands[i].value;
                    }

                }

                var url = "scpp.aspx" + brand_str;
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
        }
    </script>


    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->




   



</body>
</html>
