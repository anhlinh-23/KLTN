<%@ Page Title="" Language="C#" MasterPageFile="~/Web_MasterPage.master" AutoEventWireup="true" CodeFile="module_Tatcasanpham.aspx.cs" Inherits="web_module_module_Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .page-menu {
    background-image: none;
    /* Đường dẫn đến hình nền */
    background-repeat: no-repeat;
    background-position: center bottom;
    background-size: cover;
    background-attachment: fixed;
    overflow: hidden;
    width: 100%;
    margin: 0 auto;
    position: relative;
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
        <div class="grid"><a href="/">Trang chủ</a> <i class="fa fa-angle-right"></i><a href="/tat-ca-san-pham/">Tất cả sản phẩm</a></div>
    </div>
    <div class="page-menu">
        <div class="grid">
            <div class="c20"></div>
            <div class="c20"></div>
            <div>

                <h1 class="title-home title-page"><a>Sản phẩm</a></h1>
                <div class="c10"></div>
                <div>
                    <div style="text-align: center">
                        Khám phá ngay những mẫu quần áo nữ thời trang tại AL Fashion Store để cập nhật xu hướng mới nhất và khẳng định phong cách riêng của bạn!"<br>
                        <br>
                        <span style="color: #d5a34c"><span style="font-size: 18px">
                            <strong>AL Fashion - Cập Nhật Xu Hướng Mới Nhất</strong></span></span>
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
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder6" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder7" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder8" runat="Server">
</asp:Content>

