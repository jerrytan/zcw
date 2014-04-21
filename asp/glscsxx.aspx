<!--      
	   管理生产商信息 修改保存生产厂商信息 删除选中品牌 增加新的品牌
       文件名：glscsxx.aspx 
       传入参数：无
       author:张新颖    
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理生厂商信息</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
  
</head>

  <script type="text/javascript" language="javascript">

      function Update(id)
      {
          if (window.XMLHttpRequest)
          {
              xmlhttp = new XMLHttpRequest();
          }
          else
          {
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.onreadystatechange = function ()
          {
              if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
              {
                  document.getElementById("scs_PP").innerHTML = xmlhttp.responseText;
              }
          }
          xmlhttp.open("GET", "glfxsxx4.aspx?id=" + id + "&lx=scs", true);
          xmlhttp.send();
      }
      function Update_scs(id)
      { 
          if (window.XMLHttpRequest)
          {
              xmlhttp = new XMLHttpRequest();
          }
          else
          {
              xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp.onreadystatechange = function ()
          {
             
              if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
              {
                  var array = new Array();           //声明数组
                  array = xmlhttp.responseText;     //接收替换返回的json字符串

                  var json = array;
                  var myobj = eval(json);              //将返回的JSON字符串转成JavaScript对象 			

                  if (myobj.length == 0)
                  {
                      document.getElementById('companyname').value = "";       //供应商
                      document.getElementById('address').value = "";        //地址
                      document.getElementById('tel').value = "";                //电话  			 
                      document.getElementById('homepage').value = "";       //主页
                      document.getElementById('fax').value = "";                 //传真
                      document.getElementById('area').value = "";               //地区名称
                      document.getElementById('name').value = "";               //联系人
                      document.getElementById('phone').value = "";        //联系人电话 
                      document.getElementById('sh').style.visibility = "hidden";
					   if (id!="0")
						{
						  if (confirm("该生产商尚未填写详细信息,是否补填？"))
						  {
							  window.location.href = "btgysxx.aspx?gxs_id=" + id + "&lx=scs";
						  }
					   }
                  }
                  for (var i = 0; i < myobj.length; i++)
                  {  //遍历,将ajax返回的数据填充到文本框中				

                      document.getElementById('companyname').value = myobj[i].gys_name;       //供应商
                      document.getElementById('address').value = myobj[i].gys_address;        //地址
                      document.getElementById('tel').value = myobj[i].gys_tel;                //电话  			 
                      document.getElementById('homepage').value = myobj[i].gys_homepage;       //主页
                      document.getElementById('fax').value = myobj[i].gys_fax;                 //传真
                      document.getElementById('area').value = myobj[i].gys_area;               //地区名称
                      document.getElementById('name').value = myobj[i].gys_user;               //联系人
                      document.getElementById('phone').value = myobj[i].gys_user_phone;          //联系人电话
                      document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax返回的供应商id	供向表单提交时使用	
                      if (myobj[i].sh == "待审核")
                      {
                          document.getElementById('sh').style.visibility = "visible";
                      }
                      else
                      {
                          document.getElementById('sh').style.visibility = "hidden";
                      }
                  }

              }
          }
          xmlhttp.open("GET", "glscsxx3.aspx?id=" + id, true);
          xmlhttp.send();
          if (window.XMLHttpRequest)
          {
              xmlhttp1 = new XMLHttpRequest();
          }
          else
          {
              xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
          }
          xmlhttp1.onreadystatechange = function ()
          {
              if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200)
              {
                  var array1 = new Array();           //声明数组
                  array1 = xmlhttp1.responseText;     //接收替换返回的json字符串
                  var json1 = array1;
                  var myobj1 = eval(json1);              //将返回的JSON字符串转成JavaScript对象 	
                  var s = "";
                  for (var j = 0; j < myobj1.length; j++)
                  {  //遍历,将ajax返回的数据填充到文本框中				

                      s += "<image src='images/wwwq_03.jpg'/>";
                      s += "  <span class='fdlpp1'>";
                      s += " <a href='clxx.aspx?cl_id=" + myobj1[j].pp_id + "' class='fxsfxk'>" + myobj1[j].ppmc + "</a></span>";
                  }
                  document.getElementById("ppxx").innerHTML = s;
              }
          }
          xmlhttp1.open("GET", "glscsxx3.aspx?id=" + id + "&lx=ppxx", true);
          xmlhttp1.send();
      }

      function AddNewBrand(id)
      {
          var url = "xzpp.aspx?gys_id=" + id;
          window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
      }
      function DeleteBrand(id)
      {
          var r = confirm("请确认您将删除此品牌!");
          if (r == true)
          {
              var brands = document.getElementsByName("brand");
              var ppid;
              ppid = "";
              for (var i = 0; i < brands.length; i++)
              {
                  if (brands[i].checked)
                  {

                      ppid += brands[i].value + ",";
                  }

              }

              var url = "scpp.aspx?fxs_id=" + id + "&pp_id=" + ppid + "&lx=1";
              window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
          }
      }
</script>
  <script runat="server">
  protected DataTable dt_gysxx = new DataTable();  //分销商信息(材料供应商信息表)
        public DataTable dt_ppxx = new DataTable();   //分销商信息(材料供应商信息表)
        public string gys_id="";
        public DataConn objConn=new DataConn();
        public string sSQL="";
        public string s_yh_id="";
        public string sp_result="";
        public DataTable dt_gysxxs = new DataTable();
         public string gys_type = "";                  //单位类型  
        public string id = ""; 
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["GYS_YH_ID"]!=null)
            {
                 s_yh_id = Session["GYS_YH_ID"].ToString(); 
            }
			    sSQL = "select 单位类型 ,gys_id from  材料供应商信息表 where yh_id='"+s_yh_id+"' ";  //查询单位类型
			
                DataTable dt_type = objConn.GetDataTable(sSQL);
                if(dt_type!=null&&dt_type.Rows.Count>0)
                {
			            gys_type = dt_type.Rows[0]["单位类型"].ToString();
			            gys_id = dt_type.Rows[0]["gys_id"].ToString();  //供应商id   141
                }
                if (gys_type.Equals("生产商"))
                {
                    //如果是分销商信息 直接根据yh_id 查询供应商信息 
                    sSQL = "select 品牌名称,pp_id from 品牌字典 where 是否启用='1' and scs_id='" + gys_id + "' ";
                    dt_ppxx = objConn.GetDataTable(sSQL);
                    sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  yh_id='" + s_yh_id + "' ";
                    dt_gysxx = objConn.GetDataTable(sSQL);
                    if (dt_gysxx.Rows.Count == 0)
                        Response.Redirect("gysbtxx.aspx");
                }
                else if (gys_type == "分销商")
                {
                    sSQL = "select pp_id,品牌名称 from 分销商和品牌对应关系表 where fxs_id='" + gys_id + "'";
                    dt_ppxx = objConn.GetDataTable(sSQL);
                }    
               
                if (Request["id"]!=null&&Request["id"].ToString()!="")
                {
                    id = Request["id"].ToString();    //获取glfxsxx2页面返回的供应商id
                }
		    
                if (id != "")
                {
                    DWLX(gys_type, id, gys_id);
                }
        }
    protected void DWLX(string str_gysid_type, string id, string str_gysid)
        {
            //根据分销商id 从材料供应商信息从表中 获取代理不同品牌的品牌id

            if (str_gysid_type.Equals("生产商"))
            {
                  //如果 供应商自己修改待审核表 有记录 查询审批结果
                    sSQL = "select 审批结果 from 供应商自己修改待审核表 where gys_id='" + id + "'";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    if (dt_select != null && dt_select.Rows.Count > 0)
                    {
                        sp_result = dt_select.Rows[0]["审批结果"].ToString();
                    }
                    if (sp_result != "")
                    {
                        spjg(sp_result, gys_id, id);
                    } 
            }
            if (str_gysid_type.Equals("分销商"))
            {
                  //如果 供应商自己修改待审核表 有记录 查询审批结果
                    sSQL = "select 审批结果 from 供应商自己修改待审核表 where gys_id='" + id + "'";
                    DataTable dt_select = objConn.GetDataTable(sSQL);
                    sp_result = Convert.ToString(dt_select.Rows[0]["审批结果"]);
                    if (sp_result != "")
                    {
                        spjg(sp_result, gys_id, id);
                    }                 
            }
        }
    public void spjg(string sp_result,string gys_id, string id)
    {
         if (sp_result.Equals("通过"))
            {  
				  
			//如果审批通过 说明修改的供应商信息有效 把 供应商自己修改待审核表 有效数据更新到材料供应商信息表
            sSQL = "update  材料供应商信息表 set 供应商=(select 贵公司名称 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
			+"地址=(select 贵公司地址 from 供应商自己修改待审核表 where  gys_id='"+id+"'),电话=(select 贵公司电话 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
			+"主页=(select 贵公司主页 from 供应商自己修改待审核表 where gys_id='"+id+"'),传真=(select 贵公司传真 from 供应商自己修改待审核表 where  gys_id='"+id+"'),"
			+"联系人=(select 联系人姓名 from 供应商自己修改待审核表 where  gys_id='"+id+"'),联系人手机=(select 联系人电话 from 供应商自己修改待审核表 where gys_id='"+id+"'),"
			+"地区名称=(select 贵公司地区 from 供应商自己修改待审核表 where gys_id='"+id+"'),"
			+"经营范围=(select 经营范围 from 供应商自己修改待审核表 where  gys_id='"+id+"') where gys_id ='"+id+"'";
                     
           
            int ret =objConn.ExecuteSQLForCount(sSQL,true);
					 
			sSQL = "select 供应商,联系地址,电话,主页,传真,地区名称,联系人,联系人手机,经营范围,gys_id from 材料供应商信息表 where  gys_id='"+id+"' ";

            dt_gysxx = objConn.GetDataTable(sSQL);			 
				     
            }
		if (sp_result.Equals("不通过"))
            {
            sSQL = "delete  供应商自己修改待审核表 where gys_id ='"+id+"' ";					
            int ret = objConn.ExecuteSQLForCount(sSQL,true);
        }
		if (sp_result.Equals("待审核"))
        {
            sSQL = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,"
			+"经营范围,gys_id  from 供应商自己修改待审核表  where gys_id ='"+id+"'";           
            dt_gysxx = objConn.GetDataTable(sSQL);
        }

    }    
</script>
<body>
  <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->
    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
    <%if (gys_type == "生产商")
      {%>
         <div class="fxsxx">
		   <span class="fxsxx1">
		    </span>
            <span class="fxsxx1">贵公司的详细信息如下:</span>

            <div class="fxsxx2">
           <%if (sp_result == "待审核")
             {%>
             <dl>
             <span class="fxsxx1">贵公司的信息如下正在审核中</span>
                <dd>贵公司名称：</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司名称"] %>" /></dt>
                <dd>贵公司地址：</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地址"] %>"/></dt>
                <dd>贵公司电话：</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司电话"] %>"/></dt>
                <dd>贵公司主页：</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司主页"] %>" /></dt>
                <dd>贵公司传真：</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司传真"] %>"/></dt>
                <dd>贵公司地区：</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地区"] %>"/></dt>
                <dd>联系人姓名：</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人姓名"] %>" /></dt>
                <dd>联系人电话：</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人电话"] %>" /></dt>
                <dd>经营范围  ：</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></dt>
             </dl>
           <%}
             else
             { %>
              <dl>
                <dd>贵公司名称：</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" /></dt>
                <dd>贵公司地址：</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>"/></dt>
                <dd>贵公司电话：</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["电话"] %>"/></dt>
                <dd>贵公司主页：</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" /></dt>
                <dd>贵公司传真：</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["传真"] %>"/></dt>
                <dd>贵公司地区：</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地区名称"] %>"/></dt>
                <dd>联系人姓名：</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人"] %>" /></dt>
                <dd>联系人电话：</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" /></dt>
                <dd>经营范围  ：</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></dt>
             </dl>
           <%} %>				
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="Hidden1" class="fxsxx3" value=""/>
                    <input type="submit" value="更改" />

                </span>
          </div>
          </div>
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
            <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand(<%=gys_id %>)">删除选中品牌</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">增加新品牌</a></span>

    <%}
      else if(gys_type=="分销商")
      { %>
      
        <div class="fxsxx">
		   <span class="fxsxx1">
		    </span>
                <div class="zjgxs">
                 <span>贵公司代理品牌：</span><br />
			        <select name="pp" id="pp" class="fug" style="width:200px" onchange="Update(this.options[this.options.selectedIndex].value)">
			         <% foreach (System.Data.DataRow row_fxs in dt_ppxx.Rows)
                         { %>			
			             <option value='<%=row_fxs["pp_id"].ToString()%>'><%=row_fxs["品牌名称"].ToString()%></option>
	                <% }%>			
			        </select> 			
			    </div>
			    <div class="zjgxs">
                     <span>该品牌下的分销商：</span><br />
			        <select name="scs_PP" id="scs_PP" class="fug" style="width:200px" onchange="Update_scs(this.options[this.options.selectedIndex].value)">			
			        </select> 
			        <span class="zjgxs1"><a href="xzgxs.aspx?xzlx=scs"> 增加新的生产商</a></span>
			    </div>
         
            <span class="fxsxx1">该公司的详细信息如下:</span>

            <div class="fxsxx2">
           <%if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
             {
                 if (sp_result == "待审核")
                 {%>
               <span  class="fxsxx1">该分销商的信息正在审核中</span>
             <dl>
                <dd>贵公司名称：</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司名称"] %>" /></dt>
                <dd>贵公司地址：</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地址"] %>"/></dt>
                <dd>贵公司电话：</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司电话"] %>"/></dt>
                <dd>贵公司主页：</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司主页"] %>" /></dt>
                <dd>贵公司传真：</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司传真"] %>"/></dt>
                <dd>贵公司地区：</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["贵公司地区"] %>"/></dt>
                <dd>联系人姓名：</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人姓名"] %>" /></dt>
                <dd>联系人电话：</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人电话"] %>" /></dt>
                <dd>经营范围  ：</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></dt>
             </dl>
           <%}
                 else
                 { %>

              <dl>
                <dd>贵公司名称：</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["供应商"] %>" /></dt>
                <dd>贵公司地址：</dd><dt><input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系地址"] %>"/></dt>
                <dd>贵公司电话：</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["电话"] %>"/></dt>
                <dd>贵公司主页：</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["主页"] %>" /></dt>
                <dd>贵公司传真：</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["传真"] %>"/></dt>
                <dd>贵公司地区：</dd><dt><input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["地区名称"] %>"/></dt>
                <dd>联系人姓名：</dd><dt><input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人"] %>" /></dt>
                <dd>联系人电话：</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["联系人手机"] %>" /></dt>
                <dd>经营范围  ：</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["经营范围"] %>" /></dt>
             </dl>
           <%}
             }
             else
             {%>
               <span class="fxsxx1" id="sh" style=" visibility:hidden">该分销商的信息正在审核中</span>
              <dl>
                <dd>贵公司名称：</dd><dt><input name="companyname" type="text" id="companyname" class="fxsxx3"/></dt>
                <dd>贵公司地址：</dd><dt><input name="address" type="text" id="address" class="fxsxx3" /></dt>
                <dd>贵公司电话：</dd><dt><input name="tel" type="text" id="tel" class="fxsxx3" /></dt>
                <dd>贵公司主页：</dd><dt><input name="homepage" type="text" id="homepage" class="fxsxx3"  /></dt>
                <dd>贵公司传真：</dd><dt><input name="fax" type="text" id="fax" class="fxsxx3" /></dt>
                <dd>贵公司地区：</dd><dt><input name="area" type="text" id="area" class="fxsxx3" /></dt>
                <dd>联系人姓名：</dd><dt><input name="name" type="text" id="name" class="fxsxx3" /></dt>
                <dd>联系人电话：</dd><dt><input name="phone" type="text" id="phone" class="fxsxx3"  /></dt>
                <dd>经营范围  ：</dd><dt><input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3"  /></dt>
             </dl>
             <%} %>				
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>                 
                    <input type="submit" value="更改" />                     
                </span>
          </div>
          <span class="fxsxx1"></span>	
                    <div class="ggspp">
                        <span class="ggspp1">贵公司代理分销品牌如下</span> 
                        <div class="fgstp" id="ppxx">
                         </div>      
                    </div>	
          </div>             
      <%} %>
        
                     </form>
      
<!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->   
</body>

</html>
