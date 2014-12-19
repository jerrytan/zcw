using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public class MySqlHelper
{
    //DataConn dc = new DataConn();
    private static string connStr ; //"Data Source=192.168.1.32;Initial Catalog=mywt_mis_ZhongCaiWang02;User ID=mywtadmin; pwd=admin";// 
    /// <summary>
    /// 执行查询返回DataTable
    /// </summary>
    /// <param name="sql"></param>
    /// <param name="param"></param>
    /// <returns></returns>
    public static DataTable GetTable(string sql, params SqlParameter[] param)
    {
        connStr = DataConn.conn;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            DataTable dt = new DataTable();
            using (SqlDataAdapter sda = new SqlDataAdapter(sql, conn))
            {
                if (param != null)
                {
                    sda.SelectCommand.Parameters.AddRange(param);
                }
                sda.Fill(dt);
            }
            return dt;
        }
    }
    /// <summary>
    /// 执行增删改，返回执行成功的条数
    /// </summary>
    /// <param name="sql"></param>
    /// <param name="param"></param>
    /// <returns></returns>
    public static int ExecuteNonQuery(string sql, params SqlParameter[] param)
    {
        connStr = DataConn.conn;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (param!=null)
                {
                    cmd.Parameters.AddRange(param); 
                }
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }
    /// <summary>
    /// 返回执行查询的首行首列
    /// </summary>
    /// <param name="sql"></param>
    /// <param name="param"></param>
    /// <returns></returns>
    public static object ExecuteScalar(string sql, params SqlParameter[] param)
    {
        connStr = DataConn.conn;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (param != null)
                {
                    cmd.Parameters.AddRange(param);
                }
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }
    public static SqlDataReader ExecuteReader(string sql, params SqlParameter[] param)
    {
        connStr = DataConn.conn;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddRange(param);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                return reader;
            }
        }
    }
}

