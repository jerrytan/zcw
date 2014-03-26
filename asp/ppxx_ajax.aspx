<!--
        ppxx.aspx中的下拉框ajax响应页面
        文件名：ppxx_ajax.aspx
        传入参数：
                    ppid 品牌编号
                    type   类型id
                    pid    省id
                    cid    市id
        负责人:任武       
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>
<script runat="server">
        protected DataConn dc_tool = new DataConn();
        protected DataTable dt_province = new DataTable();    //保存省
        protected DataTable dt_city = new DataTable();  //保存市
        protected string str_pid;  //省
        protected string str_ct; //市
        protected string type = ""; //页面处理参数
        protected int ppid;   //品牌编号

        protected void Page_Load(object sender, EventArgs e)
        {
            string str_province = "";//省级响应的结果集
            string str_citys = "";   //市级响应的结果集

            type = Request["type"].ToString();
            ppid = int.Parse(Request["ppid"].ToString());

            //省级联动
            if (type == "1")
            {
                str_pid = Request["pid"];
                if (!string.IsNullOrEmpty(str_pid))
                {
                    /*获取省市信息*/
                    string str_sqlprovince = "select 省市地区编号,省市地区名称 from 地区地域字典 where 所属区域编号="
                        + int.Parse(str_pid) + "and len(省市地区编号)=2";
                    dt_province = dc_tool.GetDataTable(str_sqlprovince);
                    if (dt_province != null && dt_province.Rows.Count > 0)//有数据
                    {
                        for (int i = 0; i < dt_province.Rows.Count; i++)//遍历出所有的数据
                        {
                            str_province += dt_province.Rows[i]["省市地区编号"].ToString() + "_" + dt_province.Rows[i]["省市地区名称"].ToString() + "@";
                        }
                    }
                }
                Response.Write(str_province);
            }
            else
            {
                //市级联动
                string str_cid = Request["cid"];
                if (!string.IsNullOrEmpty(str_cid))//如果不为空
                {
                    //获取省的所有市
                    string str_sqlcity = "select 省市地区编号, 省市地区名称 from 地区地域字典 where  len(省市地区编号)=4 and left(省市地区编号,2)like '" + str_cid + "';";
                    dt_city = dc_tool.GetDataTable(str_sqlcity);
                    if (dt_city != null && dt_city.Rows.Count > 0)//dt_city不为空
                    {
                        for (int i = 0; i < dt_city.Rows.Count; i++)
                        {
                            //拼凑成字符串
                            str_citys += dt_city.Rows[i]["省市地区编号"].ToString() + "_" + dt_city.Rows[i]["省市地区名称"].ToString() + "@";
                        }
                    }
                }
                Response.Write(str_citys);

                /* 根据地区名称，找到对应的分销商信息 */
                
                //1.根据地区编号取得地区名称
                string str_sqldq = "select 省市地区名称 from 地区地域字典 where 省市地区编号 ='" + str_cid + "'";//这里获取的是省和直辖市
                DataTable dt_dq = new DataTable();
                string str_dq = "";
                dt_dq = dc_tool.GetDataTable(str_sqldq);
                if (dt_dq != null && dt_dq.Rows.Count > 0)
                {
                    str_dq = dt_dq.Rows[0]["省市地区名称"].ToString();
                }

                //2.根据品牌id和地区名称，找到对应的分销商信息
                string str_sqlfxs = "select 供应商,联系人,联系人手机,联系地址,gys_id from 材料供应商信息表 where gys_id in ( select fxs_id from 分销商和品牌对应关系表 where pp_id='" + ppid + "') and 联系地址 like '" + str_dq + "'";
                DataTable dt_fxs = new DataTable();
                string str_result = "";
                dt_fxs = dc_tool.GetDataTable(str_sqlfxs);
                if (dt_fxs != null && dt_fxs.Rows.Count > 0)
                {
                    for (int i = 0; i < dt_fxs.Rows.Count; i++)
                    {
                        str_result += dt_fxs.Rows[i]["供应商"].ToString() + "|" + dt_fxs.Rows[i]["联系人"].ToString() + "|"
                                       + dt_fxs.Rows[i]["联系人手机"].ToString() + "|" + dt_fxs.Rows[i]["联系地址"].ToString() 
                                       + dt_fxs.Rows[i].ToString() + "$";
                    }
                }
                Response.Write("#"); //分割符号
                Response.Write(str_result);
                Response.End();
            }
        }
</script>