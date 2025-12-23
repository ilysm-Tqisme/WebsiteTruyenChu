package servlet;

import dao.NguoiDungDAO;
import model.NguoiDung;
import service.EmailService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;
    private EmailService emailService;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
        emailService = new EmailService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email!");
            request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email tồn tại
        if (!nguoiDungDAO.kiemTraEmailTonTai(email.trim())) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Lấy thông tin user
        NguoiDung user = nguoiDungDAO.layThongTinNguoiDungTheoEmail(email.trim());
        if (user == null || !user.isTrangThai()) {
            request.setAttribute("error", "Tài khoản không hợp lệ hoặc đã bị khóa!");
            request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Tạo reset token
        String resetToken = emailService.generateResetToken();
        LocalDateTime expireTime = LocalDateTime.now().plusMinutes(15); // Token hết hạn sau 15 phút
        
        // Lưu token vào database
        boolean tokenSaved = nguoiDungDAO.luuTokenQuenMatKhau(user.getId(), resetToken, expireTime);
        
        if (!tokenSaved) {
            request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại.");
            request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
            return;
        }
        
        // Gửi email
        boolean emailSent = emailService.sendResetPasswordEmail(email.trim(), resetToken, user.getHoTen());
        
        if (emailSent) {
            request.setAttribute("success", 
                "Đã gửi link đặt lại mật khẩu đến email của bạn. " +
                "Vui lòng kiểm tra hộp thư (bao gồm cả thư mục spam). " +
                "Link sẽ hết hạn sau 15 phút.");
        } else {
            request.setAttribute("error", "Không thể gửi email! Vui lòng thử lại sau.");
        }
        
        request.getRequestDispatcher("/User/ForgotPassword.jsp").forward(request, response);
    }
}
