using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_KhoVatPham_admin_DonHangCuaKhachHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    private int idchitietdonhang;
    protected void Page_Load(object sender, EventArgs e)
    {
        idchitietdonhang = Convert.ToInt32(RouteData.Values["id"]);
        //var getDonHang = (from o in db.tbOrders
        //                  join ac in db.tbAccounts on o.account_id equals ac.account_id
        //                  where o.order_id == 
        //                  select new
        //                  {
        //                      o.order_code,
        //                      o.order_createdate,
        //                      ac.account_sodienthoai,
        //                      o.order_diachi,
        //                  }).SingleOrDefault();

        var getDonHang = from us in db.tb_Users
                         join o in db.tb_Orders on us.us_id equals o.us_id
                         join od in db.tb_OrderDetails on o.order_id equals od.order_id
                         join p in db.tb_Products on od.pr_id equals p.pr_id
                         where o.order_status == "Đã xong" && od.order_id == idchitietdonhang
                         select new { 
                             us.us_phone,
                             us.us_address,
                            p.pr_name,
                            o.order_creationdate,
                            od.pr_number,
                            od.ord_id,
                            od.pr_pricecurrent
                         };
        rpVatPhamChiTiet.DataSource = getDonHang;
        rpVatPhamChiTiet.DataBind();

        // Now, calculate the total price
        decimal tongTien = 0;

        foreach (var item in getDonHang)
        {
            decimal gia;
            if (decimal.TryParse(item.pr_pricecurrent, out gia))
            {
                tongTien += gia;
            }
        }
        txtTong.InnerText = Convert.ToString(tongTien);

        //txtMaNhap.Value = getDonHang.order_code;
        txtNgayNhap.Value = getDonHang.First().order_creationdate.Value.ToString("dd-MM-yyyy").Replace(' ', 'T');
        txtSDT.Value = Convert.ToString(getDonHang.First().us_phone);
        txtDiaChi.Value = getDonHang.First().us_address;

        //var getDonHangChiTiet = (from o in db.tbOrders
        //                         join ode in db.tbOrderDetails on o.order_code equals ode.order_code
        //                         join vp in db.tbVatPhams on ode.vatpham_id equals vp.vatpham_id
        //                         where o.order_id == idchitietdonhang && ode.hidden == true
        //                         select new
        //                         {
        //                             vp.vatpham_id,
        //                             vp.vatpham_name,
        //                             ode.orderdetail_soluong,
        //                             ode.orderdetail_dongia,
        //                             ode.orderdetail_thanhxu,
        //                         });
        //decimal tongsticker = getDonHangChiTiet.Sum(x => x.orderdetail_thanhxu ?? 0);
        //txtTong.InnerText = tongsticker.ToString();
        //rpVatPhamChiTiet.DataSource = getDonHangChiTiet;
        //rpVatPhamChiTiet.DataBind();
    }

    protected void btnXacNhanDatHang_Click(object sender, EventArgs e)
    {
        idchitietdonhang = Convert.ToInt32(RouteData.Values["id"]);
        var getDuLieu = (from o in db.tbOrders where o.order_id == idchitietdonhang select o).SingleOrDefault();
        getDuLieu.order_status = "Đã thanh toán";
        db.SubmitChanges();
        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Nhập hàng thành công!', '','success').then(function(){window.location = '/admin-xuat-hang';})", true);
    }
}