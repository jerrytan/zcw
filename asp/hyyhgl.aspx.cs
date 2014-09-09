using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public class UserGys
{
    public string QQ { get; set; }
    public string Name { get; set; }
    public string Phone { get; set; }
    public string Email { get; set; }
    public string Power { get; set; }
}
public class OptionItem
{
    public string Text { get; set; }
    public string SelectedString { get; set; }
    public string Value { get; set; }
}

public partial class asp_hyyhgl : System.Web.UI.Page
{
    public List<UserGys> listGys { get; set; }
    protected DataTable dtGys = new DataTable();
    protected DataConn dc = new DataConn();

    private const int Page_Size = 10; //每页的记录数量
    public int current_page = 1;//当前默认页为第一页
    public int pageCount_page; //总页数
    protected DataTable dt_content = new DataTable();
    private int i_count = 0;
    public List<OptionItem> Items { get; set; }//用于跳转页面

    protected void Page_Load(object sender, EventArgs e)
    {
        string sql_dwid;

        if (Request.Cookies["GYS_QQ_ID"]!=null)
        {
            string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            sql_dwid = "select dw_id from 用户表 where QQ_id='" + gys_QQ_id + "'";
        }
        else
        {
            string cgs_QQ_id = Request.Cookies["CGS_QQ_ID"].Value.ToString();
            sql_dwid = "select dw_id from 用户表 where QQ_id='" + cgs_QQ_id + "'";
        }

        int dwid = Convert.ToInt32(dc.DBLook(sql_dwid));


        //从查询字符串中获取"页号"参数
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
        current_page = p;

        //从查询字符串中获取"总页数"参数
        string strC = Request.QueryString["c"];
        if (string.IsNullOrEmpty(strC))//首次从数据中获取总记录数
        {
            double recordCount = this.GetProductCount(); //134
            double d1 = recordCount / Page_Size; //13.4
            double d2 = Math.Ceiling(d1); //14.0
            int pageCount = (int)d2; //14
            strC = pageCount.ToString();
        }
        int c;
        bool b2 = int.TryParse(strC, out c);
        if (b2 == false)
        {
            c = 1;
        }
        pageCount_page = c;

        //计算/查询分页数据
        int begin = (p - 1) * Page_Size + 1;
        int end = p * Page_Size;
        dt_content = this.GetProductFormDB(begin, end, dwid);
        this.SetNavLink(p, c);

        this.listGys = new List<UserGys>();
        if (dt_content.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_content.Rows)
            {
                UserGys ug = new UserGys();
                ug.QQ = dr["QQ号码"].ToString();
                ug.Name = dr["姓名"].ToString();
                ug.Phone = dr["手机"].ToString();
                ug.Email = dr["邮箱"].ToString();
                ug.Power = dr["角色权限"].ToString();
                listGys.Add(ug);
            }
        }
        //else
        //{
        //    UserGys ug = new UserGys();
        //    ug.QQ = "";
        //    ug.Name = "";
        //    ug.Phone = "";
        //    ug.Email = "";
        //    ug.Power = "";
        //    listGys.Add(ug);
        //}


        
    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {

        //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "描述性词语", "getDelete();", true);


        string sqlDelete = "";
        string strSelected = this.txt_Selected.Value.ToString();
        if (string.IsNullOrEmpty(strSelected))
        {
            Response.Write("<script>window.alert('请选中要删除的行')</script>");
        }
        else
        {
            strSelected = strSelected.TrimEnd(',');
            string[] arrSelected = strSelected.Split(',');
            for (int i = 0; i < arrSelected.Length; i++)
            {
                sqlDelete += "delete from 用户表 where QQ号码 = '" + arrSelected[i] + "'; ";
            }

            if (dc.RunSqlTransaction(sqlDelete))
            {
                //Response.Write("<script>window.alert('删除成功')</script>");
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "script", "<script>window.alert('删除成功')</script>", true);
                Response.Write("<script>window.location.href=document.URL;</script>");  //刷新页面

            }
            else
            {
                Response.Write("<script>window.alert('删除失败')</script>");
            }

        }
    }


    //设置导航链接 currentPage:当前页号 pageCount:总页数 
    private void SetNavLink(int currentPage, int pageCount)
    {
        this.Items = new List<OptionItem>();
        for (int i = 1; i <= pageCount; i++)
        {
            OptionItem item = new OptionItem();
            item.Text = i.ToString();
            item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
            item.Value = string.Format("hyyhgl.aspx?p={0}", i);
            this.Items.Add(item);
        }

    }


    //根据参数,获取数据库中分页存储过程的结果
    private DataTable GetProductFormDB(int begin, int end, int dwid)
    {
        SqlParameter[] spt = new SqlParameter[]
            {
                new SqlParameter("@begin",begin),
                new SqlParameter("@end",end),
                new SqlParameter("@dwid",dwid)
            };
        return dt_content = dc.ExecuteProcForTable("hyyhgl_Paging", spt);
    }


    //从数据库获取记录的总数量
    private int GetProductCount()
    {
        try
        {
            string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
            string str_sql = "select myID from 用户表 where dw_id = (select dw_id from 用户表 where QQ_id='" + gys_QQ_id + "') and 等级='普通用户' order by updatetime desc";
            i_count = dc.GetRowCount(str_sql);
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
        return i_count;
    }



    //检索
    protected void filter_Click(object sender, EventArgs e)
    {
        string gys_QQ_id = Request.Cookies["GYS_QQ_ID"].Value.ToString();
        string sql_Search = "select * from 用户表 where 1=1 and dw_id = (select dw_id from 用户表 where QQ_id='" + gys_QQ_id + "') and 等级='普通用户'";

        if (this.lieming.Value == "QQ号")
        {
            sql_Search += " and QQ号码='"+this.txtKeyWord.Value.Trim()+"' ";
        }
        else if (this.lieming.Value == "姓名")
        {
            sql_Search += " and 姓名='" + this.txtKeyWord.Value.Trim() + "' ";
        }
        else if (this.lieming.Value == "手机号")
        {
            sql_Search += " and 手机='" + this.txtKeyWord.Value.Trim() + "' ";
        }
        else
        {
            Response.Redirect(Request.Url.ToString());  //页面刷新
            return;
        }

        dtGys = dc.GetDataTable(sql_Search);
        this.listGys = new List<UserGys>();
        foreach (DataRow dr in dtGys.Rows)
        {
            UserGys ug = new UserGys();
            ug.QQ = dr["QQ号码"].ToString();
            ug.Name = dr["姓名"].ToString();
            ug.Phone = dr["手机"].ToString();
            ug.Email = dr["邮箱"].ToString();
            ug.Power = dr["角色权限"].ToString();
            listGys.Add(ug);
        }
        

    }




}