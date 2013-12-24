<!--
          
       供应商新增材料页面	   
       文件名：czclym.aspx 
       传入参数:无	   
	   
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>新增材料页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //发送ajax有问题,待处理


    function updateFL(id) {

        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }

    


</script>


<script runat="server">  
        
    public List<OptionItem> Items1 { get; set; }
    public List<OptionItem> Items2 { get; set; }
    public class OptionItem
    {
        public string Name { get; set; }  //下拉列表显示名属性
        public string GroupsCode { get; set; }  //下拉列表分类编码属性
        public string SelectedString { get; set; }
        public string Value { get; set; }

    }
    protected DataTable dt = new DataTable();  //材料分类大类
    protected DataTable dt1 = new DataTable();  //材料分类小类
    protected DataTable dt2 = new DataTable();  //要选择的品牌名称(品牌字典)
    protected void Page_Load(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
        SqlDataAdapter da = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where len(分类编码)='2'", conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "材料分类表");
        dt = ds.Tables[0];

        string type = Request["id"];   //获取大类穿过来的分类编码
        SqlDataAdapter da1 = new SqlDataAdapter("select 显示名字,分类编码 from 材料分类表 where left(分类编码,2)='"+type+"' and len(分类编码)='4'", conn);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1, "材料分类表");
        dt1 = ds1.Tables[0];

        string gys_id = Request["gys_id"];
        SqlDataAdapter da2 = new SqlDataAdapter("select 品牌名称 from 品牌字典 where scs_id='" + gys_id + "' ", conn);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2, "材料分类表");
        dt2 = ds2.Tables[0];


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




        if (Request.Form["clname"] != null)
        {
            conn.Open();
            //string code = Request.QueryString["code"]; //获取分类编码 把材料信息和相应的分类编码插入到材料表中
            string clname = Request.Form["clname"];  //材料名称
            string brand = Request.Form["brand"];    //品牌名称
            string cltype = Request.Form["cltype"];          //规格型号
            string measure = Request.Form["measure"];        //计量单位
            string volumetric = Request.Form["volumetric"];  //单位体积
            string instruction = Request.Form["instruction"];  //说明 
            string ejflname = Request.Form["ejflname"];        //分类名称 				

            string sql1 = " insert into 材料表(显示名,品牌名称,规格型号,计量单位,单位体积,说明,是否启用,分类名称,updatetime)values('" + clname + "','" + brand + "','" + cltype + "','" + measure + "','" + volumetric + "','" + instruction + "',1,'" + ejflname + "','getdate()') ";
            SqlCommand cmd3 = new SqlCommand(sql1, conn);
            int ret1 = (int)cmd3.ExecuteNonQuery();
            string sql2 = " update 材料表 set gys_id='61' where gys_id is null ";   //待处理
            SqlCommand cmd2 = new SqlCommand(sql2, conn);
            int ret = (int)cmd2.ExecuteNonQuery();
            conn.Close();

        }

    }				
 
</script>

<body>

    <!-- 头部开始-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- 头部结束-->


    <div class="fxsxx">
        <span class="fxsxx1">请选择您要添加的材料信息</span>
        <%string gys_id = Request["gys_id"];%>
        <form action="xzclym.aspx?gys_id=<%=gys_id%>" method="get">

            <div class="xz1">
                <div class="xza">



                    <span class="xz2"><a href="#">大类</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                        <% foreach(var v  in Items1){%>
                        <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>
                <div class="xza">
                    <span class="xz2"><a href="#">小类</a></span>
                    <select id="drop" name="drop" class="fux">
                        <% foreach(var v  in Items2){%>
                        <option value="<%=v.Name%>&<%=v.GroupsCode%>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>


                <div class="xzz">
                    <span class="xzz0">如果没有适合的小类，请联系网站管理员增加！ 联系方式是xxx@xxx.com.请使用模板。 </span>
                    <span class="xzz1"><a href="#">模板下载地址</a></span>
                </div>
            </div>

            <div class="fxsxx2">
                <span class="srcl">请输入材料信息</span>
                <dl>
                    <dd>材料名字：</dd>
                    <dt>
                        <input name="clname" type="text" class="fxsxx3" value="<%=Request.Form["clname"] %>" /></dt>

                    <dd>品    牌：</dd>
                    <dt>
                        <select name="brand" style="width: 300px">
                            <%foreach(System.Data.DataRow row in dt2.Rows){%>
                            <option value="<%=row["品牌名称"].ToString() %>"><%=row["品牌名称"].ToString()%></option>
                            <%}%>
                        </select></dt>

                    <dd>型号：</dd>
                    <dt>
                        <input name="cltype" type="text" class="fxsxx3" value="<%=Request.Form["cltype"] %>" /></dt>
                    <dd>适用场所：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" value="<%=Request.Form["gysid"] %>" /></dt>
                    <dd>计量单位：</dd>
                    <dt>
                        <input name="bit" type="text" class="fxsxx3" value="<%=Request.Form["bit"] %>" /></dt>
                    <dd>单位体积：</dd>
                    <dt>
                        <input name="volumetric" type="text" class="fxsxx3" value="<%=Request.Form["volumetric"] %>" /></dt>
                    <dd>说明：</dd>
                    <dt>
                        <input name="instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></dt>
                </dl>
            </div>


            <!--
<div class="cpdt">
   <dl>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>产品大图1：</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>
-->


            <div class="cpdt">
                <span class="dmt">多媒体信息</span>
                <dl>
                    <dd>产品视频：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>成功案例：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>更多资料：</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                </dl>

                <span class="fxsbc"><a href="#">
                    <input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg"></a></span>

            </div>
        </form>
    </div>
    </div>





    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->





</body>
</html>
