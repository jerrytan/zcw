<%@ Page Language="C#" EnableViewStateMac="false" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    DataConn Conn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string cl_id = "";
        if (Request["cl_id"] != null && Request["cl_id"].ToString() != "")
        {
            cl_id = Request["cl_id"];
        }
        while (cl_id.EndsWith(","))
        {
            cl_id = cl_id.Substring(0, cl_id.Length - 1);
        }

        //==============李宗鹏-删除材料分类属性值begin
        Dictionary<string, string> dc = DeleteSXZ(cl_id);//删除成功的话，查看属性值是否引用过
        string[] clids = cl_id.Split(',');
        int seState = 0;
        for (int i = 0; i < clids.Length; i++)
        {
            string delClid = "delete 材料表 where cl_id='" + clids[i] + "'";
            if (MySqlHelper.ExecuteNonQuery(delClid) > 0)
            {
                seState++;
            }
            else
            {
                //材料删除失败的话不用删除材料分类属性值
                for (int j = 0; j < dc.Count; j++)
                {
                    if (dc.Keys.ElementAt(j) == clids[j])
                    {
                        dc.Remove(clids[j]);
                    }
                }
            }
        }
        //开始删除
        if (dc.Count > 0)
        {
            //遍历每个材料id
            for (int i = 0; i < dc.Count; i++)
            {
                //找出材料所引用到的属性值
                string d_flbm = dc.Keys.ElementAt(i).Split('*')[1];
                string d_clbm = dc.Values.ElementAt(i);
                string[] clbms = d_clbm.Split(',');//找出材料所用到的编码
                var gysid = Session["dwid"];
                //遍历属性值,判断是否引用
                for (int j = 0; j < clbms.Length; j++)
                {
                    string clbm = clbms[j];
                    string selNumber = "select number,gysid from 材料分类属性值表 where 分类编码='" + d_flbm + "' and 编号='"+clbm+"'";
                    DataTable dtnum=MySqlHelper.GetTable(selNumber);
                    int number = Convert.ToInt32(dtnum.Rows[0]["number"]);
                    string gysidData=dtnum.Rows[0]["gysid"].ToString();

                    //值引用过一次，直接删除
                    if (number==1&&gysid.ToString()==gysidData)
                    {
                        string delFLSXZ = "delete from  材料分类属性值表 where 分类编码='" + d_flbm + "' and 编号='" + clbm + "'";
                        int delState = MySqlHelper.ExecuteNonQuery(delFLSXZ);
                        if (delState<=0)
                        {
                            //删除失败写入日志
                            String xx = DateTime.Now.ToString() + ": 材料属性值删除失败！（分类编码："+d_flbm+"；属性值编号："+clbm+"；）";
                            String filePath = Server.MapPath("../App_Code/DeleteSXZError.log");
                            if (System.IO.File.Exists(filePath))
                            {
                                System.IO.File.WriteAllText(filePath, xx + Environment.NewLine + System.IO.File.ReadAllText(filePath, Encoding.GetEncoding("GB2312")), Encoding.GetEncoding("GB2312"));
                            }
                            else
                            {
                                System.IO.File.WriteAllText(filePath, xx, Encoding.GetEncoding("GB2312"));
                            }
                        }
                        else
                        {
                            ////清空缓存
                            DataTable dttemp = new DataTable();
                            Cache["dtbm"] = dttemp;
                        }
                    }
                        //不知一材料引用过该分类属性值，那么number减1
                    else if (number > 1 || number == 1 && gysid.ToString() != gysidData)
                    {
                        string jianFLSXZ = "update 材料分类属性值表 set number=CONVERT(int,(select number from 材料分类属性值表 where 分类编码='"+d_flbm+"' and 编号='"+clbm+"')-1) where 分类编码='"+d_flbm+"' and 编号='"+clbm+"'";
                        int delState = MySqlHelper.ExecuteNonQuery(jianFLSXZ);
                        //材料分类属性值减1失败的话，写入日志
                        if (delState<=0)
                        {
                            //删除失败写入日志
                            String xx = DateTime.Now.ToString() + ": 材料属性值的number减1失败！（分类编码："+d_flbm+"；属性值编号："+clbm+"；）";
                            String filePath = Server.MapPath("../App_Code/DeleteSXZError.log");
                            if (System.IO.File.Exists(filePath))
                            {
                                System.IO.File.WriteAllText(filePath, xx + Environment.NewLine + System.IO.File.ReadAllText(filePath, Encoding.GetEncoding("GB2312")), Encoding.GetEncoding("GB2312"));
                            }
                            else
                            {
                                System.IO.File.WriteAllText(filePath, xx, Encoding.GetEncoding("GB2312"));
                            }
                        }
                    }
                    
                }
            }
        }
        //==============李宗鹏-删除材料分类属性值end
        if (seState == clids.Length)
        {
            Response.Write("1");
        }
        else
        {
            Response.Write("0");
        }

        //string sSQL = "delete 材料表 where cl_id in (" + cl_id + ") ";
        //if (Conn.ExecuteSQL(sSQL, true))
        //{
        //    Response.Write("1");
        //}
        //else
        //{
        //    Response.Write("0");
        //}
    }
    /// <summary>
    /// 删除只引用过一次的材料分类属性值
    /// </summary>
    /// <param name="str">cl_id</param>
    /// <returns></returns>
    public Dictionary<string, string> DeleteSXZ(string str)
    {
        string[] clids = str.Split(',');
        Dictionary<string, string> dc = new Dictionary<string, string>();
        for (int i = 0; i < clids.Length; i++)
        {
            string clid = clids[i];
            string clSql = "select 材料编码,分类编码 from 材料表 where cl_id='" + clid + "'";
            DataTable dt = MySqlHelper.GetTable(clSql);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                string clbm = dt.Rows[0]["材料编码"].ToString();
                string flbm = dt.Rows[0]["分类编码"].ToString();
                int flbmLength = flbm.Length;
                int start = flbmLength;
                for (int j = 0; j < (clbm.Length - flbmLength) / 3; j++)
                {
                    sb.Append(clbm.Substring(start, 3) + ",");
                    start += 3;
                }
                dc.Add(i+"*"+flbm, sb.ToString().Substring(0, (sb.ToString().Length - 1)));
            }
        }

        return dc;
    }
</script>
