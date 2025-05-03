<%@ Page Title="" Language="C#" MasterPageFile="~/Web_MasterPage.master" AutoEventWireup="true" CodeFile="module_Dathang.aspx.cs" Inherits="web_module_module_DatBan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder5" runat="Server">
    <div class="crumb">
        <div class="grid"><a href="/">Trang chủ</a> <i class="fa fa-angle-right"></i><a href="/dat-ban/">Đặt lịch </a></div>
    </div>
    <div class="grid">
        <link rel="stylesheet" type="text/css" href="/css/jquery.datetimepicker.css">
        <script type="text/javascript" src="/js/jquery.datetimepicker.js"></script>
        <h1 class="title-page title-home"><a>Hẹn xem hàng tại shop</a></h1>
        <div class="c10"></div>
        <div>
            <div style="text-align: center">
                Hãy cùng khám phá bộ sưu tập thời trang tại AL Fashion Store để trải nghiệm phong cách độc đáo và cuốn hút, giúp bạn tỏa sáng mọi lúc mọi nơi!<br>
                Liên hệ với chúng tôi<br>
                <span style="color: #d5a34c"><strong><span style="font-size: 24px">0366809335</span></strong></span>
            </div>
        </div>
        <div class="c30"></div>
        <div class="flex-container">
            <div class="cell-1-2 mobile-cell-1-1 tab-cell-1-1">
                <div style="max-width: 520px; margin: 0 auto">
                    <img src="/images/dathang.png" style="max-width: 100%">
                </div>
            </div>
            <div class="cell-1-2">
                <div class="box-form-datban">
                    <input type="hidden" name="ordersubmit" value="1">
                    <div class="flex-container">
                        <div class="cell-1-2">
                            <div class="item">
                                Họ tên
                                <input name="fullname" runat="server" id="txtName" class="notNull" placeholder="Họ tên" type="text">
                            </div>
                            <div class="item">
                                Email
                                <input name="email" runat="server" id="txtEmail" type="email" placeholder="Email">
                            </div>
                            <div class="item">
                                Điện thoại
                                <input name="phone" runat="server" id="txtPhone" class="notNull" type="text" placeholder="Điện thoại">
                            </div>
                        </div>
                        <div class="cell-1-2">
                            <div class="item">
                                Thời gian
                            	<div class="flex-container">
                                    <div style="width: 50%">
                                        <input type="date" runat="server" id="txtDay" class="notNull" name="name" value="" />
                                    </div>
                                    <div class="cell-1-3" style="width: 45%">
                                        <input type="time" runat="server" id="txtTime" class="notNull" name="name" value="" />
                                    </div>
                                </div>
                            </div>
                      
                        <div class="cell-1-1">
                            <textarea name="ghichu" runat="server" id="txtGhiChu" placeholder="Ghi chú"></textarea>
                        </div>
                        <div class="cell-1-1"><a href="javascript:void(0)" id="btnDatBan" runat="server" onserverclick="btnDatBan_ServerClick">Đặt lịch ngay</a></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="c30"></div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder6" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder7" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder8" runat="Server">
</asp:Content>

