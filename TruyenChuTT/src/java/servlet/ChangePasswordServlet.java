package servlet;

import dao.NguoiDungDAO;
import model.NguoiDung;
import util.BCryptUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
            return;
        }
        
        request.getRequestDispatcher("/User/ChangePassword.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
            return;
        }
        
        // Lấy thông tin từ form
        String matKhauCu = request.getParameter("matKhauCu");
        String matKhauMoi = request.getParameter("matKhauMoi");
        String xacNhanMatKhau = request.getParameter("xacNhanMatKhau");
        
        // Validate input
        String errorMessage = validateInput(matKhauCu, matKhauMoi, xacNhanMatKhau);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/User/ChangePassword.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu cũ
        if (!BCryptUtil.checkPassword(matKhauCu, user.getMatKhau())) {
            request.setAttribute("error", "Mật khẩu cũ không chính xác!");
            request.getRequestDispatcher("/User/ChangePassword.jsp").forward(request, response);
            return;
        }
        
        // Đổi mật khẩu
       // ✅ Đúng: hash 1 lần trước khi lưu
String hashedPassword = BCryptUtil.hashPassword(matKhauMoi);
boolean success = nguoiDungDAO.doiMatKhau(user.getId(), hashedPassword);

if (success) {
    // Cập nhật lại session để tránh logout ảo
    user.setMatKhau(hashedPassword);
    request.getSession().setAttribute("user", user);
    
    request.setAttribute("success", "Đổi mật khẩu thành công!");
} else {
    request.setAttribute("error", "Đổi mật khẩu thất bại!");
}

        
        request.getRequestDispatcher("/User/ChangePassword.jsp").forward(request, response);
    }
    
    private String validateInput(String matKhauCu, String matKhauMoi, String xacNhanMatKhau) {
        if (matKhauCu == null || matKhauCu.trim().isEmpty()) {
            return "Vui lòng nhập mật khẩu cũ!";
        }
        
        if (matKhauMoi == null || matKhauMoi.trim().isEmpty()) {
            return "Vui lòng nhập mật khẩu mới!";
        }
        
        if (xacNhanMatKhau == null || xacNhanMatKhau.trim().isEmpty()) {
            return "Vui lòng xác nhận mật khẩu mới!";
        }
        
        if (matKhauMoi.length() < 6) {
            return "Mật khẩu mới phải có ít nhất 6 ký tự!";
        }
        
        if (!matKhauMoi.equals(xacNhanMatKhau)) {
            return "Mật khẩu mới và xác nhận không khớp!";
        }
        
        if (matKhauCu.equals(matKhauMoi)) {
            return "Mật khẩu mới phải khác mật khẩu cũ!";
        }
        
        return null;
    }
}
