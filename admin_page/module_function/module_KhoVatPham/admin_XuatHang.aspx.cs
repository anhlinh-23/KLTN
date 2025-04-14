using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_KhoVatPham_admin_XuatHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    private int _id;
    protected void Page_Load(object sender, EventArgs e)
    {
        //var getXuatHang = from o in db.tbOrders
        //                  join ac in db.tbAccounts on o.account_id equals ac.account_id
        //                  orderby o.order_id descending
        //                  select new
        //                  {
        //                      o.order_code,
        //                      o.order_createdate,
        //                      o.order_tongxu,
        //                      o.order_status,
        //                      o.order_diachi,
        //                      o.order_id,
        //                      ac.account_sodienthoai,
        //                  };
        var getXuatHang = from us in db.tb_Users
                          join od in db.tb_Orders on us.us_id equals od.us_id
                          where od.order_status == "Đã xong"
                          orderby od.order_id descending
                          select new
                          {
                              od.order_id,
                              us.us_name,
                              us.us_phone,
                              us.us_email,
                              us.us_address,
                              od.order_status,
                              od.order_creationdate,
                              order_total = od.order_total + " vnđ",
                              tongsl = (from ode in db.tb_OrderDetails
                                        where ode.order_id == od.order_id
                                        select ode.pr_number).Sum(),
                          };
        grvXuatHang.DataSource = getXuatHang;
        grvXuatHang.DataBind();
    }
    //protected void btnOder_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("/admin-don-hang-cua-admin");
    //}

    protected void btnXemOder_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvXuatHang.GetRowValues(grvXuatHang.FocusedRowIndex, new string[] { "order_id" }));
        Response.Redirect("/admin-don-hang-cua-khach-hang-" + _id);
    }

    protected void btnXacNhanDonHangChiTiet_ServerClick(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvXuatHang.GetRowValues(grvXuatHang.FocusedRowIndex, new string[] { "order_id" }));
        var getDuLieu = (from o in db.tbOrders where o.order_id == _id select o).SingleOrDefault();
        getDuLieu.order_status = "Đã thanh toán";
        db.SubmitChanges();
        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Nhập hàng thành công!', '','success').then(function(){window.location = '/admin-xuat-hang';})", true);
    }
}