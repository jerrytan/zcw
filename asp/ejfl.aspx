<!--
        ���϶��������б�ҳ��
        �ļ�����ejfl.ascx
        ���������name [�������]
        owner:������
               
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
    <title>����������ϸҳ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <link href="css/ejfl.css" rel="stylesheet" type="text/css" />  
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="js/ejfl.js" type="text/javascript"></script> 
</head>
<body>
    <!-- ͷ����ʼ-->
    <!-- #include file="static/header.aspx" -->
    <!-- ͷ������-->

    <!-- ������ʼ-->
    <uc1:Menu1 ID="Menu1" runat="server" />
    <!-- ��������-->

    <!-- banner��ʼ-->
    <!-- #include file="static/banner.aspx" -->
    <!-- banner ����-->

    <script runat="server">
         
        protected DataTable dt_yjflmc = new DataTable();   //һ����������
        protected DataTable dt_ejflmc = new DataTable();  //������������ 
		protected DataTable dt_ejflpp = new DataTable();  //Ʒ��(�Ͷ���������ص�Ʒ��) ���Ϸ������fl_id Ʒ���ֵ��й�ϵû�ж�Ӧ
		protected DataTable dt_ejflcl = new DataTable();  //�������������µĲ���(���������ʯ��)
		protected DataTable dt_clxx= new DataTable();  //Ĭ���������ʾ�Ĳ�����Ϣ
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ�������(���±�)
        protected DataTable dt_flsx = new DataTable();//��������
        protected DataTable dt_flsxz = new DataTable();//��������ֵ

        protected DataConn dc_obj = new DataConn();
		
        private string name="";    //�����������
        protected string sort= string.Empty; //����ʽ
        protected string pp= string.Empty; //Ʒ��
        protected string msg = string.Empty;//���ݵ�����ֵid��ɵ��ַ���
        protected string url=string.Empty;//��ȡ��ǰ�����url
        protected int pageIndex=1;
        protected int pageSize=12;
        protected int pageCount;
        protected string pageBar="";
        protected string defaultMsg="";//��û��ɸѡ�����ʵļ�¼ʱĬ����ʾ����ʾ��Ϣ

       
        protected void Page_Load(object sender, EventArgs e)
        {
            name= Request["name"];//�������������
			string name1=name.ToString().Substring(0, 2); //ȡ�����λ�ַ���
            string str_sqlclmc = "select ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name1+"' and len(�������)='2' "; 
            dt_yjflmc = dc_obj.GetDataTable(str_sqlclmc);

			string str_sqlclmz = "select ��ʾ���� from ���Ϸ���� where �������='"+name+"' ";
            dt_ejflmc = dc_obj.GetDataTable(str_sqlclmz);
			
			string str_sqlppmc = "select Ʒ������,pp_id from Ʒ���ֵ�  where  fl_id in(select fl_id from ���Ϸ���� where �������='"+name+"') "; 
            dt_ejflpp = dc_obj.GetDataTable(str_sqlppmc);
           		
			
            string str_sqlcl = "select top 10 ��ʾ��,����ͺ�,�������,cl_id from ���ϱ� where �������='"+name+"' order by ���ʼ��� desc";
            dt_ejflcl = dc_obj.GetDataTable(str_sqlcl);
			
			string str_sqltop4 = "select top 4 ����,ժҪ,wz_id from ���±� where left(�������,4)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_sqltop4);
         
            string str_sqlflsx="select flsx_id,��ʾ from dbo.���Ϸ������Ա� where �������='"+name+"'";
            dt_flsx=dc_obj.GetDataTable(str_sqlflsx);

            string str_sqlflsxz="select flsxz_id,����ֵ,flsx_id from dbo.���Ϸ�������ֵ��";
            dt_flsxz=dc_obj.GetDataTable(str_sqlflsxz);
             
            url = Request.RawUrl;//��ȡ��ǰ�����ur
		  
            sort=Request.QueryString["sort"];//����ʽ
            pp=Request.QueryString["pp"];//Ʒ��
            string result=string.Empty;
            if(sort!=null&&pp!=null)
             {
             result=sort + ","+pp+",";
             }      
            
           msg=result+GetParameterStr(url);//����id��ɵ��ַ��� ��ԭ״̬ 
           string sqlParm=GetInputSqlParm(GetParameterStr(url));//����sql���Ĳ���
            string  Pagestr=Request.QueryString["page"];
             if (!int.TryParse(Pagestr, out pageIndex))
             {
                 pageIndex = 1;
             }            
                 
            pageCount=GetPageCount(name,pageSize,pp,sqlParm);            
            if(pageCount<=0)
            {
              defaultMsg="������Ϣ";
            }
            else
            {
             dt_clxx=GetPageList(name,pp,sort,sqlParm,pageIndex,pageSize);  
             pageBar=CreatePageBar(url,pageIndex,pageCount);   
            }     
           
		} 		  


         
         //��������     
       private string GetParameterStr(string url)
        {
             string ArrStr = string.Empty; 
             int num1 = url.IndexOf('&');//��һ�γ��ֵ�λ��          
             int num2 = url.IndexOf('&', num1 + 1);//�ڶ��γ��ֵ�λ��
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
               int num3 = url.IndexOf('&', num2 + 1);//�����γ��ֵ�λ��
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

        //������SQL����������ֵid�Ĳ���
        protected string GetInputSqlParm(string str)
        {
           str=str.Replace("0", "");
           string[] parmStr = str.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
           return string.Join(",", parmStr);           
        }

        //�õ���ҳ��Ϣ
         protected DataTable GetPageList(string name,string pp,string sort,string ids,int pageIndex,int pageSize)      
        {         
          
            string sql=@"select a.myID, a.���ϱ���,a.pp_id,a.cl_id,a.��ʾ��,a.����ͺ�,a.�������,a.���ʼ���,a.updatetime,b.flsxz_id from  ���ϱ� a ,�������Ա� b where a.cl_id=b.cl_id and a.�������=@name";
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
                orderBy = "���ʼ���";
            }
            else if (sort == "2")
            {
                orderBy = "updatetime";
            }
          
           string sql1=@"select * from (select  *,ROW_NUMBER() over(order by {0}) as newid2 from (select distinct ���ϱ���,pp_id,cl_id,��ʾ��,����ͺ�,�������,updatetime,���ʼ���,myID from ({1} ) aa )bb ) cc ";
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
         

        //�õ���ҳ��
         private int GetPageCount(string name,int pageSize,string pp,string ids)
        {               
          
           string sql="select a.myID, a.���ϱ���,a.pp_id,a.��ʾ��,a.����ͺ�,a.�������,a.���ʼ���,a.updatetime,b.flsxz_id from  ���ϱ� a ,�������Ա� b where a.cl_id=b.cl_id and a.�������="+name;
            if (pp != null && pp != "" &&pp!="0")
            {
                sql += " and a.pp_id=" + pp;
            }
            if (ids != null && ids != "")
            {
               sql += " and b.flsxz_id in(" + ids + ")";
            }     
            string sql1="select count(*) from (select  distinct ���ϱ���,pp_id,��ʾ��,����ͺ�,�������,updatetime,���ʼ���,myID from ({0}  ) aa ) bb";
            sql1=string.Format(sql1,sql);           
             string pageStr = dc_obj.DBLook(sql1);
             int recordCount =Convert.ToInt32(pageStr);
             return Convert.ToInt32(Math.Ceiling(1.0 * recordCount / pageSize));
      }

      //��ҳ��
      protected string CreatePageBar(string url,int pageIndex,int pageCount)
      {                         
            int num1 = url.IndexOf('&');//��һ�γ��ֵ�λ��          
             int num2 = url.IndexOf('&', num1 + 1);//�ڶ��γ��ֵ�λ��
             int num3 = url.IndexOf('&', num2 + 1);//�����γ��ֵ�λ��
             int num4=url.IndexOf('&',num3+1);          
             if (num1 != -1 && num2 == -1)//�ж��Ƿ����page�������
             {
                url = url.Remove(num1);
             }
             if (num1 != -1 && num2 != -1 && num3 != -1 && num4 != -1)
             {
                url = url.Remove(num4);
             }

             StringBuilder sb = new StringBuilder();          
            sb.Append("<a href='"+url+"&page=1'>��ҳ</a>&nbsp;&nbsp;");
            int temp=pageIndex;
            if (pageIndex > 1)
            {
                temp = pageIndex - 1;
            }
            sb.Append("<a href='"+url+"&page="+temp+"'>��һҳ</a>&nbsp;&nbsp;");
            temp = pageIndex;
            if (pageIndex < pageCount)
            {
                temp = pageIndex + 1;
            }
            sb.Append("<a href='"+url+"&page="+temp+"'>��һҳ</a>&nbsp;&nbsp;");
            sb.Append("<a href='"+url+"&page=" + pageCount + "'>βҳ</a> &nbsp;&nbsp;��"+pageIndex+"ҳ/��"+pageCount+"ҳ");
            return  sb.ToString();
      }

    </script>

    <div class="sc">
        <!-- ���ӵ����� ��ʼ-->
        <div class="sc1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="yjfl.aspx?name=<%=row["�������"]%>"><%=row["��ʾ����"].ToString() %></a>
            <% } %>> 
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a ><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>
        <!-- ���ӵ����� ����-->

        <!-- ���������ժҪ ��ʼ-->
        <div class="sc3">
            <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["ժҪ"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����"].ToString() %></a></div>
                <div class="rh2" style="overflow"><%=resume %></div>
            </div>
			<%}%>		   
        </div>
        <!-- ���������ժҪ ����-->

        <!--
          ��������ҳ���ɸѡ ���� �����б�
          author:lilifeng
        -->
        <!-- ɸѡ ��ʼ -->
        <div class="xzss">
        <div id="filter">
          <dl>
           <dt >Ʒ�ƣ�</dt>
           <dd class="content content0"><a  val="0">ȫ��</a>
           <%foreach (System.Data.DataRow row in dt_ejflpp.Rows){%>
           <a val="<%=row["pp_id"]%>"><%=row["Ʒ������"]%></a>
           <%} %>
           </dd></dl>         
         
    <!--�������Կ�ʼ-->
     <%int count=1;string classname="content1"; %> 
    <%if(dt_flsx.Rows.Count>2)
     { 
       for(int i=1;i<=2;i++){
        var row=dt_flsx.Rows[i-1];%>
       <dl ><dt><%=row["��ʾ"]%>��</dt>
           <dd class="content <%=classname%>"><a val="0">ȫ��</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["����ֵ"]%></a>
           <%}%>
           <%}%>            
             </dd></dl>
         <%count++;classname="content"+count;%>
       <% }%>
       <div id="btnMore" style="cursor:pointer;"><span style="font-weight:bold">����</span><img src="images/more_03.jpg" />
       <div id="more" style="display:none">
        <%for (int i = 3; i <=dt_flsx.Rows.Count; i++){%>
         <%var row=dt_flsx.Rows[i-1]; %>
         <dl ><dt><%=row["��ʾ"]%>��</dt>
           <dd class="content <%=classname%>"><a val="0">ȫ��</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["����ֵ"]%></a>
           <%}%>
        <%}%>
          </dd></dl>
         <%count++;classname="content"+count;%>
        <%}%></div>
        </div>
      <% }%>
  <% else{%>
    <% foreach (System.Data.DataRow row in dt_flsx.Rows){%>          
           <dl ><dt><%=row["��ʾ"]%>��</dt>
           <dd class="content <%=classname%>"><a val="0">ȫ��</a>
           <%foreach (System.Data.DataRow row1 in dt_flsxz.Rows){%>
           <%if (row["flsx_id"].ToString()==row1["flsx_id"].ToString()){%>
            <a val="<%=row1["flsxz_id"]%>"><%=row1["����ֵ"]%></a>
           <%}%>
           <%}%>            
             </dd></dl>
         <%count++;classname="content"+count;%>
           <%}%>
      <% }%>
     <!--�������Խ���-->
        </div>

        <div class="dlspx">
                 <span class="dlspx3">����</span>
                <ul id="sort" >
                    <li val="0" class="dlspx3" >Ĭ�Ϸ�ʽ</li>
                    <li val="1" class="dlspx3" ><span class="pl14px">����<img src="images/qweqw_03.jpg" /></span></li>
                    <li val="2" class="dlspx3" ><span>����<img src="images/qweqw_03.jpg" /></span></li>
                </ul>              
               <span class="dlspx3"><input type="checkbox" value="" id="ckAll" class="fx" />ȫѡ</span>
                <span class="dlspx4"><a id="collect">���ղأ����ڲ���</a></span>
            </div>
        </div>
         <!-- ɸѡ ���� -->

        <!-- ������ʾ�б� ��ʼ-->
        <div class="dlspxl" id="dv">
          <%if(dt_clxx.Rows.Count>0){ %>
            <% foreach(System.Data.DataRow row in dt_clxx.Rows){
                String  mc = row["��ʾ��"].ToString();
               if (mc.Length > 6) {
                    mc = mc.Substring(0,6)+"..";
               } 
            
            %>
            <div class="dlspxt">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>" title="<%=row["��ʾ��"].ToString() %>">
                    <%
                    string str_sqltop1 = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'";
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
                              parm=row["���ϱ���"].ToString()+"|"+row["pp_id"].ToString();
                             %>
                            <input name="item" type="checkbox" value="<%=parm%>" class="ck" />�ղ�
                        </span>
                        <span class="dlsgg" >���<%=row["����ͺ�"].ToString() %></span>
                    </div>              
            </div>
            <% } %>
            <%}else{ %>
              <span style="font-size:30px;font-weight:bolder;color:Red;padding:0 300px;"><%=defaultMsg%></span>
            <%} %>
        </div>
        <!-- ������ʾ�б� ����-->

        <!-- ���������ʯ�� ��ʼ -->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_ejflcl.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString() %></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2"><a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
        </div>
        <!-- ���������ʯ�� ����-->
    </div>

    <!-- ��ҳ ��ʼ -->
    <div class="fy2">
        <div class="fy3">
              <div id="page"><%=pageBar %></div>  
        </div>
    </div>
    <!-- ��ҳ ����-->

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->
    <div id="msgStr" style="display:none"><%=msg %></div>
    <div id="name" style="display:none"><%=name%></div>
  
</body>
</html>
