/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.BinhLuanDAO;
import dao.TaiKhoanVIPDAO;
import dao.TruyenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import model.BinhLuan;
import model.NguoiDung;
import model.Truyen;

/**
 *
 * @author USER
 */
@WebServlet(name="CommentServlet", urlPatterns={"/comments"})
public class CommentServlet extends HttpServlet {

    private final BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
    private final TruyenDAO truyenDAO = new TruyenDAO();
    private final TaiKhoanVIPDAO taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    
    private static final int COMMENTS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if ("loadComments".equals(action)) {
            loadComments(request, response);
        } else {
            showCommentsPage(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding và response type trước khi làm gì khác
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String action = request.getParameter("action");
        
        System.out.println("DEBUG: CommentServlet POST - action: " + action);
        
        switch (action != null ? action : "") {
            case "add":
                addComment(request, response);
                break;
            case "delete":
                deleteComment(request, response);
                break;
            case "reply":
                replyComment(request, response);
                break;
            default:
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "Action không hợp lệ: " + action);
                PrintWriter out = response.getWriter();
                out.print(errorResponse.toString());
                out.flush();
        }
    }
    
    private void showCommentsPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String truyenIdStr = request.getParameter("truyenId");
        if (truyenIdStr == null || truyenIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID truyện");
            return;
        }
        
        try {
            int truyenId = Integer.parseInt(truyenIdStr);
            
            // Lấy thông tin truyện
            Truyen truyen = truyenDAO.layTruyenTheoId(truyenId);
            if (truyen == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy truyện");
                return;
            }
            
            // Lấy tham số phân trang và sắp xếp
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            String sortOrder = request.getParameter("sort");
            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "newest"; // Mặc định sắp xếp mới nhất
            }
            
            int offset = (page - 1) * COMMENTS_PER_PAGE;
            
            // Lấy danh sách bình luận
            List<BinhLuan> binhLuanList = binhLuanDAO.layBinhLuanTheoTruyenVoiSapXep(
                truyenId, offset, COMMENTS_PER_PAGE, sortOrder);
            
            // Lấy thông tin VIP cho từng bình luận
            for (BinhLuan binhLuan : binhLuanList) {
                boolean isVIP = taiKhoanVIPDAO.kiemTraVIP(binhLuan.getNguoiDung().getId());
                binhLuan.getNguoiDung().setTrangThaiVIP(isVIP);
            }
            
            // Đếm tổng số bình luận
            int totalComments = binhLuanDAO.demBinhLuanTheoTruyen(truyenId);
            int totalPages = (int) Math.ceil((double) totalComments / COMMENTS_PER_PAGE);
            
            // Kiểm tra user hiện tại có VIP không
            HttpSession session = request.getSession();
            NguoiDung currentUser = (NguoiDung) session.getAttribute("user");
            boolean currentUserIsVIP = false;
            if (currentUser != null) {
                currentUserIsVIP = taiKhoanVIPDAO.kiemTraVIP(currentUser.getId());
            }
            
            // Set attributes
            request.setAttribute("truyen", truyen);
            request.setAttribute("binhLuanList", binhLuanList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalComments", totalComments);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("currentUserIsVIP", currentUserIsVIP);
            
            // Forward to JSP
            request.getRequestDispatcher("/User/comments.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID truyện không hợp lệ");
        }
    }
    
    private void loadComments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            int truyenId = Integer.parseInt(request.getParameter("truyenId"));
            int page = Integer.parseInt(request.getParameter("page"));
            String sortOrder = request.getParameter("sort");
            
            int offset = (page - 1) * COMMENTS_PER_PAGE;
            
            List<BinhLuan> binhLuanList = binhLuanDAO.layBinhLuanTheoTruyenVoiSapXep(
                truyenId, offset, COMMENTS_PER_PAGE, sortOrder);
            
            // Lấy thông tin VIP cho từng bình luận
            for (BinhLuan binhLuan : binhLuanList) {
                boolean isVIP = taiKhoanVIPDAO.kiemTraVIP(binhLuan.getNguoiDung().getId());
                binhLuan.getNguoiDung().setTrangThaiVIP(isVIP);
            }
            
            Gson gson = new Gson();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("comments", gson.toJsonTree(binhLuanList));
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi khi tải bình luận");
            e.printStackTrace();
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private void addComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            HttpSession session = request.getSession();
            NguoiDung currentUser = (NguoiDung) session.getAttribute("user");
            
            System.out.println("DEBUG: Current user: " + (currentUser != null ? currentUser.getHoTen() : "null"));
            
            if (currentUser == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Vui lòng đăng nhập để bình luận");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            String truyenIdStr = request.getParameter("truyenId");
            String noiDung = request.getParameter("noiDung");
            String binhLuanChaIdStr = request.getParameter("binhLuanChaId");
            
            System.out.println("DEBUG: truyenId: " + truyenIdStr);
            System.out.println("DEBUG: noiDung: " + noiDung);
            
            if (truyenIdStr == null || truyenIdStr.isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Thiếu ID truyện");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            if (noiDung == null || noiDung.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Nội dung bình luận không được để trống");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            int truyenId = Integer.parseInt(truyenIdStr);
            
            // Lấy thông tin truyện
            Truyen truyen = truyenDAO.layTruyenTheoId(truyenId);
            if (truyen == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không tìm thấy truyện");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            // Tạo bình luận mới
            BinhLuan binhLuan = new BinhLuan();
            binhLuan.setNguoiDung(currentUser);
            binhLuan.setTruyen(truyen);
            binhLuan.setNoiDung(noiDung.trim());
            binhLuan.setTrangThai(true);
            binhLuan.setNgayTao(LocalDateTime.now());
            
            // Xử lý bình luận trả lời
            if (binhLuanChaIdStr != null && !binhLuanChaIdStr.isEmpty()) {
                try {
                    Long binhLuanChaId = Long.parseLong(binhLuanChaIdStr);
                    BinhLuan binhLuanCha = new BinhLuan();
                    binhLuanCha.setId(binhLuanChaId);
                    binhLuan.setBinhLuanCha(binhLuanCha);
                } catch (NumberFormatException e) {
                    // Ignore invalid parent comment ID
                }
            }
            
            System.out.println("DEBUG: Attempting to save comment...");
            boolean success = binhLuanDAO.themBinhLuan(binhLuan);
            System.out.println("DEBUG: Save result: " + success);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Bình luận thành công");
                
                // Kiểm tra VIP cho user hiện tại
                boolean isVIP = taiKhoanVIPDAO.kiemTraVIP(currentUser.getId());
                jsonResponse.addProperty("isVIP", isVIP);
                
                // Trả về thông tin bình luận mới để hiển thị ngay lập tức
                JsonObject commentData = new JsonObject();
                commentData.addProperty("id", binhLuan.getId());
                commentData.addProperty("noiDung", binhLuan.getNoiDung());
                commentData.addProperty("ngayTaoFormatted", binhLuan.getNgayTaoFormatted());
                
                JsonObject userData = new JsonObject();
                userData.addProperty("hoTen", currentUser.getHoTen());
                userData.addProperty("trangThaiVIP", isVIP);
                userData.addProperty("anhDaiDien", currentUser.getAnhDaiDien());
                userData.addProperty("id", currentUser.getId());
                
                commentData.add("nguoiDung", userData);
                jsonResponse.add("commentData", commentData);
                
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Có lỗi xảy ra khi thêm bình luận");
            }
            
        } catch (Exception e) {
            System.out.println("DEBUG: Exception in addComment: " + e.getMessage());
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private void deleteComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        JsonObject jsonResponse = new JsonObject();
        
        HttpSession session = request.getSession();
        NguoiDung currentUser = (NguoiDung) session.getAttribute("user");
        
        if (currentUser == null) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Vui lòng đăng nhập");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
            return;
        }
        
        try {
            Long binhLuanId = Long.parseLong(request.getParameter("binhLuanId"));
            
            // Lấy thông tin bình luận
            BinhLuan binhLuan = binhLuanDAO.layBinhLuanTheoId(binhLuanId);
            if (binhLuan == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không tìm thấy bình luận");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            // Kiểm tra quyền xóa
            boolean canDelete = false;
            
            // Admin có thể xóa tất cả bình luận
            if ("ADMIN".equals(currentUser.getVaiTro())) {
                canDelete = true;
            }
            // User chỉ có thể xóa bình luận của chính mình
            // Nhưng không thể xóa bình luận của admin (trừ khi là admin)
            else if (binhLuan.getNguoiDung().getId() == currentUser.getId()) {
                // Kiểm tra xem bình luận có phải của admin không
                if (!"ADMIN".equals(binhLuan.getNguoiDung().getVaiTro())) {
                    canDelete = true;
                }
            }
            
            if (!canDelete) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Bạn không có quyền xóa bình luận này");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }
            
            boolean success = binhLuanDAO.xoaBinhLuan(binhLuanId);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Xóa bình luận thành công");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Có lỗi xảy ra khi xóa bình luận");
            }
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private void replyComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tương tự như addComment nhưng với parent comment ID
        addComment(request, response);
    }
}
