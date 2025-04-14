<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="admin_ThemNhapHang.aspx.cs" Inherits="admin_page_module_function_module_KhoVatPham_admin_ThemNhapHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="hibodyhead" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hibodywrapper" runat="Server">
    <style>
        /* Thiết lập kích thước cho input */
        .table_content tbody input[type="text"] {
            width: 70px; /* Đặt kích thước mong muốn, ví dụ 70px */
        }
    </style>
    <script>
        function checkNULL() {
            var TenNguoiNhap = document.getElementById('<%= ddlNguoiNhapHang.ClientID%>');
            if (TenNguoiNhap.value.trim() === "" || TenNguoiNhap.selectedIndex === 0) {
                swal('Tên người nhập không được để trống!', '', 'warning').then(function () { TenNguoiNhap.focus(); });
                return false;
            }
        }
        function confirmDel(id) {
            swal("Bạn có thực sự muốn xóa?",
                "Nếu xóa, dữ liệu sẽ không thể khôi phục.",
                "warning",
                {
                    buttons: true,
                    dangerMode: true
                }).then(function (value) {
                    if (value == true) {
                        document.getElementById("<%= txt_ID.ClientID%>").value = id;
                        var xoa = document.getElementById("<%= btnXoa.ClientID%>");
                        xoa.click();
                    }
                });
        }
    </script>
    <div class="card">
        <div class="container-fluid">
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Thêm chi tiết vật phẩm</h3>
            <div class="form-group table-responsive row" style="display: flex">
                <div class="col-4">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <dx:ASPxGridView ID="grvThemVatPham" runat="server" ClientInstanceName="grvList" KeyFieldName="pr_id" Width="90%">
                                <Columns>
                                    <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataColumn Caption="Tên sản phẩm" FieldName="pr_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="#" HeaderStyle-HorizontalAlign="Center" Width="0%">
                                        <DataItemTemplate>
                                            <a href="javascript:void(0)" id="<%#Eval("pr_id") %>" onclick="myThemChiTiet(<%#Eval("pr_id") %>)">Thêm</a>
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col-8">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <%--input chứa id được chọn để thêm--%>
                            <input id="txtvatpham_id" type="text" runat="server" style="display: none" />
                            <%--nút thêm--%>
                            <a href="javascript:void(0)" id="btnVatPhamChiTiet" type="button" runat="server" onserverclick="btnVatPhamChiTiet_ServerClick"></a>
                            <div class="col-12">
                                <div class="row">
                                    <div class="col-3 form-group">
                                        <label class="form-control-label">Mã Nhập:</label>
                                        <input type="text" id="txtMaNhap" runat="server" class="form-control" disabled="disabled" />
                                    </div>
                                    <div class="col-3 form-group">
                                        <label class="form-control-label">Ngày Nhập:</label>
                                        <input type="datetime" id="txtNgayNhap" runat="server" class="form-control" disabled="disabled" />
                                    </div>
                                    <div class="col-3 form-group">
                                        <label class="form-control-label">Người nhập:</label>
                                        <asp:DropDownList ID="ddlNguoiNhapHang" CssClass="form-control" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover table_content">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th scope="col">Tên vật phẩm</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Đơn giá</th>
                                        <th scope="col">Thành tiền</th>
                                        <th scope="col">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater runat="server" ID="rpVatPhamChiTiet">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%#Container.ItemIndex+1 %></td>
                                                <td>
                                                    <%#Eval("vatpham_name") %>
                                                </td>
                                                <td>
                                                    <input id="SoLuong<%#Eval("vatpham_id") %>" type="text" onchange="myUpdate(<%#Eval("vatpham_id") %>)" onkeyup="formatCurrency(this)" onkeypress="return onlyNumberKey(event)" value="<%# string.Format("{0:#,###}", Convert.ToInt32(Eval("nhaphangchitiet_soluong"))) %>" style="width: 85px" />
                                                </td>
                                                <td>
                                                    <input id="DonGia<%#Eval("vatpham_id") %>" type="text" onchange="myUpdate(<%#Eval("vatpham_id") %>)" onkeyup="formatCurrency(this)" onkeypress="return onlyNumberKey(event)" value="<%# string.Format("{0:#,###}", Convert.ToInt32(Eval("nhaphangchitiet_dongia"))) %>" style="width: 85px" />

                                                    <%--<input id="DonGia<%#Eval("vatpham_id") %>" type="text" onchange="myUpdate(<%#Eval("vatpham_id") %>)" onkeypress="return onlyNumberKey(event)" value="<%#Eval("nhaphangchitiet_dongia") %>" />--%>
                                                </td>
                                                <td>
                                                    <label id="ThanhTien<%#Eval("vatpham_id") %>">
                                                        <%# string.Format("{0:#,###}", Convert.ToInt32(Eval("nhaphangchitiet_thanhtien"))) %>
                                                    </label>
                                                </td>
                                                <td class="text-center">
                                                    <a href="javascript:void(0)" class="btn btn-success" id="btnXoa<%#Eval("vatpham_id") %>" onclick="confirmDel(<%#Eval("vatpham_id") %>)"><i class="fa fa-trash"></i></a>
                                                </td>
                                            </tr>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4"></td>
                                        <!-- Ô trống để cân chỉnh vị trí -->
                                        <td>
                                            <span>Tổng tiền:</span>
                                            <label id="txtTongTien" runat="server">
                                            </label>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                            <div class="modal-footer">
                                <asp:Button ID="btnLuu" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkNULL()" OnClick="btnLuu_Click" />
                                <a href="/admin-nhap-hang" class="btn btn-primary">Quay lại</a>
                            </div>
                            <div>
                                <input id="txt_ID" type="text" runat="server" />
                                <input id="txt_SoLuong" type="text" runat="server" />
                                <input id="txt_DonGia" type="text" runat="server" />
                                <input id="txt_ThanhTien" type="text" runat="server" />
                                <a href="javascript:void(0)" id="NhapHangChiTiet" type="button" runat="server" onserverclick="NhapHangChiTiet_ServerClick">Update</a>
                                <%--nút xóa--%>
                                <a href="javascript:void(0)" id="btnXoa" type="button" runat="server" onserverclick="btnXoa_ServerClick">Xóa</a>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <script>
        function formatCurrency(input) {
            let value = input.value.replace(/[^0-9]/g, ''); // Lấy chỉ số và loại bỏ các ký tự không phải số

            if (value.length > 3 && value.length <= 6) {
                input.value = value.slice(0, -3).replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '.' + value.slice(-3);
            } else if (value.length > 6) {
                input.value = value.slice(0, -6).replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '.' + value.slice(-6, -3) + '.' + value.slice(-3);
            } else {
                input.value = value; // Giữ nguyên giá trị nếu không đủ số để định dạng
            }
            // Lấy giá trị đã được định dạng mà không có dấu chấm
            //value = input.value.replace(/\./g, '');
            //console.log(input.value);
        }


        function myThemChiTiet(id) {
            document.getElementById("<%= txtvatpham_id.ClientID%>").value = id;
            document.getElementById("<%= btnVatPhamChiTiet.ClientID%>").click();
            //document.getElementById("btnHocSinh_" + hs_id).innerText = "Đã thêm";
        }
        function myHideLoading() {
            $("#img-loading-icon").hide();
        }
        function onlyNumberKey(evt) {
            // Lấy mã ASCII của ký tự được nhập vào
            var ASCIICode = (evt.which) ? evt.which : event.keyCode;
            // Kiểm tra nếu ký tự không phải là số hoặc không phải các phím điều khiển (control keys)
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) {
                return false;
            }
            return true;
        }
        function myUpdate(id) {
            //alert("Giá trị đã thay đổi!");
            //lấy id của số lượng và đơn giá
            var SoLuong = document.getElementById("SoLuong" + id).value;
            SoLuong = SoLuong.replace(/\./g, '');
            var DonGia = document.getElementById("DonGia" + id).value;
            DonGia = DonGia.replace(/\./g, '');
            console.log("don gia" + DonGia);
            document.getElementById("ThanhTien" + id).value = SoLuong * DonGia;
            //gán vào lại input để gọi qua server
            document.getElementById("<%= txt_ID.ClientID%>").value = id;
            document.getElementById("<%= txt_SoLuong.ClientID%>").value = SoLuong;
            document.getElementById("<%= txt_DonGia.ClientID%>").value = DonGia;
            document.getElementById("<%= txt_ThanhTien.ClientID%>").value = parseInt(SoLuong) * parseInt(DonGia);
            console.log(document.getElementById("<%= txt_ThanhTien.ClientID%>").value = parseInt(SoLuong) * parseInt(DonGia));
            document.getElementById("<%= NhapHangChiTiet.ClientID%>").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>
