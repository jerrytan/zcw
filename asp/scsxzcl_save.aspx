<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Page Language="C#" EnableViewStateMac="false" %>

<script runat="server">
    public DataConn Conn = new DataConn();
    public string temp;
    protected void Page_Load(object sender, EventArgs e)
    {
        string value = "";
        string lx = Request["lx"];
        string flbm = Request["flbm"];//分类编码
        string clbm = Request["clbm"];//产品编号
        string clmc = Request["clmc"];
        string ggxh = Request["gg_xh"];
        string jldw = Request["jldw"];
        string dwzl = Request["dwzl"];
        string dwtj = Request["dwtj"];
        string yyfw = Request["yyfw"];
        string ppid = Request["ppid"];
        string cpjg = Request["cpjg"];  //产品价格
        string SQL = Request["SQL"];   //SQL语句
        string scsid = Request["scsid"];   //SQL语句
        string dmt = Request["dmt"];
        string clid = Request["clid"];  //编辑使用
        string cpmc = Request["mcgz"];  //产品名称clmcjgg
        string sSQL = "";
        string gysid = string.Empty;
        try
        {
            if (Session["dwid"] != null)
            {

                if (cpmc != "")
                {
                    if (lx == "bj")
                    {
                        string datetime = "";
                        datetime = DateTime.Now.ToString();
                        sSQL = "update  材料表 set 显示名='" + cpmc + "',规格型号='" + ggxh + "',计量单位='" + jldw + "',单位重量='" + dwzl + "',单位体积='" + dwtj +
                            "',说明='" + yyfw + "',是否启用='1',pp_id='" + ppid + "',price='" + cpjg + "',gys_id='" + scsid + "',分类编码='" + flbm +
                            "',材料编码='" + clbm + "',updatetime='" + datetime + "',fl_id=(select fl_id from 材料分类表 where 分类编码='" + flbm +
                            "'),生产厂商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + scsid + "'), 分类名称=(select 显示名字 from 材料分类表 where 分类编码='" + flbm +
                            "'),品牌名称=(select 品牌名称 from 品牌字典 where pp_id='" + ppid + "' ),一级分类名称=( select 显示名字 from 材料分类表 where len(分类编码)=2 and 分类编码=SUBSTRING('" + flbm + "',1,2) ) where cl_id='" + clid + "'";

                        //更新材料表
                        bool bcl = Conn.ExecuteSQL(sSQL, false);
                        if (bcl)
                        {
                            //添加属性信息
                            while (SQL.EndsWith("◣"))
                            {
                                SQL = SQL.Substring(0, SQL.Length - 1);
                            }
                            bool b = false;
                            if (SQL == "1")
                            {
                                b = true;
                            }
                            else
                            {
                                sSQL = "";
                                SQL = SQL.Replace("clmc", cpmc);
                                SQL = SQL.Replace("clbm", clbm);
                                string[] arrSql = SQL.Split('◣');
                                for (int i = 0; i < arrSql.Length; i++)
                                {
                                    int begin = arrSql[i].IndexOf(",");
                                    string flsxmc = arrSql[i].Substring(0, begin);

                                    string sqlresult = "";
                                    sqlresult = "'" + arrSql[i].Replace(",", "','") + "'";
                                    if (sqlresult != "")
                                    {
                                        SQL += "delete 材料属性表 where fl_id=(select fl_id from 材料表 where cl_id='" + clid +
                                          "') and cl_id='" + clid + "' and   分类属性名称='" + flsxmc + "' ";
                                        sSQL += "insert into 材料属性表 (分类属性名称,分类属性编码,flsx_id,分类属性值,分类属性值编号,flsxz_id,属性属性值编码,fl_id,分类名称,cl_id,材料名称,材料编码,updatetime)values("
                                        + sqlresult + ",(select getdate()))    ";
                                    }

                                }
                                b = Conn.RunSqlTransaction(sSQL);
                            }

                            if (b)
                            {
                                if (dmt.Trim() != "")
                                {
                                    sSQL = "";
                                    //添加多媒体信息
                                    while (dmt.EndsWith("◥"))
                                    {
                                        dmt = dmt.Substring(0, dmt.Length - 1);
                                    }
                                    string[] arrPath = dmt.Split('◥');
                                    try
                                    {
                                        for (int i = 0; i < arrPath.Length; i++)
                                        {
                                            string[] arrTotal = new string[3];
                                            arrTotal = arrPath[i].Split(',');

                                            sSQL += "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,分类,存放地址,updatetime) values(" +
                                             clid + " ,'" + clbm + "','" + cpmc + "','是','" + arrTotal[0] + "','" + arrTotal[1] + "','" + arrTotal[2] + "',(select getdate()))  ";
                                        }
                                    }
                                    catch (Exception eee)
                                    {
                                        value = "";
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
                            value = "添加材料失败！错误信息：";
                        }
                    }
                    else
                    {
                        string countSQL = "select count(*) from 材料表 where 材料编码='" + clbm + "' and pp_id='" + ppid + "' and gys_id='" + scsid + "' and 显示名='" + cpmc + "'";
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
                               + "values('" + cpmc + "','" + ggxh + "','" + jldw + "','" + dwzl + "','" + dwtj + "','" + yyfw + "','1','" + ppid + "','" + cpjg + "','" + scsid + "','" + flbm + "','" + clbm + "','" + datetime + "') ";
                            //更新材料表
                            bool bcl = Conn.ExecuteSQL(sSQL, false);
                            if (bcl)
                            {
                                //=====================添加price=====================================
                                string priceSql = " insert into PriceScs(ScsPriceClid, ScsId, ScsPrice) values((select myID from 材料表 where 显示名='"+cpmc+"' and 材料编码='"+clbm+"' and gys_id='"+scsid+"' and pp_id='"+ppid+"'),'"+scsid+"','"+cpjg+"' )";
                                MySqlHelper.ExecuteNonQuery(priceSql);
                                //=================================================================
                                string sqlclid = "(select myID from 材料表 where 显示名='" + cpmc + "' and 材料编码='" + clbm + "' and gys_id='" + scsid + "' and pp_id='" + ppid + "')";
                                sSQL = "update 材料表 set cl_id= " + sqlclid + ","
                                      + "fl_id = (select fl_id from 材料分类表 where 分类编码='" + flbm + "'),"
                                      + "生产厂商 = (select 供应商 from 材料供应商信息表 where gys_id = '" + scsid + "'),"
                                      + "分类名称=(select 显示名字 from 材料分类表 where 分类编码='" + flbm + "'), "
                                      + "品牌名称=(select 品牌名称 from 品牌字典 where pp_id='" + ppid + "' ),updatetime=(select getdate()),"
                                      + "一级分类名称=( select 显示名字 from 材料分类表 where len(分类编码)=2 and 分类编码=SUBSTRING('" + flbm + "',1,2) )"
                                      + " where myID=" + sqlclid + " and updatetime='" + datetime + "'";
                                Conn.ExecuteSQL(sSQL, false);
                                //添加属性信息
                                while (SQL.EndsWith("◣"))
                                {
                                    SQL = SQL.Substring(0, SQL.Length - 1);
                                }
                                sSQL = "";
                                SQL = SQL.Replace("clmc", cpmc);
                                SQL = SQL.Replace("clbm", clbm);
                                string[] arrSql = SQL.Split('◣');
                                for (int i = 0; i < arrSql.Length; i++)
                                {
                                    string sqlresult = "";
                                    if (arrSql[i] != "")
                                    {
                                        sqlresult = "'" + arrSql[i].Replace(",", "','") + "'";
                                        sqlresult = sqlresult.Replace("'clid'", sqlclid);
                                        sSQL += "insert into 材料属性表 (分类属性名称,分类属性编码,flsx_id,分类属性值,分类属性值编号,flsxz_id,属性属性值编码,fl_id,分类名称,cl_id,材料名称,材料编码,updatetime)values("
                                        + sqlresult + ",(select getdate()))    ";
                                    }
                                }
                                bool b = Conn.RunSqlTransaction(sSQL);
                                if (b)
                                {
                                    value = "1," + MySqlHelper.ExecuteScalar(sqlclid).ToString();
                                }
                                //如果材料添加成功把多媒体信息添加到数据库
                                #region 添加多媒体信息
                                //if (b)
                                //{
                                //    if (dmt != "")
                                //    {
                                //        sSQL = "";
                                //        //添加多媒体信息
                                //        while (dmt.EndsWith("◥"))
                                //        {
                                //            dmt = dmt.Substring(0, dmt.Length - 1);
                                //        }
                                //        string[] arrPath = dmt.Split('◥');
                                //        for (int i = 0; i < arrPath.Length; i++)
                                //        {
                                //            string[] arrTotal = new string[3];
                                //            arrTotal = arrPath[i].Split(',');
                                //            sSQL += "insert into 材料多媒体信息表(cl_id,材料编码,材料名称,是否启用,媒体类型,分类,存放地址,updatetime) values(" +
                                //             sqlclid + " ,'" + clbm + "','" + cpmc + "','是','" + arrTotal[0] + "','" + arrTotal[1] + "','" + arrTotal[2] + "',(select getdate()))  ";
                                //        }
                                //        bool bdmt = Conn.RunSqlTransaction(sSQL);
                                //        if (bdmt)
                                //        {
                                //            value = "1";
                                //        }
                                //        else
                                //        {
                                //            value = "添加多媒体信息失败 添加语句：" + sSQL;
                                //        }
                                //    }
                                //    else
                                //    {
                                //        value = "1";
                                //    }
                                //}
                                //else
                                //{
                                //    value = "添加属性信息失败！";

                                //} 
                                #endregion
                            }
                            else
                            {
                                value = "添加材料失败！错误信息：";
                            }
                        }
                    }
                }
                else
                {
                    value = "添加失败，产品名称不能为空！";
                }
            }
            else
            {
                value = "您的登陆状态已丢失，请重新登陆！";
            }

        }
        catch (Exception ee)
        {
            value = "添加材料失败！错误信息：" + ee.ToString();
        }
        if (value.Split(',')[0] == "1")
        {
            if (!AddFLSXZ(gysid, flbm, clbm))
            {
                //删除已经添加的材料
                string delmyid = "delete from 材料表 where 显示名='" + cpmc + "' and 材料编码='" + clbm + "' and gys_id='" + scsid + "' and pp_id='" + ppid + "'";
                MySqlHelper.ExecuteNonQuery(delmyid);
                value = "您选的属性值已被删除，请刷新页面重新添加！";
            }
        }
        Response.Write(value);
    }
    public bool AddFLSXZ(string gysid, string flbm, string clbm)
    {
        //===============李宗鹏添加材料属性值number开始=============================================
        gysid = Session["dwid"].ToString();
        List<string> list = new List<string>();
        //找出材料所用到的编码
        int flbmLength = flbm.Length;
        int start = flbmLength;
        for (int i = 0; i < (clbm.Length - flbmLength) / 3; i++)
        {
            list.Add(clbm.Substring(start, 3));
            start += 3;
        }
        //把表缓存开始
        DataTable tempCache = (DataTable)Cache["dtbm"];
        try
        {
            if (tempCache == null)
            {
                DataTable dt = MySqlHelper.GetTable("select * from 材料分类属性值表");
                Cache["dtbm"] = dt;
            }
        }
        catch (Exception)
        {
           // throw;
        }
        try
        {
            if (tempCache.Rows.Count == 0)
            {
                DataTable dt = MySqlHelper.GetTable("select * from 材料分类属性值表");
                Cache["dtbm"] = dt;
            }
        }
        catch (Exception)
        {
            
            //throw;
        }
        DataTable dtcache = (DataTable)(Cache["dtbm"]);
        //缓存结束
        bool succ = true;
        for (int i = 0; i < list.Count; i++)
        {
            //查询bm
            var query = dtcache.AsEnumerable().Where(bmTable => bmTable.Field<string>("分类编码") == flbm && bmTable.Field<string>("编号") == list[i]);
            try
            {
                DataTable dtCache = query.CopyToDataTable<DataRow>();
                if (dtCache.Rows.Count > 0)
                {
                    int number = Convert.ToInt32(dtCache.Rows[0]["number"]);
                    if (number != -1)
                    {
                        //编号加1
                        string updateNum = "update 材料分类属性值表 set number=" + (number + 1) + " where 分类编码='" + flbm + "' and 编号='" + list[i] + "'";
                        if (MySqlHelper.ExecuteNonQuery(updateNum) > 0)
                        {
                            ///清空缓存
                            DataTable dttemp = new DataTable();
                            Cache["dtbm"] = dttemp;
                        }
                    }
                }
                //else
                //{
                //    succ = false;
                //    break;
                //}
            }
            catch (Exception)
            {
                succ = false;
                break;
            }
        }
        return succ;
        //===============李宗鹏添加材料属性值number结束=============================================
        
    }
</script>
