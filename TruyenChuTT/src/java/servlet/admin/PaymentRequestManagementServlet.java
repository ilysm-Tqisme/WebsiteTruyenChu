/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet.admin;

import dao.GoiVIPDAO;
import dao.NguoiDungDAO;
import dao.TaiKhoanVIPDAO;
import dao.YeuCauThanhToanDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.GoiVIP;
import model.NguoiDung;
import model.YeuCauThanhToan;
import service.EmailUtil;

/**
 *
 * @author USER
 */
@WebServlet(name="PaymentRequestManagementServlet", urlPatterns={"/admin/payments"})
public class PaymentRequestManagementServlet extends HttpServlet {

     private final YeuCauThanhToanDAO yeuCauDAO = new YeuCauThanhToanDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final GoiVIPDAO goiVIPDAO = new GoiVIPDAO();
    private final TaiKhoanVIPDAO taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    private static final int DEFAULT_PAGE_SIZE = 10;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập admin
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            listPaymentRequests(request, response);
        } else {
            switch (action) {
                case "view":
                    viewPaymentRequest(request, response);
                    break;
                case "approve":
                    approvePaymentRequest(request, response);
                    break;
                case "reject":
                    rejectPaymentRequest(request, response);
                    break;
                case "delete":
                    deletePaymentRequest(request, response);
                    break;
                case "search":
                    searchPaymentRequests(request, response);
                    break;
                default:
                    listPaymentRequests(request, response);
                    break;
            }
        }
    }

    private void listPaymentRequests(HttpServletRequest request, HttpServletResponse response)
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
                if (pageSize > 100) pageSize = 100;
            }
        } catch (NumberFormatException e) {
            // Use defaults
        }

        // Lấy danh sách yêu cầu thanh toán với thông tin chi tiết
        List<Object[]> paymentRequestsWithDetails = getPaymentRequestsWithDetails(page, pageSize);
        
        // Tính tổng số yêu cầu và số trang
        int totalRequests = getTotalPaymentRequests();
        int totalPages = (int) Math.ceil((double) totalRequests / pageSize);
        
        // Thống kê
        int pendingRequests = countRequestsByStatus("PENDING");
        int approvedRequests = countRequestsByStatus("APPROVED");
        int rejectedRequests = countRequestsByStatus("REJECTED");

        // Set attributes
        request.setAttribute("paymentRequestsWithDetails", paymentRequestsWithDetails);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRequests", totalRequests);
        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("approvedRequests", approvedRequests);
        request.setAttribute("rejectedRequests", rejectedRequests);

        request.getRequestDispatcher("/Admin/PaymentRequestManagement.jsp").forward(request, response);
    }

    private void viewPaymentRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            YeuCauThanhToan paymentRequest = yeuCauDAO.layYeuCauTheoID(requestId);
            
            if (paymentRequest != null) {
                // Lấy thông tin người dùng và gói VIP
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(paymentRequest.getNguoiDungID());
                GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(paymentRequest.getGoiVIPID());
                
                request.setAttribute("selectedPaymentRequest", paymentRequest);
                request.setAttribute("requestUser", user);
                request.setAttribute("vipPackage", vipPackage);
                
                request.getRequestDispatcher("/Admin/PaymentRequestView.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/payments?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/payments?error=invalidId");
        }
    }

    private void approvePaymentRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!"POST".equalsIgnoreCase(request.getMethod())) {
            response.sendRedirect(request.getContextPath() + "/admin/payments");
            return;
        }

        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String ghiChu = request.getParameter("ghiChu");
            
            HttpSession session = request.getSession();
            NguoiDung currentAdmin = (NguoiDung) session.getAttribute("user");
            
            // Lấy thông tin yêu cầu thanh toán
            YeuCauThanhToan paymentRequest = yeuCauDAO.layYeuCauTheoID(requestId);
            if (paymentRequest == null || !"PENDING".equals(paymentRequest.getTrangThai())) {
                request.setAttribute("errorMessage", "Yêu cầu thanh toán không tồn tại hoặc đã được xử lý");
                listPaymentRequests(request, response);
                return;
            }

            // Duyệt yêu cầu thanh toán
            boolean approveSuccess = yeuCauDAO.duyetYeuCau(requestId, currentAdmin.getId(), ghiChu);
            
            if (approveSuccess) {
                // Lấy thông tin gói VIP và người dùng
                GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(paymentRequest.getGoiVIPID());
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(paymentRequest.getNguoiDungID());
                
                if (vipPackage != null && user != null) {
                    // Cấp VIP cho người dùng
                    LocalDateTime startDate = LocalDateTime.now();
                    LocalDateTime endDate = startDate.plusMonths(vipPackage.getSoThang());
                    
                    boolean vipGranted = taiKhoanVIPDAO.capVIPChoNguoiDung(
                        user.getId(), 
                        startDate, 
                        endDate, 
                        vipPackage.getSoThang() >= 12 ? "NAM" : "THANG",
                        vipPackage.getGia()
                    );
                    
                    if (vipGranted) {
                        request.setAttribute("successMessage", 
                            "Đã duyệt yêu cầu thanh toán và cấp VIP thành công cho " + user.getHoTen());
                        
                        // Gửi email thông báo (nếu có EmailSender)
                        try {
                            sendApprovalEmail(user, vipPackage, startDate, endDate);
                        } catch (Exception e) {
                            System.err.println("Lỗi gửi email: " + e.getMessage());
                        }
                    } else {
                        request.setAttribute("errorMessage", 
                            "Đã duyệt yêu cầu nhưng có lỗi khi cấp VIP");
                    }
                } else {
                    request.setAttribute("errorMessage", 
                        "Không tìm thấy thông tin gói VIP hoặc người dùng");
                }
            } else {
                request.setAttribute("errorMessage", "Lỗi khi duyệt yêu cầu thanh toán");
            }
            
            // Quay lại trang chi tiết nếu từ view
            if ("true".equals(request.getParameter("fromView"))) {
                viewPaymentRequest(request, response);
                return;
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID yêu cầu không hợp lệ");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }

        listPaymentRequests(request, response);
    }

    private void rejectPaymentRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!"POST".equalsIgnoreCase(request.getMethod())) {
            response.sendRedirect(request.getContextPath() + "/admin/payments");
            return;
        }

        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String ghiChu = request.getParameter("ghiChu");
            
            HttpSession session = request.getSession();
            NguoiDung currentAdmin = (NguoiDung) session.getAttribute("user");
            
            // Kiểm tra yêu cầu tồn tại và đang pending
            YeuCauThanhToan paymentRequest = yeuCauDAO.layYeuCauTheoID(requestId);
            if (paymentRequest == null || !"PENDING".equals(paymentRequest.getTrangThai())) {
                request.setAttribute("errorMessage", "Yêu cầu thanh toán không tồn tại hoặc đã được xử lý");
                listPaymentRequests(request, response);
                return;
            }

            boolean rejectSuccess = yeuCauDAO.tuChoiYeuCau(requestId, currentAdmin.getId(), ghiChu);
            
            if (rejectSuccess) {
                request.setAttribute("successMessage", "Đã từ chối yêu cầu thanh toán");
                
                // Gửi email thông báo từ chối (nếu có)
                try {
                    NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(paymentRequest.getNguoiDungID());
                    GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(paymentRequest.getGoiVIPID());
                    sendRejectionEmail(user, vipPackage, ghiChu);
                } catch (Exception e) {
                    System.err.println("Lỗi gửi email: " + e.getMessage());
                }
            } else {
                request.setAttribute("errorMessage", "Lỗi khi từ chối yêu cầu thanh toán");
            }
            
            // Quay lại trang chi tiết nếu từ view
            if ("true".equals(request.getParameter("fromView"))) {
                viewPaymentRequest(request, response);
                return;
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID yêu cầu không hợp lệ");
        }

        listPaymentRequests(request, response);
    }

    private void deletePaymentRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            
            boolean deleteSuccess = yeuCauDAO.xoaYeuCau(requestId);
            
            if (deleteSuccess) {
                request.setAttribute("successMessage", "Đã xóa yêu cầu thanh toán thành công");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi xóa yêu cầu thanh toán");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID yêu cầu không hợp lệ");
        }

        listPaymentRequests(request, response);
    }

    private void searchPaymentRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("searchTerm");
        String status = request.getParameter("status");
        
        if ((keyword == null || keyword.trim().isEmpty()) && 
            (status == null || status.trim().isEmpty())) {
            request.setAttribute("errorMessage", "Vui lòng nhập từ khóa tìm kiếm hoặc chọn trạng thái");
            listPaymentRequests(request, response);
            return;
        }

        List<Object[]> searchResults = searchPaymentRequestsWithDetails(keyword, status);
        
        request.setAttribute("paymentRequestsWithDetails", searchResults);
        request.setAttribute("searchTerm", keyword);
        request.setAttribute("searchStatus", status);
        request.setAttribute("searchMode", true);
        request.setAttribute("totalRequests", searchResults.size());

        request.getRequestDispatcher("/Admin/PaymentRequestManagement.jsp").forward(request, response);
    }

    // Helper methods
    private List<Object[]> getPaymentRequestsWithDetails(int page, int pageSize) {
        List<Object[]> results = new ArrayList<>();
        List<YeuCauThanhToan> requests = yeuCauDAO.layDanhSachYeuCauChoXuLy();
        
        // Implement pagination manually since DAO doesn't have pagination
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, requests.size());
        
        for (int i = start; i < end; i++) {
            YeuCauThanhToan request = requests.get(i);
            NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(request.getNguoiDungID());
            GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(request.getGoiVIPID());
            
            Object[] row = {request, user, vipPackage};
            results.add(row);
        }
        
        return results;
    }

    private List<Object[]> searchPaymentRequestsWithDetails(String keyword, String status) {
        List<Object[]> results = new ArrayList<>();
        List<YeuCauThanhToan> allRequests = yeuCauDAO.layDanhSachYeuCauChoXuLy();
        
        for (YeuCauThanhToan request : allRequests) {
            boolean matches = true;
            
            // Filter by status
            if (status != null && !status.trim().isEmpty() && !"all".equals(status)) {
                if (!status.equals(request.getTrangThai())) {
                    matches = false;
                }
            }
            
            // Filter by keyword
            if (matches && keyword != null && !keyword.trim().isEmpty()) {
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(request.getNguoiDungID());
                if (user != null) {
                    String searchText = (user.getHoTen() + " " + user.getEmail() + " " + 
                                       request.getNoiDungChuyenKhoan()).toLowerCase();
                    if (!searchText.contains(keyword.toLowerCase())) {
                        matches = false;
                    }
                }
            }
            
            if (matches) {
                NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(request.getNguoiDungID());
                GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(request.getGoiVIPID());
                Object[] row = {request, user, vipPackage};
                results.add(row);
            }
        }
        
        return results;
    }

    private int getTotalPaymentRequests() {
        return yeuCauDAO.layDanhSachYeuCauChoXuLy().size();
    }

    private int countRequestsByStatus(String status) {
        List<YeuCauThanhToan> allRequests = yeuCauDAO.layDanhSachYeuCauChoXuLy();
        return (int) allRequests.stream()
                .filter(req -> status.equals(req.getTrangThai()))
                .count();
    }

    private void sendApprovalEmail(NguoiDung user, GoiVIP vipPackage, LocalDateTime startDate, LocalDateTime endDate) throws MessagingException {
        String subject = "Thông báo duyệt gói VIP";
        String content = "Chào " + user.getHoTen() + ",\n\n" +
        "Yêu cầu thanh toán của bạn đã được duyệt.\n" +
        "Gói VIP: " + vipPackage.getTenGoi() + "\n" +
        "Thời gian bắt đầu: " + startDate.toLocalDate() + "\n" +
        "Thời gian kết thúc: " + endDate.toLocalDate() + "\n\n" +
        "Cảm ơn bạn đã sử dụng dịch vụ.";
        EmailUtil.sendEmail(user.getEmail(), subject, content);
}


    private void sendRejectionEmail(NguoiDung user, GoiVIP vipPackage, String reason) throws MessagingException {
        String subject = "Thông báo từ chối yêu cầu thanh toán";
        String content = "Chào " + user.getHoTen() + ",\n\n" +
        "Yêu cầu thanh toán gói VIP " + (vipPackage != null ? vipPackage.getTenGoi() : "") + " của bạn đã bị từ chối.\n" +
        "Lý do: " + reason + "\n\n" +
        "Vui lòng liên hệ admin để biết thêm chi tiết.";
        EmailUtil.sendEmail(user.getEmail(), subject, content);
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Payment Request Management Servlet";
    }

}
