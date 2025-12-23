package servlet.admin;

import dao.BinhLuanDAO;
import dao.TruyenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import model.BinhLuan;
import model.NguoiDung;
import model.Truyen;

@WebServlet(name="QuanLyBinhLuanServlet", urlPatterns={"/admin/comments"})
public class QuanLyBinhLuanServlet extends HttpServlet {

    private BinhLuanDAO binhLuanDAO;
    private TruyenDAO truyenDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        binhLuanDAO = new BinhLuanDAO();
        truyenDAO = new TruyenDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!kiemTraQuyenAdmin(request, response)) {
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "") {
                case "detail":
                    xemChiTietBinhLuan(request, response);
                    break;
                case "search":
                    timKiemBinhLuan(request, response);
                    break;
                case "toggle-status":
                    thayDoiTrangThaiBinhLuan(request, response);
                    break;
                default:
                    hienThiDanhSachBinhLuan(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/Admin/comments.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!kiemTraQuyenAdmin(request, response)) {
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "") {
                case "delete":
                    xoaBinhLuan(request, response);
                    break;
                case "bulk-delete":
                    xoaNhieuBinhLuan(request, response);
                    break;
                case "bulk-toggle":
                    thayDoiTrangThaiNhieuBinhLuan(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/comments");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra", StandardCharsets.UTF_8.toString()));
        }
    }
    
    private boolean kiemTraQuyenAdmin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
    
    private void hienThiDanhSachBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Phân trang
            int page = layThamSoInt(request, "page", 1);
            int recordsPerPage = layThamSoInt(request, "records", 20);
            String sortOrder = request.getParameter("sort");
            String statusFilter = request.getParameter("status");
            
            if (recordsPerPage < 5) recordsPerPage = 5;
            if (recordsPerPage > 100) recordsPerPage = 100;
            
            int offset = (page - 1) * recordsPerPage;
            
            // Lấy danh sách bình luận
            List<BinhLuan> danhSachBinhLuan = binhLuanDAO.layTatCaBinhLuan(offset, recordsPerPage);
            int tongSoBinhLuan = binhLuanDAO.demTatCaBinhLuan();
            
            // Lấy danh sách truyện để filter
            List<Truyen> danhSachTruyen = truyenDAO.layTatCaTruyen();
            
            // Tính toán phân trang
            int totalPages = (int) Math.ceil((double) tongSoBinhLuan / recordsPerPage);
            
            // Set attributes
            request.setAttribute("danhSachBinhLuan", danhSachBinhLuan);
            request.setAttribute("danhSachTruyen", danhSachTruyen);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("totalRecords", tongSoBinhLuan);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("statusFilter", statusFilter);
            
            // Forward to JSP
            request.getRequestDispatcher("/Admin/comments.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách bình luận: " + e.getMessage());
            request.getRequestDispatcher("/Admin/comments.jsp").forward(request, response);
        }
    }
    
    private void xemChiTietBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
                return;
            }
            
            Long id = Long.parseLong(idStr);
            BinhLuan binhLuan = binhLuanDAO.layBinhLuanTheoId(id);
            
            if (binhLuan == null) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không tìm thấy bình luận", StandardCharsets.UTF_8.toString()));
                return;
            }
            
            // Lấy bình luận con nếu có
            List<BinhLuan> binhLuanCon = binhLuanDAO.layBinhLuanCon(binhLuan.getId());
            binhLuan.setBinhLuanCon(binhLuanCon);
            
            request.setAttribute("binhLuan", binhLuan);
            request.getRequestDispatcher("/Admin/comment-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra", StandardCharsets.UTF_8.toString()));
        }
    }
    
    private void timKiemBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String keyword = request.getParameter("keyword");
            String truyenIdStr = request.getParameter("truyenId");
            
            // Phân trang
            int page = layThamSoInt(request, "page", 1);
            int recordsPerPage = layThamSoInt(request, "records", 20);
            
            if (recordsPerPage < 5) recordsPerPage = 5;
            if (recordsPerPage > 100) recordsPerPage = 100;
            
            int offset = (page - 1) * recordsPerPage;
            
            List<BinhLuan> danhSachBinhLuan;
            int tongSoBinhLuan;
            
            // Tìm kiếm theo từ khóa
            if (keyword != null && !keyword.trim().isEmpty()) {
                danhSachBinhLuan = binhLuanDAO.timKiemBinhLuan(keyword.trim(), offset, recordsPerPage);
                tongSoBinhLuan = binhLuanDAO.demKetQuaTimKiem(keyword.trim());
            } 
            // Lọc theo truyện
            else if (truyenIdStr != null && !truyenIdStr.isEmpty()) {
                try {
                    int truyenId = Integer.parseInt(truyenIdStr);
                    danhSachBinhLuan = binhLuanDAO.layBinhLuanTheoTruyen(truyenId, offset, recordsPerPage);
                    tongSoBinhLuan = binhLuanDAO.demBinhLuanTheoTruyen(truyenId);
                } catch (NumberFormatException e) {
                    danhSachBinhLuan = binhLuanDAO.layTatCaBinhLuan(offset, recordsPerPage);
                    tongSoBinhLuan = binhLuanDAO.demTatCaBinhLuan();
                }
            } 
            // Mặc định lấy tất cả
            else {
                danhSachBinhLuan = binhLuanDAO.layTatCaBinhLuan(offset, recordsPerPage);
                tongSoBinhLuan = binhLuanDAO.demTatCaBinhLuan();
            }
            
            // Lấy danh sách truyện để filter
            List<Truyen> danhSachTruyen = truyenDAO.layTatCaTruyen();
            
            // Tính toán phân trang
            int totalPages = (int) Math.ceil((double) tongSoBinhLuan / recordsPerPage);
            
            // Set attributes
            request.setAttribute("danhSachBinhLuan", danhSachBinhLuan);
            request.setAttribute("danhSachTruyen", danhSachTruyen);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("totalRecords", tongSoBinhLuan);
            request.setAttribute("keyword", keyword);
            request.setAttribute("truyenId", truyenIdStr);
            
            // Forward to JSP
            request.getRequestDispatcher("/Admin/comments.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tìm kiếm: " + e.getMessage());
            request.getRequestDispatcher("/Admin/comments.jsp").forward(request, response);
        }
    }
    
    private void xoaBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
                return;
            }
            
            Long id = Long.parseLong(idStr);
            boolean success = binhLuanDAO.xoaBinhLuan(id);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?success=" +
                    URLEncoder.encode("Xóa bình luận thành công", StandardCharsets.UTF_8.toString()));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không thể xóa bình luận", StandardCharsets.UTF_8.toString()));
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra khi xóa", StandardCharsets.UTF_8.toString()));
        }
    }
    
    private void xoaNhieuBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String[] ids = request.getParameterValues("selectedIds");
            if (ids == null || ids.length == 0) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Vui lòng chọn ít nhất một bình luận", StandardCharsets.UTF_8.toString()));
                return;
            }

            List<Long> idList = new ArrayList<>();
            for (String idStr : ids) {
                try {
                    idList.add(Long.parseLong(idStr));
                } catch (NumberFormatException e) {
                    // Bỏ qua ID không hợp lệ
                }
            }

            if (idList.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không có ID hợp lệ", StandardCharsets.UTF_8.toString()));
                return;
            }

            boolean success = binhLuanDAO.xoaNhieuBinhLuanThucSu(idList);

            if (success) {
                String message = "Đã xóa " + idList.size() + " bình luận";
                response.sendRedirect(request.getContextPath() + "/admin/comments?success=" + 
                    URLEncoder.encode(message, StandardCharsets.UTF_8.toString()));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không thể xóa bình luận", StandardCharsets.UTF_8.toString()));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra", StandardCharsets.UTF_8.toString()));
        }
    }
    
    private void thayDoiTrangThaiBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            String statusStr = request.getParameter("status");
            
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
                return;
            }
            
            Long id = Long.parseLong(idStr);
            boolean newStatus = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);
            
            boolean success = binhLuanDAO.capNhatTrangThaiBinhLuan(id, newStatus);
            
            if (success) {
                String message = newStatus ? "Đã hiện bình luận" : "Đã ẩn bình luận";
                response.sendRedirect(request.getContextPath() + "/admin/comments?success=" +
                    URLEncoder.encode(message, StandardCharsets.UTF_8.toString()));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không thể cập nhật trạng thái", StandardCharsets.UTF_8.toString()));
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("ID không hợp lệ", StandardCharsets.UTF_8.toString()));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra", StandardCharsets.UTF_8.toString()));
        }
    }
    
    private void thayDoiTrangThaiNhieuBinhLuan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String[] ids = request.getParameterValues("selectedIds");
            String statusStr = request.getParameter("newStatus");
            
            if (ids == null || ids.length == 0) {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Vui lòng chọn ít nhất một bình luận", StandardCharsets.UTF_8.toString()));
                return;
            }

            boolean newStatus = "1".equals(statusStr) || "true".equalsIgnoreCase(statusStr);
            int successCount = 0;
            
            for (String idStr : ids) {
                try {
                    Long id = Long.parseLong(idStr);
                    if (binhLuanDAO.capNhatTrangThaiBinhLuan(id, newStatus)) {
                        successCount++;
                    }
                } catch (NumberFormatException e) {
                    // Bỏ qua ID không hợp lệ
                }
            }

            if (successCount > 0) {
                String action = newStatus ? "hiện" : "ẩn";
                String message = "Đã " + action + " " + successCount + " bình luận";
                response.sendRedirect(request.getContextPath() + "/admin/comments?success=" + 
                    URLEncoder.encode(message, StandardCharsets.UTF_8.toString()));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                    URLEncoder.encode("Không thể cập nhật trạng thái", StandardCharsets.UTF_8.toString()));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/comments?error=" +
                URLEncoder.encode("Có lỗi xảy ra", StandardCharsets.UTF_8.toString()));
        }
    }
    
    // Helper method để lấy tham số integer
    private int layThamSoInt(HttpServletRequest request, String paramName, int defaultValue) {
        String paramStr = request.getParameter(paramName);
        if (paramStr != null && !paramStr.isEmpty()) {
            try {
                int value = Integer.parseInt(paramStr);
                return value > 0 ? value : defaultValue;
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }
}