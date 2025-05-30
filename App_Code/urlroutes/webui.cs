﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for webui
/// </summary>
public class webui
{
    public webui()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public List<string> UrlRoutes()
    {
        List<string> list = new List<string>();
        list.Add("webTrangChu|trang-chu|~/Default.aspx");
        //Login 
        list.Add("webLogin|login|~/web_module/module_Login.aspx");
        //Register
        list.Add("webRegister|dang-ky|~/web_module/module_Register.aspx");
        //Giơi thiệu
        list.Add("webGioiThieu|gioi-thieu|~/web_module/module_GioiThieu.aspx");
     
        //menu
        list.Add("webmenu|Menu|~/web_module/module_Tatcasanpham.aspx");
        list.Add("webthucdon|nhom-{url-nhom-san-pham}|~/web_module/module_Sanpham.aspx");
        list.Add("webthucdonmon|mon-{url-san-pham}|~/web_module/module_sanphamDacBiet.aspx");
        //blog
        list.Add("webBlog|blog|~/web_module/module_Blog.aspx");
        list.Add("webBlog1|phong-cach-rieng|~/web_module/module_baiviet1.aspx");
        list.Add("webBlog2|cac-outfit-goi-y|~/web_module/module_baiviet2.aspx");
        list.Add("webBlog3|thong-bao|~/web_module/module_baiviet3.aspx");
        //liên hệ 
        list.Add("webLienHe|lien-he|~/web_module/module_LienHe.aspx");
        //đặt hàng 
        list.Add("webdatban|dat-ban|~/web_module/module_Dathang.aspx");
        //giỏ hàng
        list.Add("webgiohang|gio-hang|~/web_module/module_GioHang.aspx");
        //thanh toán
        list.Add("webthanhtoan|thanh-toan|~/web_module/module_ThanhToan.aspx");
        //vnpay return
        list.Add("webvnpayreturn|vnpay_return|~/web_module/vnpay_return.aspx");
        //bai viết
        list.Add("webBaiViet|bai-viet|~/web_module/module_BaiViet.aspx");
        

        return list;

    }
}