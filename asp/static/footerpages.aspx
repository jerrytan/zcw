<%-- 材料发现内容页码--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<script runat="server">
        protected DataTable dt = new DataTable();
		
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["DNS"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();         
            string strr = "select count(wz_id),标题,发表时间 from 文章表 where 文档类型='材料发现' group by wz_id,标题,发表时间  ";
            SqlCommand cmd = new SqlCommand(strr, conn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {                
                int str = (int)dr.GetInt32(0);
                OutputBySize(str);
            }
           conn.Close(); 
        }

               public string OutputBySize(int _intTotalPage)//分页函数
        {
                string _strRet = "";           
                int _intCurrentPage = 1;//设置第一页为初始页                           
                if (Request.QueryString["ps"] != null)
                {//set Current page number
                  
                        _intCurrentPage = Convert.ToInt32(Request.QueryString["ps"]);
                        if (_intCurrentPage > _intTotalPage)
                        {
                            _intCurrentPage = _intTotalPage;
                        }
                    }          
               
                string _strPageInfo = "";
                for (int i = 1; i <= _intTotalPage; i++)
                {
                    if (i == _intCurrentPage)
                        _strPageInfo += "[" + i + "]";
                    else
                        _strPageInfo += " <a href=?ps=" + i + ">[" + i + "]</a> ";
                }
                if (_intCurrentPage > 1)
                    _strPageInfo = "<a href=?ps=" + (_intCurrentPage - 1) + ">上一页</a>" + _strPageInfo;
                if (_intCurrentPage < _intTotalPage)
                    _strPageInfo += "<a href=?ps=" + (_intCurrentPage + 1) + ">下一页</a>";                    
         
                _strRet += 5;    //输出显示各个页码        
                return _strRet;
        }
</script>

<div class="fy0">
<div class="fy">

 <a href="#"> 尾页</a>  
直接到第 <select name="" class="fu"><option>1</option></select>      
页</div></div>

</div>