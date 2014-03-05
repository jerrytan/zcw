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
				 document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax返回的供应商id	供向表单提交时使用	  				              
				
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
            String yh_id = Convert.ToString(Session["GYS_YH_ID"]);   //获取用户id
			
			String str_type = "select 单位类型 ,gys_id from  材料供应商信息表 where yh_id='"+yh_id+"' ";  //查询单位类型
			SqlDataAdapter da_type = new SqlDataAdapter(str_type, conn);
			DataSet ds_type = new DataSet();
            da_type.Fill(ds_type, "材料供应商信息表");
            DataTable dt_type = ds_type.Tables[0];
			string gys_type = Convert.ToString(dt_type.Rows[0]["单位类型"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //供应商id   141
			if (gys_type.Equals("生产商"))
			{
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
                ite.Gys_name = Convert.ToString(dt.Rows[0]["供应商"]);  //没循环一次 把循环的分销商存入集合
                ite.Gys_sid = Convert.ToString(dt.Rows[0]["gys_id"]);
                this.Items2.Add(ite); 
			  }
            
            
			  string str_fxsid = Convert.ToString(dt_fxs_id.Rows[0]["fxs_id"]);   //获取第一个分销商id			
			  //根据不同的分销商id 查询不同的分销商信息
              String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+str_fxsid+"' ";
              SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			  DataSet ds_gysxx = new DataSet();
              da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
              dt_gysxx = ds_gysxx.Tables[0];
			  
			  SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,pp_id from 分销商和品牌对应关系表 where 是否启用='1' and fxs_id='"+str_fxsid+"' ", conn);
              DataSet ds_ppxx = new DataSet();
              da_ppxx.Fill(ds_ppxx, "分销商和品牌对应关系表");
              dt_ppxx = ds_ppxx.Tables[0]; 
			}
			if (gys_type.Equals("分销商"))
			{
               //如果是分销商信息 直接根据yh_id 查询供应商信息 
               String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id "
			   +"from 材料供应商信息表 where  yh_id='"+yh_id+"' ";
               SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			   DataSet ds_gysxx = new DataSet();
               da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
               dt_gysxx = ds_gysxx.Tables[0];
			   string fxs_id = Convert.ToString(dt_gysxx.Rows[0]["gys_id"]);
			   
			   SqlDataAdapter da_ppxx = new SqlDataAdapter("select 品牌名称,pp_id from 分销商和品牌对应关系表 where 是否启用='1' and fxs_id='"+fxs_id+"' ", conn);
               DataSet ds_ppxx = new DataSet();
               da_ppxx.Fill(ds_ppxx, "分销商和品牌对应关系表");
               dt_ppxx = ds_ppxx.Tables[0];  
			}
           
            if (dt_gysxx.Rows.Count == 0) 
			Response.Redirect("gyszym.aspx");
          
    						
			 
			       
            conn.Close();              
            
        }

       		
	
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <form id="update_fxs" name="update_fxs" action="glfxsxx2.aspx" method="post">
       <div class="fxsxx">
	   <span class="fxsxx1">
	   <%
		  string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
          SqlConnection conn = new SqlConnection(constr);
		  conn.Open();
		  string sp_result = "";        //首先声明审批结果变量
		  
          string id = Request["id"];    //获取glfxsxx2页面返回的供应商id
		  if(id=="")
		  {
            String yh_id = Convert.ToString(Session["GYS_YH_ID"]);   //获取用户id   90        
			string str_gys_id = "select 单位类型, gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' " ;//查询供应商id			
            SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
		    DataSet ds_gys_id = new DataSet();
            da_gys_id.Fill(ds_gys_id, "材料供应商信息表");
            DataTable dt_gys_id = ds_gys_id.Tables[0];
			string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //获取供应商id   141
			string str_gysid_type = Convert.ToString(dt_gys_id.Rows[0]["单位类型"]);
			
			
			if(str_gysid_type.Equals("生产商"))
			{
			   string str_pp_id = "select pp_id from 品牌字典 where scs_id='"+str_gysid+"' "; //查询品牌id		
               SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			   DataSet ds_pp_id = new DataSet();
               da_pp_id.Fill(ds_pp_id, "品牌字典");
               DataTable dt_pp_id = ds_pp_id.Tables[0];
			   string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //获取品牌id	185
            
			   
		       string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id in "    //139
			   +"(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"')";
		       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
               Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
		

               if (obj_check_gys_exist != null)
               {
                  int count = Convert.ToInt32(obj_check_gys_exist);
                  if (count != 0)  
                  {  //如果 供应商自己修改待审核表 有记录 查询审批结果
			         string str_select = "select 审批结果,gys_id from 供应商自己修改待审核表 where gys_id in "  //139
				     +"(select top 1 fxs_id from 分销商和品牌对应关系表 where pp_id='"+str_ppid+"')";
			         SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			         DataSet ds_select = new DataSet();
			         da_select.Fill(ds_select,"供应商自己修改待审核表");
			         DataTable dt_select = ds_select.Tables[0];
			         sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);   //通过
				     string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
			         if(sp_result!="")
			         {
                      if (sp_result.Equals("通过"))
                      {  
				  
				         //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                         string sql = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				         +"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
					     +"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				         +"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),"
					     +"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";
                     
                         SqlCommand cmd2 = new SqlCommand(sql, conn);
                         int ret = (int)cmd2.ExecuteNonQuery();
						 //this.Load += new EventHandler(Page_Load);      //重新调用页面 没成功
						 
						 String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+gysid+"' ";
                         SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			             DataSet ds_gysxx = new DataSet();
                         da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                         dt_gysxx = ds_gysxx.Tables[0];
				     
					     Response.Write("恭喜您!!您修改的数据已经保存,更新!");
                      }
			          if (sp_result.Equals("不通过"))
                      {
                         string sql_delete = "delete  供应商自己修改待审核表 where gys_id ='"+gys_id+"' ";			                     
                         SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                         int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					    Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
                      }
					  if (sp_result.Equals("待审核"))
                     {
					   //修改提交后 页面上显示的是 供应商自己修改待审核表 的信息
					   
					   String str_gysxx = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
					  +"经营范围,gys_id  from 供应商自己修改待审核表 where  gys_id ='"+gysid+"' ";
                      
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "供应商自己修改待审核表");
                       dt_gysxx = ds_gysxx.Tables[0];
			         
					   Response.Write("审核当中!");
                     }
			        }
                  }
			   }     
			}
			if(str_gysid_type.Equals("分销商"))
			{		             			   
		      string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+str_gysid+"' ";
		      SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
              Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();	
              if (obj_check_gys_exist != null)
              {
                 int count = Convert.ToInt32(obj_check_gys_exist);
                 if (count != 0)  
                 {  //如果 供应商自己修改待审核表 有记录 查询审批结果
			        string str_select = "select 审批结果,gys_id from 供应商自己修改待审核表 where gys_id='"+str_gysid+"' ";
				
			        SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			        DataSet ds_select = new DataSet();
			        da_select.Fill(ds_select,"供应商自己修改待审核表");
			        DataTable dt_select = ds_select.Tables[0];
			        sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);   //通过
				    string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
			        if(sp_result!="")
			        {
                      if (sp_result.Equals("通过"))
                      {  				  
				        //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                        string sql = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				        +"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
					    +"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),"
				        +"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+gysid+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+gysid+"'),"
					    +"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";
                     
                        SqlCommand cmd2 = new SqlCommand(sql, conn);
                        int ret = (int)cmd2.ExecuteNonQuery();
						//this.Load += new System.EventHandler(Page_Load);  
						
						String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+gysid+"' ";
                        SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			            DataSet ds_gysxx = new DataSet();
                        da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                        dt_gysxx = ds_gysxx.Tables[0];
                        					
				     
					    Response.Write("恭喜您!!您修改的数据已经保存,更新!");
                      }
			         if (sp_result.Equals("不通过"))
                     {
                       string sql_delete = "delete  供应商自己修改待审核表 where gys_id ='"+gys_id+"' ";			
                     
                       SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                       int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					   Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
                     }
					 if (sp_result.Equals("待审核"))
                     {
					   //修改提交后 页面上显示的是 供应商自己修改待审核表 的信息
					   
					   String str_gysxx = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
					  +"经营范围,gys_id  from 供应商自己修改待审核表 where  gys_id ='"+gysid+"'and 单位类型='分销商' ";
                      
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "供应商自己修改待审核表");
                       dt_gysxx = ds_gysxx.Tables[0];
			         
					   Response.Write("审核当中!");
                     }
			       }
                 }
			  }
			}
			
		 }
		else
		  {
		    string sql_gys_id = "select count(*) from 供应商自己修改待审核表 where gys_id='"+id+"' ";
			
		    SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
            Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();	
            if (obj_check_gys_exist != null)
            {
               int count = Convert.ToInt32(obj_check_gys_exist);
               if (count != 0)  
               {  //如果 供应商自己修改待审核表 有记录 查询审批结果
			    string str_select = "select 审批结果 from 供应商自己修改待审核表 where gys_id='"+id+"' ";
				
			    SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			    DataSet ds_select = new DataSet();
			    da_select.Fill(ds_select,"供应商自己修改待审核表");
			    DataTable dt_select = ds_select.Tables[0];
			    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]); 
			    if(sp_result!="")
			    {
                  if (sp_result.Equals("通过"))
                  {  
				  
				     //如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
                     string sql = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
				     +"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+id+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
					 +"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+id+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
				     +"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+id+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+id+"'),"
					 +"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+id+"') where gys_id ='"+id+"'";
                     
                     SqlCommand cmd2 = new SqlCommand(sql, conn);
                     int ret = (int)cmd2.ExecuteNonQuery();
					 
					 String str_gysxx = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+id+"' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "材料供应商信息表");
                     dt_gysxx = ds_gysxx.Tables[0];
				     
					 Response.Write("恭喜您!您修改的数据已经保存,更新!");
                  }
			      if (sp_result.Equals("不通过"))
                  {
                     string sql_delete = "delete  供应商自己修改待审核表 where gys_id ='"+gys_id+"' ";
					
                     
                     SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                     int ret = (int)cmd_delete.ExecuteNonQuery();
			        
					 Response.Write("您提交修改的数据不合理,请认真填写后在提交!");
                  }
				  if (sp_result.Equals("待审核"))
                     {
					   //修改提交后 页面上显示的是 供应商自己修改待审核表 的信息
					   
					   String str_gysxx = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
					  +"经营范围,gys_id  from 供应商自己修改待审核表 where  gys_id ='"+id+"' ";
                      
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "供应商自己修改待审核表");
                       dt_gysxx = ds_gysxx.Tables[0];
			         
					   Response.Write("审核当中!");
                     }
			    }
              }
			}
		  }
		  conn.Close();
		%>
	    </span>		                                
			
			
			<%	
            String user_id = Convert.ToString(Session["GYS_YH_ID"]);   //获取用户id 			
			String str_type = "select 单位类型 ,gys_id from  材料供应商信息表 where yh_id='"+user_id+"' ";  //查询单位类型
			SqlDataAdapter da_type = new SqlDataAdapter(str_type, conn);
			DataSet ds_type = new DataSet();
            da_type.Fill(ds_type, "材料供应商信息表");
            DataTable dt_type = ds_type.Tables[0];
			string gys_type = Convert.ToString(dt_type.Rows[0]["单位类型"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //供应商id   141
			//如果是分销商就没有下拉列表
			
			
			if (gys_type.Equals("生产商"))
			{
			%>
			<div class="zjgxs">
			<select name="" class="fug" style="width:200px" onchange="Update_gys(this.options[this.options.selectedIndex].value)">
			 <% foreach(var v in Items2){			
			%>			
			<option value="<%=v.Gys_sid%>"><%=v.Gys_name%></option>
			<%}%>
			
			</select> 
			<span class="zjgxs1"><a href="#">增加新的供销商</a></span>
			</div>
			<%}%>
            <span class="fxsxx1">贵公司的详细信息如下:</span>		

            <div class="fxsxx2">
                <dl>
                    <dd>贵公司名称：</dd>
                    <dt>
						<%if (sp_result.Equals("待审核")){%>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司名称"] %>" />
						<%}else{%>
						<input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" />
						<%}%>
						</dt>
						
                    <dd>贵公司地址：</dd>
                    <dt>                        
						<%if (sp_result.Equals("待审核")){%>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地址"] %>"/>
						<%}else{%>
						<input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司电话：</dd>
                    <dt>                       
						<%if (sp_result.Equals("待审核")){%>
                        <input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司电话"] %>"/>
						<%}else{%>
						<input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["电话"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司主页：</dd>
                    <dt>                        
						<%if (sp_result.Equals("待审核")){%>
                        <input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司主页"] %>" />
						<%}else{%>
						<input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" />
						<%}%>
						</dt>
						
                    <dd>贵公司传真：</dd>
                    <dt>                       
						<%if (sp_result.Equals("待审核")){%>
                        <input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司传真"] %>"/>
						<%}else{%>
						<input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["传真"] %>"/>
						<%}%>
						</dt>
						
                    <dd>贵公司地区：</dd>
                    <dt>                        
						<%if (sp_result.Equals("待审核")){%>
                        <input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地区"] %>"/>
						<%}else{%>
						<input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地区名称"] %>"/>
						<%}%>
						</dt>
                    

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
						<%if (sp_result.Equals("待审核")){%>
                        <input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人姓名"] %>" />
						<%}else{%>
						<input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人"] %>" />
						<%}%>
						</dt>
						
                    <dd>联系人电话：</dd>
                    <dt>                        
                        <%if (sp_result.Equals("待审核")){%>
                        <input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人电话"] %>" />
                        <%}else{%>
						<input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" />
						<%}%>
                    </dt>
					
					<dd>经营范围：</dd>
                    <dt>                       
                        <%if (sp_result.Equals("待审核")){%>
                        <input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" />
                        <%}else{%>
						<input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" />
						<%}%>
                    </dt>


                </dl>
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                    <input type="submit" value="保存" onclick="Update_gysxx()"/>

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
		
		function Update_gysxx(){
		alert("您更新的信息已提交,等待审核,请返回!");
		}
    </script>


    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->   



</body>
</html>



