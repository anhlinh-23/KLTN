using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class web_module_module_ThanhToan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int total = 0;
    cls_Alert alert = new cls_Alert();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Get VNPAY response data
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; // Secret key

            VnPayLibrary vnpay = new VnPayLibrary();

            // Fill response data
            foreach (string key in Request.QueryString.Keys)
            {
                // Skip the "submit" key to avoid duplicate (if it exists)
                if (!string.IsNullOrEmpty(Request.QueryString[key]) && key != "submit")
                {
                    vnpay.AddResponseData(key, Request.QueryString[key]);
                }
            }

            // Get data from response
            string vnp_ResponseCode = vnpay.GetResponseData("vnp_ResponseCode");
            string vnp_TransactionStatus = vnpay.GetResponseData("vnp_TransactionStatus");
            string vnp_OrderInfo = vnpay.GetResponseData("vnp_OrderInfo");
            string vnp_TransactionNo = vnpay.GetResponseData("vnp_TransactionNo");
            string vnp_BankCode = vnpay.GetResponseData("vnp_BankCode");
            string vnp_Amount = vnpay.GetResponseData("vnp_Amount");
            string vnp_PayDate = vnpay.GetResponseData("vnp_PayDate");
            string vnp_TxnRef = vnpay.GetResponseData("vnp_TxnRef");

            // Convert order ID from TxnRef
            int orderId = 0;
            if (!string.IsNullOrEmpty(vnp_TxnRef))
            {
                // Use Int32.TryParse to avoid exceptions if the string is not a valid integer
                Int32.TryParse(vnp_TxnRef, out orderId);
            }

            bool isValidSignature = false;
            if (!string.IsNullOrEmpty(Request.QueryString["vnp_SecureHash"]))
            {
                isValidSignature = vnpay.ValidateSignature(Request.QueryString["vnp_SecureHash"], vnp_HashSecret);
            }

            if (isValidSignature)
            {
                // Check payment status
                if (vnp_ResponseCode == "00" && vnp_TransactionStatus == "00")
                {
                    // Payment successful
                    iconSuccess.Visible = true;
                    resultTitle.InnerText = "Thanh toán thành công";
                    resultMessage.InnerText = "Đơn hàng của bạn đã được thanh toán thành công qua VNPAY.";

                    // Set payment details
                    orderCode.InnerText = vnp_TxnRef;

                    // Format payment amount (dividing by 100 since amount is in the smallest currency unit)
                    double amountDouble = 0;
                    if (!string.IsNullOrEmpty(vnp_Amount))
                    {
                        double.TryParse(vnp_Amount, out amountDouble);
                        amountDouble = amountDouble / 100;
                    }
                    amount.InnerText = string.Format("{0:N0} VNĐ", amountDouble);

                    bankCode.InnerText = vnp_BankCode;
                    transactionId.InnerText = vnp_TransactionNo;

                    // Format payment time
                    DateTime payDate = DateTime.Now;
                    if (!string.IsNullOrEmpty(vnp_PayDate))
                    {
                        try
                        {
                            payDate = DateTime.ParseExact(vnp_PayDate, "yyyyMMddHHmmss", System.Globalization.CultureInfo.InvariantCulture);
                        }
                        catch { }
                    }
                    paymentTime.InnerText = payDate.ToString("dd/MM/yyyy HH:mm:ss");

                    // Update order status in the database
                    try
                    {
                        if (orderId > 0)
                        {
                            var order = db.tb_Orders.FirstOrDefault(o => o.order_id == orderId);
                            if (order != null)
                            {
                                order.order_status = "Đã xong";
                                db.SubmitChanges();

                                // Lấy email khách hàng từ bảng user
                                string toEmail = (from u in db.tb_Users where u.us_id == order.us_id select u.us_email).FirstOrDefault();
                                string orderCodeMail = order.order_id.ToString();
                                DateTime payDateMail = DateTime.Now;
                                string paymentMethod = "VNPAY";
                                decimal total = Convert.ToDecimal(order.order_total);
                                var details = (from od in db.tb_OrderDetails
                                               join pr in db.tb_Products on od.pr_id equals pr.pr_id
                                               where od.order_id == order.order_id
                                               select new OrderDetailMail
                                               {
                                                   ImageUrl = (pr.pr_image.StartsWith("/") ? "https://thoitrangnu.com" + pr.pr_image : "https://thoitrangnu.com/images/" + pr.pr_image),
                                                   ProductCode = pr.pr_id.ToString(),
                                                   Size = "",
                                                   Price = Convert.ToDecimal(od.pr_pricecurrent),
                                                   Quantity = od.pr_number ?? 0,
                                                   Total = Convert.ToDecimal(od.pr_pricecurrent) * (od.pr_number ?? 0)
                                               }).ToList();
                                SendOrderConfirmationEmail(toEmail, orderCodeMail, payDateMail, paymentMethod, total, details);

                                // Clear cart
                                Session["Cart"] = null;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log exception
                        System.Diagnostics.Debug.WriteLine("Error updating order status: " + ex.Message);
                    }
                }
                else
                {
                    // Payment failed or canceled
                    iconFailed.Visible = true;
                    resultTitle.InnerText = "Thanh toán không thành công";
                    resultMessage.InnerText = "Giao dịch đã bị hủy hoặc xảy ra lỗi trong quá trình thanh toán.";

                    // Set payment details
                    orderCode.InnerText = vnp_TxnRef;

                    // Format payment amount (dividing by 100 since amount is in the smallest currency unit)
                    double amountDouble = 0;
                    if (!string.IsNullOrEmpty(vnp_Amount))
                    {
                        double.TryParse(vnp_Amount, out amountDouble);
                        amountDouble = amountDouble / 100;
                    }
                    amount.InnerText = string.Format("{0:N0} VNĐ", amountDouble);

                    bankCode.InnerText = vnp_BankCode;
                    transactionId.InnerText = vnp_TransactionNo;

                    // Format payment time
                    DateTime payDate = DateTime.Now;
                    if (!string.IsNullOrEmpty(vnp_PayDate))
                    {
                        try
                        {
                            payDate = DateTime.ParseExact(vnp_PayDate, "yyyyMMddHHmmss", System.Globalization.CultureInfo.InvariantCulture);
                        }
                        catch { }
                    }
                    paymentTime.InnerText = payDate.ToString("dd/MM/yyyy HH:mm:ss");

                    // Update order status in the database
                    try
                    {
                        if (orderId > 0)
                        {
                            var order = db.tb_Orders.FirstOrDefault(o => o.order_id == orderId);
                            if (order != null)
                            {
                                order.order_status = "Thanh toán thất bại";
                                db.SubmitChanges();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log exception
                        System.Diagnostics.Debug.WriteLine("Error updating order status: " + ex.Message);
                    }
                }
            }
            else
            {
                // Invalid signature
                iconFailed.Visible = true;
                resultTitle.InnerText = "Lỗi xác thực chữ ký";
                resultMessage.InnerText = "Dữ liệu giao dịch không hợp lệ. Vui lòng liên hệ với nhân viên hỗ trợ.";
            }
        }
    }

    public class OrderDetailMail
    {
        public string ImageUrl { get; set; }
        public string ProductCode { get; set; }
        public string Size { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public decimal Total { get; set; }
    }

    public void SendOrderConfirmationEmail(string toEmail, string orderCode, DateTime payDate, string paymentMethod, decimal total, List<OrderDetailMail> details)
    {
        string subject = "Xác nhận đơn hàng #" + orderCode;
        string body =
            "<b>Kính gửi Quý khách hàng,</b><br>" +
            "Chúng tôi đã nhận được thanh toán thành công từ bạn. Đơn hàng của bạn sẽ được xử lý và gửi tới địa chỉ được cung cấp trong thời gian sớm nhất.<br><br>" +
            "<b>Chi tiết thanh toán:</b><br>" +
            "<ul>" +
            "<li>Mã đơn hàng: " + orderCode + "</li>" +
            "<li>Ngày thanh toán: " + payDate.ToString("dd/MM/yyyy HH:mm:ss") + "</li>" +
            "<li>Phương thức thanh toán: " + paymentMethod + "</li>" +
            "<li>Tổng thanh toán: " + total.ToString("N0") + " đ</li>" +
            "</ul>" +
            "<b>Chi tiết đơn hàng:</b>" +
            "<table border='1' cellpadding='5' cellspacing='0'>" +
            "<tr>" +
            "<th>Hình ảnh</th>" +
            "<th>Mã sản phẩm</th>" +
            "<th>Size</th>" +
            "<th>Đơn giá</th>" +
            "<th>Số lượng</th>" +
            "<th>Tổng</th>" +
            "</tr>" +
            string.Join("", details.Select(d =>
                "<tr>" +
                    "<td><img src='" + d.ImageUrl + "' width='50'/></td>" +
                    "<td>" + d.ProductCode + "</td>" +
                    "<td>" + d.Size + "</td>" +
                    "<td>" + d.Price.ToString("N0") + " đ</td>" +
                    "<td>" + d.Quantity + "</td>" +
                    "<td>" + d.Total.ToString("N0") + " đ</td>" +
                "</tr>"
            )) +
            "</table>" +
            "<br>Xin chân thành cảm ơn sự tin tưởng và ủng hộ của bạn.<br>Trân trọng,";

        MailMessage mail = new MailMessage();
        mail.To.Add(toEmail);
        mail.Subject = subject;
        mail.Body = body;
        mail.IsBodyHtml = true;
        mail.From = new MailAddress("truongminhthuy1966@gmail.com", "Tên shop của bạn");

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials = new System.Net.NetworkCredential("truongminhthuy1966@gmail.com", "bsarbjqziayrvxll");
        smtp.EnableSsl = true;
        try
        {
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MailError", "alert('Lỗi gửi mail: " + ex.Message.Replace("'", " ") + "');", true);
        }
    }
}