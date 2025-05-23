﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Web_MasterPage.master" AutoEventWireup="true" CodeFile="module_Sanpham.aspx.cs" Inherits="web_module_module_BunHue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
            .product-out-of-stock {
            opacity: 0.5;
            filter: grayscale(50%);
            pointer-events: none;
            position: relative;
        }
        
        .product-out-of-stock::after {
            content: "Hết hàng";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            z-index: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder5" runat="Server">
    <div class="crumb">
        <div class="grid"><a href="/">Trang chủ</a> <i class="fa fa-angle-right"></i><a href="/san-pham/">Sản phẩm</a>&nbsp;
    <div class="grid">
        <div class="c20"></div>
        <div class="c20"></div>
        <div>
            <h1 class="title-home title-page"><a><%=title %></a></h1>
            <div class="c10"></div>
            <div>
                <div style="text-align: center">
                    <span style="font-size: 14px"><%=des %>&nbsp;</span><br>
                    &nbsp;
                </div>
            </div>
            <div class="c20"></div>
            <div class="flex-container ">
                <asp:Repeater runat="server" ID="rpMon">
                    <ItemTemplate>
                        <div class="cell-1-4 mobile-cell-1-2 tab-cell-1-3 b-pro margin-bottom-40">
                            <div>
                                <a href="mon-<%#Eval("link") %>">
                                    <img src="<%#Eval("pr_image") %>" alt="<%#Eval("pr_name") %>" width="100%"></a>
                            </div>
                            <div class="product-name-home"><a href="#"><%#Eval("pr_name") %></a></div>
                            <div class="product-price-home"><%#Eval("pr_price") %> đ</div>
                            <div class="c10"></div>
                            <div class="c10"></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
               
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder6" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder7" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder8" runat="Server">
</asp:Content>

