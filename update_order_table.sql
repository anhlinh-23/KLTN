-- Add new columns to tb_Order table
ALTER TABLE tb_Order ADD order_payment_method NVARCHAR(MAX) NULL;
ALTER TABLE tb_Order ADD order_address NVARCHAR(MAX) NULL;
ALTER TABLE tb_Order ADD order_phone NVARCHAR(MAX) NULL;
ALTER TABLE tb_Order ADD order_note NVARCHAR(MAX) NULL;

/*
-- Update existing orders to have default values (commented out until columns exist)
UPDATE tb_Order SET 
    order_payment_method = 'Thanh toán khi nhận hàng (COD)', 
    order_address = 'Không có thông tin',
    order_phone = 'Không có thông tin',
    order_note = ''
WHERE order_payment_method IS NULL;
*/

PRINT 'Cập nhật bảng tb_Order thành công!'; 