# Hướng dẫn sử dụng tính năng sinh mã đồ uống tự động

## Tổng quan
Tính năng này cho phép tự động sinh mã đồ uống dựa trên số lượng đồ uống hiện có trong bảng + 1 mà không cần chỉnh sửa database.

## Các file đã tạo/sửa đổi

### 1. AutoCodeGenerator.java
- **Vị trí**: `java/poly/billiards/utils/AutoCodeGenerator.java`
- **Chức năng**: Utility class để sinh mã tự động
- **Các method chính**:
  - `generateNextCode()`: Sinh mã mới theo thứ tự tăng dần
  - `generateCodeWithGap()`: Sinh mã với khoảng trống (tìm mã bị thiếu)
  - `isValidCode()`: Kiểm tra mã có hợp lệ không
  - `isCodeExists()`: Kiểm tra mã đã tồn tại chưa

### 2. FoodCategoryManagerJDialog.java
- **Vị trí**: `java/poly/billiards/ui/manager/FoodCategoryManagerJDialog.java`
- **Thay đổi**:
  - Thêm import `AutoCodeGenerator`
  - Thêm import `Collectors`
  - Thêm sự kiện focus cho `txtId`
  - Thêm method `generateAutoCode()` và `generateCodeWithGap()`
  - Cập nhật method `clear()` và `fillToTable()`

## Cách hoạt động

### 1. Tự động sinh mã khi:
- **Clear form**: Khi click nút "Xóa trắng"
- **Focus vào text field**: Khi click vào ô mã và ô trống
- **Load dữ liệu**: Sau khi load danh sách từ database

### 2. Logic sinh mã:
```java
// Ví dụ: Có 0 đồ uống trong bảng
// Sinh mã mới sẽ là: 001 (0 + 1 = 1)

// Ví dụ: Có 3 đồ uống trong bảng
// Sinh mã mới sẽ là: 004 (3 + 1 = 4)

// Ví dụ: Có 5 đồ uống trong bảng  
// Sinh mã mới sẽ là: 006 (5 + 1 = 6)
```

### 3. Các tính năng:
- **Tự động theo số lượng**: Mã = Số lượng đồ uống + 1
- **Format 3 chữ số**: 001, 002, 003, 004...
- **Đơn giản và dễ hiểu**: Không phụ thuộc vào mã hiện có
- **Validation**: Kiểm tra mã hợp lệ
- **Không trùng lặp**: Đảm bảo mã không bị trùng
- **Validation form**: Kiểm tra dữ liệu trước khi lưu
- **Thông báo thành công**: Hiển thị thông báo khi tạo/cập nhật thành công

## Cách sử dụng

### 1. Sinh mã tự động:
```java
// Tự động khi focus vào text field trống
txtId.addFocusListener(new FocusAdapter() {
    public void focusGained(FocusEvent evt) {
        if (txtId.getText().trim().isEmpty()) {
            generateAutoCode();
        }
    }
});
```

### 2. Sinh mã thủ công:
```java
// Sinh mã mới
String newCode = AutoCodeGenerator.generateNextCode(existingCodes);

// Sinh mã với khoảng trống
String codeWithGap = AutoCodeGenerator.generateCodeWithGap(existingCodes);
```

### 3. Kiểm tra mã:
```java
// Kiểm tra mã hợp lệ
boolean isValid = AutoCodeGenerator.isValidCode(code);

// Kiểm tra mã đã tồn tại
boolean exists = AutoCodeGenerator.isCodeExists(code, existingCodes);
```

### 4. Validation form:
```java
// Validate trước khi tạo/cập nhật
if (!validateForm()) {
    return;
}

// Thông báo thành công
XDialog.info(this, "Tạo loại đồ uống mới thành công!");
```

## Lợi ích

1. **Không cần chỉnh sửa database**: Tất cả logic được xử lý trong code
2. **Tự động hóa**: Không cần nhập mã thủ công
3. **Tránh trùng lặp**: Đảm bảo mã luôn duy nhất
4. **Xử lý khoảng trống**: Tận dụng mã bị xóa
5. **Dễ mở rộng**: Có thể thêm prefix, format khác

## Mở rộng

### 1. Thêm prefix:
```java
// Thay vì: 011, 012, 013
// Có thể: DR011, DR012, DR013
```

### 2. Thêm format khác:
```java
// Thay vì: 011, 012, 013
// Có thể: 0011, 0012, 0013 (4 chữ số)
```

### 3. Thêm validation:
```java
// Kiểm tra độ dài, ký tự đặc biệt, v.v.
```

## Lưu ý

1. **Performance**: Cache danh sách mã để tối ưu hiệu suất
2. **Thread-safe**: Sử dụng singleton pattern cho generator
3. **Error handling**: Xử lý exception khi parse số
4. **Backup**: Luôn có backup trước khi thay đổi code

## Test

### 1. Test sinh mã:
- Tạo đồ uống mới → Kiểm tra mã tự động
- Xóa đồ uống → Kiểm tra mã được tái sử dụng
- Nhập mã thủ công → Kiểm tra validation

### 2. Test edge cases:
- Danh sách rỗng
- Mã không phải số
- Mã trùng lặp
- Mã null/empty 