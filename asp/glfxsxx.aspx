<!--      
	   管理分销商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glfxsxx.aspx 
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
    <title>管理分销商信息</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/javascript" language="javascript">

        function Update_gys(id) {
          
            
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            }
            else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
                var array = new Array();           //声明数组
		 		array = xmlhttp.responseText;     //接收替换返回的json字符串
				
		        var json = array;
                var myobj=eval(json);              //将返回的JSON字符串转成JavaScript对象 			
				
				
                for(var i=0;i<myobj.length;i++){  //遍历,将ajax返回的数据填充到文本框中				
			     
				 document.getElementById('companyname').value = myobj[i].gys_name;       //供应商
				 document.getElementById('address').value = myobj[i].gys_address;        //地址
				 document.getElementById('tel').value = myobj[i].gys_tel;                //电话  			 
				 document.getElementById('homepage').value = myobj[i].gys_homepage;       //主页
                 document.getElementById('fax').value = myobj[i].gys_fax;                 //传真
				 document.getElementById('area').value = myobj[i].gys_area;               //地区名称
				 document.getElementById('name').value = myobj[i].gys_user;               //联系人
				 document.getElementById('phone').value = myobj[i].gys_user_phone;          //联系人电话
				 document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax返回的供应商id		  				              
				
                }  
                   
                }
            }
            xmlhttp.open("GET", "glfxsxx3.aspx?id=" + id, true);
            xmlhttp.send();
        }


</script>
	
<script runat="server">

       
        public List<GYS_Objects> Items2 { get; set; }
		public class GYS_Object
        { //属性
           public string Sid { get; set; }          		
        }
        public class GYS_Objects
        { //属性
            public string Gys_sid { get; set; }
            public string Gys_name { get; set; }
        }
		
        protected DataTable dt_gysxx = new DataTable();  //分销商信息(材料供应商信息表)
        protected DataTable dt_ppxx = new DataTable();  //品牌信息(品牌字典)
		protected DataTable dt_gys_name = new DataTable();  //下拉列表供应商的名字(材料供应商信息表)
        protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            String yh_id = Convert.ToString(Session["yh_id"]);   //获取用户id
            
			string str_gys_id = "select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' " ;//查询供应商id			
            SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
			DataSet ds_gys_id = new DataSet();
            da_gys_id.Fill(ds_gys_id, "材料供应商信息表");
            DataTable dt_gys_id = ds_gys_id.Tables[0];
			string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //获取供应商id
			
			string str_pp_id = "select pp_id from 品牌字典 where scs_id='"+str_gysid+"' "; //查询品牌id		
            SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			DataSet ds_pp_id = new DataSet();
            da_pp_id.Fill(ds_pp_id, "品牌字典");
            DataTable dt_pp_id = ds_pp_id.Tables[0];
			string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //获取品牌id
			
			string str_fxs_id = "select fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"' "; //查询分销商id		
            SqlDataAdapter da_fxs_id = new SqlDataAdapter(str_fxs_id, conn);
			DataSet ds_fxs_id = new DataSet();
            da_fxs_id.Fill(ds_fxs_id, "分销商和品牌对应关系表");
            DataTable dt_fxs_id = ds_fxs_id.Tables[0];
			
			
            this.Items2 = new List<GYS_Objects>();
            for(int x=0;x<dt_fxs_id.Rows.Count;x++)
            {
                DataRow dr2 = dt_fxs_id.Rows[x];                                 		     
 			    GYS_Object item = new GYS_Object();                
                item.Sid = Convert.ToString(dr2["fxs_id"]);    //将不同的fxs_id存入集合
                string sid = item.Sid;
                String str_gys_name = "select 供应商,gys_id from 材料供应商信息表 where  gys_id='" + sid + "' and 单位类型='分销商' ";
                SqlDataAdapter da_gys_name = new SqlDataAdapter(str_gys_name, conn);
			    DataSet ds_gys_name = new DataSet();			  
                da_gys_name.Fill(ds_gys_name, "材料供应商信息表");
                DataTable dt = ds_gys_name.Tables[0];
                
               
                GYS_Objects ite = new GYS_Objects();
                ite.Gys_name = Convert.ToString(dt.Rows[0]["供应商"]);
                ite.Gys_sid = Convert.ToString(dt.Rows[0]["gys_id"]);
                this.Items2.Add(ite); 
			}
            
            
			string str_fxsid = Convert.ToString(dt_fxs_id.Rows[0]["fxs_id"]);   //获取分销商id			
			//根据不同的分销商id 查询不同的分销商信息
            String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,gys_id from 材料供应商信息表 where  gys_id='"+str_fxsid+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
            dt_gysxx = ds_gysxx.Tables[0];

			
           
            if (dt_gysxx.Rows.Count == 0) 
			Response.Redirect("gyszym.aspx");
            //gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
    						
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,pp_id from 分销商和品牌对应关系表 where 是否启用='1' and fxs_id='"+str_fxsid+"' ", conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "分销商和品牌对应关系表");
            dt_ppxx = ds_ppxx.Tables[0];   
			       
            conn.Close();              
            
        }

       		
	
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <form id="update_fxs" name="update_fxs" action="glfxsxx2.aspx" method="post">
        <div class="fxsxx">
		<div class="zjgxs">                                
			<select name="" class="fug" style="width:200px" onchange="Update_gys(this.options[this.options.selectedIndex].value)">
			
			<%foreach(var v in Items2){%>
			<option value="<%=v.Gys_sid%>"><%=v.Gys_name%></option>
			<%}%>
			
			</select> 
			<span class="zjgxs1"><a href="#">增加新的供销商</a></span>
			</div>
			
            <span class="fxsxx1">贵公司的详细信息如下:</span>		

            <div class="fxsxx2">
                <dl>
                    <dd>贵公司名称：</dd>
                    <dt>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" /></dt>
                    <dd>贵公司地址：</dd>
                    <dt>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>"/></dt>
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
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                    <input type="submit" value="保存" />

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">贵公司分销品牌如下</span>
                    
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
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">取消选中的分销品牌</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新分销品牌</a></span>
        </div>  
	  

    <script>
        function AddNewBrand(id) {
            var url = "xzfxpp.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand() {
            var r = confirm("请确认您将取消分销此品牌!");
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



