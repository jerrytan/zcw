﻿<%@ Page Title="" Language="C#" MasterPageFile="~/asp/HomePage.master" AutoEventWireup="true"
    CodeFile="leveltwo.aspx.cs" Inherits="asp_leveltwo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="Styles/lzp.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="images/favicon.ico" />
    <link href="css/all%20of.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/leveltwo.js" type="text/javascript"></script>
    <link href="css/Paging.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/MyControl/MyControl.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <input type="hidden" id="flbm" value="<%=flbm %>" />
    <input type="hidden" id="allbm" />
    <input type="hidden" id="pageindex" />
    <input type="hidden" id="pagesize" />
    <input type="hidden" id="orderby" />
    <div class="sc">
        <div class="sc1">
            <a href="index.aspx">首页</a> &gt; <a href="levelone.aspx?flbm=<%=leveloneflbm %>&flmc=<%=leveloneflmc %>">
                <%=leveloneflmc %></a> &gt;<%=flmc %>
        </div>
        <div class="xzss">
            <%=GetAttribute(flbm) %>
        </div>
    </div>
    <div class="dlspxl">
        <div class="dlspx">
            <dl class="order">
                <dt>排序：</dt>
                <dd class="orderdd" style="border:1px solid #e4393c; background:#e4393c;" onclick="orderby(this,'0')">
                    <a href="javascript:;" style=" color:White;" class="ordera">默认</a> <b></b>
                </dd>
                <dd class="orderdd" onclick="orderby(this,'1')">
                    <a href="javascript:;" class="ordera">人气</a><b></b>
                </dd>
                <dd class="orderdd" onclick="orderby(this,'2')">
                    <a href="javascript:;" class="ordera">最新</a><b></b>
                </dd>
            </dl>
        </div>
        <div id="clbox" style="width: 760px; height: 650px;">
            <%=GetList(flbm)%>
        </div>
        <div class="paginator">
            <%=GetPageNumber(flbm)%>
        </div>
    </div>
    <div class="pxright0">
        <div class="pxright">
            <div class="pxright1" style="text-align: left; padding-left: 0px !important; padding-left: 20px;
                overflow: hidden">
                <ul>
                    <% foreach (System.Data.DataRow row in dt_ejflcl.Rows)
                       {%>
                    <li style="overflow: hidden"><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
                        <%=row["显示名"].ToString() %></a></li>
                    <%}%>
                </ul>
            </div>
        </div>
        <div class="pxright2">
            <a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
    </div>
</asp:Content>
