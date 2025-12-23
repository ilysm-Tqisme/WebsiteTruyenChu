package servlet;

import dao.NguoiDungDAO;
import model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Link không hợp lệ!");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra token hợp lệ
        NguoiDung user = nguoiDungDAO.kiemTraTokenQuenMatKhau(token);
        
        if (user == null) {
            request.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("token", token);
        request.setAttribute("email", user.getEmail());
        request.getRequestDispatcher("/User/ResetPassword.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String token = request.getParameter("token");
        String matKhauMoi = request.getParameter("matKhauMoi");
        String xacNhanMatKhau = request.getParameter("xacNhanMatKhau");
        
        // Validate input
        String errorMessage = validateInput(token, matKhauMoi, xacNhanMatKhau);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.setAttribute("token", token);
            request.getRequestDispatcher("/User/ResetPassword.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra token
        NguoiDung user = nguoiDungDAO.kiemTraTokenQuenMatKhau(token);
        if (user == null) {
            request.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
            return;
        }
        
        // Đặt lại mật khẩu
        boolean success = nguoiDungDAO.datLaiMatKhau(user.getId(), matKhauMoi, token);
        
        if (success) {
            request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đặt lại mật khẩu thất bại!");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/User/ResetPassword.jsp").forward(request, response);
        }
    }
    
    private String validateInput(String token, String matKhauMoi, String xacNhanMatKhau) {
        if (token == null || token.trim().isEmpty()) {
            return "Token không hợp lệ!";
        }
        
        if (matKhauMoi == null || matKhauMoi.trim().isEmpty()) {
            return "Vui lòng nhập mật khẩu mới!";
        }
        
        if (xacNhanMatKhau == null || xacNhanMatKhau.trim().isEmpty()) {
            return "Vui lòng xác nhận mật khẩu!";
        }
        
        if (matKhauMoi.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự!";
        }
        
        if (!matKhauMoi.equals(xacNhanMatKhau)) {
            return "Mật khẩu và xác nhận không khớp!";
        }
        
        return null;
    }
}
