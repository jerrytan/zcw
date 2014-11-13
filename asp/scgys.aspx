<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Page Language="C#" %>

 
<script runat="server">
    DataConn objConn = new DataConn();
    DataTable dt = new DataTable();
    public string gys_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
          gys_id = Request["gys_id"];
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
        if (CGS_QQ_ID == null && CGS_QQ_ID1 == "")
        {
           // Response.Write("<script> window.open(\"cgsdl.aspx\", \"\", \"height=400,width=400,top=100,left=500,status=no,location=no,toolbar=no,directories=no,menubar=yes\");window.close();</" + "script>");
            Response.Write("0");
        }
        else
        {
            DataConn objConn = new DataConn();
            DataTable dt = new DataTable();
            string dw_id = "";
            string yh_id = "";
            try
            {
                //查询是否该QQid已经登录过
     
                if (CGS_QQ_ID == null)
                {
                    string qqid = CGS_QQ_ID1;
                    string sql_scrxx = "select yh_id,姓名,QQ号码,dw_id from  用户表 where yh_id='" + qqid + "'";
                    dt = objConn.GetDataTable(sql_scrxx);
                }
                else
                {
                    string qqid = CGS_QQ_ID.Value.ToString();
                    string sql_scrxx = "select yh_id,姓名,QQ号码,dw_id from  用户表 where QQ_id='" + qqid + "'";
                    dt = objConn.GetDataTable(sql_scrxx);
                }
                string QQ = "";
                string name = "";
                if (dt != null && dt.Rows.Count > 0)
                {
                    dw_id = dt.Rows[0]["dw_id"].ToString();
                    yh_id = dt.Rows[0]["yh_id"].ToString();
                    QQ = dt.Rows[0]["QQ号码"].ToString();
                    name = dt.Rows[0]["姓名"].ToString();
                }               //先判断“采购商关注供应商表”是否有该记录，如果没有，则插入

                string str_checkexist = "select count(*) from 采购商关注供应商表 where dw_id = '" + dw_id + "' and gys_id ='" + gys_id + "'";

                int res_checkexist = Convert.ToInt32(objConn.DBLook(str_checkexist));
                if (res_checkexist ==0)
                {
                    string str_getcl = "select 供应商,gys_id from 材料供应商信息表 where gys_id ='" + gys_id + "'";
                    DataTable dt_cl = objConn.GetDataTable(str_getcl);
                    string str_gysid = Convert.ToString(dt_cl.Rows[0]["gys_id"]);
                    string str_gysname = Convert.ToString(dt_cl.Rows[0]["供应商"]);
                    string str_addgys = "insert into 采购商关注供应商表 (yh_id,gys_id,供应商名称,dw_id,updatetime,收藏时间,是否启用,收藏人QQ,收藏人) values ('" +
                        yh_id + "','" + str_gysid + "','" + str_gysname + "','" + dw_id + "',(select getdate()),(select getdate()),'1','"+QQ+"','"+name+"')";
                    if (objConn.ExecuteSQL(str_addgys, true))
                    {
                        Response.Write("1");
                    }
                    else
                    {
                        Response.Write("收藏失败");
                    }
                    
                }
                else
                {
                    Response.Write("公司内已收藏该厂商");
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
            //Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span><br/>");
            //Response.Write("<span class='dlzi'>该供应商信息已被收藏成功！</span><br/>");
            //Response.Write("<span class='dlzi'><a href='cgsgl_2.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span><br/>");
            //Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span><br/>");
        }
    }

</script>
 