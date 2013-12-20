<!--
          新增品牌  (生产商增加新的品牌)
		  文件名: xzpp.aspx              
		  传入参数gys_id
		  
         
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<script type="text/javascript" language="javascript"> 

function updateArea2(id)
 {
    
	var xmlhttp;
	if (window.XMLHttpRequest)
   {// code for IE7+, Firefox, Chrome, Opera, Safari
  
	xmlhttp=new XMLHttpRequest();
   }
else
	
   {// code for IE6, IE5
 
	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
   }
 xmlhttp.onreadystatechange=function()
	
   {
   if (xmlhttp.readyState==4 && xmlhttp.status==200)
     {
        //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
		 alert("111"); 
		document.getElementById("ejflname").innerHTML=xmlhttp.responseText;
		
		alert(document.getElementById("ejflname").innerHTML); 
     }
   }  
 
	xmlhttp.open("GET","xzpp.aspx?id="+id,true);
	 
	xmlhttp.send();
}


 </script>
</head>
<body>


<script runat="server">

        public List<OptionItem> Items1 { get; set; }
        public List<OptionItem> Items2 { get; set; }		
        public class OptionItem
        {
          public string Name { get; set; }        //下拉列表显示名属性
		  public string GroupsCode {get; set ; }  //下拉列表分类编码属性             
       
        }
        protected DataTable dt = new DataTable();   //材料分类大类
		protected DataTable dt1 = new DataTable();  //材料分类小类
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            SqlDataAdapter da = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "材料分类表");            
            dt = ds.Tables[0];
            
			string type = Request["id"];   //获取大类穿过来的分类编码
            SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where left(分类编码,2)='"+type+"'and len(分类编码)='4'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "材料分类表");            
            dt1 = ds1.Tables[0];			
			
			                 
            this.Items1 = new List<OptionItem>();  //数据表DataTable转集合  
            this.Items2 = new List<OptionItem>();           
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];

                if (Convert.ToString(dr["分类编码"]).Length == 2)
                {
                    OptionItem item = new OptionItem();
                    item.Name = Convert.ToString(dr["显示名字"]);
                    item.GroupsCode = Convert.ToString(dr["分类编码"]);
                    this.Items1.Add(item);   //将大类存入集合
                }
            }
            
            for (int x = 0; x < dt1.Rows.Count; x++)
            { 			   
                DataRow dr = dt1.Rows[x];
                if (Convert.ToString(dr["分类编码"]).Length == 4)
                {
                    OptionItem item1 = new OptionItem();  
                    item1.Name = Convert.ToString(dr["显示名字"]);
                    item1.GroupsCode = Convert.ToString(dr["分类编码"]);
                    this.Items2.Add(item1);					
                }
				
            }

            
			string gys_id = Request["gys_id"];
            if (Request.Form["brandname"] != null)  //新增品牌写入数据库
            {
                conn.Open(); 
                //string gysid = Request["gysid"]; 				
                string brandname = Request["brandname"];            //品牌名称
                string ejflname = Request["ejflname"];              //二级分类名称
                string grade = Request.Form["grade"];               //等级
                string startuser = Request.Form["startuser"];       //是否启用
                string scope = Request["scope"];                    //范围       
                                         
                string sql = "insert into  品牌字典 (品牌名称,分类名称,等级,是否启用,范围)values('" + brandname + "','" + ejflname + "','" + grade + "',1,'" + scope + "' ) ";
				SqlCommand cmd2 = new SqlCommand(sql, conn);
                int ret = (int)cmd2.ExecuteNonQuery();
				
				string sql2 = " update 品牌字典 set pp_id=(select myId from 品牌字典 where 品牌名称='"+brandname+" ') where 品牌名称='"+brandname+"' ";
				SqlCommand cmd3 = new SqlCommand(sql2, conn);
                int ret1 = (int)cmd3.ExecuteNonQuery();
				
				
                conn.Close();

            }	                    
		
        }

  
   
</script>


    <center>
	    <%string gys_id = Request["gys_id"];%>
		
        <form action="xzpp.aspx?gys_id=<%=gys_id%>" method="get">
		 <div id="myDiv"></div>
        <table border="0" width="600px">               
				
                <tr>
                <td style="width: 120px;color:Blue">
                    一级分类名称：
                </td>
                <td align="left">
                    <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateArea2(this.options[this.options.selectedIndex].value)">
                         
						 <% foreach(var v  in Items1){%>
						
						 <option value="<%=v.GroupsCode %>" ><%=v.Name%></option>
						 <%}%> 
                    </select>	
                </td>
                </tr>
				
				
                <tr>
                <td style="width: 120px;color:Blue" >
                    二级分类名称：
                </td>
                <td align="left">
                    <select id="ejflname" name="ejflname" style="width: 250px ">
					
                    <% foreach(var v  in Items2){%>
				    <option value="<%=v.Name%>"><%=v.Name%></option>
				    <%}%>
					
                    </select>
                </td>
                </tr>  
				
				<tr >
                <td  style="color:Blue"  >
                    供应商id
                </td>
				<td align="left"><input type="text" id="" name="gysid" value="<%=Request.Form["gysid"] %>" /></td>
                </tr>
				
                <tr>
                <td style="color:Blue">
                    品牌名称：
                </td>                
                <td align="left">
                <input type="text" id="" name="brandname" value="<%=Request.Form["brandname"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td style="color:Blue">
                    等级：
                </td>
                <td align="left">
                    <input type="text" id="grade" name="grade" style="width: 150px" value="<%=Request.Form["grade"] %>"/>
                </td>
                </tr>
				
			    <tr>
                <td style="color:Blue">
                    是否启用：
                </td>
                <td align="left">
                    <input type="text" id="startuser" name="startuser" style="width: 150px" value="<%=Request.Form["startuser"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td valign="top" style="color:Blue">
                    范围：
                </td>
                <td align="left">                   
                    <input type="text" id="scope" name="scope" style="width: 250px; height:100px" value="<%=Request.Form["scope"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td >                    
                    <input type="submit" id="btnSend" value="保存" style="width: 100px" />
                </td>
				<td align="left">                    
                    <a href="glsccsxxym.aspx?gys_id=<%=gys_id%>">返回上一页</a>
                </td>
                </tr>
        </table>
        </form>
    </center>
    </body>
</html>







