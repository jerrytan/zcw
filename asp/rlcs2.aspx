<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
    public string s_yh_id = "";
    public string s_gys_id = "";
    public string sSQL = "";
    public DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
        {
            s_yh_id = Session["GYS_YH_ID"].ToString();
        }
        if (Request["gys_id"] != null && Request["gys_id"].ToString() != "")
        {
            s_gys_id = Request["gys_id"].ToString();
        }
        string gys_type="";
        if (Request["gys_type"] != null && Request["gys_type"].ToString() != "")
        {
            gys_type = Request["gys_type"].ToString();
        }
        if (s_yh_id != "")
        {
            sSQL = "select count(*) from 供应商认领申请表 where yh_id = '" + s_yh_id + "'";
            Object obj_checkexist_gysid = objConn.DBLook(sSQL);
               if(gys_type=="生产商")
                {
                    if (obj_checkexist_gysid != null)
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
             
                            if (count == 0)  //认领的供应商不存在
                            {

                                //用户验证通过,可以将yh_id插入供应商申请		             

                                sSQL = "insert into 供应商认领申请表(yh_id) values('" + s_yh_id + "')";
                                objConn.ExecuteSQL(sSQL, false);

                                //根据认领的供应商id 查询供应商信息 更新到供应商申请表中
                                if (s_gys_id != "")
                                {
                                    sSQL = "select 供应商,主页,地址,电话,传真,dq_id,联系人,联系人手机,联系人QQ,单位类型,组织机构编号,单位简称, "
                                    + "地区名称,法定代表人,注册资金,联系地址,邮编,电子邮箱,经营范围,省市地区编号,企业类别 from 材料供应商信息表 where "
                                    + "gys_id='" + s_gys_id + "' ";
                                    DataTable dt_gysxx = objConn.GetDataTable(sSQL);
                                    string gys_name = Convert.ToString(dt_gysxx.Rows[0]["供应商"]);
                                    string homepage = Convert.ToString(dt_gysxx.Rows[0]["主页"]);
                                    string tel = Convert.ToString(dt_gysxx.Rows[0]["电话"]);
                                    string fax = Convert.ToString(dt_gysxx.Rows[0]["传真"]);
                                    string user_name = Convert.ToString(dt_gysxx.Rows[0]["联系人"]);
                                    string user_phone = Convert.ToString(dt_gysxx.Rows[0]["联系人手机"]);
                                    string gys_type = Convert.ToString(dt_gysxx.Rows[0]["单位类型"]);
                                    string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["组织机构编号"]);
                                    string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["联系地址"]);
                                    string scope = Convert.ToString(dt_gysxx.Rows[0]["经营范围"]);
                                    string area = Convert.ToString(dt_gysxx.Rows[0]["地区名称"]);


                                    //更新供应商申请表
                                    sSQL = "update  供应商认领申请表 set updatetime=(select getdate()),gys_id = '" + s_gys_id + "', "
                                    + "供应商='" + gys_name + "',主页='" + homepage + "',电话='" + tel + "',传真='" + fax + "',联系人='" + user_name + "', "
                                    + "联系人手机='" + user_phone + "',单位类型='" + gys_type + "',组织机构编号='" + zzjg_number + "',联系地址='" + lx_addrass + "',"
                                    + "经营范围='" + scope + "',地区名称='" + area + "',审批结果='待审核' where yh_id='" + s_yh_id + "' ";
                                    int ret = objConn.ExecuteSQLForCount(sSQL, true);
                                    Response.Write("该供应商已经成功被您认领,我方工作人员核实相关信息后,在三个工作日内给您答复,请耐心等候!");
                                }
                                else
                                {
                                    objConn.MsgBox(this.Page, "供应商id不存在，请重新认领！");
                                }
                             }  
                        }
                        if (count != 0)
                        {
                            Response.Write("您已认领了一家生产厂商,不能再继续认领!");
                            return;
                        }
                else
                {
                    //根据认领的供应商id 查询供应商信息 更新到供应商申请表中
                    if (s_gys_id != "")
                    {
                        sSQL = "select 供应商,主页,地址,电话,传真,dq_id,联系人,联系人手机,联系人QQ,单位类型,组织机构编号,单位简称, "
                        + "地区名称,法定代表人,注册资金,联系地址,邮编,电子邮箱,经营范围,省市地区编号,企业类别 from 材料供应商信息表 where "
                        + "gys_id='" + s_gys_id + "' ";
                        DataTable dt_gysxx = objConn.GetDataTable(sSQL);
                        string gys_name = Convert.ToString(dt_gysxx.Rows[0]["供应商"]);
                        string homepage = Convert.ToString(dt_gysxx.Rows[0]["主页"]);
                        string tel = Convert.ToString(dt_gysxx.Rows[0]["电话"]);
                        string fax = Convert.ToString(dt_gysxx.Rows[0]["传真"]);
                        string user_name = Convert.ToString(dt_gysxx.Rows[0]["联系人"]);
                        string user_phone = Convert.ToString(dt_gysxx.Rows[0]["联系人手机"]);
                        string gys_type = Convert.ToString(dt_gysxx.Rows[0]["单位类型"]);
                        string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["组织机构编号"]);
                        string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["联系地址"]);
                        string scope = Convert.ToString(dt_gysxx.Rows[0]["经营范围"]);
                        string area = Convert.ToString(dt_gysxx.Rows[0]["地区名称"]);

                        sSQL = "insert into 供应商认领申请表(yh_id,updatetime,gys_id,供应商,主页,电话,传真,联系人,联系人手机,单位类型,组织机构编号,联系地址,经营范围,地区名称,审批结果)"+
                        " values('" + s_yh_id + "',select getdate(), '" + s_gys_id + "','" + gys_name + "','" + homepage +
                         "','" + tel + "','" + fax + "','" + user_name + "','" + user_phone + "','" + gys_type + "','" + zzjg_number +
                          "','" + lx_addrass + "','" + scope + "','" + area + "','待审核')";
                        int ret = objConn.ExecuteSQLForCount(sSQL, true);
                        Response.Write("该供应商已经成功被您认领,我方工作人员核实相关信息后,在三个工作日内给您答复,请耐心等候!");
  
              
            }
        }
        else
        {
            Response.Write("当前用户id不存在,请重新登陆！");
        }

    }
    </script>

