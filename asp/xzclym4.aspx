
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
             string gys_id ="";
             string sSQL="";
             DataConn objConn=new DataConn();
           if( Request["gys_id"]!=null&& Request["gys_id"].ToString()!="")
           {
             gys_id = Request["gys_id"];        
            }
            //��������д�����ݿ�		
                string cl_name = Request["cl_name"];                //��������
                string cl_type = Request["cl_type"];                //����ͺ�              
                string cl_bit = Request["cl_bit"];                  //������λ
                string cl_volumetric = Request["cl_volumetric"];        //��λ���
				string cl_height = Request["cl_height"];                //��λ����
                string cl_instruction = Request["cl_instruction"];      //˵��       
                string brand = Request["brand"];                        //Ʒ��id(��ȡ���������б���value��ֵ)
                
				
                sSQL = "insert into  ���ϱ�(��ʾ��,����ͺ�,������λ,��λ���,��λ����,˵��,�Ƿ�����,pp_id) "
				+"values('" + cl_name + "','"+cl_type+"','" + cl_bit + "','" + cl_volumetric + "', "
				+" '" + cl_height + "','"+cl_instruction+"','1','"+brand+"' ) ";          
                //���²��ϱ�
				objConn.ExecuteSQL(sSQL,false);
			    
				//��ȫ���ϱ���Ϣ
				string yjflname = Request["yjflname"];              //�󼶷������� (��ȡ���������б���value��ֵ ������� ��λ)              
                string ejflname = Request["ejflname"];              //������������  (������� 4λ)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				
				sSQL="select ��������,���Ա���,��� from ���Ϸ�������ֵ�� where �������='"+flname+"' ";
				DataTable dt_cl = objConn.GetDataTable(sSQL);
                string cl_clbm = "";  //���ϱ���
				string cl_clbh = "";      //���ϱ��
				string cl_clflname="";
                if(dt_cl!=null&&dt_cl.Rows.Count>0)
                {
				      cl_clbm = Convert.ToString(dt_cl.Rows[0]["���Ա���"]);  //���ϱ���
				      cl_clbh = Convert.ToString(dt_cl.Rows[0]["���"]);      //���ϱ��
				      cl_clflname = Convert.ToString(dt_cl.Rows[0]["��������"]);      //��������
				}
                sSQL = "update ���ϱ� set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"�������� = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
				+"���ϱ��� ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , ������� = '"+flname+"', ��������='"+cl_clflname+"', "
				+"Ʒ������=(select Ʒ������ from Ʒ���ֵ� where pp_id='"+brand+"' ) where ��ʾ��='"+cl_name+"' ";
               
                int ret = objConn.ExecuteSQLForCount(sSQL,false);
				
				//��ȡ������Ҫ���²������Ա�ı���
				string sx_names = Request["sx_names"];    //��ȡ������������ (���������б���value��ֵΪ��������flsx_id)
				string sx_codes = Request["sx_codes"];    //��ȡ�������Ա���
				string sx_id = Request["sx_id"];          //��ȡ��������id
				string cl_value = Request["cl_value"];    //��ȡ��������ֵ
				string cl_number = Request["cl_number"];    //��ȡ��������ֵ���
				string cl_ids = Request["cl_ids"];          //��ȡ����ֵid
				
				sSQL="select ������������ from �������Ա� where flsx_id='"+sx_names+"' ";
				DataTable dt_flsx = objConn.GetDataTable(sSQL);
                string cl_flsxmc ="";
                if(dt_flsx!=null&&dt_flsx.Rows.Count>0)
                {
				    cl_flsxmc = Convert.ToString(dt_flsx.Rows[0]["������������"]);  //������������
				}
				sSQL = "insert into  �������Ա�(������������,�������Ա���,flsx_id,��������ֵ,��������ֵ���,flsxz_id) "
				+"values('" + cl_flsxmc + "','"+sx_codes+"','" + sx_id + "','" + cl_value + "', "
				+" '" + cl_number + "','"+cl_ids+"' ) "; 
				//���²������Ա�
				objConn.ExecuteSQL(sSQL,true); 
				
				//��ȫ�������Ա�			
		        sSQL = "update �������Ա� set clsx_id=(select max(myid) from �������Ա� ), "
				+"cl_id=(select cl_id from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"��������='"+cl_clflname+"',�������='"+flname+"',���ϱ���='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"', "
				+"��������='"+cl_name+"',��������ֵ����='"+sx_codes+"'+'"+cl_number+"' where ������������='"+cl_flsxmc+"' "
				+"and flsx_id='"+sx_id+"'and flsxz_id='"+cl_ids+"' ";
				objConn.ExecuteSQL(sSQL,true);                  
		
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