package servlet.admin;

import dao.NguoiDungDAO;
import dao.TaiKhoanVIPDAO;
import dao.GoiVIPDAO;
import model.NguoiDung;
import model.TaiKhoanVIP;
import model.GoiVIP;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "VIPManagementServlet", urlPatterns = {"/admin/vip"})
public class VIPManagementServlet extends HttpServlet {

    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final TaiKhoanVIPDAO taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    private final GoiVIPDAO goiVIPDAO = new GoiVIPDAO();
    private static final int DEFAULT_PAGE_SIZE = 10;

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập admin
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = (session != null) ? (NguoiDung) session.getAttribute("user") : null;

        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getVaiTro())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            showVIPManagement(request, response);
        } else {
            switch (action) {
                case "viewUser":
                    viewVIPUser(request, response);
                    break;
                case "grantVIP":
                    grantVIP(request, response);
                    break;
                case "revokeVIP":
                    revokeVIP(request, response);
                    break;
                case "addPackage":
                    addVIPPackage(request, response);
                    break;
                case "editPackage":
                    editVIPPackage(request, response);
                    break;
                case "deletePackage":
                    deleteVIPPackage(request, response);
                    break;
                case "searchUsers":
                    searchUsers(request, response);
                    break;
                default:
                    showVIPManagement(request, response);
                    break;
            }
        }
    }

    private void showVIPManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tab = request.getParameter("tab");
        if (tab == null || tab.isEmpty()) {
            tab = "users";
        }

        int page = 1;
        int pageSize = DEFAULT_PAGE_SIZE;
        
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            }
            
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
                if (pageSize < 1) pageSize = DEFAULT_PAGE_SIZE;
                if (pageSize > 100) pageSize = 100;
            }
        } catch (NumberFormatException e) {
            // Use defaults
        }

        if ("users".equals(tab)) {
            // Lấy danh sách tất cả người dùng
            List<NguoiDung> userList = nguoiDungDAO.layDanhSachNguoiDungPhanTrang(page, pageSize);
            int totalUsers = nguoiDungDAO.demTongSoNguoiDung();
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
            
            request.setAttribute("userList", userList);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);
            
        } else if ("packages".equals(tab)) {
            // Lấy danh sách gói VIP
            List<GoiVIP> packageList = goiVIPDAO.layTatCaGoiVIP();
            int totalPackages = goiVIPDAO.demTongSoGoiVIP();
            
            request.setAttribute("packageList", packageList);
            request.setAttribute("totalPackages", totalPackages);
        }
        
        request.setAttribute("activeTab", tab);
        request.getRequestDispatcher("/Admin/VIPManagement.jsp").forward(request, response);
    }

    private void viewVIPUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            System.out.println("DEBUG: Received userId = " + userId); // Debug log
            
            NguoiDung user = nguoiDungDAO.layThongTinNguoiDung(userId);
            
            if (user != null) {
                // Lấy thông tin VIP hiện tại của user
                TaiKhoanVIP currentVIP = taiKhoanVIPDAO.layThongTinVIP(userId);
                // Lấy danh sách gói VIP đang hoạt động
                List<GoiVIP> vipPackages = goiVIPDAO.layGoiVIPHoatDong();
                
                request.setAttribute("selectedUser", user);
                request.setAttribute("currentVIP", currentVIP);
                request.setAttribute("vipPackages", vipPackages);
                request.getRequestDispatcher("/Admin/UserVIPView.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy người dùng");
                showVIPManagement(request, response);
            }
        } catch (NumberFormatException e) {
            System.err.println("DEBUG: NumberFormatException - ID parameter: " + request.getParameter("id"));
            request.setAttribute("errorMessage", "ID người dùng không hợp lệ");
            showVIPManagement(request, response);
        }
    }

    private void grantVIP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userIdStr = request.getParameter("userId");
            String packageIdStr = request.getParameter("packageId");
            String startDateStr = request.getParameter("startDate");
            
            System.out.println("DEBUG: Grant VIP - userIdStr=" + userIdStr + ", packageIdStr=" + packageIdStr + ", startDate=" + startDateStr);
            
            if (userIdStr == null || userIdStr.isEmpty()) {
                request.setAttribute("errorMessage", "ID người dùng không hợp lệ");
                viewVIPUser(request, response);
                return;
            }
            
            if (packageIdStr == null || packageIdStr.isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng chọn gói VIP");
                viewVIPUser(request, response);
                return;
            }
            
            int userId = Integer.parseInt(userIdStr);
            int packageId = Integer.parseInt(packageIdStr);
            
            // Lấy thông tin gói VIP
            GoiVIP vipPackage = goiVIPDAO.layGoiVIPTheoID(packageId);
            if (vipPackage == null) {
                request.setAttribute("errorMessage", "Gói VIP không tồn tại");
                viewVIPUser(request, response);
                return;
            }
            
            // Parse ngày bắt đầu
            LocalDateTime startDate;
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDateTime.parse(startDateStr + "T00:00:00");
            } else {
                startDate = LocalDateTime.now();
            }
            
            // Tính ngày kết thúc dựa trên số tháng
            LocalDateTime endDate = startDate.plusMonths(vipPackage.getSoThang());
            
            System.out.println("DEBUG: VIP dates - start=" + startDate + ", end=" + endDate);
            
            // Cấp VIP
            boolean success = taiKhoanVIPDAO.capVIPChoNguoiDung(userId, startDate, endDate, 
                    vipPackage.getSoThang() >= 12 ? "NAM" : "THANG", vipPackage.getGia());
            
            System.out.println("DEBUG: Grant VIP result = " + success);
            
            if (success) {
                request.setAttribute("successMessage", "Đã cấp VIP thành công cho người dùng");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi cấp VIP");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("DEBUG: NumberFormatException in grantVIP: " + e.getMessage());
            request.setAttribute("errorMessage", "Dữ liệu đầu vào không hợp lệ");
        } catch (DateTimeParseException e) {
            System.err.println("DEBUG: DateTimeParseException in grantVIP: " + e.getMessage());
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ");
        }
        
        viewVIPUser(request, response);
    }

    private void revokeVIP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            boolean success = taiKhoanVIPDAO.thuHoiVIP(userId);
            
            if (success) {
                request.setAttribute("successMessage", "Đã thu hồi VIP thành công");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi thu hồi VIP");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID người dùng không hợp lệ");
        }
        
        viewVIPUser(request, response);
    }

    private void addVIPPackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String tenGoi = request.getParameter("tenGoi");
            String moTa = request.getParameter("moTa");
            int soThang = Integer.parseInt(request.getParameter("soThang"));
            BigDecimal gia = new BigDecimal(request.getParameter("gia"));
            String giaGocStr = request.getParameter("giaGoc");
            BigDecimal giaGoc = (giaGocStr != null && !giaGocStr.isEmpty()) ? new BigDecimal(giaGocStr) : null;
            String mauSac = request.getParameter("mauSac");
            String icon = request.getParameter("icon");
            boolean trangThai = Boolean.parseBoolean(request.getParameter("trangThai"));
            int thuTu = Integer.parseInt(request.getParameter("thuTu"));
            boolean noiBat = Boolean.parseBoolean(request.getParameter("noiBat"));
            
            // Tính phần trăm giảm giá
            int phanTramGiamGia = 0;
            if (giaGoc != null && giaGoc.compareTo(gia) > 0) {
                phanTramGiamGia = (int) ((giaGoc.subtract(gia).divide(giaGoc, 4, BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100)).intValue());
            }
            
            // Kiểm tra tên gói đã tồn tại
            if (goiVIPDAO.kiemTraTenGoiTonTai(tenGoi, 0)) {
                request.setAttribute("errorMessage", "Tên gói VIP đã tồn tại");
                request.setAttribute("activeTab", "packages");
                showVIPManagement(request, response);
                return;
            }
            
            GoiVIP goi = new GoiVIP();
            goi.setTenGoi(tenGoi);
            goi.setMoTa(moTa);
            goi.setSoThang(soThang);
            goi.setGia(gia);
            goi.setGiaGoc(giaGoc);
            goi.setPhanTramGiamGia(phanTramGiamGia);
            goi.setMauSac(mauSac);
            goi.setIcon(icon);
            goi.setTrangThai(trangThai);
            goi.setThuTu(thuTu);
            goi.setNoiBat(noiBat);
            
            boolean success = goiVIPDAO.themGoiVIP(goi);
            
            if (success) {
                request.setAttribute("successMessage", "Đã thêm gói VIP thành công");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi thêm gói VIP");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ");
        }
        
        request.setAttribute("activeTab", "packages");
        showVIPManagement(request, response);
    }

    private void editVIPPackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String tenGoi = request.getParameter("tenGoi");
            String moTa = request.getParameter("moTa");
            int soThang = Integer.parseInt(request.getParameter("soThang"));
            BigDecimal gia = new BigDecimal(request.getParameter("gia"));
            String giaGocStr = request.getParameter("giaGoc");
            BigDecimal giaGoc = (giaGocStr != null && !giaGocStr.isEmpty()) ? new BigDecimal(giaGocStr) : null;
            String mauSac = request.getParameter("mauSac");
            String icon = request.getParameter("icon");
            boolean trangThai = Boolean.parseBoolean(request.getParameter("trangThai"));
            int thuTu = Integer.parseInt(request.getParameter("thuTu"));
            boolean noiBat = Boolean.parseBoolean(request.getParameter("noiBat"));
            
            // Tính phần trăm giảm giá
            int phanTramGiamGia = 0;
            if (giaGoc != null && giaGoc.compareTo(gia) > 0) {
                phanTramGiamGia = (int) ((giaGoc.subtract(gia).divide(giaGoc, 4, BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100)).intValue());
            }
            
            // Kiểm tra tên gói đã tồn tại (trừ gói hiện tại)
            if (goiVIPDAO.kiemTraTenGoiTonTai(tenGoi, id)) {
                request.setAttribute("errorMessage", "Tên gói VIP đã tồn tại");
                request.setAttribute("activeTab", "packages");
                showVIPManagement(request, response);
                return;
            }
            
            GoiVIP goi = new GoiVIP();
            goi.setId(id);
            goi.setTenGoi(tenGoi);
            goi.setMoTa(moTa);
            goi.setSoThang(soThang);
            goi.setGia(gia);
            goi.setGiaGoc(giaGoc);
            goi.setPhanTramGiamGia(phanTramGiamGia);
            goi.setMauSac(mauSac);
            goi.setIcon(icon);
            goi.setTrangThai(trangThai);
            goi.setThuTu(thuTu);
            goi.setNoiBat(noiBat);
            
            boolean success = goiVIPDAO.capNhatGoiVIP(goi);
            
            if (success) {
                request.setAttribute("successMessage", "Đã cập nhật gói VIP thành công");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi cập nhật gói VIP");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu số không hợp lệ");
        }
        
        request.setAttribute("activeTab", "packages");
        showVIPManagement(request, response);
    }

    private void deleteVIPPackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            boolean success = goiVIPDAO.xoaGoiVIP(id);
            
            if (success) {
                request.setAttribute("successMessage", "Đã xóa gói VIP thành công");
            } else {
                request.setAttribute("errorMessage", "Lỗi khi xóa gói VIP");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID gói VIP không hợp lệ");
        }
        
        request.setAttribute("activeTab", "packages");
        showVIPManagement(request, response);
    }

    private void searchUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("searchTerm");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập từ khóa tìm kiếm");
            request.setAttribute("activeTab", "users");
            showVIPManagement(request, response);
            return;
        }

        List<NguoiDung> userList = nguoiDungDAO.timKiemNguoiDung(keyword);

        request.setAttribute("userList", userList);
        request.setAttribute("searchTerm", keyword);
        request.setAttribute("isSearchResult", true);
        request.setAttribute("totalUsers", userList.size());
        request.setAttribute("activeTab", "users");
        
        request.getRequestDispatcher("/Admin/VIPManagement.jsp").forward(request, response);
    }
}