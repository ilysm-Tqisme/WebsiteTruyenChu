package servlet;

import dao.NguoiDungDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NguoiDung;

import java.io.IOException;
import util.SessionRegistry;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private NguoiDungDAO nguoiDungDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        NguoiDung nd = (session != null) ? (NguoiDung) session.getAttribute("nguoiDung") : null;

        if (nd != null) {
            if ("ADMIN".equalsIgnoreCase(nd.getVaiTro())) {
                response.sendRedirect(request.getContextPath() + "/Admin/HomeAdmin.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/User/Home.jsp");
            }
            return;
        }

        request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (email == null || email.trim().isEmpty() ||
            matKhau == null || matKhau.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu!");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
            return;
        }

        NguoiDung nguoiDung = nguoiDungDAO.dangNhap(email.trim(), matKhau);

        if (nguoiDung != null) {

            // 🛑 Kiểm tra trạng thái tài khoản
            if (!nguoiDung.isTrangThai()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên.");
                request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
                return;
            }

            // ✅ Tạo session đăng nhập
            HttpSession session = request.getSession();
            session.setAttribute("user", nguoiDung);
            session.setAttribute("userId", nguoiDung.getId());
            session.setAttribute("userRole", nguoiDung.getVaiTro());
            session.setAttribute("userName", nguoiDung.getHoTen());

            // ✅ Lưu session để hỗ trợ hủy từ xa khi đổi mật khẩu
            SessionRegistry.addSession(nguoiDung.getId(), session);

            // ⏳ Thiết lập timeout cho session
            session.setMaxInactiveInterval("on".equals(rememberMe) ? (7 * 24 * 60 * 60) : (30 * 60));

            // ➡️ Chuyển hướng theo vai trò
            if ("ADMIN".equalsIgnoreCase(nguoiDung.getVaiTro())) {
                response.sendRedirect(request.getContextPath() + "/Admin/HomeAdmin.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/User/Login.jsp").forward(request, response);
        }
    }
}
