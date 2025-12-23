/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import dao.TheLoaiDAO;
import dao.TruyenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.TheLoai;
import model.Truyen;

/**
 *
 * @author USER
 */
@WebServlet(name="CategoryServlet", urlPatterns={"/truyen"})
public class CategoryServlet extends HttpServlet {

    private final TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
    private final TruyenDAO truyenDAO = new TruyenDAO();
    
    private static final int STORIES_PER_PAGE = 12;// số truyện 1 trang

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        // ✅ Lấy các tham số từ request
        String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");
        String theLoaiParam = request.getParameter("theLoai");
        String sortBy = request.getParameter("sort");
        String pageParam = request.getParameter("page");
        
        // ✅ Xử lý phân trang
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        int offset = (currentPage - 1) * STORIES_PER_PAGE;
        
        // ✅ Xử lý thể loại
        Integer theLoaiId = null;
        if (theLoaiParam != null && !theLoaiParam.isEmpty()) {
            try {
                theLoaiId = Integer.parseInt(theLoaiParam);
            } catch (NumberFormatException e) {
                theLoaiId = null;
            }
        }
        
        List<Truyen> danhSachTruyen;
        int totalStories;
        String categoryTitle;
        String categoryDescription;
        
        // ✅ Kiểm tra nếu có tìm kiếm hoặc lọc
        if ((keyword != null && !keyword.trim().isEmpty()) || theLoaiId != null || (sortBy != null && !sortBy.isEmpty())) {
            // Sử dụng chức năng tìm kiếm và lọc mới
            danhSachTruyen = truyenDAO.timKiemVaLocTruyen(keyword, theLoaiId, sortBy, offset, STORIES_PER_PAGE);
            totalStories = truyenDAO.demTongSoTruyenTheoLoc(keyword, theLoaiId);
            
            // Tạo tiêu đề động
            if (keyword != null && !keyword.trim().isEmpty()) {
                categoryTitle = "Kết quả tìm kiếm: \"" + keyword + "\"";
                categoryDescription = "Tìm thấy " + totalStories + " truyện phù hợp";
            } else if (theLoaiId != null) {
                TheLoai theLoai = theLoaiDAO.layThongTinTheLoai(theLoaiId);
                categoryTitle = "Thể loại: " + (theLoai != null ? theLoai.getTenTheLoai() : "Không xác định");
                categoryDescription = "Tất cả truyện thuộc thể loại này";
            } else {
                categoryTitle = "Danh sách truyện";
                categoryDescription = "Tất cả truyện được sắp xếp";
            }
        } else {
            // ✅ Xử lý theo category như cũ (vip, hot, new)
            switch (category != null ? category : "") {
                case "vip":
                    danhSachTruyen = truyenDAO.layTatCaTruyenVIP(offset, STORIES_PER_PAGE);
                    totalStories = truyenDAO.demTongSoTruyenVIP();
                    categoryTitle = "Truyện VIP";
                    categoryDescription = "Nội dung độc quyền dành cho thành viên VIP";
                    break;
                    
                case "hot":
                    danhSachTruyen = truyenDAO.layTatCaTruyenHot(offset, STORIES_PER_PAGE);
                    totalStories = truyenDAO.demTongSoTruyenHot();
                    categoryTitle = "Truyện Hot";
                    categoryDescription = "Những truyện được yêu thích nhất";
                    break;
                    
                case "new":
                    danhSachTruyen = truyenDAO.layTatCaTruyenMoi(offset, STORIES_PER_PAGE);
                    totalStories = truyenDAO.demTongSoTruyenMoi();
                    categoryTitle = "Truyện Mới";
                    categoryDescription = "Truyện mới cập nhật gần đây";
                    break;
                    
                default:
                    // Nếu không có category hoặc category không hợp lệ, hiển thị tất cả truyện
                    danhSachTruyen = truyenDAO.getTruyen();
                    totalStories = danhSachTruyen.size();
                    categoryTitle = "Tất cả truyện";
                    categoryDescription = "Danh sách tất cả các truyện";
                    
                    // Áp dụng phân trang cho tất cả truyện
                    int fromIndex = Math.min(offset, danhSachTruyen.size());
                    int toIndex = Math.min(offset + STORIES_PER_PAGE, danhSachTruyen.size());
                    if (fromIndex < toIndex) {
                        danhSachTruyen = danhSachTruyen.subList(fromIndex, toIndex);
                    } else {
                        danhSachTruyen.clear();
                    }
                    break;
            }
        }
        
        // ✅ Tính toán phân trang
        int totalPages = (int) Math.ceil((double) totalStories / STORIES_PER_PAGE);
        
        // ✅ Lấy danh sách thể loại để hiển thị trong filter
        List<TheLoai> danhSachTheLoai = theLoaiDAO.layDanhSachTheLoai();
        
        // ✅ Set attributes
        request.setAttribute("danhSachTruyen", danhSachTruyen);
        request.setAttribute("danhSachTheLoai", danhSachTheLoai);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalStories", totalStories);
        request.setAttribute("category", category);
        request.setAttribute("categoryTitle", categoryTitle);
        request.setAttribute("categoryDescription", categoryDescription);
        
        // ✅ Set các tham số tìm kiếm để giữ state trên form
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCategory", theLoaiId);
        request.setAttribute("sortBy", sortBy);
        
        // ✅ Forward đến trang JSP
        request.getRequestDispatcher("/User/CategoryList.jsp").forward(request, response);
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
        return "Servlet xử lý danh sách truyện theo danh mục với tìm kiếm và lọc";
    }
}