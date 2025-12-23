/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import com.google.gson.Gson;
import dao.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import model.NguoiDung;

/**
 *
 * @author USER
 */
@WebServlet(name="NotificationActionServlet", urlPatterns={"/notification/read", "/notification/markAllRead", "/notification/delete"})
public class NotificationActionServlet extends HttpServlet {

     private final ThongBaoDAO thongBaoDAO = new ThongBaoDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding để tránh lỗi charset
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        String requestURI = request.getRequestURI();

        try {
            if (requestURI.endsWith("/notification/read")) {
                handleMarkAsRead(request, response, user);
            } else if (requestURI.endsWith("/notification/markAllRead")) {
                handleMarkAllAsRead(request, response, user);
            } else if (requestURI.endsWith("/notification/delete")) {
                handleDeleteNotification(request, response, user);
            } else {
                sendErrorResponse(response, "Action không hợp lệ");
            }
        } catch (Exception e) {
            System.err.println("Lỗi trong NotificationActionServlet: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Lỗi hệ thống: " + e.getMessage());
        }
    }
    
    private void handleMarkAsRead(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws IOException {
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            sendErrorResponse(response, "ID thông báo không hợp lệ");
            return;
        }
        
        try {
            long thongBaoId = Long.parseLong(idStr);
            boolean success = thongBaoDAO.danhDauDaDoc(thongBaoId, user.getId());
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", success);
            result.put("message", success ? "Đã đánh dấu thông báo là đã đọc" : "Không thể đánh dấu thông báo này");
            
            // Trả về số thông báo chưa đọc hiện tại
            if (success) {
                int unreadCount = thongBaoDAO.demThongBaoChuaDoc(user.getId());
                result.put("unreadCount", unreadCount);
            }
            
            response.getWriter().write(gson.toJson(result));
        } catch (NumberFormatException e) {
            sendErrorResponse(response, "ID thông báo không hợp lệ");
        }
    }
    
    private void handleMarkAllAsRead(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws IOException {
        boolean success = thongBaoDAO.danhDauTatCaDaDoc(user.getId());
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("message", success ? "Đã đánh dấu tất cả thông báo là đã đọc" : "Không thể đánh dấu tất cả thông báo");
        
        if (success) {
            result.put("unreadCount", 0);
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    private void handleDeleteNotification(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws IOException {
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            sendErrorResponse(response, "ID thông báo không hợp lệ");
            return;
        }
        
        try {
            long thongBaoId = Long.parseLong(idStr);
            boolean success = thongBaoDAO.xoaThongBao(thongBaoId, user.getId());
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", success);
            result.put("message", success ? "Đã xóa thông báo" : "Không thể xóa thông báo này");
            
            // Trả về số thông báo chưa đọc hiện tại
            if (success) {
                int unreadCount = thongBaoDAO.demThongBaoChuaDoc(user.getId());
                result.put("unreadCount", unreadCount);
            }
            
            response.getWriter().write(gson.toJson(result));
        } catch (NumberFormatException e) {
            sendErrorResponse(response, "ID thông báo không hợp lệ");
        }
    }
    
    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", message);
        response.getWriter().write(gson.toJson(result));
    }
}
