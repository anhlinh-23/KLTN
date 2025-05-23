#Xây Dụng Website Bán Quần Áo - ASP.NET C#
## Giới thiệu
Đây là đồ án xây dựng website bán quần áo thời trang được thực hiện bằng ngôn ngữ  “C#”, sử dụng “ASP.NET” và công cụ phát triển “Visual Studio 2019”. Dự án hướng đến việc xây dựng một nền tảng thương mại điện tử đơn giản giúp người dùng có thể xem, đặt hàng và quản lý sản phẩm trực tuyến.
## Công nghệ sử dụng
- Ngôn ngữ: C#
- Framework: ASP.NET Web Forms / ASP.NET MVC (tùy chọn)
- IDE: Visual Studio 2019
- Cơ sở dữ liệu: SQL Server
- Giao diện: HTML, CSS, JavaScript, Bootstrap 
## Tính năng chính
- ✅ Trang chủ hiển thị sản phẩm nổi bật, tin tức
- ✅ Xem danh mục và chi tiết sản phẩm
- ✅ Chức năng tìm kiếm và lọc sản phẩm
- ✅ Đăng ký / đăng nhập tài khoản người dùng
- ✅ Thêm vào giỏ hàng và đặt hàng
- ✅ Quản lý sản phẩm và đơn hàng (Admin)
- ✅ Hẹn lịch xem hàng tại shop
## Cách chạy dự án
### Bước 1: Mở dự án
- Mở “Visual Studio 2019”
- Chọn “File → Open → Web Site”
- Trỏ đến thư mục dự án (nơi chứa các file `.aspx` và `Web.config`)
### Bước 2: Kết nối cơ sở dữ liệu
- Mở SQL Server Explorer (menu View → Server Explorer).
    Mở kết nối đến SQL Server chứa database bạn đã attach.
    Nếu chưa có kết nối, nhấn chuột phải vào Data Connections → Add Connection...
    Chọn SQL Server, đăng nhập và chọn database đã attach.
    Mở rộng danh sách Tables trong database.
    Kéo bảng (ví dụ: Products, Users, Orders...) vào vùng thiết kế của file .dbml.
- Cập nhật chuỗi kết nối trong `Web.config` nếu cần
### Bước 3: Thiết lập trang khởi động
- Trong Solution Explorer, chuột phải vào Default.aspx → Chọn View in browser
- Trình duyệt sẽ mở và hiển thị giao diện trang web
## Tài khoản mẫu
### Người dùng
- Tài khoản: linh123
- Mật khẩu: 123456
### Quản trị viên
- Tài khoản: root (admin)
- Mật khẩu: 12345
## Sinh viên thực hiện
- GVHD:  Th.s Hồ Ngọc Tú  
- Họ và tên: Trương Thuỵ Ánh Linh  
- MSV: 3120221210  
- Lớp:  21CNTT1 - Đại học Sư Phạm  



