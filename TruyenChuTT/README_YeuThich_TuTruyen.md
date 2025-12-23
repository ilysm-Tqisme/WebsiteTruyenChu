# Chức năng Yêu thích và Tủ truyện

## Tổng quan

Chức năng này cho phép người dùng:
- **Yêu thích truyện**: Thêm/xóa truyện khỏi danh sách yêu thích
- **Tủ truyện**: Thêm/xóa truyện khỏi tủ truyện cá nhân

## Cơ sở dữ liệu

### Bảng YeuThich
```sql
CREATE TABLE YeuThich (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(ID) ON DELETE CASCADE,
    TruyenID INT FOREIGN KEY REFERENCES Truyen(ID) ON DELETE CASCADE,
    NgayYeuThich DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_YeuThich_NguoiDung_Truyen UNIQUE (NguoiDungID, TruyenID)
);
```

### Bảng TuTruyen
```sql
CREATE TABLE TuTruyen (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(ID) ON DELETE CASCADE,
    TruyenID INT FOREIGN KEY REFERENCES Truyen(ID) ON DELETE CASCADE,
    NgayLuu DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_TuTruyen_NguoiDung_Truyen UNIQUE (NguoiDungID, TruyenID)
);
```

## Các file đã tạo/cập nhật

### Model
- `src/java/model/YeuThich.java` - Model cho bảng Yêu thích
- `src/java/model/TuTruyen.java` - Model cho bảng Tủ truyện (đã có sẵn)

### DAO
- `src/java/dao/YeuThichDAO.java` - DAO xử lý thao tác với bảng Yêu thích
- `src/java/dao/TuTruyenDAO.java` - DAO xử lý thao tác với bảng Tủ truyện (đã có sẵn)

### Servlet
- `src/java/servlet/YeuThichServlet.java` - Servlet xử lý yêu cầu Yêu thích
- `src/java/servlet/TuTruyenServlet.java` - Servlet xử lý yêu cầu Tủ truyện
- `src/java/servlet/StoryDetailServlet.java` - Đã cập nhật để tích hợp chức năng

### View
- `web/User/StoryDetail.jsp` - Đã cập nhật để hiển thị nút Yêu thích và Tủ truyện

## API Endpoints

### Yêu thích
- `POST /yeuthich/add` - Thêm truyện vào yêu thích
- `POST /yeuthich/remove` - Xóa truyện khỏi yêu thích

### Tủ truyện
- `POST /tutruyen/add` - Thêm truyện vào tủ
- `POST /tutruyen/remove` - Xóa truyện khỏi tủ

## Tham số request

### Tham số chung
- `truyenId` (int) - ID của truyện cần xử lý

### Response format
```json
{
    "success": true,
    "message": "Đã thêm vào danh sách yêu thích"
}
```

## Cài đặt

1. **Chạy SQL**: Execute file `database_yeuthich.sql` để tạo bảng trong database
2. **Build project**: Rebuild và deploy lại project
3. **Kiểm tra**: Truy cập trang chi tiết truyện để test chức năng

## Tính năng

### Frontend
- Hiển thị trạng thái hiện tại (đã yêu thích/đã lưu hay chưa)
- Nút sẽ bị disable nếu người dùng chưa đăng nhập
- Hiệu ứng loading khi xử lý
- Thông báo success/error

### Backend
- Kiểm tra đăng nhập trước khi xử lý
- Kiểm tra trùng lặp trước khi thêm mới
- Xử lý lỗi và trả về JSON response
- Validation cho tham số đầu vào

## Security
- Kiểm tra session người dùng
- Validate input parameters
- Sử dụng PreparedStatement để tránh SQL Injection
- Cascade delete khi người dùng hoặc truyện bị xóa

## Performance
- Index trên các trường thường xuyên truy vấn
- Unique constraint để tránh trùng lặp
- PreparedStatements cho tối ưu database

## Testing

1. Đăng nhập vào hệ thống
2. Truy cập trang chi tiết một truyện
3. Click vào nút "Yêu thích" - nên thấy thông báo thành công và nút đổi trạng thái
4. Click lại nút "Yêu thích" - nên thấy thông báo xóa thành công
5. Lặp lại với nút "Lưu vào tủ"
6. Test với người dùng chưa đăng nhập - các nút nên bị disable
7. Test với các tham số không hợp lệ - nên thấy thông báo lỗi
