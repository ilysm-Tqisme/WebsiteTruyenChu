/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet.admin;

import dao.TacGiaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.NguoiDung;
import model.TacGia;

/**
 *
 * @author USER
 */
@WebServlet(name="AuthorManagementServlet", urlPatterns={"/admin/authors"})
public class AuthorManagementServlet extends HttpServlet {

    private final TacGiaDAO tacGiaDAO = new TacGiaDAO();
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
        String action = request.getParameter("action");

        if (action == null) {
            listAuthors(request, response);
        } else {
            switch (action) {
                case "view":
                    viewAuthor(request, response);
                    break;
                case "create":
                    createAuthor(request, response);
                    break;
                case "delete":
                    deleteAuthor(request, response);
                    break;
                case "search":
                    searchAuthors(request, response);
                    break;
                default:
                    listAuthors(request, response);
                    break;
            }
        }
}
    
    private void listAuthors(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        List<TacGia> dsTacGia = tacGiaDAO.layDanhSachTacGia();
        request.setAttribute("dsTacGia", dsTacGia);
        request.getRequestDispatcher("/Admin/QuanLyTacGia.jsp").forward(request, response);
    }

    private void viewAuthor(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            TacGia tg = tacGiaDAO.layThongTinTacGia(id);
            if (tg != null) {
                request.setAttribute("tacGia", tg);
                request.getRequestDispatcher("/Admin/TacGiaView.jsp").forward(request, response);
            } else {
                listAuthors(request, response);
            }
        } catch (NumberFormatException e) {
            listAuthors(request, response);
        }
    }

    private void createAuthor(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String tenTacGia = request.getParameter("tenTacGia");
    String moTa = request.getParameter("moTa");
    String anhDaiDien = request.getParameter("anhDaiDien");

    // ✅ Kiểm tra trùng tên
    if (tacGiaDAO.kiemTraTenTrung(tenTacGia)) {
        request.setAttribute("errorMessage", "Tên Tác Giả đã tồn tại, vui lòng chọn tên khác!");
        listAuthors(request, response);
        return; // STOP!
    }

    TacGia tg = new TacGia();
    tg.setTenTacGia(tenTacGia);
    tg.setMoTa(moTa);
    tg.setAnhDaiDien(anhDaiDien);

    boolean success = tacGiaDAO.taoTacGia(tg);

    if (success) {
        request.setAttribute("message", "Đã thêm Tác Giả thành công!");
    } else {
        request.setAttribute("errorMessage", "Lỗi khi thêm Tác Giả.");
    }

    listAuthors(request, response);
}


    private void deleteAuthor(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int id = Integer.parseInt(request.getParameter("id"));

        // ✅ Check đang dùng
        if (tacGiaDAO.kiemTraTacGiaDangSuDung(id)) {
            request.setAttribute("errorMessage", "Không thể xóa vì Tác Giả đang thuộc 1 hoặc nhiều Truyện!");
            listAuthors(request, response);
            return;
        }

        boolean success = tacGiaDAO.xoaTacGia(id);

        if (success) {
            request.setAttribute("message", "Đã xóa Tác Giả thành công!");
        } else {
            request.setAttribute("errorMessage", "Lỗi khi xóa Tác Giả.");
        }
    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "ID Tác Giả không hợp lệ.");
    }

    listAuthors(request, response);
}


    private void searchAuthors(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String keyword = request.getParameter("searchTerm");
        List<TacGia> dsTacGia = tacGiaDAO.timKiemTacGia(keyword);

        request.setAttribute("dsTacGia", dsTacGia);
        request.setAttribute("searchTerm", keyword);
        request.setAttribute("isSearchResult", true);

        request.getRequestDispatcher("/Admin/QuanLyTacGia.jsp").forward(request, response);
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
