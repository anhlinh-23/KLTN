using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_BunBoChiTiet : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public string _Name, _Info, _Link;
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = RouteData.Values["url-san-pham"].ToString();
        var getData = from pr in db.tb_Products
                      where pr.link == url
                      select new
                      {
                          pr.pr_id,
                          pr.pr_name,
                          pr.pr_price,
                          pr.pr_image,
                          pr.pr_content,
                          pr.link,
                          pr.pr_information,
                          pr.cate_id,
                          pr.pr_status,
                          pr_soluong = (
                              (from sl in db.tbVatPham_NhapHang_ChiTiets
                               where sl.vatpham_id == pr.pr_id
                               select sl.nhaphangchitiet_soluong).Sum() ?? 0
                          ) - (
                              (from od in db.tb_OrderDetails
                               join o in db.tb_Orders on od.order_id equals o.order_id
                               where od.pr_id == pr.pr_id && o.order_status == "Đã xong"
                               select (int?)od.pr_number).Sum() ?? 0
                          )
                      };
        rpChiTiet.DataSource = getData;
        rpChiTiet.DataBind();
        var getCate = (from cate in db.tb_Categories
                       where cate.cate_id == getData.FirstOrDefault().cate_id
                       select cate).FirstOrDefault();
        _Name = getCate.cate_name;
        _Info = getData.FirstOrDefault().pr_information;
        _Link = getCate.link;
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
            int requestedQuantity;

            if (!int.TryParse(txtQuantity.Value, out requestedQuantity) || requestedQuantity < 1)
            {
                // Handle invalid quantity format or less than 1
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Số lượng không hợp lệ.');", true);
                return;
            }

            var product = (from pr in db.tb_Products
                           where pr.pr_id == productId
                           select new
                           {
                               pr.pr_name,
                               pr.pr_image,
                               pr.pr_price,
                               pr_soluong = (from sl in db.tbVatPham_NhapHang_ChiTiets
                                             where sl.vatpham_id == pr.pr_id
                                             select sl.nhaphangchitiet_soluong).Sum() ?? 0
                           }).FirstOrDefault();

            if (product == null)
            {
                // Handle product not found (though unlikely if id comes from the page)
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Sản phẩm không tìm thấy.');", true);
                return;
            }

            List<cls_Cart> cart = Session["Cart"] as List<cls_Cart>;
            if (cart == null)
            {
                cart = new List<cls_Cart>();
            }

            var existingCartItem = cart.FirstOrDefault(x => x.id == productId);
            int currentCartQuantity = existingCartItem != null ? existingCartItem.number : 0;
            int newTotalQuantity = currentCartQuantity + requestedQuantity;

            if (newTotalQuantity > product.pr_soluong)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", string.Format("alert('Tổng số lượng trong giỏ vượt quá số lượng còn lại ({0}).');", product.pr_soluong), true);
                return;
            }

            if (existingCartItem != null)
            {
                existingCartItem.number = newTotalQuantity;
                existingCartItem.total = Convert.ToInt32(Convert.ToDecimal(product.pr_price) * newTotalQuantity);
            }
            else
            {
                cls_Cart _cart = new cls_Cart
                {
                    id = productId,
                    number = requestedQuantity,
                    name = product.pr_name,
                    image = product.pr_image,
                    total = Convert.ToInt32(Convert.ToDecimal(product.pr_price) * requestedQuantity),
                    price = Convert.ToInt32(product.pr_price),
                };
                cart.Add(_cart);
            }
            Session["Cart"] = cart;
            Response.Redirect("/gio-hang");
        }
    }
}