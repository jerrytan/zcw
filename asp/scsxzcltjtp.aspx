<%@ Page Language="C#"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <META content="IE=11.0000" http-equiv="X-UA-Compatible">     
<META http-equiv="Content-Type" content="text/html; charset=utf-8">     
<TITLE>供应商产品列表</TITLE>     
<LINK href="css/css.css" rel="stylesheet" type="text/css">   
<LINK href="css/all of.css" rel="stylesheet" type="text/css">  
<link href="css/cllb.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<script runat="server">
    public DataConn Conn = new DataConn();
    protected void UploadFile(object sender, EventArgs e)
    {
        if (file1.PostedFile.FileName.ToString().Trim() == "")
        {
            Conn.MsgBox(this.Page, "请先选择上传文件！");
            return;
        }
        string FilePath = Server.MapPath("temp");

        FilePath = FilePath + "\\Vedio";
        if (!System.IO.Directory.Exists(FilePath))
        {
            System.IO.Directory.CreateDirectory(FilePath);
        }
        string name = "";
        name = System.IO.Path.GetFileName(this.file1.PostedFile.FileName.Trim());
        if (System.IO.File.Exists(FilePath + "\\" + name))
        {
            try
            {
                System.IO.File.Delete(FilePath + "\\" + name);
            }
            catch (Exception)
            {
            }

        }

        file1.PostedFile.SaveAs(FilePath + "\\" + name);

        if (System.IO.File.Exists(FilePath + "\\" + name))
        {
            string ip = "";
            ip = Page.Request.Url.ToString().Trim();
            int iPos;
            ip = ip.Replace("http://", "");
            ip = ip.Replace("HTTP://", "");
            iPos = ip.IndexOf("/");
            if (iPos != -1)
            {
                ip = ip.Substring(0, iPos);
            }

            string strVD = Request.ApplicationPath.ToString().Trim().Substring(1);
            int intPos;
            intPos = FilePath.LastIndexOf("temp");
            FilePath = FilePath.Substring(intPos);
            FilePath = FilePath.Replace("\\", "/");
            FilePath = "asp/" + FilePath;
            FilePath = strVD + "/" + FilePath + "/" + name;
            FilePath = "http://" + ip + "/" + FilePath;


            string s_mtlx = "";   //媒体类型
            string s_fl = "";
            s_mtlx = this.mtlx.Value;
            if (this.sysm.Checked)
            {
                s_fl = "使用说明";
            }
            else if (this.cgal.Checked)
            {
                s_fl = "成功案例";
            }
            else if (this.ys.Checked)
            {
                s_fl = "演示";
            }
            else if (this.cptp.Checked)
            {
                s_fl = "产品图片";
            }
            string dmt = s_mtlx + "," + s_fl + "," + FilePath;
            if (this.cldmtz.Value!="")
            {
                this.cldmtz.Value = this.cldmtz.Value + "◥" + dmt;
            }             
            else
            {
                this.cldmtz.Value =  dmt;
            } 
            Response.Write("<script>window.alert('上传" + s_mtlx + "成功！')</" + "script>");
        }
        else
        {
            Response.Write("<script>window.alert('上传失败！')</" + "script>");
        }
    }
</script>
    <form id="form2" runat="server">
   <%-- <div class="cpdt_2" style="width: 740px; float: left;">--%>
        <span class="dmt_2">&nbsp;&nbsp;多媒体信息</span>
        <div class="dmt2_2">
            <dl>
                <dd>
                    多媒体类型：</dd>
                <dt>
                    <select id="mtlx" name="mtlx" runat="server">
                        <option value="0">选择媒体类型</option>
                        <option value="视频">视频</option>
                        <option value="图片">图片</option>
                        <option value="文档">文档</option>
                    </select></dt>
                <dd>
                    分类：</dd>
                <dt>
                    <input id="sysm" name="select" value="使用说明" type="radio" validationgroup="select" runat="server" >使用说明
                    <input id="cgal" name="select" value="成功案例" type="radio" validationgroup="select" runat="server" >成功案例
                    <input id="ys" name="select" value="演示" type="radio" validationgroup="select" runat="server" >演示
                    <input id="cptp" name="select" value="产品图片" type="radio" validationgroup="select" runat="server" >产品图片
                </dt>
                <dd>
                    上传文件：</dd>
                <dt>
                   <input name="file1" runat="server" type="file" id="file1" class="fxsxx3"/>&nbsp;&nbsp;
                   <asp:ImageButton runat="server" ImageUrl="images/qweqwe_03.jpg" ID="ImageButton1" OnClick="UploadFile" /></dt>
                <dt></dt>
            </dl>
        </div>
   <%-- </div>--%>
    </form> 
         <input type="hidden"  runat="server" id="cldmtz"  value=""/>   <%-- 分类   --%>
        <script defer="defer">
            window.parent.document.getElementById("dmt").value = document.getElementById("cldmtz").value;
</script>
</body>
</html>
