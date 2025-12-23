package servlet.admin;

import dao.ChuongDAO;
import dao.TruyenDAO;
import dao.TheLoaiDAO;
import model.Chuong;
import model.Truyen;
import model.TheLoai;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ChuongServlet", urlPatterns = {"/admin/chapters"})
public class ChuongServlet extends HttpServlet {
    
    private ChuongDAO chuongDAO;
    private TruyenDAO truyenDAO;
    private TheLoaiDAO theLoaiDAO;
    
    @Override
    public void init() throws ServletException {
        chuongDAO = new ChuongDAO();
        truyenDAO = new TruyenDAO();
        theLoaiDAO = new TheLoaiDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                handleList(request, response);
                break;
            case "chapters":
                handleChaptersList(request, response);
                break;
            case "view":
                handleView(request, response);
                break;
            case "create":
                handleCreateForm(request, response);
                break;
            case "edit":
                handleEditForm(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            case "updateView":
                handleUpdateView(request, response);
                break;
            case "search":
                handleSearch(request, response);
                break;
            case "filter":
                handleFilter(request, response);
                break;
            default:
                handleList(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) action = "create";
        
        switch (action) {
            case "create":
                handleCreateSubmit(request, response);
                break;
            case "edit":
                handleEditSubmit(request, response);
                break;
            case "bulkDelete":
                handleBulkDelete(request, response);
                break;
            case "bulkUpdateStatus":
                handleBulkUpdateStatus(request, response);
                break;
            default:
                handleList(request, response);
        }
    }
    
    // Xử lý danh sách truyện (trang chính)
    private void handleList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String storyIdStr = request.getParameter("storyId");
        
        // Nếu có storyId thì hiển thị danh sách chương
        if (storyIdStr != null && !storyIdStr.isEmpty()) {
            handleChaptersList(request, response);
            return;
        }
        
        // Nếu không có storyId thì hiển thị danh sách truyện
        String keywordParam = request.getParameter("keyword");
        String theLoaiIdParam = request.getParameter("theLoaiId");
        String trangThaiParam = request.getParameter("trangThai");
        String vipParam = request.getParameter("vip");
        
        List<Truyen> listTruyen;
        
        if (keywordParam != null && !keywordParam.trim().isEmpty()) {
            listTruyen = truyenDAO.timKiemTruyenNangCao(keywordParam.trim(), 0, 100);
        } else if (theLoaiIdParam != null || trangThaiParam != null || vipParam != null) {
            Integer theLoaiId = null;
            Boolean chiDanhChoVIP = null;
            
            if (theLoaiIdParam != null && !theLoaiIdParam.isEmpty()) {
                try {
                    theLoaiId = Integer.parseInt(theLoaiIdParam);
                } catch (NumberFormatException e) {
                    theLoaiId = null;
                }
            }
            
            if (vipParam != null && !vipParam.isEmpty()) {
                chiDanhChoVIP = "true".equals(vipParam);
            }
            
            listTruyen = truyenDAO.locTruyen(theLoaiId, trangThaiParam, chiDanhChoVIP);
        } else {
            listTruyen = truyenDAO.getTruyen();
        }
        
        // Lấy danh sách thể loại cho filter
        List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
        
        request.setAttribute("listStories", listTruyen);
        request.setAttribute("dsTheLoai", dsTheLoai);
        request.setAttribute("viewMode", "stories");
        
        request.getRequestDispatcher("/Admin/QuanLyChuong.jsp").forward(request, response);
    }
    
    // Xử lý danh sách chương theo truyện
    private void handleChaptersList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String storyIdStr = request.getParameter("storyId");
        String offsetStr = request.getParameter("offset");
        String limitStr = request.getParameter("limit");
        
        if (storyIdStr == null || storyIdStr.isEmpty()) {
            response.sendRedirect("chapters");
            return;
        }
        
        int storyId = 0;
        int offset = 0;
        int limit = 20;
        
        try {
            storyId = Integer.parseInt(storyIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
            return;
        }
        
        if (offsetStr != null && !offsetStr.isEmpty()) {
            try {
                offset = Integer.parseInt(offsetStr);
            } catch (NumberFormatException e) {
                offset = 0;
            }
        }
        
        if (limitStr != null && !limitStr.isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
            } catch (NumberFormatException e) {
                limit = 20;
            }
        }
        
        // Lấy thông tin truyện
        Truyen truyen = truyenDAO.layTruyenTheoId(storyId);
        if (truyen == null) {
            request.setAttribute("errorMessage", "Không tìm thấy truyện!");
            response.sendRedirect("chapters");
            return;
        }
        
        // Lấy danh sách chương
        List<Chuong> listChuong = chuongDAO.layChuongTheoTruyen(storyId, offset, limit);
        int totalChapters = chuongDAO.demSoChuongTheoTruyen(storyId);
        
        // Thống kê chương
        Object[] stats = chuongDAO.thongKeChuongTheoTruyen(storyId);
        
        request.setAttribute("listChuong", listChuong);
        request.setAttribute("selectedTruyen", truyen);
        request.setAttribute("currentStoryId", storyId);
        request.setAttribute("totalChapters", totalChapters);
        request.setAttribute("currentOffset", offset);
        request.setAttribute("currentLimit", limit);
        request.setAttribute("totalPages", (int) Math.ceil((double) totalChapters / limit));
        request.setAttribute("currentPage", offset / limit + 1);
        request.setAttribute("chapterStats", stats);
        request.setAttribute("viewMode", "chapters");
        
        request.getRequestDispatcher("/Admin/QuanLyChuong.jsp").forward(request, response);
    }
    
    // Xử lý xem chi tiết chương
    private void handleView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("chapters");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            Chuong chuong = chuongDAO.layChuongTheoId(id);
            
            if (chuong == null) {
                request.setAttribute("errorMessage", "Không tìm thấy chương!");
                response.sendRedirect("chapters");
                return;
            }
            
            // Lấy chương trước và sau
            Chuong chuongTruoc = chuongDAO.layChuongTruoc(chuong.getTruyen().getId(), chuong.getSoChuong());
            Chuong chuongSau = chuongDAO.layChuongSau(chuong.getTruyen().getId(), chuong.getSoChuong());
            
            request.setAttribute("chuong", chuong);
            request.setAttribute("chuongTruoc", chuongTruoc);
            request.setAttribute("chuongSau", chuongSau);
            
            request.getRequestDispatcher("/Admin/XemChuong.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý form tạo chương
    private void handleCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String storyIdStr = request.getParameter("storyId");
        if (storyIdStr == null || storyIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng chọn truyện!");
            response.sendRedirect("chapters");
            return;
        }
        
        try {
            int storyId = Integer.parseInt(storyIdStr);
            Truyen truyen = truyenDAO.layTruyenTheoId(storyId);
            
            if (truyen == null) {
                request.setAttribute("errorMessage", "Không tìm thấy truyện!");
                response.sendRedirect("chapters");
                return;
            }
            
            // Lấy số chương tiếp theo
            int soChuongTiepTheo = chuongDAO.laySoChuongTiepTheo(storyId);
            
            request.setAttribute("truyen", truyen);
            request.setAttribute("soChuongTiepTheo", soChuongTiepTheo);
            request.setAttribute("action", "create");
            
            request.getRequestDispatcher("/Admin/TaoChuong.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý form chỉnh sửa chương
    private void handleEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("chapters");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            Chuong chuong = chuongDAO.layChuongTheoId(id);
            
            if (chuong == null) {
                request.setAttribute("errorMessage", "Không tìm thấy chương!");
                response.sendRedirect("chapters");
                return;
            }
            
            request.setAttribute("chuong", chuong);
            request.setAttribute("action", "edit");
            
            request.getRequestDispatcher("/Admin/TaoChuong.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý submit tạo chương
    private void handleCreateSubmit(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            int truyenId = Integer.parseInt(request.getParameter("truyenId"));
            String tenChuong = request.getParameter("tenChuong");
            String noiDung = request.getParameter("noiDung");
            int soChuong = Integer.parseInt(request.getParameter("soChuong"));
            boolean chiDanhChoVIP = "true".equals(request.getParameter("chiDanhChoVIP"));
            String trangThai = request.getParameter("trangThai");
            String ngayDangLichStr = request.getParameter("ngayDangLich");
            
            // Validation
            if (tenChuong == null || tenChuong.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên chương không được để trống!");
                handleCreateForm(request, response);
                return;
            }
            
            if (noiDung == null || noiDung.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Nội dung chương không được để trống!");
                handleCreateForm(request, response);
                return;
            }
            
            // Kiểm tra số chương trùng
            if (chuongDAO.kiemTraSoChuongTrung(truyenId, soChuong, 0)) {
                request.setAttribute("errorMessage", "Số chương " + soChuong + " đã tồn tại!");
                handleCreateForm(request, response);
                return;
            }
            
            // Tạo đối tượng chương
            Chuong chuong = new Chuong();
            Truyen truyen = new Truyen();
            truyen.setId(truyenId);
            chuong.setTruyen(truyen);
            chuong.setTenChuong(tenChuong.trim());
            chuong.setNoiDung(noiDung.trim());
            chuong.setSoChuong(soChuong);
            chuong.setChiDanhChoVIP(chiDanhChoVIP);
            chuong.setTrangThai(trangThai);
            
            // Xử lý ngày đăng lịch
            if (ngayDangLichStr != null && !ngayDangLichStr.trim().isEmpty() && "LICH_DANG".equals(trangThai)) {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                    LocalDateTime ngayDangLich = LocalDateTime.parse(ngayDangLichStr, formatter);
                    chuong.setNgayDangLich(ngayDangLich);
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Định dạng ngày đăng lịch không hợp lệ!");
                    handleCreateForm(request, response);
                    return;
                }
            }
            
            // Thêm chương
            int newId = chuongDAO.themChuong(chuong);
            
            if (newId > 0) {
                request.getSession().setAttribute("successMessage", "Thêm chương thành công!");
                response.sendRedirect("chapters?storyId=" + truyenId);
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm chương!");
                handleCreateForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            handleCreateForm(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            handleCreateForm(request, response);
        }
    }
    
    // Xử lý submit chỉnh sửa chương
    private void handleEditSubmit(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            int id = Integer.parseInt(request.getParameter("id"));
            int truyenId = Integer.parseInt(request.getParameter("truyenId"));
            String tenChuong = request.getParameter("tenChuong");
            String noiDung = request.getParameter("noiDung");
            int soChuong = Integer.parseInt(request.getParameter("soChuong"));
            boolean chiDanhChoVIP = "true".equals(request.getParameter("chiDanhChoVIP"));
            String trangThai = request.getParameter("trangThai");
            String ngayDangLichStr = request.getParameter("ngayDangLich");
            
            // Validation
            if (tenChuong == null || tenChuong.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên chương không được để trống!");
                handleEditForm(request, response);
                return;
            }
            
            if (noiDung == null || noiDung.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Nội dung chương không được để trống!");
                handleEditForm(request, response);
                return;
            }
            
            // Kiểm tra số chương trùng (trừ chương hiện tại)
            if (chuongDAO.kiemTraSoChuongTrung(truyenId, soChuong, id)) {
                request.setAttribute("errorMessage", "Số chương " + soChuong + " đã tồn tại!");
                handleEditForm(request, response);
                return;
            }
            
            // Lấy chương hiện tại
            Chuong chuong = chuongDAO.layChuongTheoId(id);
            if (chuong == null) {
                request.setAttribute("errorMessage", "Không tìm thấy chương!");
                response.sendRedirect("chapters?storyId=" + truyenId);
                return;
            }
            
            // Cập nhật dữ liệu
            chuong.setTenChuong(tenChuong.trim());
            chuong.setNoiDung(noiDung.trim());
            chuong.setSoChuong(soChuong);
            chuong.setChiDanhChoVIP(chiDanhChoVIP);
            chuong.setTrangThai(trangThai);
            
            // Xử lý ngày đăng lịch
            if (ngayDangLichStr != null && !ngayDangLichStr.trim().isEmpty() && "LICH_DANG".equals(trangThai)) {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                    LocalDateTime ngayDangLich = LocalDateTime.parse(ngayDangLichStr, formatter);
                    chuong.setNgayDangLich(ngayDangLich);
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Định dạng ngày đăng lịch không hợp lệ!");
                    handleEditForm(request, response);
                    return;
                }
            } else {
                chuong.setNgayDangLich(null);
            }
            
            // Cập nhật chương
            boolean success = chuongDAO.capNhatChuong(chuong);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Cập nhật chương thành công!");
                response.sendRedirect("chapters?storyId=" + truyenId);
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật chương!");
                handleEditForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            handleEditForm(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            handleEditForm(request, response);
        }
    }
    
    // Xử lý xóa chương
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String storyIdStr = request.getParameter("storyId");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("chapters");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            boolean success = chuongDAO.xoaChuong(id);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Xóa chương thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi xóa chương!");
            }
            
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý cập nhật lượt xem
    private void handleUpdateView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String storyIdStr = request.getParameter("storyId");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("chapters");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            boolean success = chuongDAO.capNhatLuotXem(id);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Cập nhật lượt xem thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật lượt xem!");
            }
            
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý tìm kiếm
    private void handleSearch(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String storyIdStr = request.getParameter("storyId");
        
        if (storyIdStr != null && !storyIdStr.isEmpty()) {
            // Tìm kiếm chương trong truyện
            try {
                int storyId = Integer.parseInt(storyIdStr);
                List<Chuong> listChuong = chuongDAO.timKiemChuong(keyword, storyId, 0, 100);
                Truyen truyen = truyenDAO.layTruyenTheoId(storyId);
                
                request.setAttribute("listChuong", listChuong);
                request.setAttribute("selectedTruyen", truyen);
                request.setAttribute("currentStoryId", storyId);
                request.setAttribute("searchKeyword", keyword);
                request.setAttribute("viewMode", "chapters");
                
                request.getRequestDispatcher("/Admin/QuanLyChuong.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                response.sendRedirect("chapters");
            }
        } else {
            // Tìm kiếm truyện
            List<Truyen> listTruyen = truyenDAO.timKiemTruyenNangCao(keyword, 0, 100);
            List<TheLoai> dsTheLoai = theLoaiDAO.layDanhSachTheLoai();
            
            request.setAttribute("listStories", listTruyen);
            request.setAttribute("dsTheLoai", dsTheLoai);
            request.setAttribute("searchKeyword", keyword);
            request.setAttribute("viewMode", "stories");
            
            request.getRequestDispatcher("/Admin/QuanLyChuong.jsp").forward(request, response);
        }
    }
    
    // Xử lý filter
    private void handleFilter(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String storyIdStr = request.getParameter("storyId");
        
        if (storyIdStr != null && !storyIdStr.isEmpty()) {
            // Filter chương
            String trangThai = request.getParameter("trangThai");
            String vipStr = request.getParameter("vip");
            
            Boolean vip = null;
            if (vipStr != null && !vipStr.isEmpty()) {
                vip = "true".equals(vipStr);
            }
            
            try {
                int storyId = Integer.parseInt(storyIdStr);
                List<Chuong> listChuong = chuongDAO.locChuongTheoTrangThai(trangThai, vip, 0, 100);
                
                // Lọc theo truyện
                listChuong = listChuong.stream()
                    .filter(c -> c.getTruyen().getId() == storyId)
                    .collect(Collectors.toList());
                
                Truyen truyen = truyenDAO.layTruyenTheoId(storyId);
                
                request.setAttribute("listChuong", listChuong);
                request.setAttribute("selectedTruyen", truyen);
                request.setAttribute("currentStoryId", storyId);
                request.setAttribute("filterTrangThai", trangThai);
                request.setAttribute("filterVip", vipStr);
                request.setAttribute("viewMode", "chapters");
                
                request.getRequestDispatcher("/Admin/QuanLyChuong.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                response.sendRedirect("chapters");
            }
        } else {
            // Filter truyện
            handleList(request, response);
        }
    }
    
    // Xử lý xóa nhiều chương
    private void handleBulkDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String[] idStrArray = request.getParameterValues("selectedIds");
        String storyIdStr = request.getParameter("storyId");
        
        if (idStrArray == null || idStrArray.length == 0) {
            request.getSession().setAttribute("errorMessage", "Vui lòng chọn ít nhất một chương để xóa!");
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            return;
        }
        
        try {
            List<Integer> ids = Arrays.stream(idStrArray)
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            
            boolean success = chuongDAO.xoaNhieuChuong(ids);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Xóa " + ids.size() + " chương thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi xóa chương!");
            }
            
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            response.sendRedirect("chapters");
        }
    }
    
    // Xử lý cập nhật trạng thái nhiều chương
    private void handleBulkUpdateStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String[] idStrArray = request.getParameterValues("selectedIds");
        String newStatus = request.getParameter("newStatus");
        String storyIdStr = request.getParameter("storyId");
        
        if (idStrArray == null || idStrArray.length == 0) {
            request.getSession().setAttribute("errorMessage", "Vui lòng chọn ít nhất một chương để cập nhật!");
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            return;
        }
        
        if (newStatus == null || newStatus.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Vui lòng chọn trạng thái mới!");
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            return;
        }
        
        try {
            List<Integer> ids = Arrays.stream(idStrArray)
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            
            boolean success = chuongDAO.capNhatTrangThaiNhieuChuong(ids, newStatus);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Cập nhật trạng thái " + ids.size() + " chương thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật trạng thái!");
            }
            
            if (storyIdStr != null && !storyIdStr.isEmpty()) {
                response.sendRedirect("chapters?storyId=" + storyIdStr);
            } else {
                response.sendRedirect("chapters");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
            response.sendRedirect("chapters");
        }
    }
}