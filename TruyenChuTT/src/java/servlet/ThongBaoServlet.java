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
import java.util.List;
import java.util.Map;
import model.NguoiDung;
import model.ThongBao;

/**
 *
 * @author USER
 */
@WebServlet(name="ThongBaoServlet", urlPatterns={"/notifications"})
public class ThongBaoServlet extends HttpServlet {

    private final ThongBaoDAO thongBaoDAO = new ThongBaoDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        String action = request.getParameter("action");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if ("list".equals(action)) {
                // Lấy danh sách thông báo
                List<ThongBao> thongBaoList = thongBaoDAO.layThongBaoTheoNguoiDung(user.getId(), 20);
                int soThongBaoChuaDoc = thongBaoDAO.demThongBaoChuaDoc(user.getId());

                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("notifications", thongBaoList);
                result.put("unreadCount", soThongBaoChuaDoc);

                response.getWriter().write(gson.toJson(result));

            } else if ("count".equals(action)) {
                // Đếm thông báo chưa đọc
                int soThongBaoChuaDoc = thongBaoDAO.demThongBaoChuaDoc(user.getId());

                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("unreadCount", soThongBaoChuaDoc);

                response.getWriter().write(gson.toJson(result));

            } else {
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("message", "Action không hợp lệ");
                response.getWriter().write(gson.toJson(result));
            }
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "Lỗi hệ thống: " + e.getMessage());
            response.getWriter().write(gson.toJson(result));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        String action = request.getParameter("action");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if ("markRead".equals(action)) {
                // Đánh dấu thông báo đã đọc
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    long thongBaoId = Long.parseLong(idStr);
                    boolean success = thongBaoDAO.danhDauDaDoc(thongBaoId);

                    Map<String, Object> result = new HashMap<>();
                    result.put("success", success);
                    result.put("message", success ? "Đã đánh dấu đọc" : "Lỗi khi đánh dấu đọc");

                    response.getWriter().write(gson.toJson(result));
                } else {
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", false);
                    result.put("message", "ID thông báo không hợp lệ");
                    response.getWriter().write(gson.toJson(result));
                }

            } else if ("markAllRead".equals(action)) {
                // Đánh dấu tất cả thông báo đã đọc
                boolean success = thongBaoDAO.danhDauTatCaDaDoc(user.getId());

                Map<String, Object> result = new HashMap<>();
                result.put("success", success);
                result.put("message", success ? "Đã đánh dấu tất cả đã đọc" : "Lỗi khi đánh dấu đọc");

                response.getWriter().write(gson.toJson(result));

            } else if ("delete".equals(action)) {
                // Xóa thông báo
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    long thongBaoId = Long.parseLong(idStr);
                    boolean success = thongBaoDAO.xoaThongBao(thongBaoId, user.getId());

                    Map<String, Object> result = new HashMap<>();
                    result.put("success", success);
                    result.put("message", success ? "Đã xóa thông báo" : "Lỗi khi xóa thông báo");

                    response.getWriter().write(gson.toJson(result));
                } else {
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", false);
                    result.put("message", "ID thông báo không hợp lệ");
                    response.getWriter().write(gson.toJson(result));
                }

            } else {
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("message", "Action không hợp lệ");
                response.getWriter().write(gson.toJson(result));
            }
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "Lỗi hệ thống: " + e.getMessage());
            response.getWriter().write(gson.toJson(result));
        }
    }

}
