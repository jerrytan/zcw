
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<script runat="server">  
        protected DataConn dc_obj = new DataConn();
        protected DataTable dt_msg = new DataTable(); //分页后存放的分销商信息

        protected string cl_id;    //材料id
        protected string address;   //供应商地址
        protected string content;   //分销商信息
        protected string fy_list;   //分页信息

        private const int Page_Size = 2; //每页的记录数量
        private int CurrentPage = 1;//当前默认页为第一页
        private int PageCount; //总页数
    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                cl_id = Request["cl_id"];
                address = Request["address"];
                if (!string.IsNullOrEmpty(address))
                {
                    string strP = Request.QueryString["p"];
                    if (string.IsNullOrEmpty(strP))//判断传过来的参数是否为空  
                    {
                        strP = "1";
                    }

                    int p;
                    bool b1 = int.TryParse(strP, out p);
                    if (b1 == false)
                    {
                        p = 1;
                    }
                    CurrentPage = p;

                    //获取"总页数"
                    string strC = "";
                    if (string.IsNullOrEmpty(strC))
                    {
                        double recordCount = GetCLFXSCount(address);
                        double d1 = recordCount / Page_Size;
                        double d2 = Math.Ceiling(d1);
                        int pageCount = (int)d2;
                        strC = pageCount.ToString();
                    }
                    int c;
                    bool b2 = int.TryParse(strC, out c);
                    if (b2 == false)
                    {
                        c = 1;
                    }
                    PageCount = c;

                    //计算/查询分页数据
                    int begin = (p - 1) * Page_Size + 1;
                    int end = p * Page_Size;
                    if (address.Equals("-省(市)-"))
                    {
                        address = "";
                    }
                    dt_msg = this.GetPageList(cl_id, begin, end, address);

                    if (dt_msg != null && dt_msg.Rows.Count > 0)//有数据,则进行遍历
                    {
                        //所有的供应商信息
                        foreach (System.Data.DataRow row in dt_msg.Rows)
                        {
                            content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                                + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                                + row["供应商"].ToString() + "</li><li>联系人："
                                + row["联系人"].ToString() + "</li><li>电话："
                                + row["联系人手机"].ToString() + "</li><li>地址："
                                + row["联系地址"].ToString() + "</li></ul></a></div>";
                        }
                        
						 //分页显示信息
						if((CurrentPage <= 1) && (PageCount <=1)) { //一页
							fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
							+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
						}
						else if((CurrentPage<= 1)  && (PageCount>1)) {//两页 
							fy_list += "<span style='font-size:12px;color:Black'><font style='color:Gray'>上一页</font>&nbsp;<a href='clxx.aspx?cl_id="
							+ cl_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
							+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
						}   
						else if(!(CurrentPage<=1)&&!(CurrentPage == PageCount)){  //多页
							fy_list += "<span style='font-size:12px;color:Black'><a href='clxx.aspx?cl_id="
							+ cl_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<a href='clxx.aspx?cl_id="
							+ cl_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>&nbsp;&nbsp;第"
							+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
						}
						else if((CurrentPage == PageCount) && (PageCount > 1)){  //末页
							fy_list += "<span style='font-size:12px;color:Black'><a href='clxx.aspx?cl_id="
							+ cl_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a>&nbsp;<font style='color:Gray'>下一页</font>&nbsp;&nbsp;第"
							+ CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>"; 
						}
                    }
                    Response.Write(content);
                    Response.Write("@");
                    Response.Write(fy_list);
                }
            }
        }
    
		//从数据库获取记录的总数量
        protected int GetCLFXSCount(string address)
        {
            int i_count=0;
            try
            {
                string cl_id = Request["cl_id"];   //获取供应商id
				string str_sql_fxsxx="";
				if(address.Equals("-省(市)-"))
				{
					str_sql_fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"'))";
				}
				str_sql_fxsxx = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id='"+cl_id+"')) and 联系地址 like '%"+address+"%'";
                 
                i_count = dc_obj.GetRowCount(str_sql_fxsxx);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return i_count;
        } 
		
        //获取分页信息:cl_id 材料id, begin 开始, end 结束
        protected DataTable GetPageList(string cl_id, int begin, int end,string address)
        {

            //执行分页的sql语句
             string str_sqlpage = @"select 供应商,联系人,联系人手机,联系地址,gys_id from (select ROW_NUMBER() over (order by gys_id) as RowId,* from 材料供应商信息表 where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id = (select pp_id from 材料表 where cl_id= @cl_id ))and 联系地址 like '%'+@address+'%')t where t.RowId between @begin and @end  ";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@cl_id",SqlDbType.VarChar),
                    new SqlParameter("@address",SqlDbType.VarChar)
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = cl_id;
            parms[3].Value = address;
            return dc_obj.GetDataTable(str_sqlpage, parms);
        }
		
</script>
