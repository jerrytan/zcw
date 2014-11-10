<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Page Language="C#"  EnableViewStateMac= "false" %>
     <script runat="server">
     public DataConn Conn = new DataConn();
     private System.Web.HttpPostedFile postedFile = null;
     protected void Page_Load(object sender, EventArgs e)
     {
         string value = "";
         string scsid = "";
         try
         {
             string s_yh_id = "";
             if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
             {
                 s_yh_id = Session["GYS_YH_ID"].ToString();
             }
             string flbm = Request["flbm"];
             string clbm = Request["clbm"];
             string clmc = Request["clmc"];
             string ggxh = Request["mcgz"];
             string jldw = Request["jldw"];
             string dwzl = Request["dwzl"];
             string dwtj = Request["dwtj"];
             string yyfw = Request["yyfw"];
             string ppid = Request["ppid"];
             string cpjg = Request["cpjg"];
             string SQL = Request["SQL"];   //SQL语句
                    scsid = Request["scsid"];   //SQL语句
             string sSQL = "";
 
             string dmt = Request["dmt"];
             string countSQL = "select count(*) from 材料表 where 材料编码='" + clbm + "' and pp_id='" + ppid + "' and gys_id='" + scsid + "'";
             string count = Conn.DBLook(countSQL);

             if (Convert.ToInt32(count) > 0)
             {
                 value = "材料已存在!";
             }
             else
             {
                 string datetime = "";
                 datetime = DateTime.Now.ToString();
                 sSQL = "insert into  材料表(显示名,规格型号,计量单位,单位重量,单位体积,说明,是否启用,pp_id,price,gys_id,分类编码,材料编码,updatetime) "
                    + "values('" + clmc + "','" + ggxh + "','" + jldw + "','" + dwzl + "','" + dwtj + "','" + yyfw + "','1','" + ppid + "','" + cpjg + "','" + scsid + "','" + flbm + "','" + clbm + "','" + datetime + "') ";
                 //更新材料表
                 bool bcl = Conn.ExecuteSQL(sSQL, false);
                 if (bcl)
                 {
                     string sqlclid = "(select myID from 材料表 where 显示名='" + clmc + "' and 材料编码='" + clbm + "' and gys_id='" + scsid + "' and pp_id='" + ppid + "')";
                     sSQL = "update 材料表 set cl_id= " + sqlclid + ","
                           + "fl_id = (select fl_id from 材料分类表 where 分类编码='" + flbm + "'),"
                           + "生产厂商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + scsid + "'),"
                           + "分类名称=(select 显示名字 from 材料分类表 where 分类编码='" + flbm + "'), "
                           + "品牌名称=(select 品牌名称 from 品牌字典 where pp_id='" + ppid + "' ),updatetime=(select getdate()),"
                           + "一级分类名称=( select 显示名字 from 材料分类表 where len(分类编码)=2 and 分类编码=SUBSTRING('" + flbm + "',1,2) ),yh_id='" +
                           s_yh_id
                           + "'" + " where myID=" + sqlclid + " and updatetime='" + datetime + "'";
                     bool bupdate = Conn.ExecuteSQL(sSQL, false);
                     if (bupdate)
                     {
                         //添加属性信息
                         while (SQL.EndsWith("◣"))
                         {
                             SQL = SQL.Substring(0, SQL.Length - 1);
                         }
                         sSQL = "";
                         SQL = SQL.Replace("clmc", clmc);
                         SQL = SQL.Replace("clbm", clbm);
                         string[] arrSql = SQL.Split('◣');
                         for (int i = 0; i < arrSql.Length; i++)
                         {
                             string sqlresult = "";
                             sqlresult = "'" + arrSql[i].Replace(",", "','") + "'";
                             sqlresult = sqlresult.Replace("'clid'", sqlclid);
                             sSQL += "insert into 材料属性表 (分类属性名称,分类属性编码,flsx_id,分类属性值,分类属性值编号,flsxz_id,属性属性值编码,fl_id,分类名称,cl_id,材料名称,材料编码,updatetime)values("
                             + sqlresult + ",(select getdate()))    ";
                         }
                         bool b = Conn.RunSqlTransaction(sSQL);
                         if (b)
                         {
                             sSQL = "";
                             if (dmt != "")
                             {
                                 //添加多媒体信息
                                 while (dmt.EndsWith("◥"))
                                 {
                                     dmt = dmt.Substring(0, dmt.Length - 1);
                                 }
                                 string[] arrPath = dmt.Split('◥');
                                 for (int i = 0; i < arrPath.Length; i++)
                                 {
                                     string[] arrTotal = new string[3];
                                     arrTotal = arrPath[i].Split(',');
                                     sSQL += "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,分类,存放地址,updatetime) values(" +
                                      sqlclid + " ,'" + clbm + "','" + clmc + "','是','" + arrTotal[0] + "','" + arrTotal[1] + "','" + arrTotal[2] + "',(select getdate()))  ";
                                 }
                                 bool bdmt = Conn.RunSqlTransaction(sSQL);
                                 if (bdmt)
                                 {
                                     value = "1";
                                 }
                                 else
                                 {
                                     value = "添加多媒体信息失败 添加语句：" + sSQL;
                                 }
                             }
                             else
                             {
                                 value = "1";
                             }
                         }
                         else
                         {
                             value = "添加属性信息失败！";

                         }
                     }
                     else
                     {
                         value = "更新材料表失败！错误语句"+sSQL;
                     }
                 }
                 else
                 {
                     value = "添加材料失败！错误语句" + sSQL;
                 }
             }
         }
         catch (Exception ee)
         {
             value = "添加材料失败！错误信息：" + ee.ToString();
         }
         Response.Write(value);
         //if (value == "1")
         //{
         //    Response.Write("<scrpt>alert('添加成功！');window.localtion.href='gysglcl.aspx?gys_id=" + scsid + "';</" + "script>");
         //}
         //else
         //{
         //    Response.Write("<scrpt>alert('" + value + "');window.localtion.href='gysglcl.aspx?gys_id=" + scsid + "';</" + "script>");
         //}
          
     }
     </script>
