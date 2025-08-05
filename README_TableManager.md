# TableManager - Quản lý bàn bi-a với chức năng sửa giá tiền

## Tổng quan
TableManager là module quản lý bàn bi-a cho phép cập nhật trạng thái và giá tiền của các bàn.

## Tính năng
- **Xem danh sách bàn**: Hiển thị tất cả bàn với trạng thái và giá tiền
- **Cập nhật trạng thái**: Thay đổi trạng thái bàn (Trống, Đang sử dụng, Bảo trì)
- **Cập nhật giá tiền**: Sửa giá tiền cho từng bàn
- **Không hỗ trợ xóa**: Chức năng xóa bàn bị vô hiệu hóa

## Cấu trúc Database

### Bảng BilliardTable
```sql
CREATE TABLE [dbo].[BilliardTable](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [Status] [nvarchar](20) NOT NULL,
    [Price] [decimal](10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY CLUSTERED ([Id] ASC)
)
```

### Dữ liệu mẫu
- **Bàn liber 1-12**: 50,000 VNĐ
- **Bàn VIP 1-3**: 80,000 VNĐ  
- **Bàn lỗ 1-5**: 60,000 VNĐ

## Cài đặt

### 1. Chạy script SQL hoàn chỉnh
Sử dụng file `PolyBilliards_Complete.sql` để:
- Tạo database PolyBilliards
- Tạo tất cả bảng cần thiết
- Thêm cột `Price` vào bảng `BilliardTable`
- Thêm dữ liệu mẫu cho 18 bàn với giá tiền

### 2. Cấu trúc Code
- **Entity**: `Table.java` - Chứa field `price`
- **DAO**: `TableDAOImpl.java` - Sử dụng bảng `BilliardTable`
- **UI**: `TableManagerJDialog.java` - Giao diện quản lý

## Sử dụng

### Mở TableManager
1. Đăng nhập vào hệ thống
2. Chọn menu "Quản lý bàn bi-a"
3. Hoặc nhấn nút "Table Manager" trong menu

### Cập nhật bàn
1. Chọn bàn cần sửa từ danh sách
2. Thay đổi trạng thái trong dropdown
3. Nhập giá tiền mới
4. Nhấn "Cập nhật"

### Validation
- Giá tiền phải là số dương
- Giá tiền không được để trống
- Chỉ cho phép cập nhật, không cho phép xóa

## Lưu ý
- Sử dụng file `PolyBilliards_Complete.sql` để tạo database hoàn chỉnh
- Backup database trước khi thực hiện thay đổi
- Bảng `BilliardTable` đã có sẵn cột `Price`

## Troubleshooting
- Nếu gặp lỗi "Invalid object name 'BilliardTable'": Chạy file `PolyBilliards_Complete.sql`
- Nếu gặp lỗi "Invalid object name 'Users'": Kiểm tra kết nối database
- Nếu không hiển thị giá tiền: Kiểm tra field `price` trong entity
- Nếu cột Price chưa tồn tại: Chạy file SQL hoàn chỉnh 