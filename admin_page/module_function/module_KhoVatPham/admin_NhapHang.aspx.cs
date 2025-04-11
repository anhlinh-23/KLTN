using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_KhoVatPham_admin_NhapHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    private int _id;
    protected void Page_Load(object sender, EventArgs e)
    {
        Load();
    }
    public void Load()
    {
        var getVatPham = from nh in db.tbVatPham_NhapHangs
                         join u in db.admin_Users on nh.username_id equals u.username_id
                         orderby nh.nhaphang_id descending
                         select new
                         {
                             nh.nhaphang_id,
                             nh.nhaphang_code,
                             nh.nhaphang_createdate,
                             u.username_fullname,
                             nh.nhaphang_tongtien,
                         };
        grvNhapHang.DataSource = getVatPham;
        grvNhapHang.DataBind();
    }

    protected void btnThem_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin-them-nhap-hang-" + 0);
    }

    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvNhapHang.GetRowValues(grvNhapHang.FocusedRowIndex, new string[] { "nhaphang_id" }));
        Response.Redirect("/admin-them-nhap-hang-" + _id);
    }
}