<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="admin_XuatHang.aspx.cs" Inherits="admin_page_module_function_module_KhoVatPham_admin_XuatHang" %>

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
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Danh sách xuất hàng</h3>
            <asp:UpdatePanel ID="udButton" runat="server">
                <ContentTemplate>
                    <asp:Button ID="btnOder" runat="server" Text="Oder" CssClass="btn btn-primary" OnClick="btnOder_Click" />
                    <asp:Button ID="btnXemOder" runat="server" Text="Xem oder" CssClass="btn btn-primary" OnClick="btnXemOder_Click" />
                    <a href="/admin-kho-hang" class="btn btn-primary">Quay lại kho hàng</a>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="form-group table-responsive">
                <dx:ASPxGridView ID="grvXuatHang" runat="server" ClientInstanceName="grvList" KeyFieldName="order_id" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn Caption="SĐT người oder" FieldName="account_sodienthoai" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Mã hóa đơn" FieldName="order_code" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Ngày oder" FieldName="order_createdate" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tổng xu" FieldName="order_tongxu" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Địa chỉ" FieldName="order_diachi" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tình trạng" FieldName="order_status" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="#" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <a href="javascript:void(0)" id="<%#Eval("order_id") %>" onclick="myThemChiTiet(<%#Eval("order_id") %>)">Xác nhận</a>
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
            <div>
                <%--input chứa id được chọn để thêm--%>
                <input id="txtdonhang_id" type="text" runat="server" style="display: none" />
                <%--nút thêm--%>
                <a href="javascript:void(0)" id="btnXacNhanDonHangChiTiet" type="button" runat="server" onserverclick="btnXacNhanDonHangChiTiet_ServerClick"></a>
            </div>
        </div>
    </div>
    <script>
        function myThemChiTiet(id) {
            document.getElementById("<%= txtdonhang_id.ClientID%>").value = id;
            document.getElementById("<%= btnXacNhanDonHangChiTiet.ClientID%>").click();
            //document.getElementById("btnHocSinh_" + hs_id).innerText = "Đã thêm";
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>

