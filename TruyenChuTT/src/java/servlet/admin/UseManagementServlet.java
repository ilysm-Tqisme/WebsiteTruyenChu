/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet.admin;

import com.sun.jdi.connect.spi.Connection;
import dao.NguoiDungDAO;
import db.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.NguoiDung;
import util.BCryptUtil;
import util.SessionRegistry;

/**
 *
 * @author USER
 */
@WebServlet(name="UseManagementServlet", urlPatterns={"/admin/users"})
public class UseManagementServlet extends HttpServlet {

    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private static final int DEFAULT_PAGE_SIZE = 10;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         // ✅ KIỂM TRA ĐĂNG NHẬP
    HttpSession session = request.getSession(false);
    NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

    if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    // Process based on URL pattern
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");
        String servletPath = request.getServletPath();


        // Default action is to list users
        if (pathInfo == null && action == null) {
            listUsers(request, response);
        } else if (action != null) {
            switch (action) {
                case "view":
                   viewUser(request, response);
                   break;
                case "changePassword":
                    changePassword(request, response);
                    break;
                case "changeStatus":
                    changeUserStatus(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "search":
                    searchUsers(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } else {
            listUsers(request, response);
        }
    }
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = DEFAULT_PAGE_SIZE;
        
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            }
            
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
                if (pageSize < 1) pageSize = DEFAULT_PAGE_SIZE;
                if (pageSize > 100) pageSize = 100; // Limit max page size
            }
        } catch (NumberFormatException e) {
            // Use defaults if parsing fails
        }
        
        // Get user list with pagination
        List<NguoiDung> userList = nguoiDungDAO.layDanhSachNguoiDungPhanTrang(page, pageSize);
        int totalUsers = nguoiDungDAO.demTongSoNguoiDung();
        int totalUsersVIP = nguoiDungDAO.demTaiKhoanVIP();
        
        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        
        
        // Set attributes for JSP
        request.setAttribute("userList", userList);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalUsersVIP", totalUsersVIP);
        
        // Forward to JSP
        request.getRequestDispatcher("/Admin/UserManagement.jsp").forward(request, response);
    }

        private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(userId);

            if (user != null) {
                request.setAttribute("selectedUser", user);
                request.getRequestDispatcher("/Admin/UserView.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalidId");
        }
    }
/**
     * Change a user's password
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getMethod();
        
        if ("POST".equalsIgnoreCase(method)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                // Validate input
                if (newPassword == null || newPassword.isEmpty()) {
                    request.setAttribute("errorMessage", "Mật khẩu mới không được để trống");
                    listUsers(request, response);
                    return;
                }
                
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp");
                    listUsers(request, response);
                    return;
                }
                
                // Hash the password for security
                String hashedPassword = BCryptUtil.hashPassword(newPassword);
                
                // Update password
                boolean success = nguoiDungDAO.doiMatKhau(userId, hashedPassword);
                
                if (success) {
                    request.setAttribute("successMessage", "Đã đổi mật khẩu thành công");
                    // Thêm ID người dùng vào danh sách cần đăng xuất
                    markUserForLogout(request.getSession(), userId);
                } else {
                    request.setAttribute("errorMessage", "Lỗi khi đổi mật khẩu");
                }
                
                // If we are viewing a specific user, go back to that view
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(userId);
                if (user != null && request.getParameter("fromUserView") != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/Admin/UserView.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID người dùng không hợp lệ");
            }
        }
        
        // Redirect back to user list
        listUsers(request, response);
    }
    

    private void markUserForLogout(HttpSession adminSession, int userId) {
        NguoiDung currentAdmin = (NguoiDung) adminSession.getAttribute("user");
        if (currentAdmin != null && currentAdmin.getId() == userId) {
            return; // Không tự đăng xuất chính mình
        }   
            SessionRegistry.invalidateSession(userId);
        }

/**
     * Change a user's active status (lock/unlock account)
     */
    private void changeUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
            
            boolean success = nguoiDungDAO.capNhatTrangThaiNguoiDung(userId, newStatus);
            
            if (success) {
                request.setAttribute("successMessage", "Đã " + (newStatus ? "mở khóa" : "khóa") + " tài khoản thành công");
                // Nếu tài khoản bị khóa, đánh dấu để đăng xuất
                if (!newStatus) {
                    markUserForLogout(request.getSession(), userId);
                }
            } else {
                request.setAttribute("errorMessage", "Lỗi khi thay đổi trạng thái tài khoản");
            }
            
            // If we are viewing a specific user, go back to that view
            if (request.getParameter("fromUserView") != null) {
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/Admin/UserView.jsp").forward(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID người dùng không hợp lệ");
        }
        
        // Redirect back to user list
        listUsers(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Không cho phép admin tự xóa chính mình
        HttpSession session = request.getSession(false);
        NguoiDung currentAdmin = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        if (currentAdmin != null && currentAdmin.getId() == userId) {
            request.setAttribute("errorMessage", "Không thể xóa chính tài khoản của bạn.");
            listUsers(request, response);
            return;
        }

        boolean success = nguoiDungDAO.xoaNguoiDung(userId);

        if (success) {
            request.setAttribute("successMessage", "Đã xóa tài khoản thành công.");
            // Đảm bảo đăng xuất user nếu đang hoạt động
            markUserForLogout(request.getSession(), userId);
        } else {
            request.setAttribute("errorMessage", "Lỗi khi xóa tài khoản.");
        }

    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "ID người dùng không hợp lệ.");
    }

    listUsers(request, response);
}
    
    private void searchUsers(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String keyword = request.getParameter("searchTerm");
    
    if (keyword == null || keyword.trim().isEmpty()) {
        request.setAttribute("errorMessage", "Vui lòng nhập từ khóa tìm kiếm.");
        listUsers(request, response);
        return;
    }

    // Gọi DAO để tìm kiếm
    List<NguoiDung> userList = nguoiDungDAO.timKiemNguoiDung(keyword);

    // Gửi dữ liệu về JSP
    request.setAttribute("userList", userList);
    request.setAttribute("searchTerm", keyword);
    request.setAttribute("searchMode", true);
    request.setAttribute("totalUsers", userList.size());

    int totalUsersVIP = (int) userList.stream()
        .filter(u -> "VIP".equalsIgnoreCase(u.getVaiTro()))
        .count();
    request.setAttribute("totalUsersVIP", totalUsersVIP);

    request.getRequestDispatcher("/Admin/UserManagement.jsp").forward(request, response);
}

    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
