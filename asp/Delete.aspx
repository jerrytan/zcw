<%@ Page Language="C#" EnableViewStateMac= "false" %>

 <script runat="server">
     protected void Page_Load(object sender, EventArgs e)
     {
         string FilePath = Server.MapPath("temp");
         string CompanyID = "";  //营业注册号
         string htmlmc = "";    //要删除的文件名称
         if (Request["CompanyID"] != null && Request["CompanyID"].ToString() != "")
         {
             CompanyID = Request["CompanyID"].ToString();
         }
         if (Request["HtmlMC"] != null && Request["HtmlMC"].ToString() != "")
         {
             htmlmc = Request["HtmlMC"].ToString();
         }
         FilePath = FilePath + "\\" + CompanyID + "\\" + htmlmc + ".htm";
         try
         {
             if (System.IO.File.Exists(FilePath))
             {
                 System.IO.File.Delete(FilePath);
             }            
         }
         catch (Exception)
         {
             Encoding encoding = System.Text.Encoding.Default;
             System.IO.FileStream fs1 = new System.IO.FileStream(FilePath, System.IO.FileMode.Create, System.IO.FileAccess.Write);
             System.IO.BinaryWriter bw = new System.IO.BinaryWriter(fs1);
             bw.Write(encoding.GetBytes(""));
             bw.Close();
             fs1.Close(); 
         }
     }
 </script>
