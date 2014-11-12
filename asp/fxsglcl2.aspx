<%@ Import Namespace="System.Data" %>
<%@ Page Language="C#"%>

 <script runat="server">
     DataConn objConn = new DataConn();
     protected void Page_Load(object sender, EventArgs e)
     {
         string ppid = "";  //品牌id
         string ppmc = "";  //品牌名称
         string scs = "";   //生产商
         DataTable dtcl = new DataTable();
         if (Request["ppid"]!=null&&Request["ppid"].ToString()!="")
         {
             ppid = Request["ppid"].ToString();
         }
         if (Request["ppmc"] != null && Request["ppmc"].ToString() != "")
         {
             ppmc = Request["ppmc"].ToString();
         }
         if (Request["scs"] != null && Request["scs"].ToString() != "")
         {
             scs = Request["scs"].ToString();
         }
         string fxs_id = "";
         if (Request["fxs_id"] != null && Request["fxs_id"].ToString() != "")
         {
             fxs_id = Request["fxs_id"].ToString();
         }
         string sSQL = "";
         sSQL = "select cl_id,材料编码,显示名 as 材料名称,规格型号,计量单位,生产厂商,price from  供应商材料表 where pp_id='" + ppid + "' and fxs_id="+fxs_id;
         dtcl = objConn.GetDataTable(sSQL);
         string html="";
         html = "  <thead>"
                + "        <tr>"
                + "           <th width='37' align='center'><input  class='middle' type='checkbox' name='checkboxAll' id='checkboxAll' onclick='return selectall();'   /> </th>"
                + "           <th width='44' align='center' style='display:none;'>cl_id</th>"
                + "           <th width='100' align='center'><strong>材料编码</strong></th>"
                + "           <th width='90' align='center'><strong>材料名称</strong></th>"
                + "           <th width='140' align='center'><strong>规格/型号</strong></th>"
                + "           <th width='180' align='center'><strong>供应商</strong></th>"
                + "           <th width='80' align='center'><strong>品牌</strong></th>"
                + "           <th width='55' align='center'><strong>单位</strong></th>"
                + "           <th width='80' align='center'><strong>价格</strong></th>"
                + "           <th width='44' align='center'><strong>操作</strong></th>"
                + "         </tr>"
                + "       </thead>";
         if (dtcl!=null&&dtcl.Rows.Count>0)
         {
             int i = 0;
             foreach (DataRow drcl in dtcl.Rows)
             {
                 string color = ""; 
                 i++;
                 if (i%2==0)
                 {
                     color = "#f2f6ff";
                 }
                 else
                 {
                     color = "#fff";
                 }
                 html += "<tr  style='background:" + color + "' onmouseover=\"this.style.backgroundColor='#fff0e9'\" onmouseout=\"this.style.backgroundColor='"+color+"'\">"
                    + "    <td align='center'><input type='checkbox' name='checkbox' onclick=\"return selectall1(this);\"  />"
                    + "	  <label for='checkbox'></label></td>"
                    + "	  <td align='center' style='display:none;'>" + drcl["cl_id"] + "</td>"
                    + "	  <td align='center'>"+drcl["材料编码"]+"</td>"
                    + "	  <td align='left'>"+drcl["材料名称"]+"</td>"
                    + "	  <td class='gridtable'>"+drcl["规格型号"]+"</td>"
                    + "	  <td align='left'>" + drcl["生产厂商"] + "</td>"
                    + "	  <td class='gridtable'>" + ppmc + "</td>"
                    + "	  <td align='center'>" + drcl["计量单位"] + "</td>"
                    + "	  <td align='center'>" + drcl["price"] + "</td>"    //单价
                    + "	  <td align='center'>"
                    + "	  <input type='Button' name='filter' value='查阅' id='filter' class='filter' filter='' onclick=\"Read('" + drcl["cl_id"] + "')\"  style='color:Black;border-style:None;font-family:宋体;font-size:12px;height:20px;width:37px; cursor:pointer;'/>"
                    + "	  </td>"
                    + "	  </tr>";
             }  
         }
         Response.Write(html);
     }
 </script>
