package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NguoiDung;


import java.io.IOException;

@WebFilter(urlPatterns = {"/User/*", "/Admin/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Các trang không cần đăng nhập
        String[] publicPages = {
            "/User/Login.jsp",
            "/User/Register.jsp",
            "/login",
            "/register",
            "/logout"
        };
        
        // Kiểm tra xem có phải trang public không
        boolean isPublicPage = false;
        for (String page : publicPages) {
            if (requestURI.endsWith(page)) {
                isPublicPage = true;
                break;
            }
        }
        
        if (isPublicPage) {
            chain.doFilter(request, response);
            return;
        }
        
        // Kiểm tra session
        HttpSession session = httpRequest.getSession(false);
        NguoiDung user = null;
        
        if (session != null) {
            user = (NguoiDung) session.getAttribute("user"); // ✅
        }
        
        if (user == null) {
            // Chưa đăng nhập, chuyển về trang login
            httpResponse.sendRedirect(contextPath + "/User/Login.jsp");
            return;
        }
        
        // Kiểm tra quyền truy cập Admin
        if (requestURI.contains("/Admin/")) {
            if (!"ADMIN".equals(user.getVaiTro())) {
                // Không có quyền admin
                httpResponse.sendRedirect(contextPath + "/User/Home.jsp");
                return;
            }
        }
        
        // Kiểm tra trạng thái tài khoản
        if (!user.isTrangThai()) {
            // Tài khoản bị khóa
            session.invalidate();
            httpRequest.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
            httpRequest.getRequestDispatcher("/User/Login.jsp").forward(httpRequest, httpResponse);
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
