<!--
       供应商管理材料页面 可以删除选中的材料,可也增加新的材料
	   文件名:  gysglcl.aspx   
       传入参数：无 
       
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>供应商收藏页面</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<style>
 #menu { width:200px; margin:auto;}
 #menu h1 { font-size:12px;margin-top:1px; font-weight:100}
 #menu h2 { padding-left:15px; font-size:12px; font-weight:100}
 #menu ul { padding-left:15px; height:100px;overflow:auto; font-weight:100}
 #menu a { display:block; padding:5px 0 3px 10px; text-decoration:none; overflow:hidden;}
 #menu a:hover{ color:#000;}
 #menu .no {display:none;}
 #menu .h1 a{color:#000;}
 #menu .h2 a{color:#000;}
 #menu  h1 a{color:#000;}
</style>
<script language="JavaScript">
<!--    //
    function ShowMenu(obj, n) {
        var Nav = obj.parentNode;
        if (!Nav.id) {
            var BName = Nav.getElementsByTagName("ul");
            var HName = Nav.getElementsByTagName("h2");
            var t = 2;
        } else {
            var BName = document.getElementById(Nav.id).getElementsByTagName("span");
            var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
            var t = 1;
        }
        for (var i = 0; i < HName.length; i++) {
            HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
            HName[i].className = "";
        }
        obj.className = "h" + t;
        for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
        if (BName[n].className == "no") {
            BName[n].className = "";
            obj.innerHTML = obj.innerHTML.replace("+", "-");
        } else {
            BName[n].className = "no";
            obj.className = "";
            obj.innerHTML = obj.innerHTML.replace("-", "+");
        }
    }
//-->
</script>

    <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">                       
		

     		
    </script>

</head>

<body>


<!-- 头部开始-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- 头部结束-->


<script runat="server">

          public List<FLObject_yj> Items1 { get; set; }
          public List<FLObject_ej> Items2 { get; set; }
          public List<CLObject> Cllist { get; set; }
		  public Boolean userIsVIP = false;
		  
		  public class CLObject
          { //属性
  	        public string Cl_flbm { get; set; }  //分类编码(4位)
            public string Cl_Name { get; set; }  //具体的材料名称 
            public string Cl_id { get; set; }
          }
		  
		  public class FLObject_yj
          {  //属性
  	         public string flbm { get; set; }
             public string YJfl_name { get; set; }             
          }
		  
		  public class FLObject_ej
          { //属性
  	         public string Ej_flbm { get; set; }   
             public string Ejfl_Name { get; set; }     
          }
  
          

        protected DataTable dt_cl = new DataTable();    //根据供应商id查询显示名,分类编码(材料表)
        protected DataTable dt_yjfl = new DataTable();  //取一级分类显示名称(材料分类表)
		protected DataTable dt_ejfl = new DataTable();  //取二级分类显示名称(材料分类表)
		protected void Page_Load(object sender, EventArgs e)
		{
		   Products_gys_cl();
		}
		
        protected void Products_gys_cl()
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);            
			String yh_id = Convert.ToString(Session["yh_id"]);   //获取session中yh_id
			
			//根据用户id 查询供应商id
			SqlDataAdapter da_gys = new SqlDataAdapter("select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ", conn);   //141
            DataSet ds_gys = new DataSet();
            da_gys.Fill(ds_gys, "材料供应商信息表");           
            DataTable dt_gys = ds_gys.Tables[0];
			string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
			
			//根据供应商id 查询材料信息
            SqlDataAdapter da_cl = new SqlDataAdapter("select cl_id,显示名,分类编码 from 材料表 where gys_id='"+gys_id+"'and 是否启用='1' ", conn);
            DataSet ds_cl = new DataSet();
            da_cl.Fill(ds_cl, "材料表");           
            dt_cl = ds_cl.Tables[0];
			
			////数据表DataTable转集合                   
            this.Cllist = new List<CLObject>();
			for(int x=0;x<dt_cl.Rows.Count;x++)
            {
			    DataRow dr2 = dt_cl.Rows[x]; 		      
			    CLObject item = new CLObject();
                item.Cl_Name = Convert.ToString(dr2["显示名"]);   //具体的材料名字
                item.Cl_flbm = Convert.ToString(dr2["分类编码"]); //根据供应商id查询分类编码加入类的属性(分类编码长度为4位)
				item.Cl_id = Convert.ToString(dr2["Cl_id"]);
                this.Cllist.Add(item);              				 //加入集合
		    } 
			foreach(var v in this.Cllist)    //遍历集合
			{
			   if(v.Cl_flbm.ToString()!=null&Convert.ToString(v.Cl_flbm).Length==4)
			   {
			   string code = v.Cl_flbm.ToString().Substring(0, 2);	//取分类编码前两位再次进行查询 最终获得一级分类的名字	
			   SqlDataAdapter da_yjfl = new SqlDataAdapter("select  显示名字 from 材料分类表 where 分类编码='"+code+"' ", conn);
               DataSet ds_yjfl = new DataSet();
               da_yjfl.Fill(ds_yjfl, "材料分类表");           
               dt_yjfl = ds_yjfl.Tables[0];
			   }
			}
			this.Items1 = new List<FLObject_yj>();
			for(int x=0;x<dt_yjfl.Rows.Count;x++)
            {
			    DataRow dr = dt_yjfl.Rows[x]; 		      
			    FLObject_yj item = new FLObject_yj();
                item.YJfl_name = Convert.ToString(dr["显示名字"]);   //一级分类名称                
                this.Items1.Add(item);              				 //加入集合
		    } 
			
			//取二级分类名称
			SqlDataAdapter da_ejfl = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where  "
			+"分类编码 in(select 分类编码 from 材料表 where gys_id='"+gys_id+"'and 是否启用='1' )", conn);
            DataSet ds_ejfl = new DataSet();
            da_ejfl.Fill(ds_ejfl, "材料分类表");            
            dt_ejfl = ds_ejfl.Tables[0];
			
			this.Items2 = new List<FLObject_ej>();
			for(int x=0;x<dt_ejfl.Rows.Count;x++)
            {
			    DataRow dr = dt_ejfl.Rows[x]; 		      
			    FLObject_ej item = new FLObject_ej();
                item.Ejfl_Name = Convert.ToString(dr["显示名字"]);   //二级分类名称 
                item.Ej_flbm = Convert.ToString(dr["分类编码"]);     //二级分类编码 				
                this.Items2.Add(item);              				 //加入集合
		    }		                    
		    CancelFollowButton.Attributes.Add("onClick", "return confirm('您确定要删除该选中的材料吗？');");
        } 
          
          protected void dumpFollowCLs(object sender, EventArgs e)
          {
  	         string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr);             
  	         string yh_id = Session["yh_id"].ToString();
			 
			 //根据用户id 查询供应商id
			 SqlDataAdapter da_gys = new SqlDataAdapter("select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ", conn);
             DataSet ds_gys = new DataSet();
             da_gys.Fill(ds_gys, "材料供应商信息表");           
             DataTable dt_gys = ds_gys.Tables[0];
			 string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
  	         
			 //根据gys_id 查询材料表相关的数据 以便导出excel 表格
  	         string query_cl_gys = "select*from 材料表 where gys_id='"+gys_id+"' ";
  	
  	         SqlDataAdapter da = new SqlDataAdapter(query_cl_gys, conn);
             DataSet clds = new DataSet();
             da.Fill(clds, "材料表");              
             DataTable cldt = new DataTable();
             cldt = clds.Tables[0];
             outToExcel(cldt);
         }
		 
		    private StringBuilder  AppendCSVFields(StringBuilder argSource, string argFields)
            {
  	          return argSource.Append(argFields.Replace(",", " ").Trim()).Append(",");
            }
			public static void DownloadFile(HttpResponse argResp, StringBuilder argFileStream, string strFileName)
            {
		      try
		       {
  		          string strResHeader = "attachment; filename=" + Guid.NewGuid().ToString() + ".csv";
   	 	          if (!string.IsNullOrEmpty(strFileName))
   	 	          {
   	 		        strResHeader = "inline; filename=" + strFileName;
  	 	          }
  	 	          argResp.AppendHeader("Content-Disposition", strResHeader);//attachment说明以附件下载，inline说明在线打开
   	 	          argResp.ContentType = "application/ms-excel";
   	 	          argResp.ContentEncoding = Encoding.GetEncoding("GB2312"); 
   	 	          argResp.Write(argFileStream);
  	           }
   	          catch (Exception ex)
  	           {
  	 	         throw ex;
   	           }
            }
		    public void outToExcel(DataTable followcls) 
		    {  	
              StringWriter swCSV = new StringWriter();
              StringBuilder sbText = new StringBuilder();
              for (int i = 0; i < followcls.Columns.Count; i++)
              {
        	     AppendCSVFields(sbText,followcls.Columns[i].ColumnName);
              }
              sbText.Remove(sbText.Length - 1, 1);
              swCSV.WriteLine(sbText.ToString());
        
              for (int i = 0; i < followcls.Rows.Count; i++)
              {
        	     sbText.Clear();
        	     for (int j = 0; j < followcls.Columns.Count; j++)
                 {
          	       AppendCSVFields(sbText,followcls.Rows[i][j].ToString());
                 }
                 sbText.Remove(sbText.Length - 1, 1);
        	     swCSV.WriteLine(sbText.ToString());
              }
              string fileName = Path.GetRandomFileName();
              DownloadFile(Response, swCSV.GetStringBuilder(), fileName +".csv");
              swCSV.Close();
              Response.End();
           }
   
</script>



<form id="form1" runat="server">

<script runat="server">
          void Delete_cl(object sender, EventArgs e)
          {
		    
  	        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
  	        String yh_id = Convert.ToString(Session["yh_id"]);   //获取session中yh_id
			
			//根据用户id 查询供应商id
			SqlDataAdapter da_gys = new SqlDataAdapter("select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ", conn);
            DataSet ds_gys = new DataSet();
            da_gys.Fill(ds_gys, "材料供应商信息表");           
            DataTable dt_gys = ds_gys.Tables[0];
			string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
  	        
  	        //获取复选框选中的cl_id
  	        string clidstr =Request.Form["clid"];
  	        
			//通过获取的供应商id和cl_id进行删除
  	        string str_cancelfollow = "update 材料表 set 是否启用='0' where gys_id ='" +  gys_id + "' and cl_id in (" + clidstr + ")" ;
  	        SqlCommand cmd_cancelfollow = new SqlCommand(str_cancelfollow, conn);         
            cmd_cancelfollow.ExecuteNonQuery();
    
   
  	        conn.Close();
            Products_gys_cl();
         }
</script>

<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2">
<div id="menu">

 <% 
 	   int firstlevel = 0;
       foreach (var menu1 in this.Items1){
                    %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
                    <img src="images/biao2.jpg" /><%=menu1.YJfl_name%> &gt;</a></h1>
                    <span class="no">
                    <% 
 	                  int secondlevel = 0;
 		              foreach (var menu2 in this.Items2){
 	   	  
                    %>
                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=menu2.Ejfl_Name%></a></h2>
                        <ul class="no">
                          <% 
                            //二级下的分类产品要根据,具体的二级分类编码进行查询						  
                            							
							string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                            SqlConnection conn = new SqlConnection(constr); 
                            String yh_id = Convert.ToString(Session["yh_id"]);   //获取session中yh_id							
			                
							//根据用户id 查询供应商id
			                SqlDataAdapter da_gys = new SqlDataAdapter("select gys_id from 材料供应商信息表 where yh_id='"+yh_id+"' ", conn);
                            DataSet ds_gys = new DataSet();
                            da_gys.Fill(ds_gys, "材料供应商信息表");           
                            DataTable dt_gys = ds_gys.Tables[0];
							
			                string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
							string flbm = menu2.Ej_flbm;
							
                            SqlDataAdapter da_cls = new SqlDataAdapter("select cl_id,显示名,分类编码 from 材料表 where gys_id='"+gys_id+"'and 分类编码='"+flbm+"' ", conn);
                            DataSet ds_cls = new DataSet();
                            da_cls.Fill(ds_cls, "材料表");           
                            DataTable dt_cls = ds_cls.Tables[0];
						
                            foreach (System.Data.DataRow row in dt_cls.Rows){
      	        
                            %>
                            <a href="clbj.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString()%></a><input type="checkbox" name="clid" value="<%=row["cl_id"]%>" />选中                           
							<%    			    
   		                     }
   		       secondlevel++;
                            %>
                        </ul>
                        <% 	         
  	                       }
                        %>
                    </span>
                    <% 
 		firstlevel++;
                     } 
                    %>

        
 
 <span class="no">
 

 </span>
  
</div></div>
<div class="dlqqz3">

<a href="xzclym.aspx"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;

<!--
<a id="btnDeleteBatch" onclick="Delete_cl" href="#"><img src="images/scxzcl.jpg" border="0" /></a>
-->
<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg" runat="server" OnClick="Delete_cl" />

</div>
</div>


<div class="dlex">
            <%
	if (userIsVIP){
            %>            
                <div class="dlex1">
                    <asp:Button runat="server" ID="button1" Text="选择数据进入自身内部系统" OnClick="dumpFollowCLs" />
                </div>
            
            <%
	}else {
            %>
            
            <div class="dlex1">
                您可以把你管理的材料数据导出为excel，供下线使用
                <asp:Button runat="server" ID="button2" Text="全部导出为EXCEL" OnClick="dumpFollowCLs" />
            </div>
            <%
	}	
            %>

</div>
</form> 

<!--  footer 开始-->
<!-- #include file="static/footer.aspx" -->
<!-- footer 结束-->



</body>
</html>



