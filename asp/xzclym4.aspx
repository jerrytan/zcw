
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);          
            String gys_id = Request["gys_id"];        

            //��������д�����ݿ�
            {
                conn.Open(); 
                				
                string cl_name = Request["cl_name"];                //��������
                string cl_type = Request["cl_type"];                //����ͺ�              
                string cl_bit = Request["cl_bit"];                  //������λ
                string cl_volumetric = Request["cl_volumetric"];        //��λ���
				string cl_height = Request["cl_height"];                //��λ����
                string cl_instruction = Request["cl_instruction"];      //˵��       
                string brand = Request["brand"];                        //Ʒ��id(��ȡ���������б���value��ֵ)
                
				
                string str_xzcl = "insert into  ���ϱ�(��ʾ��,����ͺ�,������λ,��λ���,��λ����,˵��,�Ƿ�����,pp_id) "
				+"values('" + cl_name + "','"+cl_type+"','" + cl_bit + "','" + cl_volumetric + "', "
				+" '" + cl_height + "','"+cl_instruction+"','1','"+brand+"' ) ";          
                //���²��ϱ�
				SqlCommand cmd_insert= new SqlCommand(str_xzcl, conn);
                cmd_insert.ExecuteNonQuery();	
			    
				//��ȫ���ϱ���Ϣ
				string yjflname = Request["yjflname"];              //�󼶷������� (��ȡ���������б���value��ֵ ������� ��λ)              
                string ejflname = Request["ejflname"];              //������������  (������� 4λ)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				
				SqlDataAdapter ad_cl = new SqlDataAdapter ("select ��������,���Ա���,��� from ���Ϸ�������ֵ�� where �������='"+flname+"' ",conn);
				DataSet ds_cl = new  DataSet();
				DataTable dt_cl = new DataTable();
				ad_cl.Fill(ds_cl,"���Ϸ�������ֵ��");
				dt_cl = ds_cl.Tables[0];
				string cl_clbm = Convert.ToString(dt_cl.Rows[0]["���Ա���"]);  //���ϱ���
				string cl_clbh = Convert.ToString(dt_cl.Rows[0]["���"]);      //���ϱ��
				string cl_clflname = Convert.ToString(dt_cl.Rows[0]["��������"]);      //��������
				
                string cl_update = "update ���ϱ� set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"�������� = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
				+"���ϱ��� ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , ������� = '"+flname+"', ��������='"+cl_clflname+"', "
				+"Ʒ������=(select Ʒ������ from Ʒ���ֵ� where pp_id='"+brand+"' ) where ��ʾ��='"+cl_name+"' ";
                SqlCommand cmd_update= new SqlCommand(cl_update, conn);
                int ret = (int)cmd_update.ExecuteNonQuery();	
				 
				
                conn.Close();    
            }	                    
		
     %>

    <body>
        <p>
        </p>             
        <a href="gysglcl.aspx" style="color: Blue" onclick="clickMe() ">�������ϳɹ�!�뷵��; </a>
        <script>
            //function clickMe() 
			{
                //window.close();
                //opener.location.reload();
            }
        </script>
        

    </body>