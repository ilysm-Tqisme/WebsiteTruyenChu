package servlet.admin;

import dao.TheLoaiDAO;
import model.NguoiDung;
import model.TheLoai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "TheLoaiServlet", urlPatterns = {"/admin/categories"})
public class TheLoaiServlet extends HttpServlet {

    private final TheLoaiDAO theLoaiDAO = new TheLoaiDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra phân quyền ADMIN
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            listTheLoai(request, response);
        } else {
            switch (action) {
                case "create":
                    createTheLoai(request, response);
                    break;
                case "delete":
                    deleteTheLoai(request, response);
                    break;
                case "search":
                    searchTheLoai(request, response);
                    break;
                default:
                    listTheLoai(request, response);
                    break;
            }
        }
    }

    private void listTheLoai(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("dsTheLoai", theLoaiDAO.layDanhSachTheLoai());
        request.getRequestDispatcher("/Admin/TheLoaiDanhSach.jsp").forward(request, response);
    }

    private void createTheLoai(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenTheLoai = request.getParameter("tenTheLoai");
        String moTa = request.getParameter("moTa");
        String mauSac = request.getParameter("mauSac");

        if (tenTheLoai == null || tenTheLoai.trim().isEmpty()) {
            request.setAttribute("message", "Tên thể loại không được để trống!");
        } else if (theLoaiDAO.kiemTraTenTrung(tenTheLoai)) {
            request.setAttribute("message", "Tên thể loại đã tồn tại!");
        } else {
            TheLoai theLoai = new TheLoai();
            theLoai.setTenTheLoai(tenTheLoai);
            theLoai.setMoTa(moTa);
            theLoai.setMauSac(mauSac);
            theLoai.setTrangThai(true);

            boolean result = theLoaiDAO.taoTheLoai(theLoai);
            if (result) {
                request.setAttribute("message", "Thêm thể loại thành công!");
            } else {
                request.setAttribute("message", "Có lỗi khi thêm thể loại!");
            }
        }

        listTheLoai(request, response);
    }

    private void deleteTheLoai(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (theLoaiDAO.kiemTraTheLoaiDangSuDung(id)) {
                request.setAttribute("message", "Không thể xóa thể loại đang có truyện!");
            } else {
                theLoaiDAO.xoaTheLoai(id);
                request.setAttribute("message", "Xóa thể loại thành công!");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "ID không hợp lệ!");
        }
        listTheLoai(request, response);
    }

    private void searchTheLoai(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("searchTerm");
        request.setAttribute("dsTheLoai", theLoaiDAO.timKiemTheLoai(keyword));
        request.setAttribute("isSearchResult", true);
        request.setAttribute("searchTerm", keyword);
        request.getRequestDispatcher("/Admin/TheLoaiDanhSach.jsp").forward(request, response);
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
        return "Quản lý thể loại";
    }
}
