<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="admin_DonHangCuaKhachHang.aspx.cs" Inherits="admin_page_module_function_module_KhoVatPham_admin_DonHangCuaKhachHang" %>

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
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Chi tiết đơn hàng</h3>
            <div class="form-group table-responsive row" style="display: flex">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <%--input chứa id được chọn để thêm--%>
                        <input id="txtvatpham_id" type="text" runat="server" style="display: none" />
                        <%--nút thêm--%>
                      <%--  <a href="javascript:void(0)" id="btnMuaVatPham" type="button" runat="server" onserverclick="btnMuaVatPham_ServerClick"></a>--%>
                        <div class="col-12">
                            <div class="row">
                              <%--  <div class="col-2 form-group">
                                    <label class="form-control-label">Mã Nhập:</label>
                                    <input type="text" id="txtMaNhap" runat="server" class="form-control" disabled="disabled" />
                                </div>--%>
                                <div class="col-2 form-group">
                                    <label class="form-control-label">Ngày mua:</label>
                                    <input type="datetime" id="txtNgayNhap" runat="server" class="form-control" disabled="disabled" style="width: 92%;" />
                                </div>
                                <div class="col-3 form-group">
                                    <label class="col-12 form-control-label">SĐT người order:</label>
                                    <div class="col-md-12">
                                        <input id="txtSDT" type="text" runat="server"  value="" style="width: 100px" />
                                       <%-- <asp:DropDownList ID="ddlNguoiMuaHang" CssClass="form-control" runat="server"></asp:DropDownList>--%>
                                    </div>
                                </div>
                                <div class="col-5 form-group">
                                    <label class="col-12 form-control-label">Địa chỉ:</label>
                                    <div class="col-md-12">
                                        <input id="txtDiaChi" runat="server" type="text" value="" style="width: 100%;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-hover table_content">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th scope="col">Tên vật phẩm</th>
                                    <th scope="col">Số lượng</th>
                                  <th scope="col">Tổng tiền</th>
                                     <%-- <th scope="col">Tổng sticker</th>--%>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rpVatPhamChiTiet">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#Container.ItemIndex+1 %></td>
                                            <td>
                                                <%#Eval("pr_name") %>
                                            </td>
                                            <td>
                                                <label id="SoLuong<%#Eval("ord_id") %>">
                                                    <%#Eval("pr_number") %>
                                                </label>
                                                <%--<input id="SoLuong<%#Eval("vatpham_id") %>" type="text" onchange="myUpdate(<%#Eval("vatpham_id") %>)" onkeypress="return onlyNumberKey(event)" value="<%#Eval("orderDetail_quanlity") %>" />--%>
                                            </td>
                                           <td>
                                                <label id="DonGia<%#Eval("ord_id") %>">
                                                    <%#Eval("pr_pricecurrent") %>
                                                </label>
                                            </td>
                                             <%--<td>
                                                <label id="ThanhTien<%#Eval("vatpham_id") %>">
                                                    <%#Eval("orderdetail_thanhxu") %>
                                                </label>
                                            </td>--%>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3"></td>
                                    <!-- Ô trống để cân chỉnh vị trí -->
                                    <td>
                                        <span>Tổng:</span>
                                        <label id="txtTong" runat="server">
                                            <%#Eval("pr_pricecurrent") %>
                                        </label>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="modal-footer">
                           <%-- <asp:Button ID="btnXacNhanDatHang" runat="server" Text="Xác nhận đặt hàng" CssClass="btn btn-primary" OnClick="btnXacNhanDatHang_Click" />--%>
                            <a href="/admin-xuat-hang" class="btn btn-primary">Quay lại</a>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
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

