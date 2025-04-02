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
        .new-list{
             display: flex;
            justify-content: space-evenly;
        }
        .footer-list{
             display: flex;
            justify-content: space-evenly;
        }
        {
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial,sans-serif;
        }
        body{
            text-align:center;
            background-color: #fff;

        }
        header{
              display: flex;
            justify-content: space-between;
            align-items:center;
            padding:20px;
        }
        nav ul{
            list-style:none;
            display:flex;
        }
        nanv ul li{
            margin: 0 15px;
        }
        nanv ul li a{
            text-decoration:none;
            color:blue;
        }
        .banner {
            width :100%;
            max-height: 300px;
            object-fit:cover;
        }
        .product,.about, .new{
            padding: 40px 20px;
        }
        .product-list, .new-list{
            display : flex;
            justify-content:center;
            gap:20px;
        }
        .product, .new-item{
            background: #ffffff;
            padding: 20px;
            width: 150px;
            text-align :center;
            border-radius:5px;

        }
        footer{
            background:#000000;
            color:white;
            padding:20px;
            margin-top:20px;
        }
        .product img{
            max-width:100%;
            height:auto;
        }
        .logo img{
            height:60px;
        }
    </style>
</head>s
<body>
    <header>
        <div class="logo"></div>
        <nav>
            <ul>
                <li><a href="#">Tranng chủ</a></li>
                 <li><a href="#">Giới thiệu</a></li>
                 <li><a href="#">Sản phẩm</a></li>
                 <li><a href="#">Tin tức</a></li>
                 <li><a href="#">Giỏ hàng</a></li>
            </ul>
        </nav>
    </header>
    <section class="banner">
    </section>
    <section class="products">
        <h2>Sản phẩm mới nhất</h2>
        <div class="product-list">
            <div class="product">Sản phẩm 1</div>
             <div class="product">Sản phẩm 2</div>
             <div class="product">Sản phẩm 3</div>
             <div class="product">Sản phẩm 4</div>
        </div>
    </section>
    <section class="about">
        <h2> AL Fashion Store</h2>
        <p>Giới thiệu về cửa hàng thời trang</p>
    </section>
    <section class="news">
        <h2>Tin tức</h2>
        <div class="new-list">
            <div class="new-item">Bài viết 1</div>
             <div class="new-item">Bài viết 2</div>
             <div class="new-item">Bài viết 3</div>
        </div>
    </section>
    <footer>
        <div class="contact">Thông tin liên hệ</div>
         <div class="contact">Mạng xã hội</div>
    </footer>
</body>
</html>
