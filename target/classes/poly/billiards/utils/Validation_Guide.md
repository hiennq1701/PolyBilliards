# Hướng dẫn Validation cho Quản lý Loại Đồ Uống

## Tổng quan
Hệ thống đã được tích hợp validation để đảm bảo dữ liệu được nhập chính xác trước khi lưu vào database.

## Các loại Validation

### 1. Validation Mã Loại Đồ Uống

#### Kiểm tra trống:
```java
if (id.isEmpty()) {
    XDialog.alert(this, "Mã loại đồ uống không được để trống!");
    txtId.requestFocus();
    return false;
}
```

#### Kiểm tra định dạng:
```java
if (!AutoCodeGenerator.isValidCode(id)) {
    XDialog.alert(this, "Mã loại đồ uống không đúng định dạng!");
    txtId.requestFocus();
    return false;
}
```

#### Kiểm tra trùng lặp (chỉ khi tạo mới):
```java
if (AutoCodeGenerator.isCodeExists(id, existingCodes)) {
    XDialog.alert(this, "Mã loại đồ uống đã tồn tại!");
    txtId.requestFocus();
    return false;
}
```

### 2. Validation Tên Loại Đồ Uống

#### Kiểm tra trống:
```java
if (name.isEmpty()) {
    XDialog.alert(this, "Tên loại đồ uống không được để trống!");
    txtName.requestFocus();
    return false;
}
```

#### Kiểm tra độ dài tối thiểu:
```java
if (name.length() < 2) {
    XDialog.alert(this, "Tên loại đồ uống phải có ít nhất 2 ký tự!");
    txtName.requestFocus();
    return false;
}
```

#### Kiểm tra độ dài tối đa:
```java
if (name.length() > 100) {
    XDialog.alert(this, "Tên loại đồ uống không được quá 100 ký tự!");
    txtName.requestFocus();
    return false;
}
```

## Cách hoạt động

### 1. Khi tạo mới:
1. **Nhập dữ liệu** → User nhập mã và tên
2. **Click "Tạo mới"** → Hệ thống validate
3. **Validation thành công** → Lưu vào database
4. **Thông báo thành công** → Hiển thị "Tạo loại đồ uống mới thành công!"

### 2. Khi cập nhật:
1. **Chọn item** → User chọn item cần sửa
2. **Sửa dữ liệu** → User sửa thông tin
3. **Click "Cập nhật"** → Hệ thống validate
4. **Validation thành công** → Cập nhật database
5. **Thông báo thành công** → Hiển thị "Cập nhật loại đồ uống thành công!"

## Thông báo lỗi

### Các thông báo lỗi có thể gặp:

1. **"Mã loại đồ uống không được để trống!"**
   - **Nguyên nhân**: Chưa nhập mã
   - **Cách khắc phục**: Nhập mã loại đồ uống

2. **"Tên loại đồ uống không được để trống!"**
   - **Nguyên nhân**: Chưa nhập tên
   - **Cách khắc phục**: Nhập tên loại đồ uống

3. **"Tên loại đồ uống phải có ít nhất 2 ký tự!"**
   - **Nguyên nhân**: Tên quá ngắn
   - **Cách khắc phục**: Nhập tên dài hơn

4. **"Tên loại đồ uống không được quá 100 ký tự!"**
   - **Nguyên nhân**: Tên quá dài
   - **Cách khắc phục**: Rút gọn tên

5. **"Mã loại đồ uống không đúng định dạng!"**
   - **Nguyên nhân**: Mã không phải số
   - **Cách khắc phục**: Nhập mã chỉ chứa số

6. **"Mã loại đồ uống đã tồn tại!"**
   - **Nguyên nhân**: Mã đã có trong hệ thống
   - **Cách khắc phục**: Chọn mã khác

## Thông báo thành công

### Khi tạo mới thành công:
```
"Tạo loại đồ uống mới thành công!"
```

### Khi cập nhật thành công:
```
"Cập nhật loại đồ uống thành công!"
```

### Khi xóa thành công:
```
"Xóa loại đồ uống thành công!"
```

## Lưu ý

1. **Focus tự động**: Khi có lỗi, focus sẽ tự động chuyển đến field có lỗi
2. **Validation real-time**: Validation được thực hiện ngay khi click nút
3. **Thông báo rõ ràng**: Mỗi lỗi có thông báo cụ thể
4. **Không lưu khi có lỗi**: Dữ liệu không được lưu nếu validation thất bại
5. **Phân biệt tạo mới/cập nhật**: Kiểm tra trùng mã chỉ áp dụng khi tạo mới

## Test Cases

### Test tạo mới thành công:
1. Nhập mã: "001"
2. Nhập tên: "Nước ngọt"
3. Click "Tạo mới"
4. **Kết quả**: Thông báo thành công

### Test validation lỗi:
1. Để trống tên
2. Click "Tạo mới"
3. **Kết quả**: Thông báo "Tên loại đồ uống không được để trống!"

### Test mã trùng lặp:
1. Nhập mã đã tồn tại
2. Nhập tên hợp lệ
3. Click "Tạo mới"
4. **Kết quả**: Thông báo "Mã loại đồ uống đã tồn tại!" 