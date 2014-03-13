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

/// <summary>
/// DataConn 的摘要说明
/// </summary>
public class DataConn : System.Web.UI.Page
{
    private SqlConnection objConn = null;
    private string ABC = "admin";
    private string strConnString = "";
    #region 构造函数
    /// <summary>
    /// Connection 构造函数
    /// </summary>
    /// <param name="strDB">选择的数据库</param>
    public DataConn()
    {
        string strServerName = GetWebConfigValue("DBServerName");
        string DBName="";
        DBName=GetWebConfigValue("DBName");
        objConn = new SqlConnection("data source=" + strServerName + ";initial catalog="+DBName+";persist security info=False;user id=mywtadmin;pwd="+ABC);
    }

  
    #endregion

    #region 其他操作
    /// <summary>
    /// 取出配置文件中的指定值
    /// </summary>
    /// <param name="sPara"></param>
    /// <returns></returns>
    public string GetWebConfigValue(string sPara)
    {
        string sValue = "";
        try
        {
            sValue = System.Configuration.ConfigurationSettings.AppSettings[sPara].ToString().Trim();
        }
        catch
        {
            System.Web.HttpContext.Current.Response.Redirect("frmResult.aspx?Success=1&ReturnMsg=" + Server.UrlEncode("请升级配置文件！"));
        }
        return sValue;
    }

    /// <summary>
    /// 根据数据库名返回数据库连接字符串的
    /// </summary>
    /// <param name="DBName"></param>
    /// <returns></returns>
    public string GetConnStr(string DBName)
    {
        string strServerName = GetWebConfigValue("DBServerName"); ;
        string sConnStr = "data source=" + strServerName + ";initial catalog=" + DBName + ";persist security info=False;user id=mywtadmin;pwd=" + ABC;

        return sConnStr;
    }
    #endregion

    #region 打开关闭数据库

    /// <summary>
    /// 和数据库建立连接
    /// </summary>
    public void OpenDB()
    {
        if (objConn.State.ToString().ToUpper().Trim() != "OPEN")
            objConn.Open();
    }


    /// <summary>
    /// 关闭数据库
    /// </summary>
    public void Close()
    {
        if (objConn != null)
        {
            if (objConn.State.ToString().ToUpper()=="OPEN")
            {
                objConn.Close(); // 关闭数据库
            }
           
        }
    }
    #endregion

    #region 直接执行sql语句的
    /// <summary>
    /// 执行SQL语句，取出SQL语句的第一行第一列的值
    /// </summary>
    /// <param name="strSQL">要执行的SQL语句</param>
    /// <returns>SQL语句执行结果的第一行第一列的值</returns>
    public string DBLook(string strSQL)
    {
        DataTable objDt = null;
        try
        {
            objDt = GetDataTable(strSQL);
            if (objDt != null && objDt.Rows.Count > 0)
            {
                return (objDt.Rows[0][0].ToString().Trim());
            }
            else
            {
                return ("");
            }
        }
        catch
        {
            return ("");
        }

    }
    /// <summary>
    /// 建立DataSet对象,用记录填充或构架(如果必要)DataSet对象,DataSet即是数据在内存的缓存，并返回
    /// </summary>
    /// <param name="str_Sql">打开表Sql语句</param>
    /// <returns>返回DataSet表格</returns>
    public DataSet GetDataSet(string strSQL)
    {
        try
        {
            SqlDataAdapter objDataAdapter = null;
            DataSet objDataSet = new DataSet();
            objDataSet.Clear();

            objDataAdapter = new SqlDataAdapter(strSQL, objConn);
            objDataAdapter.Fill(objDataSet);
            return objDataSet;
        }
        catch (Exception err)
        {
            return null;
        }
        finally
        {
            Close();
        }
    }
    public SqlDataReader sqlDataReader(string strSQL)
    {
        try
        {
            OpenDB();
            SqlCommand objCommand = null;
            SqlDataReader objDataReader = null;
            objCommand = new SqlCommand(strSQL, objConn);
            objDataReader = objCommand.ExecuteReader();
            return objDataReader;
        }
        catch (Exception)
        {
            throw;
        }
            
    }
    /// <summary>
    /// 返回指定查询SQL的DataTable对象
    /// </summary>
    /// <param name="strSQL"></param>
    /// <returns></returns>
    public DataTable GetDataTable(string strSQL)
    {
        DataTable objDt = null;
        try
        {
            objDt = GetDataSet(strSQL).Tables[0];
            return objDt;
        }
        catch
        {
            //System.Web.HttpContext.Current.Response.Write("<script language='vbscript'>msgbox '取出数据集失败，请重试！',,'系统提示'</script>");
            return null;
        }
    }
    /// <summary>
    /// 获得包含在DataSet对象的映谢表集合中的index为0的映谢表
    /// </summary>
    /// <param name="str_Sql">Select-SQL语句</param>
    /// <returns>返回DataSet表格DataTable中的行集</returns>
    public DataRowCollection GetRows(string strSQL)
    {
        DataSet objDataSet = null;
        DataRowCollection objDataRowCol = null;

        objDataSet = GetDataSet(strSQL);
        if (objDataSet != null && objDataSet.Tables.Count > 0 && objDataSet.Tables[0].Rows.Count > 0)
        {
            objDataRowCol = objDataSet.Tables[0].Rows;
        }
        return objDataRowCol;
    }

    /// <summary>
    /// 获得符合该Sql语句的表记录数
    /// </summary>
    /// <param name="str_Sql">Select-SQL语句</param>
    /// <returns>返回表记录条数</returns>
    public int GetRowCount(string strSQL)
    {
        DataSet objDataSet = null;

        objDataSet = GetDataSet(strSQL);
        if (objDataSet != null)
        {
            return objDataSet.Tables[0].Rows.Count;
        }
        else
        {
            return 0;
        }
    }
    /// <summary>
    /// 获得dataview
    /// </summary>
    /// <param name="str_Sql"></param>
    /// <returns></returns>
    public DataView GetDataView(string strSQL)
    {
        DataSet objDataSet = null;
        DataView objDataView = null;

        objDataSet = GetDataSet(strSQL);
        objDataView = objDataSet.Tables[0].DefaultView;
        return objDataView;

    }

    #endregion

    #region 执行带参数的sql语句

    /// <summary>
    /// 建立DataSet对象,用记录填充或构架(如果必要)DataSet对象,DataSet即是数据在内存的缓存，并返回
    /// </summary>
    /// <param name="str_Sql">打开表Sql语句</param>
    /// <returns>返回DataSet表格</returns>
    public DataSet GetDataSet(string strSQL, SqlParameter[] coll)
    {
        DataSet objDataSet = new DataSet();
        try
        {
            SqlDataAdapter objDataAdapter = null;
            objDataSet.Clear();
            objDataAdapter = new SqlDataAdapter();
            SqlCommand objdataCommand = new SqlCommand(strSQL, objConn);
            for (int i = 0; i < coll.Length; i++)
            {
                objdataCommand.Parameters.Add(coll[i]);
            }
            objDataAdapter.SelectCommand = objdataCommand;
            objDataAdapter.Fill(objDataSet);
        }
        catch (Exception err)
        {
            string s = err.Message;
            return null;
        }
        Close();
        return objDataSet;
        
    }


    /// <summary>
    /// 返回指定查询SQL的DataTable对象
    /// </summary>
    /// <param name="strSQL"></param>
    /// <returns></returns>
    public DataTable GetDataTable(string strSQL, SqlParameter[] coll)
    {
        DataTable objDt = null;
        DataSet ds = GetDataSet(strSQL, coll);
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null)
        {
            objDt = ds.Tables[0];
        }
        return objDt;
    }

    /// <summary>
    /// 获得包含在DataSet对象的映谢表集合中的index为0的映谢表
    /// </summary>
    /// <param name="str_Sql">Select-SQL语句</param>
    /// <returns>返回DataSet表格DataTable中的行集</returns>
    public DataRowCollection GetRows(string strSQL, SqlParameter[] coll)
    {
        DataSet objDataSet = null;
        DataRowCollection objDataRowCol = null;

        objDataSet = GetDataSet(strSQL, coll);
        if (objDataSet != null && objDataSet.Tables.Count > 0 && objDataSet.Tables[0].Rows.Count > 0)
        {
            objDataRowCol = objDataSet.Tables[0].Rows;
        }
        return objDataRowCol;
    }

    /// <summary>
    /// 获得符合该Sql语句的表记录数
    /// </summary>
    /// <param name="str_Sql">Select-SQL语句</param>
    /// <returns>返回表记录条数</returns>
    public int GetRowCount(string strSQL, SqlParameter[] coll)
    {
        DataSet objDataSet = null;

        objDataSet = GetDataSet(strSQL, coll);
        if (objDataSet != null)
        {
            return objDataSet.Tables[0].Rows.Count;
        }
        else
        {
            return 0;
        }
    }

   

    #endregion

    #region 执行sql语句，并根据参数是否关闭数据库的

    /// <summary>
    /// 执行SQL语句，并返回是否成功
    /// </summary>
    /// <param name="str_Sql"></param>
    /// <returns></returns>
    public bool ExecuteSQL(string str_Sql, bool blnClose)
    {
        SqlCommand objCommand = null;
        OpenDB();
        objCommand = new SqlCommand(str_Sql, objConn);

        //放开执行SQL语句（包括存储过程）的超时时间，均设置为300秒（SqlCommand默认为30秒）
        objCommand.CommandTimeout = 300;
        try
        {
            objCommand.ExecuteNonQuery();
            if (blnClose == true)
                Close();
            return true;
        }
        catch (Exception e)
        {
            if (blnClose == true)
                Close();

            HttpContext.Current.Session["ErrorMsg"] = e.Message.ToString().Trim();
            return false;
        }
        finally
        {
            Close();
        }
    }



    /// <summary>
    /// 执行SQL语句，并返回是否成功
    /// </summary>
    /// <param name="str_Sql"></param>
    /// <returns></returns>
    public bool ExecuteSQL(SqlCommand cmd, bool blnClose)
    {

        cmd.Connection.ConnectionString = this.strConnString;
        OpenDB();

        //放开执行SQL语句（包括存储过程）的超时时间，均设置为300秒（SqlCommand默认为30秒）
        cmd.CommandTimeout = 300;

        try
        {
            cmd.ExecuteNonQuery();
            if (blnClose == true)
                Close();

            return true;
        }
        catch (Exception e)
        {
            if (blnClose == true)
                Close();

            HttpContext.Current.Session["ErrorMsg"] = e.Message.ToString().Trim();
            return false;
        }
        finally
        {
            Close();
        }
    }


    /// <summary>
    /// 执行SQL语句，并返回影响的行数
    /// </summary>
    /// <param name="str_Sql"></param>
    /// <returns></returns>
    public int ExecuteSQLForCount(string str_Sql, bool blnClose)
    {
        int ret = 0;
        SqlCommand objCommand = null;

        OpenDB();
        objCommand = new SqlCommand(str_Sql, objConn);

        //放开执行SQL语句（包括存储过程）的超时时间，均设置为300秒（SqlCommand默认为30秒）
        objCommand.CommandTimeout = 300;

        try
        {
            ret = objCommand.ExecuteNonQuery();
            if (blnClose == true)
                Close();
            return ret;
        }
        catch (Exception e)
        {
            if (blnClose == true)
                Close();

            HttpContext.Current.Session["ErrorMsg"] = e.Message.ToString().Trim();
            ret = 0;
            return ret;
        }
        finally
        {
            Close();
        }
    }


    /// <summary>
    /// 先设置当前数据库，再执行SQL语句，并返回是否成功
    /// </summary>
    /// <param name="str_Sql"></param>
    /// <returns></returns>
    public bool ExecuteDBSQL(string DBName, string str_Sql, bool blnClose)
    {
        string sSQL;
        sSQL = "use " + DBName;

        if (ExecuteSQL(sSQL, false) == false)
            return false;
        if (ExecuteSQL(str_Sql, false) == false)
            return false;

        if (blnClose == true)
            Close();

        return true;
    }


    #endregion

    #region 执行存储过程的
    /// <summary>
    /// 执行存储过程
    /// </summary>
    /// <returns></returns>
    public bool ExecuteProc()
    {
        string strServerName = GetWebConfigValue("DBServerName");
        SqlConnection conn1 = new SqlConnection("data source=" + strServerName + ";initial catalog=master;persist security info=False;user id=mywtadmin;pwd=" + ABC);

        SqlCommand cmd = new SqlCommand("p_killspid", conn1);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add("@dbname", "NewsPublish");

        cmd.Connection.Open();

        cmd.ExecuteNonQuery();

        cmd.Connection.Close();
        return true;

    }


    /// <summary>
    /// 执行存储过程返回datatable
    /// </summary>
    /// <param name="strProcName">存储过程名称</param>
    /// <param name="coll">存储过程参数列表</param>
    /// <returns>datatable</returns>
    public DataTable ExecuteProcForTable(string strProcName, SqlParameter[] coll)
    {
        DataTable dt = null;
        DataSet ds = null;
        SqlCommand objcom = new SqlCommand();
        SqlDataAdapter objadapter;
        try
        {
            objcom.Connection = objConn;
            objcom.CommandType = CommandType.StoredProcedure;
            objcom.CommandText = strProcName;
            objcom.Parameters.Clear();
            for (int i = 0; i < coll.Length; i++)
            {
                objcom.Parameters.Add(coll[i]);
            }
            objadapter = new SqlDataAdapter(objcom);
            objadapter.Fill(ds);
            if (ds != null && ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
            }
        }
        catch
        {
            dt = null;
        }
        objcom.Connection.Close();
        return dt;
    }
    #endregion

    #region 其他有关数据库操作的
    /// <summary>
    /// 把字节流存到数据库
    /// </summary>
    /// <param name="strSQL">sql语句</param>
    /// <param name="byFileData">字节流</param>
    /// <returns>执行成功与否</returns>
    public bool SaveFileToImage(string strSQL, string DBName, byte[] byFileData)
    {

        SqlDataAdapter objDataAdapter = null;
        DataSet objDataSet = new DataSet();
        objDataSet.Clear();

        //重新连接
        Close();
        string strServerName = GetWebConfigValue("DBServerName");
        objConn = new SqlConnection("data source=" + strServerName + ";initial catalog=" + DBName + ";persist security info=False;user id=mywtadmin;pwd=" + ABC);

        if (objConn.State.ToString().ToUpper()=="OPEN")
        {
            objConn.Open();
        }
        objDataAdapter = new SqlDataAdapter(strSQL, objConn);

        objDataAdapter.Fill(objDataSet);

        DataRow objRow = null;
        objRow = objDataSet.Tables[0].Rows[0];
        objRow[0] = byFileData;

        // Generate the update commands（生成SQL命令） 
        SqlCommandBuilder objBuilder = null;
        objBuilder = new SqlCommandBuilder(objDataAdapter);

        objDataAdapter.UpdateCommand = objBuilder.GetUpdateCommand();

        // Update the data store （更新数据库，于数据库同步）
        objDataAdapter.Update(objDataSet);

        Close();

        return true;
    }


    public void DataPile(string strsql, DataSet objset, string strtable)
    {
        SqlDataAdapter objDataAdapter = null;
        objDataAdapter = new SqlDataAdapter(strsql, objConn);
        objDataAdapter.Fill(objset, strtable);
        Close();
    }
    /// <summary>
    /// 返回指定查询SQL,数据源和源表的DataTable对象
    /// </summary>
    /// <param name="strSql">sql语句</param>
    /// <param name="objSet">数据源</param>
    /// <param name="strTable">源表的名称</param>
    /// <returns>返回DataTable对象</returns>
    public DataTable DataPileDT(string strSql, DataSet objSet, string strTable)
    {
        DataTable dt = null;
        SqlDataAdapter spa = null;
        spa = new SqlDataAdapter(strSql,objConn);
        try
        {
            spa.Fill(objSet, strTable);
            if (objSet != null && objSet.Tables.Count > 0)
            {
                dt = objSet.Tables[0];
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
        finally
        {
            Close();
        }
        return dt;
    }

    /// <summary>
    /// 执行操作型SQL，并返回自动增值ID
    /// </summary>
    public int ExeSQLGetID(string strSQL)
    {
        SqlCommand objCommand = null;
        SqlDataReader objDataReader = null;
        int iId = -1;

        OpenDB();

        //取得自动增值
        strSQL += "    SELECT @@IDENTITY AS 'Identity'";

        objCommand = new SqlCommand(strSQL, objConn);

        try
        {
            objDataReader = objCommand.ExecuteReader();

            if (objDataReader.Read())
            {
                iId = int.Parse(objDataReader["Identity"].ToString());
            }

            objDataReader.Close();
        }
        catch (Exception e)
        {
            iId = -1;
            HttpContext.Current.Session["ErrorMsg"] = e.Message.ToString().Trim();
        }

        finally
        {
            Close();
        }
        return iId;
    }


    /// <summary>
    /// 执行事物
    /// </summary>
    /// <param name="sSQL"></param>
    /// <returns></returns>
    public bool RunSqlTransaction(string sSQL)
    {
        bool blnResult;

        OpenDB();

        SqlCommand myCommand = objConn.CreateCommand();
        SqlTransaction myTrans;

        // Start a local transaction
        myTrans = objConn.BeginTransaction(IsolationLevel.ReadUncommitted, "SampleTransaction");
        // Must assign both transaction object and connection
        // to Command object for a pending local transaction
        myCommand.Connection = objConn;
        myCommand.Transaction = myTrans;

        try
        {
            myCommand.CommandText = sSQL;
            myCommand.ExecuteNonQuery();
            myTrans.Commit();

            blnResult = true;
        }
        catch (Exception e)
        {
            myTrans.Rollback("SampleTransaction");

            HttpContext.Current.Session["ErrorMsg"] = e.Message.ToString().Trim();

            blnResult = false;
        }
        finally
        {
            Close();
        }

        return blnResult;
    }

    #endregion
  
}
