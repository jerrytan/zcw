<!--
        �����ղ�ҳ��
        �ļ�����sccl.ascx
        ���������cl_id   ����id
        author:����ӱ       
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
   <meta content="IE=10.000" http-equiv="X-UA-Compatible"/>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl3.aspx" charset="utf8"></script>

    <title>�ղز���</title>
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
		
			//�ɹ��� 
			HttpCookie CGS_QQ_ID = Request.Cookies["CGS_QQ_ID"];
            object cgs_yh_id = Session["CGS_YH_ID"];
            string str_cl = Request["cl_id"];	   
            string str_gysid = Request["gys_id"];  //��ȡҳ�洫�����Ĺ�Ӧ��id
            string str_sccs = Request["sccs"];     //��ȡҳ�洫��������������
            string str_clid = Request["clid"];     //��ȡҳ�洫�����Ĳ���id
            string str_clmc = Request["clmc"];     //��ȡҳ�洫�����Ĳ�������  
            string str_clbm = Request["clbm"];     //��ȡҳ�洫�����Ĳ��ϱ��� 
			string cl_id = "";



            //Response.Write(str_gysid);
            //Response.Write(str_sccs);
            //Response.Write(str_clbm);
			
			//��Ӧ�� 
			HttpCookie GYS_QQ_ID = Request.Cookies["GYS_QQ_ID"];
			object gys_yh_id = Session["GYS_YH_ID"];
			
			//�ɹ��� ��½
			if ((CGS_QQ_ID == null ) || (cgs_yh_id == null))
			{
                //Response.Write("openid is empty");
            %>
            <span class="dlzi">�𾴵Ĳɹ��̣�����! </span>
            <span class="dlzi">�����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  
                });

            </script>
            <img src="images/wz_03.jpg">
   
           <%
            }
			else   //�ɹ��̵�¼�����
			{
                DataConn objConn  = new DataConn();
				//�ɹ����ղز���
				if(CGS_QQ_ID.Value !=null && CGS_QQ_ID.Value != "")
				{                 
					//Response.Write("QQ_id is " + QQ_id.Value + "<p>");
                    //string yh_id = "����";
                    //string s_count1 = "";
					try
					{

                        DataTable dt_scrxx = new DataTable();
                        string qqid = CGS_QQ_ID.Value.ToString();
                        string sql_scrxx = "select yh_id,����,QQ����,dw_id from  �û��� where QQ_id='" + qqid + "'";
                        dt_scrxx = objConn.GetDataTable(sql_scrxx);
                        string scryhid = dt_scrxx.Rows[0]["yh_id"].ToString();
                        string scrxm = dt_scrxx.Rows[0]["����"].ToString();
                        string scrqq = dt_scrxx.Rows[0]["QQ����"].ToString();
                        string scrdwid = dt_scrxx.Rows[0]["dw_id"].ToString();

                        //Response.Write(scryhid);
                        //Response.Write(str_clid);
                        //Response.Write(str_clmc);
                        //Response.Write(str_clbm);
                        //Response.Write(scrqq);




                        //Response.Write(scrdwid);
                        //Response.Write(str_clid);
                        string sql_clcount = "select * from �ɹ��̹�ע�Ĳ��ϱ� where cl_id ='" + str_clid + "' and dw_id = '" + scrdwid + "'";
                        //Response.Write(objConn.GetRowCount(sql_clcount));
                        if (objConn.GetRowCount(sql_clcount) == 0)
                        {
                            string sql_scxx = @"insert into �ɹ��̹�ע�Ĳ��ϱ� (yh_id,cl_id,��������,���ϱ���,�ղ�ʱ��,�ղ���QQ,�Ƿ�����,dw_id,�ղ���) 
                            values ('" + scryhid + "','" + str_clid + "','" + str_clmc + "','" + str_clbm + "',GETDATE(),'" + scrqq + "','1','" + scrdwid + "','" + scrxm + "')";
                            objConn.ExecuteSQL(sql_scxx, true);
                        }
                        else
                        {
                            //Response.Write("<script>alert('�ò������ղ�');</script>");
                        }




                        string sql_gyscount = "select * from �ɹ��̹�ע��Ӧ�̱� where gys_id='" + str_gysid + "' and dw_id='" + scrdwid + "'";
                        if (objConn.GetRowCount(sql_gyscount)==0)
                        {
                            string sql_scgys = @"insert into �ɹ��̹�ע��Ӧ�̱� (yh_id,gys_id,��Ӧ������,�ղ�ʱ��,�ղ���QQ,�Ƿ�����,dw_id,�ղ���)  
                            values ('" + scryhid + "','" + str_gysid + "','" + str_sccs + "',GETDATE(),'" + scrqq + "',1,'" + scrdwid + "','" + scrxm + "')";
                            objConn.ExecuteSQL(sql_scgys,true);
                        }
                        else
                        {
                            //Response.Write("<script>alert('�ù�Ӧ�����ղ�');</script>");
                        }
                        
						//��ѯ���ݿ����Ƿ���ڴ��û�
                        //string str_checkuserexist = "select count(*) from �û��� where QQ_id = '" + CGS_QQ_ID.Value + "'";
                        //s_count1 = objConn.DBLook(str_checkuserexist);

                        //if (s_count1 != "")
                        //{
                            //int count = Convert.ToInt32(s_count1);
                            //if (count == 0)  //qq_id�����ڣ���Ҫ�����û���
                            //{
                            //    string str_insertuser = "INSERT into �û��� (QQ_id) VALUES ('" + CGS_QQ_ID.Value + "')";
                            //    objConn.ExecuteSQL(str_insertuser, false);

                            //    string str_updateyhid = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '" + CGS_QQ_ID.Value + "') where QQ_id = '" + CGS_QQ_ID.Value + "'";
                            //    objConn.ExecuteSQL(str_updateyhid, true);
                            //}

                            ////���yh_id��QQ_idӦ��Ϊ
                            //string str_getyhid = "select myId from �û��� where QQ_id ='" + CGS_QQ_ID.Value + "'";
                            //DataTable dt_yh = objConn.GetDataTable(str_getyhid);

                            //if (dt_yh != null && dt_yh.Rows.Count > 0)
                            //{
                            //    yh_id = dt_yh.Rows[0]["myID"].ToString();
                            //}

                            //���жϡ��ɹ��̹�ע��Ӧ�̱��Ƿ��иü�¼�����û�У������
                            //if (!string.IsNullOrEmpty(str_gysid) && !string.IsNullOrEmpty(str_sccs))
                            //{
                            //    //Response.Write(str_gysid+"  "); Response.Write(str_sccs+"   "); Response.Write(yh_id);
                            //    string sql_gzcount = "select * from �ɹ��̹�ע��Ӧ�̱� where yh_id='" + str_gysid + "' and gys_id='" + str_sccs + "'";
                            //    int gzcount = objConn.GetRowCount(sql_gzcount);
                                
                            //    if (gzcount==0)
                            //    {
                            //        string sql_gsgys = "insert into �ɹ��̹�ע��Ӧ�̱� (yh_id,gys_id,��Ӧ������) values (" + yh_id + "," + str_gysid + ",'" + str_sccs + "')";
                            //        objConn.ExecuteSQL(sql_gsgys,true);
                            //    }
                                
                            //}


                            ////���жϡ��ɹ��̹�ע�Ĳ��ϱ��Ƿ��иü�¼�����û�У������
                            //if (!string.IsNullOrEmpty(str_cl))
                            //{
                            //    string str_clnumber = ""; //���ϱ��
                            //    string str_ppid = ""; //Ʒ��id
                                
                            //    if (str_cl.IndexOf('x') > 0) //�������
                            //    {
                            //        Response.Write("�������");
                            //        string[] str_parames = cl_id.Split('x');//"0801A01|107x0801B03|10" ���ϱ���|Ʒ��id x ���ϱ���|Ʒ��id
                            //        foreach (string s in str_parames)
                            //        {
                            //            if (s.IndexOf('|') > 0)
                            //            {
                            //                string[] str_ps = s.Split('|');	 //["0801A01|107","0801B03|108"] ���ϱ���|Ʒ��id
                            //                for (int i = 0; i < str_ps.Length; i++)
                            //                {

                            //                    if (i % 2 == 0)
                            //                    {
                            //                        str_clnumber = str_ps[i].ToString();//���ϱ��
                            //                    }
                            //                    else
                            //                    {
                            //                        str_ppid = str_ps[i].ToString();//Ʒ��id
                            //                    }
                            //                    //�ȸ��ݲ��ϱ�ź�Ʒ��id���ҵ���Ӧ�Ĳ���id
                            //                    string str_sqlfcl = "select cl_id from ���ϱ� where pp_id='" + str_ppid + "' and ���ϱ���='" + str_clnumber + "'";
                            //                    cl_id = objConn.DBLook(str_sqlfcl);

                            //                    if (!string.IsNullOrEmpty(cl_id))
                            //                    {
                            //                        string cl_count = "";
                            //                        int i_count;
                            //                        string str_check = "select count(*) from �ɹ��̹�ע���ϱ� where yh_id = '" + yh_id + "' and cl_id ='" + cl_id + "'";
                            //                        cl_count = objConn.DBLook(str_check);
                            //                        i_count = Convert.ToInt32(cl_count);
                            //                        DataTable dt_clname;
                            //                        if (i_count != 1)
                            //                        {
                            //                            string str_sqlclname = "select ��ʾ���� from  ���ϱ� where cl_id ='" + cl_id + "' and ���ϱ���='" + str_clnumber + "'";
                            //                            dt_clname = objConn.GetDataTable(str_sqlclname);
                            //                            string str_clname = "";
                            //                            if (dt_clname != null && dt_clname.Rows.Count > 0)
                            //                            {
                            //                                str_clname = dt_clname.Rows[0]["��ʾ��"].ToString();
                            //                            }
                            //                            string str_updatecl = "insert into �ɹ��̹�ע���ϱ� (yh_id,cl_id,��������,���ϱ���) values ('" + yh_id + "','" + cl_id + "','" + str_clname + "','" + str_clnumber + "')";
                            //                            objConn.ExecuteSQL(str_updatecl, true);
                            //                        }
                            //                    }

                            //                }
                            //            }
                            //        }
                            //    }
                            //    else  //��������
                            //    {
                            //        if (str_cl.IndexOf('|') > 0)
                            //        {
										
                            //            string[] str_ps = str_cl.Split('|');	 //["0801A01|107","0801B03|108"] ���ϱ���|Ʒ��id
                            //            for (int i = 0; i < str_ps.Length; i++)
                            //            {
                            //                if(i%2==0)
                            //                {
                            //                    str_clnumber = str_ps[i].ToString();//���ϱ��
                            //                }
                            //                else
                            //                {
                            //                    str_ppid = str_ps[i].ToString();//Ʒ��id
                            //                }
                            //            }

                            //            //�ȸ��ݲ��ϱ�ź�Ʒ��id���ҵ���Ӧ�Ĳ���id
                            //            string str_sqlfcl = "select cl_id from ���ϱ� where pp_id='" + str_ppid + "' and ���ϱ���='" + str_clnumber + "'";
                            //            cl_id = objConn.DBLook(str_sqlfcl);

                            //            if (!string.IsNullOrEmpty(cl_id))
                            //            {
                            //                string cl_count = "";
                            //                int i_count;
                            //                string str_check = "select count(*) from �ɹ��̹�ע�Ĳ��ϱ� where yh_id = '" + yh_id + "' and cl_id ='" + cl_id + "'";
                            //                cl_count = objConn.DBLook(str_check);
                            //                i_count = Convert.ToInt32(cl_count);
                            //                DataTable dt_clname;
                            //                if (i_count != 1)
                            //                {
                            //                    string str_sqlclname = "select ��ʾ���� from  ���ϱ� where cl_id ='" + cl_id + "' and ���ϱ���='" + str_clnumber + "'";
                            //                    dt_clname = objConn.GetDataTable(str_sqlclname);
                            //                    string str_clname = "";
                            //                    if (dt_clname != null && dt_clname.Rows.Count > 0)
                            //                    {
                            //                        str_clname = dt_clname.Rows[0]["��ʾ��"].ToString();
                            //                    }
                            //                    string str_updatecl = "insert into �ɹ��̹�ע�Ĳ��ϱ� (yh_id,cl_id,��������,���ϱ���) values ('" + yh_id + "','" + cl_id + "','" + str_clname + "','" + str_clnumber + "')";
                            //                    objConn.ExecuteSQL(str_updatecl, true);
                            //                }
                            //            }
                            //        }
                            //    }
                            //}
                        //}
					}
					catch (Exception ex){
						Response.Write(ex);
					}          

					Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span>");
					Response.Write("<span class='dlzi'>�ò����ѱ��ղسɹ���</span>");
					Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span>");
                    //Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span>");
				}
				
			}
		%>
        </div>
    </div>
</body>
</html>
