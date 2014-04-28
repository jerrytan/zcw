<!--
        gysxx.aspx中的下拉框ajax响应页面
        文件名：gysxx_ajax.aspx
        传入参数：
                    gys_id 供应商编号
                    address    地址
                    gys_count  数量
        负责人:任武       
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<script runat="server">
        protected DataConn dc = new DataConn();
        protected DataTable dt_msg = new DataTable(); //分页后存放的分销商信息

        protected string gys_id;    //供应商id
        protected string address;   //供应商地址
        protected double count;     //生产商旗下所有的供应商
        protected string content;   //分销商信息
        protected string fy_list;   //分页信息

        private const int Page_Size = 3; //每页的记录数量
        private int CurrentPage=1;//当前默认页为第一页
        private int PageCount; //总页数


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                gys_id = Request["gys_id"];
                count =  double.Parse(Request["gys_count"]);

                address = Request["address"];
                if (!string.IsNullOrEmpty(address))
                {
                    string strP = Request.QueryString["p"];
                    if(string.IsNullOrEmpty(strP))//判断传过来的参数是否为空  
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
                    if(string.IsNullOrEmpty(strC))
                    {
                        double recordCount = count; 
                        double d1 = recordCount / Page_Size; 
                        double d2 = Math.Ceiling(d1); 
                        int pageCount = (int)d2; 
                        strC = pageCount.ToString();
                    }
                    int c;
                    bool b2 = int.TryParse(strC,out c);
                    if (b2 == false)
                    {
                        c = 1;
                    }
                    PageCount = c;

                    //计算/查询分页数据
                    int begin = (p - 1) * Page_Size + 1;
                    int end = p * Page_Size;
                    if(address.Equals("-省(市)-"))
                    {
                        address="";
                    }
                    dt_msg = this.GetPageList(gys_id,begin,end,address);

                    if(dt_msg != null && dt_msg.Rows.Count>0)//有数据,则进行遍历
                    {   
                        //所有的供应商信息
                        foreach(System.Data.DataRow row in dt_msg.Rows)
                        {
                             content += "<div class='fxs2'><a href='gysxx.aspx?gys_id="
                                        + row["gys_id"].ToString() + "'><ul><li class='fxsa'>"
                                        + row["供应商"].ToString() + "</li><li>联系人："
                                        + row["联系人"].ToString() + "</li><li>电话："
                                        + row["联系人手机"].ToString() + "</li><li>地址："
                                        + row["联系地址"].ToString() + "</li></ul></a></div>";;
                        }
                        //分页信息
                        if(CurrentPage>1 && CurrentPage!=PageCount)
                        {
                            fy_list += "<span style='font-size:12px;color:Black'><a href='gysxx.aspx?gys_id="
                            + gys_id + "&p=" + (CurrentPage-1).ToString() + "' style='color:Black'>上一页</a><a href='gysxx.aspx?gys_id="
                            + gys_id + "&p=" + (CurrentPage+1).ToString() + "' style='color:Black'>下一页</a>第"
                            + CurrentPage.ToString() + "页/共" + PageCount.ToString() + "页</span>";
                        }
                    }
                    Response.Write(content);
                    Response.Write("@");
                    Response.Write(fy_list);
                }
            }
        }


        //获取分页信息:gys_id 生产商id, begin 开始, end 结束, address 地址
        protected DataTable GetPageList(string gys_id, int begin, int end,string address)
        {
            
            //执行分页的sql语句
            string str_sqlpage = @"select gys_id,供应商,联系人,联系人手机,联系地址 from (select ROW_NUMBER() over (order by gys_id) as RowId ,* from 材料供应商信息表  where gys_id in(select fxs_id from 分销商和品牌对应关系表 where pp_id in(select pp_id from 品牌字典 where scs_id=@gys_id) ))t where t.RowId between @begin and @end and t.联系地址 like '%'+@address+'%' ";
            //添加相应参数值
            SqlParameter[] parms = new SqlParameter[] 
            {      
                    new SqlParameter("@begin",SqlDbType.Int),
                    new SqlParameter("@end",SqlDbType.Int),
                    new SqlParameter("@gys_id",SqlDbType.VarChar),
                    new SqlParameter("@address",SqlDbType.VarChar)
            };
            parms[0].Value = begin;
            parms[1].Value = end;
            parms[2].Value = gys_id;
            parms[3].Value = address;
            return  dc.GetDataTable(str_sqlpage,parms);
        }
</script>