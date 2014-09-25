<!--
        材料收藏页面
        文件名：sccl.ascx
        传入参数：cl_id   材料id
        author:张新颖       
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl3.aspx" charset="utf8"></script>

    <title>收藏材料</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
	
	<script  language="javascript" defer="defer">
        function doload()
        {
            window.close();
            opener.location.href = "cgsgl.aspx";
        }
		<%	if(Request.Cookies["CGS_QQ_ID"]!=null) {%>
				setTimeout("doload()",3000);
		<%} %>
    </script>
</head>

<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
		
			//采购商 
			HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            object cgs_yh_id = Session["CGS_YH_ID"];
			string str_cl = Request["cl_id"];	
            string str_gysid = Request["gys_id"];  //获取页面传过来的供应商id
            string str_sccs = Request["sccs"];     //获取页面传过来的生产厂商
			string cl_id = "";

            //Response.Write(str_sccs);
			
			//供应商 
			HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
			object gys_yh_id = Session["GYS_YH_ID"];
			
			//采购商 登陆
			if ((CGS_QQ_ID == null ) || (cgs_yh_id == null))
			{
                //Response.Write("openid is empty");
            %>
            <span class="dlzi">尊敬的采购商，您好! </span>
            <span class="dlzi">请点击右边按钮登陆！</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //插入按钮的节点id  
                });

            </script>
            <img src="images/wz_03.jpg">
   
           <%
            }
			else   //采购商登录的情况
			{
                DataConn objConn  = new DataConn();
				//采购商收藏材料
				if(CGS_QQ_ID.Value !=null && CGS_QQ_ID.Value != "")
				{
					//Response.Write("QQ_id is " + QQ_id.Value + "<p>");
					string yh_id = "错误";
					string s_count1 = "";
					try
					{
						//查询是否该QQid已经登录过
						string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '" + CGS_QQ_ID.Value + "'";
						s_count1 = objConn.DBLook(str_checkuserexist);

                        if (s_count1 != "")
                        {
                            int count = Convert.ToInt32(s_count1);
                            if (count == 0)  //qq_id不存在，需要增加用户表
                            {
                                string str_insertuser = "INSERT into 用户表 (QQ_id) VALUES ('" + CGS_QQ_ID.Value + "')";
                                objConn.ExecuteSQL(str_insertuser, false);

                                string str_updateyhid = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '" + CGS_QQ_ID.Value + "') where QQ_id = '" + CGS_QQ_ID.Value + "'";
                                objConn.ExecuteSQL(str_updateyhid, true);
                            }

                            //获得yh_id，QQ_id应该为
                            string str_getyhid = "select myId from 用户表 where QQ_id ='" + CGS_QQ_ID.Value + "'";
                            DataTable dt_yh = objConn.GetDataTable(str_getyhid);

                            if (dt_yh != null && dt_yh.Rows.Count > 0)
                            {
                                yh_id = dt_yh.Rows[0]["myID"].ToString();
                            }

                            //先判断“采购商关注供应商表”是否有该记录，如果没有，则插入
                            if (!string.IsNullOrEmpty(str_gysid) && !string.IsNullOrEmpty(str_sccs))
                            {
                                //Response.Write(str_gysid+"  "); Response.Write(str_sccs+"   "); Response.Write(yh_id);
                                string sql_gzcount = "select * from 采购商关注供应商表 where yh_id='" + str_gysid + "' and gys_id='" + str_sccs + "'";
                                int gzcount = objConn.GetRowCount(sql_gzcount);
                                
                                if (gzcount==0)
                                {
                                    string sql_gsgys = "insert into 采购商关注供应商表 (yh_id,gys_id,供应商名称) values (" + yh_id + "," + str_gysid + ",'" + str_sccs + "')";
                                    objConn.ExecuteSQL(sql_gsgys,true);
                                }
                                
                            }


                            //先判断“采购商关注的材料表”是否有该记录，如果没有，则插入
                            if (!string.IsNullOrEmpty(str_cl))
                            {
								string str_clnumber = ""; //材料编号
                                string str_ppid = ""; //品牌id
                                
								if (str_cl.IndexOf('x') > 0) //多个材料
                                {
									Response.Write("多个材料");
                                    string[] str_parames = cl_id.Split('x');//"0801A01|107x0801B03|10" 材料编码|品牌id x 材料编码|品牌id
                                    foreach (string s in str_parames)
                                    {
                                        if (s.IndexOf('|') > 0)
                                        {
                                            string[] str_ps = s.Split('|');	 //["0801A01|107","0801B03|108"] 材料编码|品牌id
                                            for (int i = 0; i < str_ps.Length; i++)
                                            {

                                                if (i % 2 == 0)
                                                {
                                                    str_clnumber = str_ps[i].ToString();//材料编号
                                                }
                                                else
                                                {
                                                    str_ppid = str_ps[i].ToString();//品牌id
                                                }
                                                //先根据材料编号和品牌id，找到对应的材料id
                                                string str_sqlfcl = "select cl_id from 材料表 where pp_id='" + str_ppid + "' and 材料编码='" + str_clnumber + "'";
                                                cl_id = objConn.DBLook(str_sqlfcl);

                                                if (!string.IsNullOrEmpty(cl_id))
                                                {
                                                    string cl_count = "";
                                                    int i_count;
                                                    string str_check = "select count(*) from 采购商关注材料表 where yh_id = '" + yh_id + "' and cl_id ='" + cl_id + "'";
                                                    cl_count = objConn.DBLook(str_check);
                                                    i_count = Convert.ToInt32(cl_count);
                                                    DataTable dt_clname;
                                                    if (i_count != 1)
                                                    {
                                                        string str_sqlclname = "select 显示名称 from  材料表 where cl_id ='" + cl_id + "' and 材料编码='" + str_clnumber + "'";
                                                        dt_clname = objConn.GetDataTable(str_sqlclname);
                                                        string str_clname = "";
                                                        if (dt_clname != null && dt_clname.Rows.Count > 0)
                                                        {
                                                            str_clname = dt_clname.Rows[0]["显示名"].ToString();
                                                        }
                                                        string str_updatecl = "insert into 采购商关注材料表 (yh_id,cl_id,材料名称,材料编码) values ('" + yh_id + "','" + cl_id + "','" + str_clname + "','" + str_clnumber + "')";
                                                        objConn.ExecuteSQL(str_updatecl, true);
                                                    }
                                                }

                                            }
                                        }
                                    }
								}
								else  //单个材料
								{
                                    if (str_cl.IndexOf('|') > 0)
									{
										
										string[] str_ps = str_cl.Split('|');	 //["0801A01|107","0801B03|108"] 材料编码|品牌id
										for (int i = 0; i < str_ps.Length; i++)
										{
											if(i%2==0)
											{
												str_clnumber = str_ps[i].ToString();//材料编号
											}
											else
											{
												str_ppid = str_ps[i].ToString();//品牌id
											}
										}

										//先根据材料编号和品牌id，找到对应的材料id
										string str_sqlfcl = "select cl_id from 材料表 where pp_id='" + str_ppid + "' and 材料编码='" + str_clnumber + "'";
										cl_id = objConn.DBLook(str_sqlfcl);

										if (!string.IsNullOrEmpty(cl_id))
										{
											string cl_count = "";
											int i_count;
                                            string str_check = "select count(*) from 采购商关注的材料表 where yh_id = '" + yh_id + "' and cl_id ='" + cl_id + "'";
											cl_count = objConn.DBLook(str_check);
											i_count = Convert.ToInt32(cl_count);
											DataTable dt_clname;
											if (i_count != 1)
											{
												string str_sqlclname = "select 显示名称 from  材料表 where cl_id ='" + cl_id + "' and 材料编码='" + str_clnumber + "'";
												dt_clname = objConn.GetDataTable(str_sqlclname);
												string str_clname = "";
												if (dt_clname != null && dt_clname.Rows.Count > 0)
												{
													str_clname = dt_clname.Rows[0]["显示名"].ToString();
												}
                                                string str_updatecl = "insert into 采购商关注的材料表 (yh_id,cl_id,材料名称,材料编码) values ('" + yh_id + "','" + cl_id + "','" + str_clname + "','" + str_clnumber + "')";
												objConn.ExecuteSQL(str_updatecl, true);
											}
										}
									}
                                }
                            }
                        }
					}
					catch (Exception ex){
						Response.Write(ex);
					}          

					Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span>");
					Response.Write("<span class='dlzi'>该材料已被收藏成功！</span>");
					Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span>");
					Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span>");
				}
				
			}
		%>
        </div>
    </div>
</body>
</html>
