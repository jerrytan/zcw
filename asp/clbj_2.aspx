<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
       string gys_id = "";
        string sSQL = "";
        DataConn objConn = new DataConn();
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            gys_id = Request["gys_id"];
        }
        string cl_id = Request["cl_id"];
        string cl_name = Request["cl_name"];                //材料名称
        string cl_type = Request["cl_type"];                //规格型号              
        string cl_bit = Request["cl_bit"];                  //计量单位
        string cl_volumetric = Request["cl_volumetric"];        //单位体积
        string cl_height = Request["cl_height"];                //单位重量
        string cl_instruction = Request["cl_instruction"];      //说明       
        string brand = Request["brand"];

        //补全材料表信息
        string yjflname = Request["yjflname"];              //大级分类名称 (获取的是下拉列表中value的值 分类编码 两位)              
        string ejflname = Request["ejflname"];              //二级分类名称  (分类编码 4位)
        string flname = ejflname;
        if (flname.Equals("0"))
            flname = yjflname;
        sSQL = "select 分类名称,属性编码,编号 from 材料分类属性值表 where 分类编码='" + flname + "' ";
        System.Data.DataTable dt_cl = objConn.GetDataTable(sSQL);
        string cl_clbm = "";  //材料编码
        string cl_clbh = "";      //材料编号
        string cl_clflname = "";
        if (dt_cl != null && dt_cl.Rows.Count > 0)
        {
            cl_clbm = Convert.ToString(dt_cl.Rows[0]["属性编码"]);  //材料编码
            cl_clbh = Convert.ToString(dt_cl.Rows[0]["编号"]);      //材料编号
            cl_clflname = Convert.ToString(dt_cl.Rows[0]["分类名称"]);      //分类名称
        }
        sSQL = "update 材料表 set gys_id='" + gys_id + "', "
        + "fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
        + "材料编码 ='" + flname + "'+' " + cl_clbm + "'+'" + cl_clbh + "' , 分类编码 = '" + flname + "', "+
        "分类名称='" + cl_clflname + "',品牌名称=(select 品牌名称 from 品牌字典 where pp_id='" + brand + "' ),"+
        "updatetime=(select getdate()),显示名='" + cl_name + "',规格型号='" + cl_type + "',计量单位='" + cl_bit + "',"+
        "单位体积='" + cl_volumetric + "',单位重量='" + cl_height + "',说明='" + cl_instruction + "',是否启用=1 "+
        "where cl_id='"+cl_id+"'";
        int ret = objConn.ExecuteSQLForCount(sSQL, false);
        //获取表单中需要更新材料属性表的变量
        string sx_names = Request["sx_names"];    //获取分类属性名称 (都是下拉列表中value的值为分类属性flsx_id)
        string sx_codes = Request["sx_codes"];    //获取分类属性编码
        string sx_id = Request["sx_id"];          //获取分类属性id
        string cl_value = Request["cl_value"];    //获取分类属性值
        string cl_number = Request["cl_number"];    //获取分类属性值编号
        string cl_ids = Request["cl_ids"];          //获取属性值id

        sSQL = "select 分类属性名称 from 材料属性表 where flsx_id='" + sx_names + "' ";

        System.Data.DataTable dt_flsx = objConn.GetDataTable(sSQL);
        string cl_flsxmc = "";
        if (dt_flsx != null && dt_flsx.Rows.Count > 0)
        {
            cl_flsxmc = Convert.ToString(dt_flsx.Rows[0]["分类属性名称"]);  //分类属性名称
        }
        //补全材料属性表			
        sSQL = "update 材料属性表 set clsx_id=(select max(myid) from 材料属性表 ), "
        + "cl_id=(select cl_id from 材料表 where 显示名='" + cl_name + "'),"
        + "fl_id = (select fl_id from 材料分类表 where 分类编码='" + flname + "'),"
        + "分类名称='" + cl_clflname + "',分类编码='" + flname + "',材料编码='" + flname + "'+' " + cl_clbm + "'+'" + cl_clbh + "', "
        + "材料名称='" + cl_name + "',属性属性值编码='" + sx_codes + "'+'" + cl_number + "',updatetime=(select getdate()) where 分类属性名称='" + cl_flsxmc + "' "
        + "and flsx_id='" + sx_id + "'and flsxz_id='" + cl_ids + "' ";
        if (objConn.ExecuteSQL(sSQL, true))
        {
            Response.Write("<script>window.alert('更改材料成功!请返回！');window.location.href='gysglcl.aspx?ejfl=&gys_id=" + gys_id + "';</" + "script>");
        }
        else
        {
            Response.Write("<script>window.alert('更改材料失败!请返回！');window.location.href='gysglcl.aspx?ejfl=&gys_id=" + gys_id + "';</" + "script>");
        }
    }
</script>