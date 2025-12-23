/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet.admin;

import dao.TacGiaDAO;
import dao.TheLoaiDAO;
import dao.TruyenDAO;
import java.io.IOException;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.NguoiDung;
import model.TacGia;
import model.TheLoai;
import model.Truyen;

/**
 *
 * @author USER
 */
@WebServlet(name="StoryServlet", urlPatterns={"/admin/stories"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class StoryServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/images";
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // ✅ Check đăng nhập + quyền ADMIN
        HttpSession session = request.getSession(false);
        NguoiDung user = (session != null) ? (NguoiDung) session.getAttribute("user") : null;
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        TruyenDAO truyenDAO = new TruyenDAO();
        TacGiaDAO tacGiaDAO = new TacGiaDAO();
        TheLoaiDAO theLoaiDAO = new TheLoaiDAO();

        try {
            switch (action) {
                case "create":
                    hienForm(request, response, tacGiaDAO, theLoaiDAO, null);
                    break;
                case "insert":
                    them(request, response, truyenDAO, tacGiaDAO, user);
                    break;
                case "edit":
                    hienFormEdit(request, response, truyenDAO, tacGiaDAO, theLoaiDAO);
                    break;
                case "update":
                    capNhat(request, response, truyenDAO, tacGiaDAO, user);
                    break;
                case "delete":
                    xoa(request, response, truyenDAO);
                    break;
                case "filter":
                    loc(request, response, truyenDAO, theLoaiDAO);
                    break;
                case "search":
                    timKiem(request, response, truyenDAO, theLoaiDAO);
                    break;
                case "top":
                    layTop(request, response, truyenDAO, theLoaiDAO);
                    break;
                case "updateRating":
                    capNhatDiem(request, response, truyenDAO);
                    break;
                case "updateView":
                    capNhatLuotXem(request, response, truyenDAO);
                    break;
                case "view":
                    xemChiTiet(request, response, truyenDAO, tacGiaDAO, theLoaiDAO);
                    break;
                default:
                    hienDS(request, response, truyenDAO, theLoaiDAO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Helper: Kiểm tra TrangThai hợp lệ - SỬA ĐỂ KHỚP VỚI DATABASE */
    private boolean isValidTrangThai(String trangThai) {
        if (trangThai == null) return false;
        return trangThai.equals("DANG_TIEN_HANH") || 
               trangThai.equals("HOAN_THANH") || 
               trangThai.equals("TAM_DUNG") || 
               trangThai.equals("DA_XOA");
    }

    /** ✅ Hiển thị danh sách */
private void hienDS(HttpServletRequest request, HttpServletResponse response, 
                    TruyenDAO truyenDAO, TheLoaiDAO theLoaiDAO)
        throws ServletException, IOException {

    // ✅ Lấy thông báo thành công từ tham số
    String success = request.getParameter("success");
    if ("insert".equals(success)) {
        request.setAttribute("successMessage", "Thêm truyện thành công!");
    } else if ("update".equals(success)) {
        request.setAttribute("successMessage", "Cập nhật truyện thành công!");
    } else if ("delete".equals(success)) {
        request.setAttribute("successMessage", "Xóa truyện thành công!");
    }

    // Lấy dữ liệu
    List<Truyen> ds = truyenDAO.layTatCaTruyen();
    List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
    
    request.setAttribute("listStories", ds);
    request.setAttribute("dsTheLoai", dsTheLoai);
    request.getRequestDispatcher("/Admin/QuanLyTruyen.jsp").forward(request, response);
}


    /** ✅ Hiển thị form thêm */
    private void hienForm(HttpServletRequest request, HttpServletResponse response,
                          TacGiaDAO tacGiaDAO, TheLoaiDAO theLoaiDAO, Truyen truyen)
            throws ServletException, IOException {
        List<TacGia> tacGias = tacGiaDAO.layDanhSachTacGia();
        List<TheLoai> theLoais = theLoaiDAO.layDanhSachTheLoai();
        
        request.setAttribute("dsTacGia", tacGias);
        request.setAttribute("dsTheLoai", theLoais);
        request.setAttribute("truyen", truyen);
        request.getRequestDispatcher("/Admin/StoryForm.jsp").forward(request, response);
        
        
    }

    /** ✅ Hiển thị form sửa */
    private void hienFormEdit(HttpServletRequest request, HttpServletResponse response,
                              TruyenDAO truyenDAO, TacGiaDAO tacGiaDAO, TheLoaiDAO theLoaiDAO)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Truyen truyen = truyenDAO.layTruyenTheoId(id);
            
            if (truyen == null) {
                request.setAttribute("errorMessage", "Không tìm thấy truyện!");
                hienDS(request, response, truyenDAO, theLoaiDAO);
                return;
            }
            
            List<Integer> listTL = truyenDAO.layTheLoaiIdsCuaTruyen(id);
            request.setAttribute("listTheLoaiGan", listTL);
            hienForm(request, response, tacGiaDAO, theLoaiDAO, truyen);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID truyện không hợp lệ!");
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Thêm mới */
    private void them(HttpServletRequest request, HttpServletResponse response,
                      TruyenDAO truyenDAO, TacGiaDAO tacGiaDAO, NguoiDung user) 
                      throws IOException, ServletException {
        try {
            // Validate input
            String ten = request.getParameter("tenTruyen");
            if (ten == null || ten.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên truyện không được để trống!");
                hienForm(request, response, tacGiaDAO, new TheLoaiDAO(), null);
                return;
            }
            
            // Check duplicate name
            if (truyenDAO.kiemTraTrungTen(ten.trim())) {
                request.setAttribute("errorMessage", "Tên truyện đã tồn tại!");
                hienForm(request, response, tacGiaDAO, new TheLoaiDAO(), null);
                return;
            }

            String moTa = request.getParameter("moTa");
            String trangThai = request.getParameter("trangThai");
            
            // ✅ VALIDATE và SET DEFAULT cho TrangThai
            if (trangThai == null || trangThai.trim().isEmpty()) {
                trangThai = "DANG_TIEN_HANH"; // Default value
            }
            
            // ✅ KIỂM TRA giá trị TrangThai hợp lệ
            if (!isValidTrangThai(trangThai)) {
                request.setAttribute("errorMessage", "Trạng thái không hợp lệ: " + trangThai);
                hienForm(request, response, tacGiaDAO, new TheLoaiDAO(), null);
                return;
            }
            
            boolean vip = request.getParameter("vip") != null;
            boolean noiBat = request.getParameter("noiBat") != null;
            boolean moi = request.getParameter("truyenMoi") != null;

            // Handle author
            int tacGiaId = handleAuthor(request, tacGiaDAO);
            if (tacGiaId == -1) {
                request.setAttribute("errorMessage", "Lỗi khi xử lý thông tin tác giả!");
                hienForm(request, response, tacGiaDAO, new TheLoaiDAO(), null);
                return;
            }

            // Handle file upload
            String fileName = handleFileUpload(request);

            // Create story
            Truyen t = new Truyen();
            t.setTenTruyen(ten.trim());
            t.setMoTa(moTa != null ? moTa.trim() : "");
            t.setAnhBia(fileName);
            t.setTrangThai(trangThai);
            t.setTacGiaId(tacGiaId);
            t.setNguoiTaoId(user.getId());
            t.setChiDanhChoVIP(vip);
            t.setNoiBat(noiBat);
            t.setTruyenMoi(moi);
            t.setNgayTao(LocalDateTime.now());
            t.setNgayCapNhat(LocalDateTime.now());

            // ✅ DEBUG: In ra giá trị TrangThai
            System.out.println("DEBUG - TrangThai value before insert: '" + t.getTrangThai() + "'");

            int newId = truyenDAO.themTruyen(t);
            if (newId > 0) {
                // Handle genres
                handleGenres(request, truyenDAO, newId);
                request.setAttribute("successMessage", "Thêm truyện thành công!");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi thêm truyện!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        response.sendRedirect("stories?success=insert");
    }

    /** ✅ Cập nhật */
    private void capNhat(HttpServletRequest request, HttpServletResponse response,
                         TruyenDAO truyenDAO, TacGiaDAO tacGiaDAO, NguoiDung user) 
                         throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String ten = request.getParameter("tenTruyen");
            
            if (ten == null || ten.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên truyện không được để trống!");
                response.sendRedirect("stories?action=edit&id=" + id);
                return;
            }

            String moTa = request.getParameter("moTa");
            String trangThai = request.getParameter("trangThai");
            
            // ✅ VALIDATE TrangThai cho UPDATE
            if (trangThai == null || trangThai.trim().isEmpty()) {
                trangThai = "DANG_TIEN_HANH";
            }
            
            if (!isValidTrangThai(trangThai)) {
                request.setAttribute("errorMessage", "Trạng thái không hợp lệ: " + trangThai);
                response.sendRedirect("stories?action=edit&id=" + id);
                return;
            }
            
            boolean vip = request.getParameter("vip") != null;
            boolean noiBat = request.getParameter("noiBat") != null;
            boolean moi = request.getParameter("truyenMoi") != null;

            // Handle author
            int tacGiaId = handleAuthor(request, tacGiaDAO);
            if (tacGiaId == -1) {
                request.setAttribute("errorMessage", "Lỗi khi xử lý thông tin tác giả!");
                response.sendRedirect("stories?action=edit&id=" + id);
                return;
            }

            // Handle file upload (keep old image if no new upload)
            String fileName = handleFileUpload(request);
            if (fileName == null) {
                fileName = request.getParameter("currentImage");
            }

            Truyen t = new Truyen();
            t.setId(id);
            t.setTenTruyen(ten.trim());
            t.setMoTa(moTa != null ? moTa.trim() : "");
            t.setAnhBia(fileName);
            t.setTrangThai(trangThai);
            t.setTacGiaId(tacGiaId);
            t.setNguoiTaoId(user.getId());
            t.setChiDanhChoVIP(vip);
            t.setNoiBat(noiBat);
            t.setTruyenMoi(moi);

            if (truyenDAO.capNhatTruyen(t)) {
                // Update genres
                truyenDAO.xoaTatCaTheLoaiCuaTruyen(id);
                handleGenres(request, truyenDAO, id);
                request.setAttribute("successMessage", "Cập nhật truyện thành công!");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi cập nhật truyện!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        response.sendRedirect("stories?success=update");
    }

    /** ✅ Xóa */
    private void xoa(HttpServletRequest request, HttpServletResponse response, TruyenDAO truyenDAO)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (truyenDAO.xoaTruyen(id)) {
                request.setAttribute("successMessage", "Xóa truyện thành công!");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi xóa truyện!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        response.sendRedirect("stories?success=delete");
    }

    /** ✅ Lọc */
    private void loc(HttpServletRequest request, HttpServletResponse response, 
                     TruyenDAO truyenDAO, TheLoaiDAO theLoaiDAO)
            throws ServletException, IOException {
        try {
            String theLoaiIdStr = request.getParameter("theLoaiId");
            Integer theLoaiId = (theLoaiIdStr != null && !theLoaiIdStr.isEmpty()) 
                              ? Integer.parseInt(theLoaiIdStr) : null;
            
            String trangThai = request.getParameter("trangThai");
            if (trangThai != null && trangThai.isEmpty()) trangThai = null;
            
            Boolean vip = request.getParameter("vip") != null ? true : null;
            
            List<Truyen> ds = truyenDAO.locTruyen(theLoaiId, trangThai, vip);
            List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
            
            request.setAttribute("listStories", ds);
            request.setAttribute("dsTheLoai", dsTheLoai);
            request.getRequestDispatcher("/Admin/QuanLyTruyen.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lọc dữ liệu: " + e.getMessage());
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Tìm kiếm nâng cao */
    private void timKiem(HttpServletRequest request, HttpServletResponse response, 
                         TruyenDAO truyenDAO, TheLoaiDAO theLoaiDAO)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            if (keyword == null) keyword = "";
            
            int offset = 0;
            int limit = 20;
            
            try {
                offset = Integer.parseInt(request.getParameter("offset"));
                limit = Integer.parseInt(request.getParameter("limit"));
            } catch (NumberFormatException e) {
                // Use default values
            }
            
            List<Truyen> ds = truyenDAO.timKiemTruyenNangCao(keyword, offset, limit);
            List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
            
            request.setAttribute("listStories", ds);
            request.setAttribute("dsTheLoai", dsTheLoai);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/Admin/QuanLyTruyen.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tìm kiếm: " + e.getMessage());
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Lấy top */
    private void layTop(HttpServletRequest request, HttpServletResponse response, 
                        TruyenDAO truyenDAO, TheLoaiDAO theLoaiDAO)
            throws ServletException, IOException {
        try {
            String tieuChi = request.getParameter("tieuChi");
            if (tieuChi == null) tieuChi = "luotXem";
            
            int limit = 10;
            try {
                limit = Integer.parseInt(request.getParameter("limit"));
                if (limit < 1 || limit > 100) limit = 10;
            } catch (NumberFormatException e) {
                limit = 10;
            }
            
            List<Truyen> ds = truyenDAO.layTopTruyen(tieuChi, limit);
            List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
            
            request.setAttribute("listStories", ds);
            request.setAttribute("dsTheLoai", dsTheLoai);
            request.getRequestDispatcher("/Admin/QuanLyTruyen.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lấy top truyện: " + e.getMessage());
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Cập nhật điểm */
    private void capNhatDiem(HttpServletRequest request, HttpServletResponse response, TruyenDAO truyenDAO)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            double diem = Double.parseDouble(request.getParameter("diem"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            
            if (diem < 1 || diem > 10) {
                request.setAttribute("errorMessage", "Điểm đánh giá phải từ 1.0 đến 10.0!");
            } else if (soLuong < 1) {
                request.setAttribute("errorMessage", "Số lượng đánh giá phải lớn hơn 0!");
            } else if (truyenDAO.capNhatDiemDanhGia(id, diem, soLuong)) {
                request.setAttribute("successMessage", "Cập nhật điểm đánh giá thành công!");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi cập nhật điểm đánh giá!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        response.sendRedirect("stories");
    }

    /** ✅ Cập nhật lượt xem */
    private void capNhatLuotXem(HttpServletRequest request, HttpServletResponse response, TruyenDAO truyenDAO)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (truyenDAO.capNhatLuotXem(id)) {
                request.setAttribute("successMessage", "Tăng lượt xem thành công!");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi tăng lượt xem!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        response.sendRedirect("stories");
    }

    /** ✅ Xem chi tiết truyện */
    private void xemChiTiet(HttpServletRequest request, HttpServletResponse response,
                            TruyenDAO truyenDAO, TacGiaDAO tacGiaDAO, TheLoaiDAO theLoaiDAO)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Truyen truyen = truyenDAO.layTruyenTheoId(id);
            
            if (truyen == null) {
                request.setAttribute("errorMessage", "Không tìm thấy truyện!");
                hienDS(request, response, truyenDAO, theLoaiDAO);
                return;
            }
            
            // Lấy danh sách thể loại của truyện
            List<String> theLoaiNames = truyenDAO.layTheLoaiNamesCuaTruyen(id);
            truyen.setTheLoaiTenList(theLoaiNames);
            
            // Lấy số lượng chương
            int soLuongChuong = truyenDAO.demSoLuongChuong(id);
            truyen.setSoLuongChuong(soLuongChuong);
            
            request.setAttribute("truyen", truyen);
            request.getRequestDispatcher("/Admin/StoryDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID truyện không hợp lệ!");
            hienDS(request, response, truyenDAO, theLoaiDAO);
        }
    }

    /** ✅ Helper: Xử lý tác giả */
    private int handleAuthor(HttpServletRequest request, TacGiaDAO tacGiaDAO) {
        try {
            String tacGiaMoi = request.getParameter("tacGiaMoi");
            if (tacGiaMoi != null && !tacGiaMoi.trim().isEmpty()) {
                // Create new author
                TacGia tg = new TacGia();
                tg.setTenTacGia(tacGiaMoi.trim());
                tg.setMoTa(""); // Default empty description
                return tacGiaDAO.taoVaLayIdTacGia(tg);
            } else {
                // Use existing author
                String tacGiaIdStr = request.getParameter("tacGiaID");
                if (tacGiaIdStr != null && !tacGiaIdStr.isEmpty()) {
                    return Integer.parseInt(tacGiaIdStr);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    /** ✅ Helper: Xử lý upload file */
    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
    Part filePart = request.getPart("anhBia");
    if (filePart == null || filePart.getSize() == 0) {
        return null;
    }

    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    if (fileName == null || fileName.isEmpty()) {
        return null;
    }

    // Validate file type
    String contentType = filePart.getContentType();
    if (!contentType.startsWith("image/")) {
        throw new ServletException("Chỉ chấp nhận file ảnh!");
    }

    // Generate unique filename
    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
    String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

    // Đường dẫn vật lý để lưu ảnh
    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    // Ghi file vào thư mục
    filePart.write(uploadPath + File.separator + uniqueFileName);

    // ✅ Quan trọng: trả về đường dẫn để lưu vào DB
    return UPLOAD_DIR + "/" + uniqueFileName; // => "assets/images/abc.jpg"
}


    /** ✅ Helper: Xử lý thể loại */
    private void handleGenres(HttpServletRequest request, TruyenDAO truyenDAO, int truyenId) {
        String[] theLoaiIds = request.getParameterValues("theLoaiID");
        if (theLoaiIds != null && theLoaiIds.length > 0) {
            List<Integer> list = new ArrayList<>();
            for (String s : theLoaiIds) {
                try {
                    list.add(Integer.parseInt(s));
                } catch (NumberFormatException e) {
                    // Skip invalid IDs
                }
            }
            if (!list.isEmpty()) {
                truyenDAO.ganTheLoai(truyenId, list);
            }
        }
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
        return "Story management servlet for admin panel";
    }// </editor-fold>
}