using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_GioHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int total = 0;
    public string none;
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["User"] == null)
            {
                Response.Redirect("/login");
            }
        }

        List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];
        rpGioHang.DataSource = cart;
        rpGioHang.DataBind();
        if (Session["Cart"] != null)
        {
            foreach (var item in cart)
            {
                total += item.total;
            }
        }
        if (total == 0)
        {
            none = "style='display: none'";
        }

    }


    protected void btnAdd_ServerClick(object sender, EventArgs e)
    {
        List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];

        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
        cls_Cart existingProduct = cart.FirstOrDefault(p => p.id == Convert.ToInt32(txtId.Value));

        if (existingProduct != null)
        {
            existingProduct.number += 1;
            existingProduct.total = existingProduct.number * existingProduct.price;
        }
        txtId.Value = "";
        Session["Cart"] = cart;
        Response.Redirect("/gio-hang");
    }

    protected void btnGiam_ServerClick(object sender, EventArgs e)
    {
        List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];

        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
        cls_Cart existingProduct = cart.FirstOrDefault(p => p.id == Convert.ToInt32(txtId.Value));

        if (existingProduct != null)
        {
            if (existingProduct.number > 1)
            {
                existingProduct.number -= 1;
                existingProduct.total = existingProduct.number * existingProduct.price;
            }
            else
            {
                cart.Remove(existingProduct);
            }
        }
        txtId.Value = "";
        Session["Cart"] = cart;
        Response.Redirect("/gio-hang");
    }

    protected void btnDel_ServerClick(object sender, EventArgs e)
    {
        List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];

        // Xóa sản phẩm khỏi giỏ hàng dựa trên ID
        cls_Cart productToRemove = cart.FirstOrDefault(p => p.id == Convert.ToInt32(txtId.Value));

        if (productToRemove != null)
        {
            cart.Remove(productToRemove);
        }
        Session["Cart"] = cart;
        Response.Redirect("/gio-hang");
    }

    protected void btnSave_ServerClick(object sender, EventArgs e)
    {
        // Chuyển sang trang thanh toán thay vì xử lý đơn hàng trực tiếp
        Response.Redirect("/thanh-toan");
    }
}