<!--
        ����һ�������б�ҳ��
        �ļ�����yjfl.ascx
        ���������name
        owner:������
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <style type="text/css">
        .p {
            font-size: 12px;
            color: Black;
            font-weight: bold;
            text-decoration: none;
        }

        .p1 {
            font-size: 16px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
    <title>һ������</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
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

    <!-- ��ҳ ʯ����ҳ ��ʼ-->
    <script runat="server">

        protected DataTable dt_ejflmc = new DataTable();   //������������
        protected DataTable dt_allcl = new DataTable();  //�������Ʒ�ҳ (�����µ����в��Ϸ�ҳ)
        protected DataTable dt_yjflmc = new DataTable();  //��ҳ��ʾһ����������
        protected DataTable dt_zclmc = new DataTable();   //����������� ���������ʯ��	
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ���������(���±�)
		protected DataConn dc_obj = new DataConn();	//���߲�����
        		
        protected string currentPageIndex=string.Empty; //�Զ���������������ŵ�ǰҳ��
        protected string currentPageCount = string.Empty;      
        protected string btnVisitValue = "������";
        protected string btnUpdateValue = "�������ڡ�";

        protected void Page_Load(object sender, EventArgs e)
        {
            string name= Request["name"]; //��ȡ��ҳ��������һ���������(��λ)

            string str_sqltop10 = "select top 10 ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name+"' and len(�������)='4' ";            
            dt_ejflmc = dc_obj.GetDataTable(str_sqltop10);

            string str_sqlflname = "select  ��ʾ����,fl_id from ���Ϸ���� where  �������='"+name+"' ";                
            dt_yjflmc = dc_obj.GetDataTable(str_sqlflname);      
  
            string str_sqltop10name = "select  top 10 ��ʾ��,cl_id from ���ϱ� where left(���ϱ���,2)='"+name+"' order by ���ʼ��� desc";              
            dt_zclmc = dc_obj.GetDataTable(str_sqltop10name); 
			
			string str_top4wz = "select top 4 ����,ժҪ,wz_id from ���±� where left(�������,2)='"+name+"' ";
			dt_wz = dc_obj.GetDataTable(str_top4wz);
            
			 if(!IsPostBack)
              {
                   dt_allcl=BindProductList(1);  
              }    
                 
            //��һҳ
            if(!string.IsNullOrEmpty(Request.Form["HtmBtnPrePage"]))
            {
                int pageIndex = Convert.ToInt32(Request.Form["HidPageIndex"]);
                dt_allcl=BindProductList(--pageIndex);
            }
            //��һҳ
            if (!string.IsNullOrEmpty(Request.Form["HtmBtnNextPage"]))
            {
                int pageIndex = Convert.ToInt32(Request.Form["HidPageIndex"]);
                dt_allcl=BindProductList(++pageIndex);            
            }
         
          //����������
            if (!string.IsNullOrEmpty(Request.Form["btnVisitOderBy"]))
            {
                OrderByVisit(Request.Form["btnVisitOderBy"].ToString());
            }
            else
            {
                if (ViewState["orderBy"] != null)
                {
                    if (ViewState["orderBy"].ToString() == "���ʼ��� asc")
                    {
                        btnVisitValue = "������";
                    }
                }
            }
            //����������           
            if (!string.IsNullOrEmpty(Request.Form["btnUpdateOderBy"]))
            {
                OrderByUpdateTime(Request.Form["btnUpdateOderBy"].ToString());
            }
            else
            {
                if (ViewState["orderBy"] != null)
                {
                    if (ViewState["orderBy"].ToString() == "updatetime asc")
                    {
                        btnUpdateValue = "�������ڡ�";
                    }
                }
            }
        }    

         //����������������
        private void OrderByVisit(string value)
        {
            if (value == "������")
            {
                btnVisitValue = "������";
                ViewState["orderBy"] = "���ʼ��� asc";
            }
            else
            {
                btnVisitValue = "������";
                ViewState["orderBy"] = "���ʼ��� desc";
            }
            dt_allcl=BindProductList(1);//��ʾ�����ĵ�һҳ
        }


        //���ո������ڽ�������
         private void OrderByUpdateTime(string value)
        {
            if (value == "�������ڡ�")
            {
                btnUpdateValue = "�������ڡ�";
                ViewState["orderBy"] = "updatetime asc";
            }
            else
            {
                btnUpdateValue = "�������ڡ�";
                ViewState["orderBy"] = "updatetime desc";
            }
           dt_allcl=BindProductList(1);//��ʾ�����ĵ�һҳ
        }


        //�õ���ҳ��Ϣ
        protected  DataTable GetList(int pageIndex ,int pageSize,string name,string orderBy)
        {
        string sql=@"select ��ʾ��,���ϱ���,cl_id,fl_id,����ͺ�  from (select ROW_NUMBER() over (order by {0}) as RowId ,*from ���ϱ� where left(���ϱ���,2)=@name)t
where t.RowId between (@pageIndex-1)*@pageSize+1 and @pageIndex*@pageSize ";
            sql=string.Format(sql,(orderBy!=""&&orderBy!=null)?orderBy:"myID");
             SqlParameter[] parms = { 
                                   new SqlParameter("@pageIndex",SqlDbType.Int),
                                   new SqlParameter("@pageSize",SqlDbType.Int),
                                   new SqlParameter("@name",SqlDbType.VarChar)
                                };
            parms[0].Value=pageIndex;
            parms[1].Value=pageSize;
            parms[2].Value=name;
           return dc_obj.GetDataTable(sql,parms);
        
        }


         //��ʾ��ǰҳ����Ϣ
         private DataTable BindProductList(int pageIndex)
        {           
            int pageCount;       
            string  categoryId=string.Empty;
            if (Request.QueryString["name"]!=null) //�ж��Ƿ�ѡ���˷���
            {
                categoryId =Request.QueryString["name"];
            }           
            pageCount =GetPageCount(categoryId,12);//��ҳ��
           
            if (pageIndex < 1)
            {
                pageIndex = 1;
            }
            if (pageIndex > pageCount)
            {
                pageIndex = pageCount;
            } 
           
            currentPageIndex = pageIndex.ToString();
            currentPageCount = pageCount.ToString();

            string orderBy = string.Empty;
            if(ViewState["orderBy"]!=null)
            {
                orderBy = ViewState["orderBy"].ToString();
            }
             return GetList(pageIndex,12,categoryId,orderBy);
            }
               
        //�õ���ҳ��
         private int GetPageCount(string name,int pageSize)
        {          
             string sql = "select count(cl_Id) from ���ϱ� where left(���ϱ���,2)='"+name+"'";
             string pageStr = dc_obj.DBLook(sql);
             int recordCount =Convert.ToInt32(pageStr);
             return Convert.ToInt32(Math.Ceiling(1.0 * recordCount / pageSize));
      }

    </script>

    <div class="sc">
        <% string name=Request["name"];%>
        <div class="sc1">
            <a href="index.aspx" class="p1">��ҳ ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_yjflmc.Rows){%>
            <a href="#"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc2">
            <% foreach(System.Data.DataRow row in dt_ejflmc.Rows){%>
            <a href="ejfl.aspx?name=<%=row["�������"] %>"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc3">
		    <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               string resume = row["ժҪ"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1" style="overflow:hidden"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����"].ToString() %></a></div>
                <div class="rh2" style="overflow:hidden"><%=resume %></div>
            </div>
			<%}%>			
        </div>
        <form id="Form1" runat="server">        
        <div class="px0">
            <div class="px">����ʽ�� <input type="submit" value="<%=btnVisitValue %>"  name="btnVisitOderBy"/> 
            |             <input  type="submit" value="<%=btnUpdateValue %>" name="btnUpdateOderBy" /></div>
        </div>
    
        <div class="pxleft">      
           

            <% foreach(System.Data.DataRow row in dt_allcl.Rows)
               {%>
                <div class="pxtu">
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
				    <%
					    string str_sqltop1dz = "select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                                                            +row["cl_id"]+"'"; //and ��С='С'";
                        string imgsrc= "images/222_03.jpg";
                        object result = dc_obj.DBLook(str_sqltop1dz);
                        if (result != null) 
                        {
                            imgsrc = result.ToString();
                        }
                        Response.Write(@"<img src='http://192.168.1.22/"+imgsrc+ "' width=150px height=150px />") ;  
				    %>
                    </a>
                <span class="pxtu1" style="overflow:hidden"><%=row["��ʾ��"].ToString()%></span>
                </div>
            <%}%>
         </div>

        <!-- ���������ʯ�� ��ʼ-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1" style=" text-align:left; padding-left:0px !important; padding-left:20px;overflow:hidden">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt_zclmc.Rows){%>
                        <li style="overflow:hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString()%></a></li>
                        <%}%>
                    </ul>
                </div>
            </div>
            <div class="pxright2">
                <a href="#">
                    <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" />
                </a>
            </div>
        </div>
         <!-- ���������ʯ�� ����-->
    </div>
   
    <!-- ��ҳ ʯ����ҳ ����-->

    <!-- ʯ�Ĺ��ҳ�� ��ʼ-->
    <div >
        <div class="fy2">
            <div class="fy3" style=" width:500px;height:auto; padding-left:0% !important; padding-left:23%">
               ��<%=currentPageIndex%>ҳ&nbsp;&nbsp;��<%=currentPageCount %>ҳ
         <input type="hidden" name="HidPageIndex" value="<%=currentPageIndex %>" />        
         <input type="submit" name="HtmBtnPrePage" value="��һҳ" />
          <input type="submit" name="HtmBtnNextPage" value="��һҳ" />
            </div>
        </div>
    </div>
    <!-- ʯ�Ĺ��ҳ�� ����-->
   </form>
    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

</body>
</html>
