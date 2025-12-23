/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import dao.BinhLuanDAO;
import dao.ChuongDAO;
import dao.TaiKhoanVIPDAO;
import dao.TheLoaiDAO;
import dao.TruyenDAO;
import dao.YeuThichDAO;
import dao.TuTruyenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.BinhLuan;
import model.Chuong;
import model.NguoiDung;
import model.Truyen;

/**
 *
 * @author USER
 */
@WebServlet(name="StoryDetailServlet", urlPatterns={"/story"})
public class StoryDetailServlet extends HttpServlet {

    private final TruyenDAO truyenDAO = new TruyenDAO();
    private final ChuongDAO chuongDAO = new ChuongDAO();
    private final TaiKhoanVIPDAO vipDAO = new TaiKhoanVIPDAO();
    private final BinhLuanDAO binhLuanDAO = new BinhLuanDAO();
    private final YeuThichDAO yeuThichDAO = new YeuThichDAO();
    private final TuTruyenDAO tuTruyenDAO = new TuTruyenDAO();
    private final TheLoaiDAO theLoaiDAO = new TheLoaiDAO();

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String storyIdParam = request.getParameter("id");
        String pageParam = request.getParameter("page");
        
        if (storyIdParam == null || storyIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int storyId = Integer.parseInt(storyIdParam);
            int page = 1;
            
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            // Lấy thông tin truyện
            Truyen truyen = truyenDAO.layTruyenTheoId(storyId);
            
            if (truyen == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
//            // Lấy danh sách tên thể loại của truyện
//        List<String> tenTheLoai = theLoaiDAO.layThongTinTheLoai(storyId);
//            truyen.setTheLoaiTenList(tenTheLoai);
            // Kiểm tra người dùng hiện tại
            HttpSession session = request.getSession();
            NguoiDung nguoiDung = (NguoiDung) session.getAttribute("user");
            boolean isVIP = false;
            
            if (nguoiDung != null) {
                isVIP = vipDAO.kiemTraVIP(nguoiDung.getId());
                nguoiDung.setTrangThaiVIP(isVIP);
            }
            
            // Kiểm tra quyền xem truyện VIP
            if (truyen.isChiDanhChoVIP() && !isVIP) {
                request.setAttribute("errorMessage", "Bạn cần nâng cấp tài khoản VIP để xem truyện này!");
                request.setAttribute("errorType", "vip");
                request.setAttribute("truyen", truyen);
                request.getRequestDispatcher("/User/StoryDetail.jsp").forward(request, response);
                return;
            }
            
            // Phân trang cho danh sách chương
            int pageSize = 50;
            int offset = (page - 1) * pageSize;
            
            // Lấy danh sách chương
            List<Chuong> danhSachChuong = chuongDAO.layChuongTheoTruyen(storyId, offset, pageSize);
            
            // Đếm tổng số chương
            int totalChapters = chuongDAO.demSoChuongTheoTruyen(storyId);
            int totalPages = (int) Math.ceil((double) totalChapters / pageSize);
            
            // Lấy bình luận gần đây (5 bình luận đầu tiên)
            List<BinhLuan> recentComments = binhLuanDAO.layBinhLuanTheoTruyen(storyId, 0, 5);
            
            // Lấy thông tin VIP cho từng bình luận
            for (BinhLuan binhLuan : recentComments) {
                boolean commentUserIsVIP = vipDAO.kiemTraVIP(binhLuan.getNguoiDung().getId());
                binhLuan.getNguoiDung().setTrangThaiVIP(commentUserIsVIP);
            }
            
            // Đếm tổng số bình luận
            int totalComments = binhLuanDAO.demBinhLuanTheoTruyen(storyId);
            
            // Cập nhật lượt xem truyện
            truyenDAO.capNhatLuotXem(storyId);
            
            // Kiểm tra trạng thái yêu thích và tủ truyện
            boolean isFavorite = false;
            boolean isInLibrary = false;
            
            if (nguoiDung != null) {
                isFavorite = yeuThichDAO.kiemTraTruyenYeuThich(nguoiDung.getId(), storyId);
                isInLibrary = tuTruyenDAO.kiemTraTruyenTrongTu(nguoiDung.getId(), storyId);
            }
            
            // Truyền dữ liệu vào request
            request.setAttribute("truyen", truyen);
            request.setAttribute("danhSachChuong", danhSachChuong);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalChapters", totalChapters);
            request.setAttribute("isVIP", isVIP);
            request.setAttribute("recentComments", recentComments);
            request.setAttribute("totalComments", totalComments);
            request.setAttribute("isFavorite", isFavorite);
            request.setAttribute("isInLibrary", isInLibrary);
            
            // Forward đến trang chi tiết
            request.getRequestDispatcher("/User/StoryDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}