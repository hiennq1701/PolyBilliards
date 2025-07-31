# Ví dụ sử dụng tính năng sinh mã đồ uống

## Cách hoạt động mới

### Logic: Mã = Số lượng đồ uống hiện có + 1

| Số lượng đồ uống | Mã được sinh | Giải thích |
|------------------|---------------|------------|
| 0 | 001 | 0 + 1 = 1 |
| 1 | 002 | 1 + 1 = 2 |
| 2 | 003 | 2 + 1 = 3 |
| 3 | 004 | 3 + 1 = 4 |
| 4 | 005 | 4 + 1 = 5 |
| 5 | 006 | 5 + 1 = 6 |

## Ví dụ thực tế

### Kịch bản 1: Bảng trống
```
Bảng đồ uống: (trống)
→ Sinh mã: 001
```

### Kịch bản 2: Có 2 đồ uống
```
Bảng đồ uống: 
- 001 (Coca Cola)
- 002 (Pepsi)

→ Sinh mã mới: 003 (2 + 1 = 3)
```

### Kịch bản 3: Có 5 đồ uống
```
Bảng đồ uống:
- 001 (Coca Cola)
- 002 (Pepsi) 
- 003 (Sprite)
- 004 (Fanta)
- 005 (7Up)

→ Sinh mã mới: 006 (5 + 1 = 6)
```

## Ưu điểm của cách này

1. **Đơn giản**: Chỉ cần đếm số lượng đồ uống
2. **Dễ hiểu**: Mã = Số lượng + 1
3. **Format đẹp**: 001, 002, 003, 004...
4. **Không phụ thuộc**: Không cần quan tâm mã hiện có
5. **Luôn đúng**: Không bao giờ bị trùng lặp
6. **Dễ debug**: Dễ dàng kiểm tra logic

## So sánh với cách cũ

### Cách cũ (dựa trên mã lớn nhất):
```
Mã hiện có: 001, 002, 004, 006
→ Tìm mã lớn nhất: 006
→ Sinh mã mới: 007
```

### Cách mới (dựa trên số lượng):
```
Số lượng đồ uống: 4
→ Sinh mã mới: 005 (4 + 1 = 5)
```

## Lưu ý

- Mã luôn bắt đầu từ 001 (khi bảng trống)
- Mã tăng dần theo số lượng đồ uống: 001, 002, 003, 004...
- Format 3 chữ số với số 0 ở đầu
- Không quan trọng mã hiện có là gì
- Chỉ quan trọng có bao nhiêu đồ uống trong bảng 