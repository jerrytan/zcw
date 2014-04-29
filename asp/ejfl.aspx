<!--
        材料二级分类列表页面
        文件名：ejfl.ascx
        传入参数：name [分类编码]
        owner:丁传宇
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Text" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>二级分类详细页面</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/ejfl.css" rel="stylesheet" type="text/css" />  
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="js/ejfl.js" type="text/javascript"></script> 
</head>
<body>
    <!-- 头部开始-->
    <!-- #include file="static/header.aspx" -->
    <!-- 头部结束-->

    <!-- 导航开始-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- 导航结束-->

    <!-- banner开始-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner 结束-->

    <script runat="server">
         
        protected DataTable dt_yjflmc = new DataTable();   //一级分类名称
        protected DataTable dt_ejflmc = new DataTable();  //二级分类名称 
		protected DataTable dt_ejflpp = new DataTable();  //品牌(和二级分类相关的品牌) 材料分类表中fl_id 品牌字典中关系没有对应
		protected DataTable dt_ejflcl = new DataTable();  //二级分类名称下的材料(最具人气的石材)
		protected DataTable dt_clxx= new DataTable();  //默认情况下显示的材料信息
		protected DataTable dt_wz = new DataTable();  //如何挑选大理石相关文章(文章表)
        protected DataTable dt_flsx = new DataTable();//分类属性
        protected DataTable dt_flsxz = new DataTable();//分类属性值

        protected DataConn dc_obj = new DataConn();
		
        private string name="";    //二级分类编码
        protected string sort= string.Empty; //排序方式
        protected string pp= string.Empty; //品牌
        protected string msg = string.Empty;//传递的属性值id组成的字符串
        protected string url=string.Empty;//获取当前请求的url
        protected int pageIndex=1;
        protected int pageSize=12;
        protected int pageCount;
        protected string pageBar="";
        protected string defaultMsg="";//当没有筛选到合适的记录时默认显示的提示信息

       
        protected void Page_Load(object sender, EventArgs e)
        {
            name= Request["name"];//二级分类的名称
			string name1=name.ToString().Substring(0, 2); //取左边两位字符串
            string str_sqlclmc = "select 显示名字,分类编码 from 材料分类表 where  left(分类编码,2)='"+name1+"' and len(分类编码)='2' "; 
            dt_yjflmc = dc_obj.GetDataTable(str_sqlclmc);

			string str_sqlclmz = "select 显示名字 from 材料分类表 where 分类编码='"+name+"' ";
            dt_ejflmc = dc_obj.GetDataTable(str_sqlclmz);
			
			string str_sqlppmc = "select 品牌名称,pp_id from 品牌字典  where  fl_id in(select fl_id from 材料分类表 where 分类编码='"+name+"') "; 
            dt_ejflpp = dc_obj.GetDataTable(str_sqlppmc);
           		
			
            string str_sqlcl = "select top 10 显示名,规格型号,分类编码,cl_id from 材料表 where 分类编码='"+name+"' order by 访问计数 desc";
            dt_ejflcl = dc_obj.GetDataTable(str_sqlcl);
			
			string str_sqltop4 = "select top 4 标题,摘要,wz_id from 文章表 where left(分类编码,4)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_sqltop4);
         
            string str_sqlflsx="select flsx_id,显示 from dbo.材料分类属性表 where 分类编码='"+name+"'";
            dt_flsx=dc_obj.GetDataTable(str_sqlflsx);

            string str_sqlflsxz="select flsxz_id,属性值,flsx_id from dbo.材料分类属性值表";
            dt_flsxz=dc_obj.GetDataTable(str_sqlflsxz);
             
            url = Request.RawUrl;//获取当前请求的ur
		  
            sort=Request.QueryString["sort"];//排序方式
            pp=Request.QueryString["pp"];//品牌
            string result=string.Empty;
            if(sort!=null&&pp!=null)
             {
             result=sort + ","+pp+",";
             }      
            
           msg=result+GetParameterStr(url);//参数id组成的字符串 还原状态 
           string sqlParm=GetInputSqlParm(GetParameterStr(url));//传入sql语句的参数
            string  Pagestr=Request.QueryString["page"];
             if (!int.TryParse(Pagestr, out pageIndex))
             {
                 pageIndex = 1;
             }            
                 
            pageCount=GetPageCount(name,pageSize,pp,sqlParm);            
            if(pageCount<=0)
            {
              defaultMsg="暂无信息";
            }
            else
            {
             dt_clxx=GetPageList(name,pp,sort,sqlParm,pageIndex,pageSize);  
             pageBar=CreatePageBar(url,pageIndex,pageCount);   
            }     
           
		} 		  


         
         //解析参数     
       private string GetParameterStr(string url)
        {
             string ArrStr = string.Empty; 
             int num1 = url.IndexOf('&');//第一次出现的位置          
             int num2 = url.IndexOf('&', num1 + 1);//第二次出现的位置
             if(num1==-1)
             {
               ArrStr="";
             }
             else if(num1!=-1&&num2==-1)
             {
               ArrStr="";
             }
             else if(num1!=-1&&num2!=-1)
             {
               int num3 = url.IndexOf('&', num2 + 1);//第三次出现的位置
               int num4 = url.IndexOf('&', num3 + 1);
               if(num4!=-1)
               {
                url = url.Remove(num4);
               }
                url = url.Substring(num3 + 1);
                string[] strArr = url.Split('=');
                ArrStr = strArr[1].Replace('x', ',');
             }
            
             return ArrStr;
        }

        //处理传入SQL语句关于属性值id的参数
        protected string GetInputSqlParm(string str)
        {
           str=str.Replace("0", "");
           string[] parmStr = str.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
           return string.Join(",", parmStr);           
        }

        //得到分页信息
         protected DataTable GetPageList(string name,string pp,string sort,string ids,int pageIndex,int pageSize)      
        {         
          
            string sql=@"select a.myID, a.材料编码,a.pp_id,a.cl_id,a.显示名,a.规格型号,a.分类编码,a.访问计数,a.updatetime,b.flsxz_id from  材料表 a ,材料属性表 b where a.cl_id=b.cl_id and a.分类编码=@name";
           if (pp != null && pp != ""&&pp!="0")
            {
                sql += " and a.pp_id=" + pp;
              
            }
           if (ids != null && ids != "")
            {
                sql += " and b.flsxz_id in(" + ids + ")";
              
            }      
            string orderBy = string.Empty;
            if (sort == "0")
            {
                orderBy = "myid";
            }
            else if (sort == "1")
            {
                orderBy = "访问计数";
            }
            else if (sort == "2")
            {
                orderBy = "updatetime";
            }
          
           string sql1=@"select * from (select  *,ROW_NUMBER() over(order by {0}) as newid2 from (select distinct 材料编码,pp_id,cl_id,显示名,规格型号,分类编码,updatetime,访问计数,myID from ({1} ) aa )bb ) cc ";
            sql1=string.Format(sql1,(orderBy != "" && orderBy != null) ? orderBy : "myid",sql);
            sql1=sql1+" where cc.newid2 between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize";
            SqlParameter[] parms ={ 
                                   new SqlParameter("@pageIndex",SqlDbType.Int),
                                   new SqlParameter("@pageSize",SqlDbType.Int),
                                   new SqlParameter("@name",SqlDbType.VarChar)
                                };           
            parms[0].Value=pageIndex;
            parms[1].Value=pageSize; 
            parms[2].Value=name;              
                
            return  dc_obj.GetDataTable(sql1,parms);
                 
          
        }
         

        //得到总页数
         private int GetPageCount(string name,int pageSize,string pp,string ids)
        {               
          
           string sql="select a.myID, a.材料编码,a.pp_id,a.显示名,a.规格型号,a.分类编码,a.访问计数,a.updatetime,b.flsxz_id from  材料表 a ,材料属性表 b where a.cl_id=b.cl_id and a.分类编码="+name;
            if (pp != null && pp != "" &&pp!="0")
            {
                sql += " and a.pp_id=" + pp;
            }
            if (ids != null && ids != "")
            {
               sql += " and b.flsxz_id in(" + ids + ")";
            }     
            string sql1="select count(*) from (select  distinct 材料编码,pp_id,显示名,规格型号,分类编码,updatetime,访问计数,myID from ({0}  ) aa ) bb";
            sql1=string.Format(sql1,sql);           
             string pageStr = dc_obj.DBLook(sql1);
             int recordCount =Convert.ToInt32(pageStr);
             return Convert.ToInt32(Math.Ceiling(1.0 * recordCount / pageSize));
      }

      //分页条
      protected string CreatePageBar(string url,int pageIndex,int pageCount)
      {                         
            int num1 = url.IndexOf('&');//第一次出现的位置          
             int num2 = url.IndexOf('&', num1 + 1);//第二次出现的位置
             int num3 = url.IndexOf('&', num2 + 1);//第三次出现的位置
             int num4=url.IndexOf('&',num3+1);          
             if (num1 != -1 && num2 == -1)//判断是否出现page这个参数
             {
                url = url.Remove(num1);
             }
             if (num1 != -1 && num2 != -1 && num3 != -1 && num4 != -1)
             {
                url = url.Remove(num4);
             }

             StringBuilder sb = new StringBuilder();          
            sb.Append("<a href='"+url+"&page=1'>首页</a>&nbsp;&nbsp;");
            int temp=pageIndex;
            if (pageIndex > 1)
            {
                temp = pageIndex - 1;
            }
            sb.Append("<a href='"+url+"&page="+temp+"'>上一页</a>&nbsp;&nbsp;");
            temp = pageIndex;
            if (pageIndex < pageCount)
            {
                temp = pageIndex + 1;
            }
            sb.Append("<a href='"+url+"&page="+temp+"'>下一页</a>&nbsp;&nbsp;");
            sb.Append("<a href='"+url+"&page=" + pageCount + "'>尾页</a> &nbsp;&nbsp;第"+pageIndex+"页/共"+pageCount+"页");
            return  sb.ToString();
      }

    </script>

    <div class="sc">
        <!-- 链接导航栏 开始-->
        <div class="sc1">
            <a href="index.aspx">首页 ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="yjfl.aspx?name=<%=row["分类编码"]%>"><%=row["显示名字"].ToString() %></a>
            <% } %>> 
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a ><%=row["显示名字"].ToString() %></a>
            <% } %>
        </div>
        <!-- 链接导航栏 结束-->

        <!-- 标题和内容摘要 开始-->
        <div class="sc3">
            <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["摘要"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["标题"].ToString() %></a></div>
                <div class="rh2" style="overflow"><%=resume %></div>
            </div>
			<%}%>		   
        </div>
        <!-- 标题和内容摘要 结束-->

        <!--
          二级分类页面的筛选 排序 材料列表
          author:lilifeng
        -->
        <!-- 筛选 开始 -->
        <div class="xzss">
        <div id="filter">
          <dl>
           <dt >品牌：</dt>
           <dd class="content content0"><a  val="0">全部</a>
           <%foreach (System.Data.DataRow row in dt_ejflpp.Rows){%>
           <a val="<%=row["pp_id"]%>"><%=row["品牌名称"]%></a>
           <%} %>
           </dd></dl>         
         
    <!--其它属性开始-->
     <%int count=1;string classname="content1"; %> 
    <%if(dt_flsx.Rows.Count>2)
     { 
       for(int i=1;i<=2;i++){
        var row=dt_flsx.Rows[i-1];%>
       <dl ><dt><%=row["显示"]%>：</dt>
           <dd class="content <%=classname%>"><a val="0">全部</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["属性值"]%></a>
           <%}%>
           <%}%>            
             </dd></dl>
         <%count++;classname="content"+count;%>
       <% }%>
       <div id="btnMore" style="cursor:pointer;"><span style="font-weight:bold">更多</span><img src="images/more_03.jpg" />
       <div id="more" style="display:none">
        <%for (int i = 3; i <=dt_flsx.Rows.Count; i++){%>
         <%var row=dt_flsx.Rows[i-1]; %>
         <dl ><dt><%=row["显示"]%>：</dt>
           <dd class="content <%=classname%>"><a val="0">全部</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["属性值"]%></a>
           <%}%>
        <%}%>
          </dd></dl>
         <%count++;classname="content"+count;%>
        <%}%></div>
        </div>
      <% }%>
  <% else{%>
    <% foreach (System.Data.DataRow row in dt_flsx.Rows){%>          
           <dl ><dt><%=row["显示"]%>：</dt>
           <dd class="content <%=classname%>"><a val="0">全部</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["属性值"]%></a>
           <%}%>
           <%}%>            
             </dd></dl>
         <%count++;classname="content"+count;%>
           <%}%>
      <% }%>
     <!--其它属性结束-->
        </div>

        <div class="dlspx">
                 <span class="dlspx3">排序：</span>
                <ul id="sort" >
                    <li val="0" class="dlspx3" >默认方式</li>
                    <li val="1" class="dlspx3" ><span class="pl14px">人气<img src="images/qweqw_03.jpg" /></span></li>
                    <li val="2" class="dlspx3" ><span>最新<img src="images/qweqw_03.jpg" /></span></li>
                </ul>              
               <span class="dlspx3"><input type="checkbox" value="" id="ckAll" class="fx" />全选</span>
                <span class="dlspx4"><a id="collect">请收藏，便于查找</a></span>
            </div>
        </div>
         <!-- 筛选 结束 -->

        <!-- 材料显示列表 开始-->
        <div class="dlspxl" id="dv">
          <%if(dt_clxx.Rows.Count>0){ %>
            <% foreach(System.Data.DataRow row in dt_clxx.Rows){
                String  mc = row["显示名"].ToString();
               if (mc.Length > 6) {
                    mc = mc.Substring(0,6)+"..";
               } 
            
            %>
            <div class="dlspxt">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>" title="<%=row["显示名"].ToString() %>">
                    <%
                    string str_sqltop1 = "select  top 1 存放地址 from 材料多媒体信息表 where cl_id ='"
                        +row["cl_id"]+"' and 大小='小'";
                    string imgsrc= "images/222_03.jpg";
                   
                    object result = dc_obj.DBLook(str_sqltop1);
                    if (result != null) {
                        imgsrc = result.ToString();
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
				    %>
                    
                    <div class="dlspxt1" >
                        <span class="dlsl"><%=mc%></span>  </a>
                        <span class="dlspx3">
                            <%string parm="";
                              parm=row["材料编码"].ToString()+"|"+row["pp_id"].ToString();
                             %>
                            <input name="item" type="checkbox" value="<%=parm%>" class="ck" />收藏
                        </span>
                        <span class="dlsgg" >规格：<%=row["规格型号"].ToString() %></span>
                    </div>              
            </div>
            <% } %>
            <%}else{ %>
              <span style="font-size:30px;font-weight:bolder;color:Red;padding:0 300px;"><%=defaultMsg%></span>
            <%} %>
        </div>
        <!-- 材料显示列表 结束-->

        <!-- 最具人气的石材 开始 -->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["显示名"].ToString() %></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2"><a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
        </div>
        <!-- 最具人气的石材 结束-->
    </div>

    <!-- 分页 开始 -->
    <div class="fy2">
        <div class="fy3">
              <div id="page"><%=pageBar %></div>  
        </div>
    </div>
    <!-- 分页 结束-->

    <div>
        <!-- 关于我们 广告服务 投诉建议 开始-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- 关于我们 广告服务 投诉建议 结束-->
    </div>

    <!--  footer 开始-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer 结束-->
    <div id="msgStr" style="display:none"><%=msg %></div>
    <div id="name" style="display:none"><%=name%></div>
  
</body>
</html>
