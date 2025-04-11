using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_KhoVatPham_admin_ThemNhapHang : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int idchitiet;
    private decimal tongtien;
    DataTable dtVPDaChon;
    int _idUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        //var getuser = (from u in db.admin_Users
        //               where u.username_username == Request.Cookies["UserName"].Value
        //               select u).FirstOrDefault();
        //_idUser = getuser.username_id;

        //Session["dtVPDaChon"] = null;
        idchitiet = Convert.ToInt32(RouteData.Values["id"]);
        if (!IsPostBack)
        {
            //Session["_id"] = 0;
            var dsGiaoVien = from gv in db.admin_Users where gv.username_active == true select gv;
            ddlNguoiNhapHang.Items.Clear();
            ddlNguoiNhapHang.Items.Insert(0, "Chọn Giáo viên");
            ddlNguoiNhapHang.AppendDataBoundItems = true;
            ddlNguoiNhapHang.DataTextField = "username_fullname";
            ddlNguoiNhapHang.DataValueField = "username_id";
            ddlNguoiNhapHang.DataSource = dsGiaoVien;
            ddlNguoiNhapHang.DataBind();
            string matutang = Matutang();
            txtMaNhap.Value = matutang;
            txtNgayNhap.Value = DateTime.Now.ToString("dd/MM/yyyy");


            if (idchitiet == 0)
            {

                dtVPDaChon = (DataTable)Session["dtVPDaChon"];
                Session["dtVPDaChon"] = null;
                Load();
            }
            else
            {
                Load();
                var getDuLieuNhapHang = (from nh in db.tbVatPham_NhapHangs
                                         where nh.nhaphang_id == idchitiet
                                         select new
                                         {
                                             nh.nhaphang_code,
                                             nh.nhaphang_createdate,
                                             nh.username_id,
                                         }).SingleOrDefault();

                txtMaNhap.Value = getDuLieuNhapHang.nhaphang_code;
                txtNgayNhap.Value = getDuLieuNhapHang.nhaphang_createdate.Value.ToString("dd-MM-yyyy").Replace(' ', 'T');
                ddlNguoiNhapHang.SelectedValue = getDuLieuNhapHang.username_id + "";

                var getDuLieuNhapHangChiteit = (from nh in db.tbVatPham_NhapHangs
                                                join nhct in db.tbVatPham_NhapHang_ChiTiets on nh.nhaphang_code equals nhct.nhaphang_code
                                                join vp in db.tbVatPhams on nhct.vatpham_id equals vp.vatpham_id
                                                where nh.nhaphang_id == idchitiet && nhct.hidden == true
                                                select new
                                                {
                                                    vp.vatpham_id,
                                                    vp.vatpham_name,
                                                    nhct.nhaphangchitiet_soluong,
                                                    nhct.nhaphangchitiet_dongia,
                                                    nhct.nhaphangchitiet_thanhtien,
                                                    nh.nhaphang_tongtien,
                                                    nhct.nhaphangchitiet_id,
                                                    nhct.hidden,
                                                });
                decimal tongTien = getDuLieuNhapHangChiteit.Sum(item => item.nhaphangchitiet_thanhtien ?? 0);
                txtTongTien.InnerText = tongTien.ToString("#,##0");
                //loaddata ra datatable
                loaddatatable();
                foreach (var item in getDuLieuNhapHangChiteit)
                {
                    DataRow row = dtVPDaChon.NewRow();
                    var getName = (from vp in db.tbVatPhams where vp.vatpham_id == item.vatpham_id select vp);
                    if (getName.Count() > 0)
                    {
                        row["nhaphangchitiet_id"] = item.nhaphangchitiet_id;
                        row["vatpham_id"] = item.vatpham_id;
                        row["vatpham_name"] = getName.FirstOrDefault().vatpham_name;
                        row["nhaphangchitiet_soluong"] = item.nhaphangchitiet_soluong;
                        row["nhaphangchitiet_dongia"] = item.nhaphangchitiet_dongia;
                        row["nhaphangchitiet_thanhtien"] = item.nhaphangchitiet_thanhtien;
                        row["hidden"] = item.hidden;
                        dtVPDaChon.Rows.Add(row);
                    }
                };
                Session["dtVPDaChon"] = dtVPDaChon;
                rpVatPhamChiTiet.DataSource = dtVPDaChon;
                rpVatPhamChiTiet.DataBind();
            }
        }
    }
    public void Load()
    {
        var getVatPham = from vp in db.tbVatPhams
                         where vp.hidden == true
                         orderby vp.vatpham_id descending // Sắp xếp theo trường ID giảm dần
                         select new
                         {
                             vp.vatpham_id,
                             vp.vatpham_name,
                         };
        grvThemVatPham.DataSource = getVatPham;
        grvThemVatPham.DataBind();

    }

    public string Matutang()
    {
        int year = DateTime.Now.Year;
        String yearStr = Convert.ToString(year);
        var list = from nh in db.tbVatPham_NhapHangs select nh;
        string s = "NH";
        if (list.Count() <= 0)
        {
            s = year + "NH0001";
        }
        else
        {
            var list1 = from nh in db.tbVatPham_NhapHangs orderby nh.nhaphang_code descending select nh;
            string chuoi = list1.First().nhaphang_code;
            if (chuoi.Substring(0, 4) != yearStr)
            {
                s = yearStr + "NH0001";
            }
            else
            {
                int k;
                k = Convert.ToInt32(chuoi.Substring(6, 4));
                k = k + 1;
                if (k < 10)
                {
                    s = s + "000";
                }
                else if (k < 100)
                {
                    s = s + "00";
                }
                else if (k < 1000)
                {
                    s = s + "0";
                }
                s = yearStr + s + k.ToString();
            }
        }
        return s;

    }
    public void loaddatatable()
    {
        try
        {
            if (dtVPDaChon == null)
            {
                dtVPDaChon = new DataTable();
                dtVPDaChon.Columns.Add("vatpham_id", typeof(int));
                dtVPDaChon.Columns.Add("vatpham_name", typeof(string));
                dtVPDaChon.Columns.Add("nhaphangchitiet_soluong", typeof(int));
                dtVPDaChon.Columns.Add("nhaphangchitiet_dongia", typeof(int));
                dtVPDaChon.Columns.Add("nhaphangchitiet_thanhtien", typeof(int));
                dtVPDaChon.Columns.Add("nhaphangchitiet_id", typeof(int));
                dtVPDaChon.Columns.Add("hidden", typeof(bool));
            }
        }
        catch
        {

        }
    }
    protected void btnVatPhamChiTiet_ServerClick(object sender, EventArgs e)
    {
        if (idchitiet == 0)
        {
            int _idvatpham = Convert.ToInt32(txtvatpham_id.Value);
            var vatpham = (from vp in db.tbVatPhams
                           where vp.vatpham_id == _idvatpham
                           select vp).SingleOrDefault();
            if (Session["dtVPDaChon"] != null)
            {
                dtVPDaChon = (DataTable)Session["dtVPDaChon"];
                DataRow[] vatpham_id = dtVPDaChon.Select("vatpham_id='" + _idvatpham + "'");
                if (vatpham_id.Length != 0)
                {
                    alert.alert_Warning(Page, "Vật phẩm này đã được chọn", "");
                }
                else
                {
                    DataRow row = dtVPDaChon.NewRow();
                    row["vatpham_id"] = _idvatpham;
                    row["vatpham_name"] = vatpham.vatpham_name;
                    row["nhaphangchitiet_soluong"] = 1;
                    row["nhaphangchitiet_dongia"] = 1;
                    row["nhaphangchitiet_thanhtien"] = 1;
                    row["hidden"] = true;
                    dtVPDaChon.Rows.Add(row);
                    Session["dtVPDaChon"] = dtVPDaChon;
                }
            }
            else
            {
                loaddatatable();
                DataRow row = dtVPDaChon.NewRow();
                row["vatpham_id"] = _idvatpham;
                row["vatpham_name"] = vatpham.vatpham_name;
                row["nhaphangchitiet_soluong"] = 1;
                row["nhaphangchitiet_dongia"] = 1;
                row["nhaphangchitiet_thanhtien"] = 1;
                row["hidden"] = true;
                dtVPDaChon.Rows.Add(row);
                Session["dtVPDaChon"] = dtVPDaChon;
            }
            if (Session["dtVPDaChon"] != null)
            {
                dtVPDaChon = (DataTable)Session["dtVPDaChon"];
                object sumObject = dtVPDaChon.Compute("SUM(nhaphangchitiet_thanhtien)", "");
                if (sumObject != DBNull.Value)
                {
                    tongtien = Convert.ToDecimal(sumObject);
                    txtTongTien.InnerText = tongtien.ToString("#,##0");
                    // txtTongTien.InnerText = Convert.ToString(tongtien);
                }
            }
            rpVatPhamChiTiet.DataSource = dtVPDaChon;
            rpVatPhamChiTiet.DataBind();
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "myHideLoading()", true);
        }
        else
        {
            int _idvatpham = Convert.ToInt32(txtvatpham_id.Value);
            var vatpham = (from vp in db.tbVatPhams
                           where vp.vatpham_id == _idvatpham
                           select vp).SingleOrDefault();
            if (Session["dtVPDaChon"] != null)
            {
                dtVPDaChon = (DataTable)Session["dtVPDaChon"];
                DataRow[] vatpham_id = dtVPDaChon.Select("vatpham_id='" + _idvatpham + "'");
                if (vatpham_id.Length != 0)
                {
                    alert.alert_Warning(Page, "Vật phẩm này đã có", "");
                }
                else
                {
                    DataRow row = dtVPDaChon.NewRow();
                    row["nhaphangchitiet_id"] = 0;
                    row["vatpham_id"] = vatpham.vatpham_id;
                    row["vatpham_name"] = vatpham.vatpham_name;
                    row["nhaphangchitiet_soluong"] = 1;
                    row["nhaphangchitiet_dongia"] = 1;
                    row["nhaphangchitiet_thanhtien"] = 1;
                    row["hidden"] = true;
                    dtVPDaChon.Rows.Add(row);
                    Session["dtVPDaChon"] = dtVPDaChon;
                }
            }
            if (Session["dtVPDaChon"] != null)
            {
                dtVPDaChon = (DataTable)Session["dtVPDaChon"];
                object sumObject = dtVPDaChon.Compute("SUM(nhaphangchitiet_thanhtien)", "");
                if (sumObject != DBNull.Value)
                {
                    tongtien = Convert.ToDecimal(sumObject);
                    txtTongTien.InnerText = tongtien.ToString("#,##0");
                    //txtTongTien.InnerText = Convert.ToString(tongtien);
                }
            }
            rpVatPhamChiTiet.DataSource = dtVPDaChon;
            rpVatPhamChiTiet.DataBind();
        }

    }
    protected void NhapHangChiTiet_ServerClick(object sender, EventArgs e)
    {

        // kiểm tra id
        int _id = Convert.ToInt32(txt_ID.Value);

        if (Session["dtVPDaChon"] != null)
        {
            dtVPDaChon = (DataTable)Session["dtVPDaChon"];
            // chạy foreach để lặp lại các row 
            foreach (DataRow row in dtVPDaChon.Rows)
            {
                string product_id = row["vatpham_id"].ToString();
                if (product_id == _id.ToString())
                {
                    // lưu data bằng input đầu vào
                    row.SetField("nhaphangchitiet_soluong", txt_SoLuong.Value);
                    row.SetField("nhaphangchitiet_dongia", txt_DonGia.Value);
                    row.SetField("nhaphangchitiet_thanhtien", txt_ThanhTien.Value);
                    object sumObject = dtVPDaChon.Compute("SUM(nhaphangchitiet_thanhtien)", "");
                    if (sumObject != DBNull.Value)
                    {
                        tongtien = Convert.ToDecimal(sumObject);
                        txtTongTien.InnerText = tongtien.ToString("#,##0");
                        //txtTongTien.InnerText = Convert.ToString(tongtien);
                    }
                    rpVatPhamChiTiet.DataSource = dtVPDaChon;
                    rpVatPhamChiTiet.DataBind();
                    break;
                }
            }
        }
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        dtVPDaChon = (DataTable)Session["dtVPDaChon"];
        //try
        //{
        //    if (dtVPDaChon.Rows.Count <= 0 || dtVPDaChon == null) alert.alert_Warning(Page, "Bạn chưa có sản phẩm nào", "");
        //}
        //catch { }
        if (idchitiet == 0)
        {
            if (dtVPDaChon == null) alert.alert_Warning(Page, "Bạn chưa có sản phẩm nào", "");
            else
            {
                //Lưu vào bảng tbVatPham_NhapHang
                tbVatPham_NhapHang inserts = new tbVatPham_NhapHang();
                inserts.nhaphang_code = txtMaNhap.Value;
                inserts.nhaphang_createdate = DateTime.Now;
                inserts.nhaphang_tongtien = 0;
                inserts.username_id = Convert.ToInt32(ddlNguoiNhapHang.SelectedValue);
                db.tbVatPham_NhapHangs.InsertOnSubmit(inserts);
                db.SubmitChanges();
                //Lưu dữ liệu vào bảng tbVatPham_NhapHang_ChiTiet
                try
                {
                    if (dtVPDaChon.Rows.Count > 0)
                    {
                        foreach (DataRow row in dtVPDaChon.Rows)
                        {
                            tbVatPham_NhapHang_ChiTiet insert = new tbVatPham_NhapHang_ChiTiet();
                            insert.nhaphang_code = txtMaNhap.Value;
                            insert.vatpham_id = Convert.ToInt32(row["vatpham_id"]);
                            insert.nhaphangchitiet_soluong = Convert.ToInt32(row["nhaphangchitiet_soluong"]);
                            insert.nhaphangchitiet_dongia = Convert.ToInt32(row["nhaphangchitiet_dongia"]);
                            insert.nhaphangchitiet_thanhtien = Convert.ToInt32(row["nhaphangchitiet_thanhtien"]);
                            insert.hidden = true;
                            db.tbVatPham_NhapHang_ChiTiets.InsertOnSubmit(insert);
                            db.SubmitChanges();
                        }
                    }
                    var updatetien = (from nh in db.tbVatPham_NhapHangs where nh.nhaphang_code == txtMaNhap.Value select nh).SingleOrDefault();
                    updatetien.nhaphang_tongtien = (from nhct in db.tbVatPham_NhapHang_ChiTiets where nhct.nhaphang_code == txtMaNhap.Value select nhct).Sum(x => x.nhaphangchitiet_thanhtien);
                    db.SubmitChanges();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Nhập hàng thành công!', '','success').then(function(){window.location = 'admin-nhap-hang';})", true);
                }
                catch
                {
                    alert.alert_Error(Page, "Vui lòng liên hệ IT", "");
                }
                string matutang = Matutang();
                txtMaNhap.Value = matutang;
            }
        }
        else
        {
            if (dtVPDaChon == null) alert.alert_Warning(Page, "Bạn chưa có sản phẩm nào", "");
            else
            {
                if (dtVPDaChon.Rows.Count > 0)
                {
                    //thêm vào bảng tbVatPham_NhapHang_ChiTiet
                    foreach (DataRow row in dtVPDaChon.Rows)
                    {
                        var getchecknhct = from nhct in db.tbVatPham_NhapHang_ChiTiets
                                           where nhct.nhaphang_code == txtMaNhap.Value && nhct.nhaphangchitiet_id == Convert.ToInt32(row["nhaphangchitiet_id"]) && nhct.hidden == true
                                           select nhct;
                        if (getchecknhct.Count() > 0)
                        {
                            foreach (var product in getchecknhct)
                            {
                                if (product.nhaphangchitiet_id == Convert.ToInt32(row["nhaphangchitiet_id"]))
                                {
                                    //update tbVatPham_NhapHang_ChiTiet
                                    product.nhaphangchitiet_id = Convert.ToInt32(row["nhaphangchitiet_id"]);
                                    product.nhaphangchitiet_soluong = Convert.ToInt32(row["nhaphangchitiet_soluong"]);
                                    product.nhaphangchitiet_dongia = Convert.ToInt32(row["nhaphangchitiet_dongia"]);
                                    product.nhaphangchitiet_thanhtien = Convert.ToInt32(row["nhaphangchitiet_thanhtien"]);
                                    product.hidden = true;
                                    db.SubmitChanges();
                                }
                            }
                        }
                        else
                        {
                            tbVatPham_NhapHang_ChiTiet addRow = new tbVatPham_NhapHang_ChiTiet();
                            addRow.nhaphang_code = txtMaNhap.Value;
                            addRow.vatpham_id = Convert.ToInt32(row["vatpham_id"]);
                            addRow.nhaphangchitiet_soluong = Convert.ToInt32(row["nhaphangchitiet_soluong"]);
                            addRow.nhaphangchitiet_dongia = Convert.ToInt32(row["nhaphangchitiet_soluong"]);
                            addRow.nhaphangchitiet_thanhtien = Convert.ToInt32(row["nhaphangchitiet_thanhtien"]);
                            addRow.hidden = true;
                            db.tbVatPham_NhapHang_ChiTiets.InsertOnSubmit(addRow);
                            db.SubmitChanges();
                            DataTable dataTable = (DataTable)Session["dtVPDaChon"];
                            dtVPDaChon = dataTable;
                            rpVatPhamChiTiet.DataSource = dtVPDaChon;
                            rpVatPhamChiTiet.DataBind();
                        }
                        db.SubmitChanges();
                    }
                }
                var updatetienmoi = (from nh in db.tbVatPham_NhapHangs where nh.nhaphang_code == txtMaNhap.Value select nh).SingleOrDefault();
                updatetienmoi.nhaphang_tongtien = (from nhct in db.tbVatPham_NhapHang_ChiTiets where nhct.nhaphang_code == txtMaNhap.Value && nhct.hidden == true select nhct).Sum(x => x.nhaphangchitiet_thanhtien);
                updatetienmoi.username_id = Convert.ToInt32(ddlNguoiNhapHang.SelectedValue);
                db.SubmitChanges();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Nhập hàng thành công!', '','success').then(function(){window.location = '/admin-nhap-hang';})", true);
            }
        }

    }

    protected void btnXoa_ServerClick(object sender, EventArgs e)
    {
        int _id = Convert.ToInt32(txt_ID.Value);
        dtVPDaChon = (DataTable)Session["dtVPDaChon"];
        if (idchitiet == 0)
        {
            foreach (DataRow row in dtVPDaChon.Rows)
            {
                string nhaphangchitiet = row["vatpham_id"].ToString();
                if (nhaphangchitiet == _id.ToString())
                {
                    dtVPDaChon.Rows.Remove(row);
                    Session["dtVPDaChon"] = dtVPDaChon;
                    object sumObject = dtVPDaChon.Compute("SUM(nhaphangchitiet_thanhtien)", "");
                    if (sumObject != DBNull.Value)
                    {
                        tongtien = Convert.ToDecimal(sumObject);
                        txtTongTien.InnerText = Convert.ToString(tongtien);
                    }
                    else
                    {
                        txtTongTien.InnerText = Convert.ToString(0);
                    }
                    db.SubmitChanges();
                    break;
                }
            }
        }
        else
        {
            foreach (DataRow row in dtVPDaChon.Rows)
            {
                //xóa trong datatable
                var getchecknhct = from nhct in db.tbVatPham_NhapHang_ChiTiets where nhct.vatpham_id == _id && nhct.hidden == true && nhct.nhaphang_code == txtMaNhap.Value select nhct;
                string nhaphangchitiet = row["vatpham_id"].ToString();
                if (nhaphangchitiet == _id.ToString())
                {
                    dtVPDaChon.Rows.Remove(row);
                    Session["dtVPDaChon"] = dtVPDaChon;
                    object sumObject = dtVPDaChon.Compute("SUM(nhaphangchitiet_thanhtien)", "");
                    if (sumObject != DBNull.Value)
                    {
                        tongtien = Convert.ToDecimal(sumObject);
                        txtTongTien.InnerText = Convert.ToString(tongtien);
                    }

                    var dell = (from nhct in db.tbVatPham_NhapHang_ChiTiets where nhct.vatpham_id == _id && nhct.hidden == true && nhct.nhaphang_code == txtMaNhap.Value select nhct).FirstOrDefault();
                    dell.hidden = false;
                    db.SubmitChanges();
                    break;
                }
            }
        }

        rpVatPhamChiTiet.DataSource = dtVPDaChon;
        rpVatPhamChiTiet.DataBind();
        alert.alert_Warning(Page, "Xóa thành công", "");

    }
}