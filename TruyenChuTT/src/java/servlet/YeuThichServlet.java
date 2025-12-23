/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import com.google.gson.JsonObject;
import dao.TruyenDAO;
import dao.YeuThichDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NguoiDung;
import model.Truyen;
import model.YeuThich;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;
import model.utils.Pagination;

/**
 *
 * @author USER
 */
@WebServlet(name = "YeuThichServlet", urlPatterns = {"/yeuthich/*"})
public class YeuThichServlet extends HttpServlet {

    private final YeuThichDAO yeuThichDAO = new YeuThichDAO();
    private final TruyenDAO truyenDAO = new TruyenDAO();
    private static final int ITEMS_PER_PAGE = 12;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            pathInfo = "/list";
        }
        
        switch (pathInfo) {
            case "/list":
                showList(request, response, user);
                break;
            case "/check":
                checkStatus(request, response, user);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        
        if (user == null) {
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Vui lòng đăng nhập");
            sendJsonResponse(response, jsonResponse);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            pathInfo = "/add";
        }
        
        switch (pathInfo) {
            case "/add":
                addToFavorites(request, response, user);
                break;
            case "/remove":
                removeFromFavorites(request, response, user);
                break;
            default:
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Action không hợp lệ");
                sendJsonResponse(response, jsonResponse);
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        try {
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            int offset = (page - 1) * ITEMS_PER_PAGE;
            
            // Lấy danh sách truyện yêu thích
            List<YeuThich> danhSach = yeuThichDAO.layDanhSachTruyenYeuThich(user.getId(), offset, ITEMS_PER_PAGE);
            
            // Đếm tổng số truyện yêu thích
            int totalItems = yeuThichDAO.demTruyenYeuThichTheoNguoiDung(user.getId());
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            
            Pagination pagination = new Pagination(page, totalPages, totalItems);
            
            request.setAttribute("danhSach", danhSach);
            request.setAttribute("pagination", pagination);
            request.setAttribute("totalItems", totalItems);
            
            request.getRequestDispatcher("/User/YeuThich.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/User/YeuThich.jsp").forward(request, response);
        }
    }

    private void checkStatus(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String truyenIdStr = request.getParameter("truyenId");
            if (truyenIdStr == null || truyenIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Thiếu ID truyện");
                sendJsonResponse(response, jsonResponse);
                return;
            }
            
            int truyenId = Integer.parseInt(truyenIdStr);
            boolean isFavorite = yeuThichDAO.kiemTraTruyenYeuThich(user.getId(), truyenId);
            
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("isFavorite", isFavorite);
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        sendJsonResponse(response, jsonResponse);
    }

    private void addToFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String truyenIdStr = request.getParameter("truyenId");
            if (truyenIdStr == null || truyenIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Thiếu ID truyện");
                sendJsonResponse(response, jsonResponse);
                return;
            }
            
            int truyenId = Integer.parseInt(truyenIdStr);
            
            // Kiểm tra truyện có tồn tại không
            Truyen truyen = truyenDAO.layTruyenTheoId(truyenId);
            if (truyen == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không tìm thấy truyện");
                sendJsonResponse(response, jsonResponse);
                return;
            }
            
            // Tạo YeuThich và thêm vào yêu thích
            YeuThich yeuThich = new YeuThich();
            yeuThich.setNguoiDung(user);
            yeuThich.setTruyen(truyen);
            yeuThich.setNgayYeuThich(LocalDateTime.now());
            
            boolean success = yeuThichDAO.themTruyenVaoYeuThich(yeuThich);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Đã thêm vào yêu thích");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Truyện đã có trong yêu thích rồi");
            }
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        sendJsonResponse(response, jsonResponse);
    }

    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String truyenIdStr = request.getParameter("truyenId");
            if (truyenIdStr == null || truyenIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Thiếu ID truyện");
                sendJsonResponse(response, jsonResponse);
                return;
            }
            
            int truyenId = Integer.parseInt(truyenIdStr);
            
            boolean success = yeuThichDAO.xoaTruyenKhoiYeuThich(user.getId(), truyenId);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Đã xóa khỏi yêu thích");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không tìm thấy truyện trong yêu thích");
            }
            
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        sendJsonResponse(response, jsonResponse);
    }

    private void sendJsonResponse(HttpServletResponse response, JsonObject jsonResponse) throws IOException {
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}

