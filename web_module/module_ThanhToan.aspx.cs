using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_ThanhToan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int total = 0;
    cls_Alert alert = new cls_Alert();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if user is logged in
            if (Request.Cookies["User"] == null)
            {
                Response.Redirect("/login");
                return;
            }
            
            // Check if cart exists and has items
            if (Session["Cart"] == null)
            {
                Response.Redirect("/gio-hang");
                return;
            }
            
            // Auto-fill user information if available
            int userId = (from u in db.tb_Users
                           where u.us_username == Request.Cookies["User"].Value
                           select u.us_id).FirstOrDefault();
            
            var userInfo = (from u in db.tb_Users
                            where u.us_id == userId
                            select u).FirstOrDefault();
            
            if (userInfo != null)
            {
                txtName.Value = userInfo.us_name;
                txtPhone.Value = userInfo.us_phone;
                txtEmail.Value = userInfo.us_email;
            }
        }
        
        // Display cart items
        List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];
        rpGioHang.DataSource = cart;
        rpGioHang.DataBind();
        
        // Calculate total
        if (Session["Cart"] != null)
        {
            foreach (var item in cart)
            {
                total += item.total;
            }
        }
    }
    
    protected void btnThanhToan_ServerClick(object sender, EventArgs e)
    {
        try
        {
            // Validate required fields
            if (string.IsNullOrEmpty(txtName.Value) || string.IsNullOrEmpty(txtPhone.Value) || string.IsNullOrEmpty(txtAddress.Value))
            {
                alert.alert_Warning(Page, "Vui lòng điền đầy đủ thông tin bắt buộc", "");
                return;
            }
            
            // Create order
            tb_Order order = new tb_Order();
            order.order_creationdate = DateTime.Now;
            order.us_id = (from u in db.tb_Users
                           where u.us_username == Request.Cookies["User"].Value
                           select u).FirstOrDefault().us_id;
            order.order_status = "Đang chờ xử lý";
            order.order_total = Convert.ToString(total);
            
            
            //// Add payment method
            //if (banking.Checked)
            //{
            //    order.order_payment_method = "Chuyển khoản ngân hàng";
            //}
            //else
            //{
            //    order.order_payment_method = "Thanh toán khi nhận hàng (COD)";
            //}
            
            // Add shipping info
            //order.order_diachi = txtAddress.Value;
            //order.order_phone = txtPhone.Value;
            //order.order_note = txtNote.Value;
            
            // Save order to database
            db.tb_Orders.InsertOnSubmit(order);
            db.SubmitChanges();
            
            // Get newly created order ID
            int orderId = (from o in db.tb_Orders orderby o.order_id descending select o).FirstOrDefault().order_id;
            
            // Add order details
            List<cls_Cart> cart = (List<cls_Cart>)Session["Cart"];
            foreach (var item in cart)
            {
                tb_OrderDetail orderDetail = new tb_OrderDetail();
                orderDetail.pr_id = item.id;
                orderDetail.pr_pricecurrent = Convert.ToString(item.price);
                orderDetail.pr_number = item.number;
                orderDetail.order_id = orderId;
                db.tb_OrderDetails.InsertOnSubmit(orderDetail);
                db.SubmitChanges();
            }
            
            // Clear cart
            Session["Cart"] = null;
            
            // Show success message and redirect
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", 
                "swal('Đặt hàng thành công','Cảm ơn bạn đã mua hàng tại AL Fashion Store','success').then(function(){window.location = '/trang-chu';})", 
                true);
        }
        catch (Exception ex)
        {
            alert.alert_Warning(Page, "Đặt hàng thất bại: " + ex.Message, "");
        }
    }
} 