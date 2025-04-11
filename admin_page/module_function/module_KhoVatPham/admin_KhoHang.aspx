<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="admin_KhoHang.aspx.cs" Inherits="admin_page_module_function_module_KhoVatPham_admin_KhoHang" %>

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
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Danh sách kho hàng</h3>
            <asp:UpdatePanel ID="udButton" runat="server">
                <ContentTemplate>
                    <asp:Button ID="btnNhapHang" runat="server" Text="Nhập hàng" CssClass="btn btn-primary" OnClick="btnNhapHang_Click" />
                    <asp:Button ID="btnXuatHang" runat="server" Text="Xuất hàng" CssClass="btn btn-primary" OnClick="btnXuatHang_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <table class="table table-bordered table-hover table_content">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th scope="col">Tên vật phẩm</th>
                        <th scope="col">Số lượng tồn</th>
                        <th scope="col">Tổng nhập</th>
                        <th scope="col">Tổng xuất</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="rpKhoHang">
                        <ItemTemplate>
                            <tr>
                                <td><%#Container.ItemIndex+1 %></td>
                                <td>
                                    <%#Eval("vatpham_name") %>
                                </td>
                                <td>
                                   <%-- sử dụng biểu thức ba ngôi trong string.Format để nếu nó là 0 thì vẫn hiện 0--%>
                                    <%# (Convert.ToInt32(Eval("soluongton")) == 0) ? "0" : string.Format("{0:#,###}", Convert.ToInt32(Eval("soluongton"))) %>
                                    <%--<%# string.Format("{0:#,###}", Convert.ToInt32(Eval("soluongton"))) %>--%>
                                    <%-- <%#Eval("soluongton") %>--%>
                                </td>
                                <td>
                                    <%# (Convert.ToInt32(Eval("soluongtongnhap")) == 0) ? "0" : string.Format("{0:#,###}", Convert.ToInt32(Eval("soluongtongnhap"))) %>
                                </td>
                                <td>
                                    <%# (Convert.ToInt32(Eval("soluongtongxuat")) == 0) ? "0" : string.Format("{0:#,###}", Convert.ToInt32(Eval("soluongtongxuat"))) %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>


