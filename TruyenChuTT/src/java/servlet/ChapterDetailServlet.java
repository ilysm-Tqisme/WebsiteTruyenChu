/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import dao.ChuongDAO;
import dao.TaiKhoanVIPDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Chuong;
import model.NguoiDung;

/**
 *
 * @author USER
 */
@WebServlet(name="ChapterDetailServlet", urlPatterns={"/chapter"})
public class ChapterDetailServlet extends HttpServlet {

    private final ChuongDAO chuongDAO = new ChuongDAO();
    private final TaiKhoanVIPDAO vipDAO = new TaiKhoanVIPDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String chapterIdParam = request.getParameter("id");
        
        if (chapterIdParam == null || chapterIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int chapterId = Integer.parseInt(chapterIdParam);
            
            // Lấy thông tin chương
            Chuong chuong = chuongDAO.layChuongTheoId(chapterId);
            
            if (chuong == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            // Kiểm tra người dùng hiện tại
            HttpSession session = request.getSession();
            NguoiDung nguoiDung = (NguoiDung) session.getAttribute("user");
            boolean isVIP = false;
            
            if (nguoiDung != null) {
                isVIP = vipDAO.kiemTraVIP(nguoiDung.getId());
            }
            
            // Kiểm tra quyền xem chương VIP
            if (chuong.isChiDanhChoVIP() && !isVIP) {
                request.setAttribute("errorMessage", "Bạn cần nâng cấp tài khoản VIP để đọc chương này!");
                request.setAttribute("errorType", "vip");
                request.setAttribute("chuong", chuong);
                request.getRequestDispatcher("/User/ChapterDetail.jsp").forward(request, response);
                return;
            }
            
            // Cập nhật lượt xem chương
            chuongDAO.capNhatLuotXem(chapterId);
            
            // Lấy chương trước và sau
            Chuong chuongTruoc = chuongDAO.layChuongTruoc(chuong.getTruyen().getId(), chuong.getSoChuong());
            Chuong chuongSau = chuongDAO.layChuongSau(chuong.getTruyen().getId(), chuong.getSoChuong());
            
            // Truyền dữ liệu vào request
            request.setAttribute("chuong", chuong);
            request.setAttribute("chuongTruoc", chuongTruoc);
            request.setAttribute("chuongSau", chuongSau);
            request.setAttribute("isVIP", isVIP);
            
            // Forward đến trang đọc chương
            request.getRequestDispatcher("/User/ChapterDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

}
