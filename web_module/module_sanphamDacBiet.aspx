<%@ Page Title="" Language="C#" MasterPageFile="~/Web_MasterPage.master" AutoEventWireup="true" CodeFile="module_sanphamDacBiet.aspx.cs" Inherits="web_module_module_BunBoChiTiet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        @media only screen and (min-width: 1000px) {
            .block {
                width: 50%;
            }
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
        <div class="grid"><a href="/">Trang chủ</a> <i class="fa fa-angle-right"></i><a href="/san-pham/">Sản phẩm</a>&nbsp;<i class="fa fa-angle-right"></i>&nbsp;<a href="/nhom-<%=_Link %>"><%=_Name %></a></div>
    </div>
    <div style="background: #FFF;" class="container">
        <div class="row">
            <div class="box-bg-product col-xs-7 col-xl-7">
                <div class="flex-container">
                    <asp:Repeater runat="server" ID="rpChiTiet">
                        <ItemTemplate>
                            <div class="cell-3-5 mobile-cell-1-1 tab-cell-1-1">
                                <img src="<%#Eval("pr_image") %>" class="img-fluid">
                            </div>
                            <div class="cell-2-5 mobile-cell-1-1 tab-cell-1-1 ">
                                <h1 class="product-detail-name"><%#Eval("pr_name") %></h1>
                                <div class="c30"></div>
                                <div>
                                    <div style="text-align: justify"><%#Eval("pr_content") %></div>
                                </div>
                                <div class="c20"></div>
                                <div class="product-quantity">Số lượng còn lại: <%# Eval("pr_soluong") %></div>
                                <div class="c20"></div>
                                <div class="price-detail">Giá: <%#Eval("pr_price") %>₫</div>
                                <div class="c20"></div>
                                <div class="size-selection">
                                    <span>Chọn Size:</span>
                                    <input type="radio" id="sizeS" name="product_size" value="S" />
                                    <label for="sizeS">S</label>
                                    <input type="radio" id="sizeM" name="product_size" value="M" checked="checked" />
                                    <label for="sizeM">M</label>
                                    <input type="radio" id="sizeL" name="product_size" value="L" />
                                    <label for="sizeL">L</label>
                                    <input type="radio" id="sizeXL" name="product_size" value="XL" />
                                    <label for="sizeXL">XL</label>
                                </div>
                                <div class="c20"></div>
                                <div class="quantity-input-section" style="margin-bottom: 10px; display: flex; align-items: center;">
                                    <label for='quantity_<%# Eval("pr_id") %>' style="margin-right: 10px; font-weight: bold;">Số lượng:</label>
                                    <input type="number" class="product-quantity-input" id='quantity_<%# Eval("pr_id") %>' value="1" min="1" max='<%# Eval("pr_soluong") %>' style="width: 70px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center;" />
                                </div>
                                <div class="c20"></div>
                                <a href="javascript:void(0)" class="btn-order-detail"
                                   onclick='<%# Eval("pr_status") != null && Eval("pr_status").ToString() == "Hết" ? "" : "addCart(" + Eval("pr_id") + ")" %>'
                                   style='<%# Eval("pr_status") != null && Eval("pr_status").ToString() == "Hết" ? "pointer-events:none;opacity:0.5;cursor:not-allowed;" : "" %>'>
                                    <%# Eval("pr_status") != null && Eval("pr_status").ToString() == "Hết" ? "Hết hàng" : "Đặt hàng ngay" %>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                </div>
            </div>
            <div class="content-text col-xs-5 col-xl-5">
                <h2 class="title-product-info">Thông tin sản phẩm</h2>
                <div>
                    <div style="text-align: justify">
                        <%=_Info %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <br />
    <div style="display: none">
            <input type="text" id="txtId" runat="server" name="name" value="" />
            <asp:HiddenField ID="txtQuantity" runat="server" />
            <a href="#" id="btnAdd" runat="server" onserverclick="btnAdd_ServerClick">content</a>
        </div>
    <script>
        function addCart(id) {
            var quantityInput = document.querySelector('.product-quantity-input');
            var quantity = quantityInput.value;
            var maxQuantity = parseInt(quantityInput.max) || Infinity;
            var minQuantity = parseInt(quantityInput.min) || 1;
            var parsedQuantity = parseInt(quantity);

            if (isNaN(parsedQuantity) || parsedQuantity < minQuantity) {
                alert('Số lượng không hợp lệ. Vui lòng nhập một số lớn hơn hoặc bằng ' + minQuantity + '.');
                quantityInput.focus();
                return;
            }
            if (parsedQuantity > maxQuantity) {
                alert('Số lượng yêu cầu vượt quá số hàng còn lại (' + maxQuantity + '). Vui lòng nhập số lượng nhỏ hơn.');
                quantityInput.focus();
                return;
            }

            document.getElementById("<%=txtId.ClientID%>").value = id;
            document.getElementById("<%=txtQuantity.ClientID%>").value = parsedQuantity;
            document.getElementById("<%=btnAdd.ClientID%>").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder6" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder7" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder8" runat="Server">
</asp:Content>

