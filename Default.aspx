<%@ Page Title="" Language="C#" MasterPageFile="~/Web_MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- <script src="js/script.js"></script>--%>
    <style>
        #carouselExampleInterval img {
            max-width: 79%;
            max-height: 100%;
            width: auto;
            height: auto;
            margin: auto;
        }

        .box-about-home .box-text:before {
            width: 406px;
            height: 392px;
            background-image: none;
            background-repeat: no-repeat;
            background-position: left top;
            position: absolute;
            top: 0px;
            left: calc(100% - 70px);
            content: "";
            z-index: 1;
        }

        #page {
            background-image:url('../images/logo/tranh-ve-hoa.png');
            background-position: center bottom;
            background-size: cover;
            background-attachment: fixed;
            overflow: hidden;
            margin: 0 auto;
            position: relativ;
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
    <div id="page " class="site-content">
        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="10000">
                    <img src="images/banner/xuan he2.png" class="d-block w-100 h-50" alt="...">
                </div>
                <div class="carousel-item" data-bs-interval="2000">
                    <img src="images/banner/xuan he3.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="images/banner/xuan he4.png" class="d-block w-100" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <div class="grid">
            <div class="c40 hide-on-mobile hide-on-pad hide-on-tab"></div>
            <h2 class="title-home"><a href="san-pham-noi-bat/index.html">Sản phẩm nổi bật</a></h2>
            <div class="c10"></div>
            <div></div>
            <div class="c20"></div>
            <div id="loadproducthome" style="position: relative">
                <div class="flex-container">
                    <asp:Repeater runat="server" ID="rpMenu">
                        <ItemTemplate>
                            <div class="cell-1-4 b-pro tab-cell-1-2 mobile-cell-1-2 margin-bottom-20">
                                <div>
                                    <a href="<%#Eval("link") %>">
                                        <img src="<%#Eval("pr_image") %>" width="100%" alt="<%#Eval("pr_name") %>" />
                                    </a>
                                </div>
                                <div class="product-name-home"><a href="<%#Eval("link") %>"><%#Eval("pr_name") %></a></div>
                                <div class="product-price-home"><%#Eval("pr_price") %></div>
                                <div class="c10"></div>
                                <div align="center"><a class="btn-order-c" href="javascript:void(0)" onclick="addCart(<%#Eval("pr_id") %>)">Đặt hàng</a></div>
                                <div class="c10"></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="cell-1-4 tab-cell-1-2 mobile-cell-1-2"></div>
                    <div class="cell-1-4 tab-cell-1-2 mobile-cell-1-2"></div>
                </div>
            </div>
            <div class="c40"></div>
        </div>
        <div class="box-about-home">
            <div class="c40"></div>
            <div class="c30"></div>
            <div class="grid">
                <div class="box-text">
                    <h1 class="title-about-home">AL Fashion Store</h1>
                    <div>
                        Thời trang không chỉ là trang phục, mà còn là cách bạn thể hiện phong cách và cá tính. AL Fashion Store mang đến những thiết kế tinh tế, hiện đại, tôn vinh vẻ đẹp nữ tính và sự tự tin của bạn. Mỗi sản phẩm đều được chọn lọc kỹ lưỡng, từ chất liệu đến kiểu dáng, giúp bạn luôn tỏa sáng trong mọi khoảnh khắc. Hãy cùng khám phá bộ sưu tập thời trang độc đáo tại AL Fashion Store và biến mỗi ngày trở thành một sàn diễn của riêng bạn!<br>
                        &nbsp;
                   
                        <div><strong><span style="color: #d5a34c"><span style="font-size: 18px">“Thời trang đẳng cấp – Phong cách riêng bạn!”</span></span></strong></div>
                    </div>
                </div>
            </div>
            <div class="c40"></div>
            <div class="c30"></div>
        </div>

        <div class="anh">
            <div class="c30"></div>
            <div class="grid">
                <h2 class="title-home"><a href="tin-tuc/index.html">Tin tức </a></h2>
                <div>
                    <div style="text-align: center">
                        Hãy cùng khám phá bộ sưu tập thời trang tại AL Fashion Store để cập nhật những xu hướng mới nhất và tỏa sáng với phong cách của riêng bạn.<br>
                        AL Fashion Store để cập nhật những xu hướng mới nhất
                   
                    </div>
                </div>
                <div class="c20"></div>
                <div class="flex-container">
                    <div class="cell-1-3 margin-bottom-20 tab-cell-1-2 mobile-cell-1-1">
                        <div>
                            <a href="phong-cach-rieng">
                                <img src="../images/banner/hinh1.png" alt="Mix đồ unisex – phong cách trung tính phù hợp cho mọi giới tính" class="image-news" width="100%"></a>
                        </div>
                        <h3 class="news-name"><a href="phong-cach-rieng">Phong cách theo cách riêng của bạn </a></h3>
                        <div>AL Fashion Store</div>
                    </div>
                    <div class="cell-1-3 margin-bottom-20 tab-cell-1-2 mobile-cell-1-1">
                        <div>
                            <a href="cac-outfit-goi-y">
                                <img src="../images/banner/hinh2.png" alt="Các outfit gợi ý theo dịp lễ, sự kiện đặc biệt" class="image-news" width="100%"></a>
                        </div>
                        <h3 class="news-name"><a href="cac-outfit-goi-y">Các outfit gợi ý theo dịp lễ, sự kiện đặc biệt</a></h3>
                        <div>&nbsp;</div>
                    </div>
                    <div class="cell-1-3 margin-bottom-20 tab-cell-1-2 mobile-cell-1-1">
                        <div>
                            <a href="thong-bao">
                                <img src="../images/banner/hinh3.png" alt="AL Fashion Stoer Thông Tết Nghỉ Tết 2026" class="image-news" width="100%"></a>
                        </div>
                        <h3 class="news-name"><a href="thong-bao">AL Fashion Stoer Thông Tết Nghỉ Tết 2026"</a></h3>
                        <div>&nbsp;</div>
                    </div>
                </div>
            </div>
            <div class="c30"></div>
        </div>
        <div style="display: none">
            <input type="text" id="txtId" runat="server" name="name" value="" />
            <a href="#" id="btnAdd" runat="server" onserverclick="btnAdd_ServerClick">content</a>
        </div>
        <%--<script>
            $(function () {
                $('.box-list-map .item-map:first').addClass('active');
                /*$( "#loadmap" ).html('<div class="loading">Đang tải...</div>');
                $( "#loadmap" ).load( "/index4.php?page=dailymap&id=" + $('.box-list-map .item-map:first').data('id'), function( response, status, xhr ) {
                  if ( status == "error" ) {}
                });*/

                $('.item-map').click(function () {
                    $('.box-list-map .item-map').removeClass('active');
                    $(this).addClass('active');
                    /*$( "#loadmap" ).html('<div class="loading">Đang tải...</div>');
                    $( "#loadmap" ).load( "/index4.php?page=dailymap&id=" + $(this).data('id'), function( response, status, xhr ) {
                      if ( status == "error" ) { }
                    });*/
                    return false;
                })
            })
        </script>--%>
    </div>
    <script>
        function addCart(id) {
            document.getElementById("<%=txtId.ClientID%>").value = id;
            document.getElementById("<%=btnAdd.ClientID%>").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder7" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="ContentPlaceHolder8" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="ContentPlaceHolder6" runat="Server">
</asp:Content>

