<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="admin_NhapHang.aspx.cs" Inherits="admin_page_module_function_module_KhoVatPham_admin_NhapHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="hibodyhead" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hibodywrapper" runat="Server">
    <div class="card">
        <div class="container-fluid">
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Danh sách nhập hàng</h3>
            <asp:UpdatePanel ID="udButton" runat="server">
                <ContentTemplate>
                    <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-primary" OnClick="btnThem_Click" />
                    <asp:Button ID="btnChiTiet" runat="server" Text="Chi tiết" CssClass="btn btn-primary" OnClick="btnChiTiet_Click" />
                    <a href="/admin-kho-hang" class="btn btn-primary">Quay lại kho hàng</a>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="form-group table-responsive">
                <dx:ASPxGridView ID="grvNhapHang" runat="server" ClientInstanceName="grvList" KeyFieldName="nhaphang_id" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn Caption="Mã hóa đơn" FieldName="nhaphang_code" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Ngày nhập" FieldName="nhaphang_createdate" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Người nhập" FieldName="username_fullname" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tổng tiền" FieldName="nhaphang_tongtien" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <dx:ASPxLabel ID="lblTongTien" runat="server" Text='<%# Eval("nhaphang_tongtien", "{0:#,##0}") %>'></dx:ASPxLabel>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                    </Columns>
                    <%--<ClientSideEvents RowDblClick="btnChiTiet" />--%>
                    <SettingsSearchPanel Visible="true" />
                    <SettingsBehavior AllowFocusedRow="true" />
                    <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập từ cần tìm kiếm..." />
                    <SettingsLoadingPanel Text="Đang tải..." />
                    <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} dòng)"></SettingsPager>
                </dx:ASPxGridView>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>

