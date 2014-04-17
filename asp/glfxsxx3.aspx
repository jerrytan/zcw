<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections.Generic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>

<script runat="server">

    public List<Option_gys> Items { get; set; }

    public class Option_gys
    {//属性
        public string gys_name { get; set; }       //供应商
        public string gys_address { get; set; }    //地址
        public string gys_tel { get; set; }        //电话
        public string gys_homepage { get; set; }   //主页
        public string gys_fax { get; set; }        //传真
        public string gys_area { get; set; }       //地区名称
        public string gys_user { get; set; }       //联系人
        public string gys_user_phone { get; set; }       //联系人手机 
        public string gys_id { get; set; }       //供应商id		
        public string sh { get; set; }
       
    }
    protected DataTable dt_gysxx = new DataTable();
    public DataConn objConn = new DataConn();
    public string fxs_id = "";                   //获取下拉框传过来的分销商id
    public string sSQL = "";
    public string pp_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Request["id"] != null && Request["id"].ToString() != "")
            {
                fxs_id = Request["id"].ToString();
            }
        //   sSQL="select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机,gys_id,fxs_pp.pp_id,fxs_pp.品牌名称 from 材料供应商信息表 cl join  分销商和品牌对应关系表 fxs_pp on cl.gys_id=fxs_pp.fxs_id where gys_id='"+fxs_id+"'";
            sSQL = "select 供应商,地址,电话,主页,传真,地区名称,联系人,联系人手机,gys_id from 材料供应商信息表 where  gys_id='" + fxs_id + "' ";

            dt_gysxx = objConn.GetDataTable(sSQL);

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            this.Items = new List<Option_gys>();  //数据表DataTable转集合  
           if(dt_gysxx!=null&&dt_gysxx.Rows.Count>0)
           {
                DataRow dr2 = dt_gysxx.Rows[0];

                Option_gys item = new Option_gys();

                item.gys_name = Convert.ToString(dr2["供应商"]);
                item.gys_address = Convert.ToString(dr2["地址"]);
                item.gys_tel = Convert.ToString(dr2["电话"]);
                item.gys_homepage = Convert.ToString(dr2["主页"]);
                item.gys_fax = Convert.ToString(dr2["传真"]);
                item.gys_area = Convert.ToString(dr2["地区名称"]);
                item.gys_user = Convert.ToString(dr2["联系人"]);
                item.gys_user_phone = Convert.ToString(dr2["联系人手机"]);
                item.gys_id = Convert.ToString(dr2["gys_id"]);
                this.Items.Add(item);
            }
           else
           {
               sSQL = "select 贵公司名称,贵公司地址,贵公司电话,贵公司主页,贵公司传真,贵公司地区,联系人姓名,联系人电话,gys_id,审批结果 from 供应商自己修改待审核表 where  gys_id='" + fxs_id + "' ";
               dt_gysxx = objConn.GetDataTable(sSQL);
               if (dt_gysxx != null && dt_gysxx.Rows.Count > 0)
               {
                   DataRow dr2 = dt_gysxx.Rows[0];

                   Option_gys item = new Option_gys();

                   item.gys_name = Convert.ToString(dr2["贵公司名称"]);
                   item.gys_address = Convert.ToString(dr2["贵公司地址"]);
                   item.gys_tel = Convert.ToString(dr2["贵公司电话"]);
                   item.gys_homepage = Convert.ToString(dr2["贵公司主页"]);
                   item.gys_fax = Convert.ToString(dr2["贵公司传真"]);
                   item.gys_area = Convert.ToString(dr2["贵公司地区"]);
                   item.gys_user = Convert.ToString(dr2["联系人姓名"]);
                   item.gys_user_phone = Convert.ToString(dr2["联系人电话"]);
                   item.gys_id = Convert.ToString(dr2["gys_id"]);
                   item.sh = Convert.ToString(dr2["审批结果"]);
                   this.Items.Add(item);
               }
           }

            string jsonStr = serializer.Serialize(Items);
            Response.Clear();
            Response.Write(jsonStr);   //向前端glscsxx.aspx输出json字符串
            Response.End();
       
    }
</script>
</html>
