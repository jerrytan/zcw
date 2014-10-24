<%@ Page Language="C#" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //提交页面
        try
        {
            string FilePath = Server.MapPath("temp");
            string HTML = "";
            if (Request["wjj"] != null && Request["wjj"].ToString() != "")
            {
                FilePath = FilePath + "\\" + Request["wjj"].ToString();
            }
            else
            {
                FilePath = FilePath + "\\temp\\";
            }
            if (!System.IO.Directory.Exists(FilePath))
            {
                System.IO.Directory.CreateDirectory(FilePath);
            }
            if (Request["htmlmc"] != null && Request["htmlmc"].ToString() != "")
            {
                FilePath = FilePath + "\\" + Request["htmlmc"].ToString() + ".htm";
            }
            else
            {
                FilePath = FilePath + "\\" + "Html.htm";
            }
            try
            {
                if (System.IO.File.Exists(FilePath))
                {
                    System.IO.File.Delete(FilePath);
                }
            }
            catch (Exception)
            {
            }

            if (Request["HTML"] != null && Request["HTML"] != "")
            {
                HTML = Request["HTML"].ToString();
            }
            HTML = HTML.Replace("&nbsp;", "");
            HTML = HTML.Replace(" ", "");
            string all = HTML;
            Encoding encoding = System.Text.Encoding.Default;
            System.IO.FileStream fs1 = new System.IO.FileStream(FilePath, System.IO.FileMode.Create, System.IO.FileAccess.Write);
            System.IO.BinaryWriter bw = new System.IO.BinaryWriter(fs1);
            bw.Write(encoding.GetBytes(all));
            bw.Close();
            fs1.Close();
            Response.Write("<script>alert('提交成功！');window.opener = null;window.open('', '_self'); window.close(); <"+"/script>");
           // Response.Write("1");
        }
        catch (Exception)
        {
            
            Response.Write("<script>alert('提交失败！');history.go(-1);<"+"/script>");
           // Response.Write("");
        }

    }
</script>
