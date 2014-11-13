<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>
 
<script runat="server">
    DataConn objConn = new DataConn();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie CGS_QQ_ID = null;
        string CGS_QQ_ID1 = "";
        //采购商 
        if (Request.Cookies["CGS_QQ_ID"] != null)
        {
            CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
        }
        if (Session["CGS_YH_ID"] != null)
        {
            CGS_QQ_ID1 = Session["CGS_YH_ID"].ToString();
        }
         object cgs_yh_id = Session["CGS_YH_ID"];
            string str_cl = Request["cl_id"];	   
            string str_gysid = Request["gys_id"];  //获取页面传过来的供应商id
            string str_sccs = Request["sccs"];     //获取页面传过来的生产厂商
            string str_clid = Request["clid"];     //获取页面传过来的材料id
            string str_clmc = Request["clmc"];     //获取页面传过来的材料名称  
            string str_clbm = Request["clbm"];     //获取页面传过来的材料编码 ;            
            Session["cl_id"] = str_clid;
			//采购商 登陆
            if (CGS_QQ_ID == null && CGS_QQ_ID1 == "")
            {
                Response.Write("0");
              //  Response.Write("<script> window.open(\"cgsdl.aspx\", \"\", \"height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes\");window.close();</" + "script>");
            }
            else   //采购商登录的情况
            {

                if (CGS_QQ_ID != null || CGS_QQ_ID1 != "")
                {
                    try
                    {
                        string qqid = "";
                        DataTable dt_scrxx = new DataTable();
                        string sql_scrxx = "";
                        if (CGS_QQ_ID == null)
                        {
                            qqid = CGS_QQ_ID1;
                            sql_scrxx = "select yh_id,姓名,QQ号码,dw_id from  用户表 where yh_id='" + qqid + "'";
                            dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        }
                        else
                        {
                            qqid = CGS_QQ_ID.Value.ToString();
                            sql_scrxx = "select yh_id,姓名,QQ号码,dw_id from  用户表 where QQ_id='" + qqid + "'";
                            dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        }
                         
                        dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        string scryhid = dt_scrxx.Rows[0]["yh_id"].ToString() == "" ? "" : dt_scrxx.Rows[0]["yh_id"].ToString();
                        string scrxm = dt_scrxx.Rows[0]["姓名"].ToString() == "" ? "" : dt_scrxx.Rows[0]["姓名"].ToString();
                        string scrqq = dt_scrxx.Rows[0]["QQ号码"].ToString() == "" ? "" : dt_scrxx.Rows[0]["QQ号码"].ToString();
                        string scrdwid = dt_scrxx.Rows[0]["dw_id"].ToString() == "" ? "" : dt_scrxx.Rows[0]["dw_id"].ToString();

                        string sql_clcount = "select * from 采购商关注的材料表 where cl_id ='" + str_clid + "' and dw_id = '" + scrdwid + "'";
                        //Response.Write(objConn.GetRowCount(sql_clcount));
                        if (objConn.GetRowCount(sql_clcount) == 0)
                        {
                            string sql_scxx = @"insert into 采购商关注的材料表 (yh_id,cl_id,材料名称,材料编码,收藏时间,收藏人QQ,是否启用,dw_id,收藏人,updatetime) 
                            values ('" + scryhid + "','" + str_clid + "','" + str_clmc + "','" + str_clbm + "',GETDATE(),'" + scrqq + "','1','" + scrdwid + "','" + scrxm + "',GETDATE())";
                            if (objConn.ExecuteSQL(sql_scxx, true))
                            {
                                Response.Write("1");
                            }
                            else
                            {
                                Response.Write("收藏失败！");
                            }
                        }
                        else
                        {
                            Response.Write("本公司已收藏改材料！");
                        }                      

                        string sql_gyscount = "select * from 采购商关注供应商表 where gys_id='" + str_gysid + "' and dw_id='" + scrdwid + "'";
                      
                        if (objConn.GetRowCount(sql_gyscount) == 0)
                        {
                            string sql_scgys = @"insert into 采购商关注供应商表 (yh_id,gys_id,供应商名称,收藏时间,收藏人QQ,是否启用,dw_id,收藏人,updatetime)  
                            values ('" + scryhid + "','" + str_gysid + "','" + str_sccs + "',GETDATE(),'" + scrqq + "',1,'" + scrdwid + "','" + scrxm + "',GETDATE())";
                            
                            objConn.ExecuteSQL(sql_scgys, true);
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                    }

                    //Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span><br/>");
                    //Response.Write("<span class='dlzi'>该材料已被收藏成功！</span><br/>");
                    //Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span><br/>");
                    //Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span><br/>");
                }
            }
    }
</script>
