<!--
      ����������Ʒ��
	  �ļ���:  xzpp3.aspx   
      �������:�û�id 
	  author:����ӱ         
-->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.ServiceModel.Channels" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>

    <body>
    <script runat="server">
        DataConn objConn = new DataConn();
        public string gys_id = "";
        public int ret;
        protected void Page_Load(object sender, EventArgs e)
        {
            string yh_id = "";          
            if (Session["GYS_YH_ID"] != null && Session["GYS_YH_ID"].ToString() != "")
            {
                yh_id = Session["GYS_YH_ID"].ToString();   //��ȡ�û�id
            }

            string source = Request.Form["source"];

            string gys_id = Request.Form["gys_id"];
            string brandname = Request.Form["brandname"];            //Ʒ������
            //string yjflname = Request.Form["yjflname"];              //�󼶷�������               
            //string ejflname = Request.Form["ejflname"];              //������������
            string grade = Request.Form["grade"];               //�ȼ�
            string scope = Request.Form["scope"];                    //��Χ      
            string isqy = Request.Form["Isqy"];                    //��Χ      
            //string flname = Request.Form["ejflname"];
            //if (flname.Equals("0"))  flname = Request.Form["yjflname"];
            string bj = Request["bj"];
            string ppid = Request["ppid"];
            if (brandname!=null && brandname!="")
            {
                if (bj == "1")
                {
                    string sSQL = "select count(*) from Ʒ���ֵ� where Ʒ������='" + brandname + "' and scs_id='" + gys_id + "'";
                    string count = objConn.DBLook(sSQL);
                    if (count=="0")
                    {
                        string sql = "";
                        sql = "update Ʒ���ֵ� set Ʒ������='" + brandname + "',�Ƿ�����='" + isqy + "',�ȼ�='" + grade + "',��Χ='" + scope + "' where pp_id='" + ppid + "'";

                        ret = objConn.ExecuteSQLForCount(sql, true);
                    }
                    else
                    {
                        ret = 2;
                    }
                }
                else
                {
                    string sSQL = "select count(*) from Ʒ���ֵ� where Ʒ������='" + brandname + "' and scs_id='" + gys_id + "'";
                    string count = objConn.DBLook(sSQL);
                    if (count == "0")
                    {
                        //string str_insert = "insert into  Ʒ���ֵ� (Ʒ������,�Ƿ�����,scs_id,�������,�ȼ�,��Χ,yh_id) values('" + 
                        //    brandname + "',1,'" + gys_id + "','" + flname + "','" + grade + "','" + scope + "','" + yh_id + "' ) ";
                        string str_insert = "insert into  Ʒ���ֵ� (Ʒ������,�Ƿ�����,scs_id,�ȼ�,��Χ,yh_id,updatetime) values('" +
                            brandname + "','" + isqy + "','" + gys_id + "','" + grade + "','" + scope + "','" + yh_id + "',(select getdate()) ) ";
                        objConn.ExecuteSQL(str_insert, false);
                        string str_update = "update Ʒ���ֵ� set pp_id= (select myID from Ʒ���ֵ� where Ʒ������='" + brandname + "'),"
                            // + " fl_id = (select fl_id from ���Ϸ���� where �������='" + flname + "'),"
                            + " ������ = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '" + gys_id + "')"
                            //  + " �������� = (select ��ʾ���� from ���Ϸ���� where ������� = '" + flname + "'),updatetime=(select getdate())"
                            + " where Ʒ������='" + brandname + "'";

                        ret = objConn.ExecuteSQLForCount(str_update, true);
                        //if (ret == 0)
                        //{
                        //    string sql = "delete Ʒ���ֵ� where Ʒ������='" + brandname +
                        //        "' and �Ƿ�����=1 and scs_id='" + gys_id + "' and  yh_id='" + yh_id + "'";
                        //    objConn.ExecuteSQL(sql, true);
                        //}
                    }
                    else
                    {
                        ret = 2;
                    }
                }        
            }
            else
            {
                ret = 3;
            }             
		
        }
    </script>
        <p>
        </p> 
         <p>
        </p>
       <%if(ret!=0&&ret!=2&&ret!=3) {%>
        <a style="color: Red" onclick="clickMe()">����ɹ����뷵��; </a>
        <%}else if(ret==0){ %>
         <a style="color: Red" onclick="clickMe()">����ʧ�ܣ�ҳ�潫��ת����ҳ��</a>
             
        <%}else if (ret == 3)
          { %>
        <a style="color: Red" onclick="clickMe()">Ʒ����Ϊ�գ�����ʧ�ܣ�</a>   
             
        <% }
          else if(ret==2)
          { %>
            <a style="color: Red" onclick="clickMe()">Ʒ�����Ѵ��ڣ�����ʧ�ܣ�</a>   
        <% } %>
        <script defer="defer" type="text/javascript">
            function doload()
            {
                window.close();
//                opener.location.reload();
                 opener.location.href='glscsxx.aspx?gys_id=<%=gys_id %>';
            }
            setTimeout("doload()", 2000);
        </script>
        <script type="text/javascript">
            function clickMe() {
                window.close();
                // opener.location.reload();
                opener.location.href = 'glscsxx.aspx';
            }
        </script>
        

    </body>
    </html>




