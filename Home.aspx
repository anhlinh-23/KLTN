<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
    </title>
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


    <style>
 
        .product-list{
                display: flex;
    justify-content: space-evenly;
}
        .news-list{  display: flex;
    justify-content: space-evenly;

        }
        .footer-list{
  display: flex;
    justify-content: space-evenly;
        }
        {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            text-align: center;
            background-color: #fff;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }
        nav ul {
            list-style: none;
            display: flex;
        }
        nav ul li {
            margin: 0 15px;
        }
        nav ul li a {
            text-decoration: none;
            color: blue;
        }
        .banner img {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
        }
        .products, .about, .news {
            padding: 40px 20px;
        }
        .product-list, .news-list {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .product, .news-item {
            background: #f8f8f8;
            padding: 20px;
            width: 150px;
            text-align: center;
            border-radius: 5px;
        }
        footer {
            background: #333;
            color: #fff;
            padding: 20px;
            margin-top: 20px;
        }
        .product img {
    max-width: 100%; /* Đảm bảo hình ảnh không vượt quá kích thước container */
    height: auto; /* Duy trì tỷ lệ khung hình */
}

.logo img {
    height: 60px;
}
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">
            
        <img src="images/logo/logo1.png" />
           </div>

        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li><a href="#">Trang Chủ</a></li>
                <li><a href="#">Giới Thiệu</a></li>
                <li><a href="#">Sản Phẩm</a></li>
                <li><a href="#">Tin Tức</a></li>
                <li><a href="#">Giỏ Hàng</a></li>
            </ul>
        </nav>
    </header>
    
    <!-- Banner chính -->
    <section class="banner">
           
<img src="images/banner/xuan%20he3.png" />
    </section>
    
    <!-- Sản phẩm mới nhất -->
    <section class="products">
        <h2>Sản phẩm mới nhất</h2>
        <div class="product-list">
            <div class="product">
<img src="uploadimages/áo%20sơ%20mi%20Hàn%20Quốc%20nữ%20trẻ%20trung.png" alt="Sản phẩm 1" width="100"/>
                <p>Sản phẩm 1</p></div>
            <div class="product">
    <img src="uploadimages/aocotron.png" alt="Sản phẩm 2" width="100" />
               <p>Sản phẩm 2</p></div>
            <div class="product">
<img src="uploadimages/vay2day.png" alt="Sản phẩm 2" width="100"/>
                <p>Sản phẩm 3</p></div>
            <div class="product">Sản phẩm 4</div>
            <div class="product">Sản phẩm 5</div>
        </div>
    </section>
    
    <!-- Giới thiệu -->
    <section class="about">
        <h2>AL Fashion Store</h2>
        <p>Giới thiệu về cửa hàng thời trang.</p>
    </section>
    
    <!-- Tin tức -->
    <section class="news">
        <h2>Tin tức</h2>
        <div class="news-list">
            <div class="news-item">Bài viết 1</div>
            <div class="news-item">Bài viết 2</div>
            <div class="news-item">Bài viết 3</div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="footer-list">
        <div class="contact">Thông tin liên hệ</div>
        <div class="social">Mạng xã hội</div>
        <div class="social">Tin tức nổi bật</div>
            </div>
    </footer>
</body>
</html>
