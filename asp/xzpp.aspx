<!--
          ����Ʒ��  (�����������µ�Ʒ��)
		  �ļ���: xzpp.aspx              
		  �������gys_id
		  
         
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
          public string Name { get; set; }        //�����б���ʾ������
		  public string GroupsCode {get; set ; }  //�����б�����������             
       
        }
        protected DataTable dt = new DataTable();   //���Ϸ������
		protected DataTable dt1 = new DataTable();  //���Ϸ���С��
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            SqlDataAdapter da = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϸ����");            
            dt = ds.Tables[0];
            
			string type = Request["id"];   //��ȡ���ഩ�����ķ������
            SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+type+"'and len(�������)='4'", conn);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϸ����");            
            dt1 = ds1.Tables[0];			
			
			                 
            this.Items1 = new List<OptionItem>();  //���ݱ�DataTableת����  
            this.Items2 = new List<OptionItem>();           
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];

                if (Convert.ToString(dr["�������"]).Length == 2)
                {
                    OptionItem item = new OptionItem();
                    item.Name = Convert.ToString(dr["��ʾ����"]);
                    item.GroupsCode = Convert.ToString(dr["�������"]);
                    this.Items1.Add(item);   //��������뼯��
                }
            }
            
            for (int x = 0; x < dt1.Rows.Count; x++)
            { 			   
                DataRow dr = dt1.Rows[x];
                if (Convert.ToString(dr["�������"]).Length == 4)
                {
                    OptionItem item1 = new OptionItem();  
                    item1.Name = Convert.ToString(dr["��ʾ����"]);
                    item1.GroupsCode = Convert.ToString(dr["�������"]);
                    this.Items2.Add(item1);					
                }
				
            }

            
			string gys_id = Request["gys_id"];
            if (Request.Form["brandname"] != null)  //����Ʒ��д�����ݿ�
            {
                conn.Open(); 
                //string gysid = Request["gysid"]; 				
                string brandname = Request["brandname"];            //Ʒ������
                string ejflname = Request["ejflname"];              //������������
                string grade = Request.Form["grade"];               //�ȼ�
                string startuser = Request.Form["startuser"];       //�Ƿ�����
                string scope = Request["scope"];                    //��Χ       
                                         
                string sql = "insert into  Ʒ���ֵ� (Ʒ������,��������,�ȼ�,�Ƿ�����,��Χ)values('" + brandname + "','" + ejflname + "','" + grade + "',1,'" + scope + "' ) ";
				SqlCommand cmd2 = new SqlCommand(sql, conn);
                int ret = (int)cmd2.ExecuteNonQuery();
				
				string sql2 = " update Ʒ���ֵ� set pp_id=(select myId from Ʒ���ֵ� where Ʒ������='"+brandname+" ') where Ʒ������='"+brandname+"' ";
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
                    һ���������ƣ�
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
                    �����������ƣ�
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
                    ��Ӧ��id
                </td>
				<td align="left"><input type="text" id="" name="gysid" value="<%=Request.Form["gysid"] %>" /></td>
                </tr>
				
                <tr>
                <td style="color:Blue">
                    Ʒ�����ƣ�
                </td>                
                <td align="left">
                <input type="text" id="" name="brandname" value="<%=Request.Form["brandname"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td style="color:Blue">
                    �ȼ���
                </td>
                <td align="left">
                    <input type="text" id="grade" name="grade" style="width: 150px" value="<%=Request.Form["grade"] %>"/>
                </td>
                </tr>
				
			    <tr>
                <td style="color:Blue">
                    �Ƿ����ã�
                </td>
                <td align="left">
                    <input type="text" id="startuser" name="startuser" style="width: 150px" value="<%=Request.Form["startuser"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td valign="top" style="color:Blue">
                    ��Χ��
                </td>
                <td align="left">                   
                    <input type="text" id="scope" name="scope" style="width: 250px; height:100px" value="<%=Request.Form["scope"] %>"/>
                </td>
                </tr>
				
                <tr>
                <td >                    
                    <input type="submit" id="btnSend" value="����" style="width: 100px" />
                </td>
				<td align="left">                    
                    <a href="glsccsxxym.aspx?gys_id=<%=gys_id%>">������һҳ</a>
                </td>
                </tr>
        </table>
        </form>
    </center>
    </body>
</html>







