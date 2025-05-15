using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        var getMenu1 = (from pr in db.tb_Products
                        where pr.cate_id == 1
                        orderby pr.pr_id descending
                        select pr).Take(1);
        var getMenu2 = (from pr in db.tb_Products
                        where pr.cate_id == 1
                        orderby pr.pr_id descending
                        select pr).Take(1);
        getMenu2 = getMenu2.Union(getMenu1);
        var getMenu3 = (from pr in db.tb_Products
                        where pr.cate_id == 3
                        orderby pr.pr_id descending
                        select pr).Take(2);
        getMenu3 = getMenu3.Union(getMenu2);
        var getMenu4 = (from pr in db.tb_Products
                        where pr.cate_id == 4
                        orderby pr.pr_id descending
                        select pr).Take(1);
        var listProduct = getMenu4.Union(getMenu3).Select(x => new {
            x.pr_id,
            x.pr_name,
            x.pr_price,
            x.pr_image,
            x.link,
            pr_soluong = (
                (from sl in db.tbVatPham_NhapHang_ChiTiets
                 where sl.vatpham_id == x.pr_id
                 select sl.nhaphangchitiet_soluong).Sum() ?? 0
            ) - (
                (from od in db.tb_OrderDetails
                 join o in db.tb_Orders on od.order_id equals o.order_id
                 where od.pr_id == x.pr_id && o.order_status == "Đã xong"
                 select (int?)od.pr_number).Sum() ?? 0
            )
        });
        rpMenu.DataSource = listProduct;
        rpMenu.DataBind();
    }

    protected void btnAdd_ServerClick(object sender, EventArgs e)
    {
        if (Request.Cookies["User"] == null)
        {
            Response.Redirect("/login");
        }
        else
        {
            int productId = Convert.ToInt32(txtId.Value);

            // Tính tồn kho thực tế
            int tongNhap = (from sl in db.tbVatPham_NhapHang_ChiTiets
                            where sl.vatpham_id == productId
                            select sl.nhaphangchitiet_soluong).Sum() ?? 0;
            int tongBan = (from od in db.tb_OrderDetails
                           join o in db.tb_Orders on od.order_id equals o.order_id
                           where od.pr_id == productId && o.order_status == "Đã xong"
                           select (int?)od.pr_number).Sum() ?? 0;
            int tonKho = tongNhap - tongBan;

            if (tonKho <= 0)
            {
                // Hết hàng, không cho thêm vào giỏ
                Response.Redirect("/het-hang"); // hoặc hiện alert, hoặc quay lại trang cũ
                return;
            }

            cls_Cart _cart = new cls_Cart
            {
                id = productId,
                number = 1,
                name = (from pr in db.tb_Products
                        where pr.pr_id == productId
                        select pr).FirstOrDefault().pr_name,
                image = (from pr in db.tb_Products
                         where pr.pr_id == productId
                         select pr).FirstOrDefault().pr_image,
                total = Convert.ToInt32((from pr in db.tb_Products
                                         where pr.pr_id == productId
                                         select pr).FirstOrDefault().pr_price),
                price = Convert.ToInt32((from pr in db.tb_Products
                                         where pr.pr_id == productId
                                         select pr).FirstOrDefault().pr_price),
            };
            List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];
            cart.Add(_cart);
            Session["Cart"] = cart;
            Response.Redirect("/gio-hang");
        }
    }
}