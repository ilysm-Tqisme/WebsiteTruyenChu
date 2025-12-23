package servlet;

import dao.BinhLuanDAO;
import dao.DanhGiaDAO;
import dao.LichSuDocDAO;
import dao.NguoiDungDAO;
import dao.TaiKhoanVIPDAO;
import dao.TuTruyenDAO;
import dao.YeuThichDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NguoiDung;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.BinhLuan;
import model.DanhGia;
import model.LichSuDoc;
import model.TaiKhoanVIP;
import model.TuTruyen;
import model.YeuThich;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
     private NguoiDungDAO nguoiDungDAO;
    private BinhLuanDAO binhLuanDAO;
    private DanhGiaDAO danhGiaDAO;
    private LichSuDocDAO lichSuDocDAO;
    private TuTruyenDAO tuTruyenDAO;
    private YeuThichDAO yeuThichDAO;
    private TaiKhoanVIPDAO taiKhoanVIPDAO;
    
    @Override
    public void init() throws ServletException {
        nguoiDungDAO = new NguoiDungDAO();
        binhLuanDAO = new BinhLuanDAO();
        danhGiaDAO = new DanhGiaDAO();
        lichSuDocDAO = new LichSuDocDAO();
        tuTruyenDAO = new TuTruyenDAO();
        yeuThichDAO = new YeuThichDAO();
        taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
            return;
        }
        
        try {
            // Lấy thông tin người dùng mới nhất từ database
            NguoiDung currentUser = nguoiDungDAO.layThongTinNguoiDung(user.getId());
            if (currentUser == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
                return;
            }
            
            // Format ngày tạo để hiển thị
            if (currentUser.getNgayTao() != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                String ngayTaoFormatted = currentUser.getNgayTao().format(formatter);
                request.setAttribute("ngayTaoFormatted", ngayTaoFormatted);
            }
            
            // Kiểm tra VIP
            boolean isVIP = taiKhoanVIPDAO.kiemTraVIP(currentUser.getId());
            TaiKhoanVIP vipInfo = null;
            
            if (isVIP) {
                vipInfo = taiKhoanVIPDAO.layThongTinVIP(currentUser.getId());
                if (vipInfo != null) {
                    // Format ngày VIP
                    DateTimeFormatter vipFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    if (vipInfo.getNgayBatDau() != null) {
                        String ngayBatDauFormatted = vipInfo.getNgayBatDau().format(vipFormatter);
                        request.setAttribute("ngayBatDauFormatted", ngayBatDauFormatted);
                    }
                    if (vipInfo.getNgayKetThuc() != null) {
                        String ngayKetThucFormatted = vipInfo.getNgayKetThuc().format(vipFormatter);
                        request.setAttribute("ngayKetThucFormatted", ngayKetThucFormatted);
                    }
                    // Format giá VIP
                    if (vipInfo.getGiaVIP() != null) {
                        String giaVIPFormatted = String.format("%,.0f VNĐ", vipInfo.getGiaVIP());
                        request.setAttribute("giaVIPFormatted", giaVIPFormatted);
                    }
                }
            }
            
            // Thống kê hoạt động
            int binhLuanCount = binhLuanDAO.demBinhLuanTheoNguoiDung(currentUser.getId());
            int danhGiaCount = danhGiaDAO.demDanhGiaTheoNguoiDung(currentUser.getId());
            int lichSuDocCount = lichSuDocDAO.demTruyenDaDocTheoNguoiDung(currentUser.getId());
            int tuTruyenCount = tuTruyenDAO.demTruyenTrongTuTheoNguoiDung(currentUser.getId());
            
            // Lấy hoạt động gần đây (giới hạn 5 mục mỗi loại)
            List<LichSuDoc> recentReading = lichSuDocDAO.layLichSuDocGanDayTheoNguoiDung(currentUser.getId(), 5);
            List<BinhLuan> recentComments = binhLuanDAO.layBinhLuanGanDayTheoNguoiDung(currentUser.getId(), 5);
            List<DanhGia> recentRatings = danhGiaDAO.layDanhGiaGanDayTheoNguoiDung(currentUser.getId(), 5);
            
            // Lấy danh sách yêu thích (giới hạn 6 truyện đầu tiên)
            List<YeuThich> danhSachYeuThich = yeuThichDAO.layDanhSachTruyenYeuThich(currentUser.getId(), 0, 6);
            
            // Lấy danh sách tủ truyện (giới hạn 6 truyện đầu tiên)
            List<TuTruyen> danhSachTuTruyen = tuTruyenDAO.layDanhSachTruyenTrongTu(currentUser.getId(), 0, 6);
            
            // Set attributes
            request.setAttribute("user", currentUser);
            request.setAttribute("isVIP", isVIP);
            request.setAttribute("vipInfo", vipInfo);
            
            // Thống kê
            request.setAttribute("binhLuanCount", binhLuanCount);
            request.setAttribute("danhGiaCount", danhGiaCount);
            request.setAttribute("lichSuDocCount", lichSuDocCount);
            request.setAttribute("tuTruyenCount", tuTruyenCount);
            
            // Hoạt động gần đây
            request.setAttribute("recentReading", recentReading);
            request.setAttribute("recentComments", recentComments);
            request.setAttribute("recentRatings", recentRatings);
            
            // Yêu thích và tủ truyện
            request.setAttribute("danhSachYeuThich", danhSachYeuThich);
            request.setAttribute("danhSachTuTruyen", danhSachTuTruyen);
            
            // Cập nhật session
            session.setAttribute("user", currentUser);
            
            // Kiểm tra thông báo từ URL parameter
            String updated = request.getParameter("updated");
            if ("true".equals(updated)) {
                request.setAttribute("success", "Cập nhật thông tin thành công!");
            }
            
            // Forward to JSP
            request.getRequestDispatcher("/User/Profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin profile!");
                request.getRequestDispatcher("/User/Profile.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
            return;
        }
        
        try {
            // Lấy thông tin từ form
            String hoTen = request.getParameter("hoTen");
            String soDienThoai = request.getParameter("soDienThoai");
            
            // Validate dữ liệu
            String error = validateProfileData(hoTen, soDienThoai, user.getId());
            if (error != null) {
                request.setAttribute("error", error);
                doGet(request, response);
                return;
            }
            
            // Lấy thông tin người dùng hiện tại từ database
            NguoiDung currentUser = nguoiDungDAO.layThongTinNguoiDung(user.getId());
            if (currentUser == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/User/Login.jsp");
                return;
            }
            
            // Cập nhật thông tin
            currentUser.setHoTen(hoTen.trim());
            currentUser.setSoDienThoai(soDienThoai != null && !soDienThoai.trim().isEmpty() ? soDienThoai.trim() : null);
            
            // Lưu vào database
            boolean success = nguoiDungDAO.capNhatThongTin(currentUser);
            
            if (success) {
                // Cập nhật session
                session.setAttribute("user", currentUser);
                // Redirect để tránh resubmit form
                response.sendRedirect(request.getContextPath() + "/profile?updated=true");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
                doGet(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
            doGet(request, response);
        }
    }
    
    /**
     * Validate dữ liệu profile
     */
    private String validateProfileData(String hoTen, String soDienThoai, int userId) {
        if (hoTen == null || hoTen.trim().isEmpty()) {
            return "Họ và tên không được để trống!";
        }
        
        if (hoTen.trim().length() < 2) {
            return "Họ và tên phải có ít nhất 2 ký tự!";
        }
        
        if (hoTen.trim().length() > 100) {
            return "Họ và tên không được quá 100 ký tự!";
        }
        
        // Kiểm tra tên chỉ chứa chữ cái, khoảng trắng và một số ký tự đặc biệt tiếng Việt
        if (!hoTen.trim().matches("^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$")) {
            return "Họ và tên chỉ được chứa chữ cái và khoảng trắng!";
        }
        
        if (soDienThoai == null || soDienThoai.trim().isEmpty()) {
            return "Số điện thoại không được để trống!";
        }

            soDienThoai = soDienThoai.trim();

        if (!soDienThoai.matches("^0[0-9]{9}$")) {
            return "Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0!";
        }

        if (nguoiDungDAO.kiemTraSoDienThoaiDaTonTai(soDienThoai, userId)) {
            return "Số điện thoại này đã được sử dụng bởi tài khoản khác!";
        }
      
        return null;
    }
}
