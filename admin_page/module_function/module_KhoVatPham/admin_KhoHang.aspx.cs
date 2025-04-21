using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_KhoVatPham_admin_KhoHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        Load();
    }
    public void Load()
    {
        //var getKhoHangDistinct = (from vp in db.tbVatPhams
        //                          group vp by new { vp.vatpham_name, vp.vatpham_id } into grouped
        //                          select new
        //                          {
        //                              vatpham_name = grouped.Key.vatpham_name,
        //                              soluongtongnhap = ((from v in db.tbVatPhams
        //                                                  join nhct in db.tbVatPham_NhapHang_ChiTiets on v.vatpham_id equals nhct.vatpham_id
        //                                                  where nhct.hidden == true && nhct.vatpham_id == grouped.Key.vatpham_id
        //                                                  select nhct.nhaphangchitiet_thanhtien).Sum()) ?? 0,
        //                              soluongtongxuat = ((from v in db.tbVatPhams
        //                                                  join ode in db.tbOrderDetails on v.vatpham_id equals ode.vatpham_id
        //                                                  where ode.hidden == true && ode.vatpham_id == grouped.Key.vatpham_id
        //                                                  select ode.orderdetail_thanhxu).Sum()) ?? 0,
        //                              soluongton = (((from v in db.tbVatPhams
        //                                              join nhct in db.tbVatPham_NhapHang_ChiTiets on v.vatpham_id equals nhct.vatpham_id
        //                                              where nhct.hidden == true && nhct.vatpham_id == grouped.Key.vatpham_id
        //                                              select nhct.nhaphangchitiet_thanhtien).Sum()) ?? 0) - (((from v in db.tbVatPhams
        //                                                                                                       join ode in db.tbOrderDetails on v.vatpham_id equals ode.vatpham_id
        //                                                                                                       where ode.hidden == true && ode.vatpham_id == grouped.Key.vatpham_id
        //                                                                                                       select ode.orderdetail_thanhxu).Sum()) ?? 0)
        //                          }).Distinct();
        //rpKhoHang.DataSource = getKhoHangDistinct.ToList().OrderByDescending(item => item.soluongtongnhap);
        //rpKhoHang.DataBind();
        var gẹtKhoHangDistinct = from vpcc in db.tbVatPham_NhapHang_ChiTiets
                                 join p in db.tb_Products on vpcc.vatpham_id equals p.pr_id
                                 group new { vpcc, p.pr_name } by vpcc.vatpham_id into grouped
                                 select new
                                 {
                                     vatpham_id = grouped.Key,
                                     pr_name = grouped.Select(g => g.pr_name).FirstOrDefault(),

                                     // Tổng số lượng nhập của cùng 1 vật phẩm
                                     nhaphangchitiet_soluong = grouped.Sum(g => g.vpcc.nhaphangchitiet_soluong),

                                     // Tổng số lượng đã xuất
                                     soluongtongxuat = (from o in db.tb_Orders
                                                        join od in db.tb_OrderDetails on o.order_id equals od.order_id
                                                        where o.order_status == "Đã xong" && od.pr_id == grouped.Key
                                                        select (int?)od.pr_number).Sum() ?? 0,

                                     // Tính tồn kho = tổng nhập - tổng xuất
                                     soluongton = grouped.Sum(g => g.vpcc.nhaphangchitiet_soluong)
                                                    -
                                                    ((from o in db.tb_Orders
                                                      join od in db.tb_OrderDetails on o.order_id equals od.order_id
                                                      where o.order_status == "Đã xong" && od.pr_id == grouped.Key
                                                      select (int?)od.pr_number).Sum() ?? 0)
                                 };

        rpKhoHang.DataSource = gẹtKhoHangDistinct.ToList().OrderByDescending(item => item.nhaphangchitiet_soluong);
        rpKhoHang.DataBind();
    }
    protected void btnNhapHang_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin-nhap-hang");
    }

    protected void btnXuatHang_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin-xuat-hang");
    }
}