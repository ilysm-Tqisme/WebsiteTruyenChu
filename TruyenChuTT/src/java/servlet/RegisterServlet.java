package servlet;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.NguoiDung;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/User/Register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");
        String xacNhanMatKhau = request.getParameter("confirmPassword");
        String hoTen = request.getParameter("fullName");
        String soDienThoai = request.getParameter("phone");
        
        // Validate dữ liệu
        String errorMessage = validateInput(email, matKhau, xacNhanMatKhau, hoTen, soDienThoai);
        
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/User/Register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại
        if (nguoiDungDAO.kiemTraEmailTonTai(email)) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.getRequestDispatcher("/User/Register.jsp").forward(request, response);
            return;
        }
        
        // Tạo người dùng mới
        NguoiDung nguoiDung = new NguoiDung(email, matKhau, hoTen, soDienThoai);
        
        // Thực hiện đăng ký
        boolean success = nguoiDungDAO.dangKy(nguoiDung);
        
        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("/User/Register.jsp").forward(request, response);
        }
    }
    
    private String validateInput(String email, String matKhau, String xacNhanMatKhau, String hoTen, String soDienThoai) {
        // Kiểm tra các trường bắt buộc
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống!";
        }
        
        if (matKhau == null || matKhau.trim().isEmpty()) {
            return "Mật khẩu không được để trống!";
        }
        
        if (xacNhanMatKhau == null || xacNhanMatKhau.trim().isEmpty()) {
            return "Vui lòng xác nhận mật khẩu!";
        }
        
        if (hoTen == null || hoTen.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        
        // Validate email format - chỉ chấp nhận @gmail.com
        if (!email.toLowerCase().endsWith("@gmail.com")) {
            return "Chỉ chấp nhận email @gmail.com!";
        }
        
        // Validate password length
        if (matKhau.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự!";
        }
        
        // Kiểm tra mật khẩu khớp
        if (!matKhau.equals(xacNhanMatKhau)) {
            return "Mật khẩu xác nhận không khớp!";
        }
        
        // Validate họ tên
        if (hoTen.length() < 2) {
            return "Họ tên phải có ít nhất 2 ký tự!";
        }

        // Validate số điện thoại
        if (soDienThoai != null && !soDienThoai.trim().isEmpty()) {
            if (!soDienThoai.matches("^0[0-9]{9}$")) {
                return "Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0!";
            }
        }
        
        return null; // Không có lỗi
    }
}
