using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace ClassLibrary1
{
    public class Class1
    {
        public static void Main(String[] args)
        {
            Console.WriteLine("开始导出数据库数据为XML文件\n");
            exportToXmlPath();
            Console.WriteLine("导出结束\n");
        }
        public static void exportToXml()
        {
            string query = "SELECT *  FROM dbo.材料表 FOR XML AUTO";

            using (SqlConnection _con = new SqlConnection("server=localhost; database=mywt_mis_ZhongCaiWang01;uid=mywtadmin; pwd=admin"))
            using (SqlCommand _cmd = new SqlCommand(query, _con))
            {
                _con.Open();
                string result = _cmd.ExecuteScalar().ToString();
                _con.Close();

                System.IO.File.WriteAllText(@"D:\test.xml", result);
            }

        }
        public static void exportToXmlPath()
        {
            string query = "SELECT [myID] AS '@ID',[cl_id],[材料编码],[是否启用],[类型],[显示名] FROM [dbo].[材料表] FOR XML PATH('材料表'),ROOT('材料')";

            using (SqlConnection _con = new SqlConnection("server=localhost; database=mywt_mis_ZhongCaiWang01;uid=mywtadmin; pwd=admin"))
            using (SqlCommand _cmd = new SqlCommand(query, _con))
            {
                _con.Open();
                string result = _cmd.ExecuteScalar().ToString();
                _con.Close();

                System.IO.File.WriteAllText(@"D:\test.xml", result);
            }

        }
    }
}
