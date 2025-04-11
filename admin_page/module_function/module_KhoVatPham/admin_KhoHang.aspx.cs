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
        var getKhoHangDistinct = (from vp in db.tbVatPhams
                                  group vp by new { vp.vatpham_name, vp.vatpham_id } into grouped
                                  select new
                                  {
                                      vatpham_name = grouped.Key.vatpham_name,
                                      soluongtongnhap = ((from v in db.tbVatPhams
                                                          join nhct in db.tbVatPham_NhapHang_ChiTiets on v.vatpham_id equals nhct.vatpham_id
                                                          where nhct.hidden == true && nhct.vatpham_id == grouped.Key.vatpham_id
                                                          select nhct.nhaphangchitiet_thanhtien).Sum()) ?? 0,
                                      soluongtongxuat = ((from v in db.tbVatPhams
                                                          join ode in db.tbOrderDetails on v.vatpham_id equals ode.vatpham_id
                                                          where ode.hidden == true && ode.vatpham_id == grouped.Key.vatpham_id
                                                          select ode.orderdetail_thanhxu).Sum()) ?? 0,
                                      soluongton = (((from v in db.tbVatPhams
                                                      join nhct in db.tbVatPham_NhapHang_ChiTiets on v.vatpham_id equals nhct.vatpham_id
                                                      where nhct.hidden == true && nhct.vatpham_id == grouped.Key.vatpham_id
                                                      select nhct.nhaphangchitiet_thanhtien).Sum()) ?? 0) - (((from v in db.tbVatPhams
                                                                                                               join ode in db.tbOrderDetails on v.vatpham_id equals ode.vatpham_id
                                                                                                               where ode.hidden == true && ode.vatpham_id == grouped.Key.vatpham_id
                                                                                                               select ode.orderdetail_thanhxu).Sum()) ?? 0)
                                  }).Distinct();
        rpKhoHang.DataSource = getKhoHangDistinct.ToList().OrderByDescending(item => item.soluongtongnhap);
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