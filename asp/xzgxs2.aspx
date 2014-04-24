<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script runat="server">
        public List<Option_gys> Items { get; set; }

        public class Option_gys
        {//属性
            public string dj { get; set; }       //等级
            public string fw { get; set; }    //范围
            public string flname { get; set; }        //分类名称
            public string flid { get; set; }   //分类id
            public string scs { get; set; }        //生产商
            public string scsid { get; set; }       //生产商id
            public string flbm { get; set; }
            public string pp_id { get; set; }      
            public string ppname { get; set; }
        }
        protected DataConn objConn = new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            string pp_id = "";
            if (Request["id"]!=null&&Request["id"].ToString()!="")
            {
                pp_id = Request["id"].ToString();
            }
            string sSQL = "select pp_id,品牌名称,等级,范围,分类名称,分类编码,fl_id,生产商,scs_id from 品牌字典 where pp_id='"+pp_id+"'";
            DataTable dt_pp_xx = objConn.GetDataTable(sSQL);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            this.Items = new List<Option_gys>();  //数据表DataTable转集合  
            if (dt_pp_xx!=null&&dt_pp_xx.Rows.Count>0)
            {                
                Option_gys item = new Option_gys();
                item.dj = dt_pp_xx.Rows[0]["等级"].ToString();
                item.fw = dt_pp_xx.Rows[0]["范围"].ToString();
                item.flname = dt_pp_xx.Rows[0]["分类名称"].ToString();
                item.flid = dt_pp_xx.Rows[0]["fl_id"].ToString();
                item.scs = dt_pp_xx.Rows[0]["生产商"].ToString(); ;
                item.scsid = dt_pp_xx.Rows[0]["scs_id"].ToString();
                item.flbm = dt_pp_xx.Rows[0]["分类编码"].ToString();
                item.pp_id = dt_pp_xx.Rows[0]["pp_id"].ToString();
                item.ppname = dt_pp_xx.Rows[0]["品牌名称"].ToString();
                Items.Add(item);
            }
            string jsonStr = serializer.Serialize(Items);
            Response.Clear();
            Response.Write(jsonStr);   //向前端glscsxx.aspx输出json字符串
            Response.End();
        }
     </script>
</head>
<body>

</body>
</html>
