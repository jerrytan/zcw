<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"  EnableViewStateMac= "false" %>

     <script runat="server">
     public DataConn Conn = new DataConn();
 
     protected void Page_Load(object sender, EventArgs e)
     {
         string value = "";
         try
         {
             string cl_id = Request["cl_id"];   //SQL语句
             string fxs_id = Request["fxs_id"];   //SQL语句
             string sSQL = "";
             if (cl_id != "")
             {
                 while (cl_id.EndsWith(","))
                 {
                     cl_id = cl_id.Substring(0, cl_id.Length - 1);
                 }
                 string Insert = "";
                 string[] cl_price = cl_id.Split(',');   //添加几项
                 for (int i = 0; i < cl_price.Length; i++)
                 {
                     string[] cl = cl_price[i].Split('|');
                     string price = "";
                     price = cl[1];
                     sSQL = "select fl_id,材料编码,是否启用,类型,price,显示名,pp_id,说明,分类名称,品牌名称,生产厂商,规格型号,计量单位,单位体积,单位重量,gys_id,分类编码,yh_id,一级分类名称 from 材料表 where cl_id='" + cl[0] + "'";
                     DataTable dt_cl = Conn.GetDataTable(sSQL);
                     if (dt_cl != null && dt_cl.Rows.Count > 0)
                     {
                         if (price=="0"||price=="")
                         {
                             price = dt_cl.Rows[0]["price"].ToString();
                         }
                           Insert += "   insert into 供应商材料表(cl_id,fl_id,材料编码,是否启用,类型,price,显示名,pp_id,说明,分类名称,品牌名称,生产厂商,规格型号,计量单位,单位体积,单位重量,gys_id,分类编码,yh_id,一级分类名称,fxs_id,updatetime) values(" +
                            "'" + cl[0] + "','" + dt_cl.Rows[0]["fl_id"] + "','" + dt_cl.Rows[0]["材料编码"] + "','1','" + dt_cl.Rows[0]["类型"] + "','" + price + "','"
                            + dt_cl.Rows[0]["显示名"] + "','" + dt_cl.Rows[0]["pp_id"] + "','" + dt_cl.Rows[0]["说明"] + "','" + dt_cl.Rows[0]["分类名称"] + "','" +
                            dt_cl.Rows[0]["品牌名称"] + "','" + dt_cl.Rows[0]["生产厂商"] + "','" + dt_cl.Rows[0]["规格型号"] + "','" + dt_cl.Rows[0]["计量单位"] + "','"
                            + dt_cl.Rows[0]["单位体积"] + "','" + dt_cl.Rows[0]["单位重量"] + "','" + dt_cl.Rows[0]["gys_id"] + "','" + dt_cl.Rows[0]["分类编码"] + "','" +
                            dt_cl.Rows[0]["yh_id"] + "','" + dt_cl.Rows[0]["一级分类名称"] + "','" + fxs_id + "',(select getdate()))";
                     }                     
                 }
                 if (Conn.RunSqlTransaction(Insert))
                 {
                     value = "1";
                 }
                 else
                 {
                     value = "添加失败！";
                 }
             }
             else
             {
                 value = "未选中材料！";
             }         
         }
         catch (Exception ee)
         {
             value = "添加材料失败！错误信息：" + ee.ToString();
         }
         Response.Write(value);
     }
     </script>