package servlet;

import dao.TheLoaiDAO;
import dao.TruyenDAO;
import dao.GoiVIPDAO;
import dao.ThongBaoDAO;
import dao.TaiKhoanVIPDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.TheLoai;
import model.Truyen;
import model.GoiVIP;
import model.ThongBao;
import model.NguoiDung;

@WebServlet(name="HomeUser", urlPatterns={"/home"})
public class HomeUser extends HttpServlet {

    private final TheLoaiDAO theLoaiDAO = new TheLoaiDAO();
    private final TruyenDAO truyenDAO = new TruyenDAO();
    private final GoiVIPDAO goiVIPDAO = new GoiVIPDAO();
    private final ThongBaoDAO thongBaoDAO = new ThongBaoDAO();
    private final TaiKhoanVIPDAO taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    
    private static final int STORIES_PER_PAGE = 12;
     
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        // Lấy các tham số tìm kiếm và lọc
        String keyword = request.getParameter("keyword");
        String theLoaiParam = request.getParameter("theLoai");
        String sortBy = request.getParameter("sort");
        String pageParam = request.getParameter("page");
        
        // Kiểm tra nếu có tìm kiếm hoặc lọc thì chuyển hướng đến /truyen
        if ((keyword != null && !keyword.trim().isEmpty()) || 
            (theLoaiParam != null && !theLoaiParam.isEmpty()) || 
            (sortBy != null && !sortBy.isEmpty()) ||
            (pageParam != null && !pageParam.equals("1") && !pageParam.isEmpty())) {
            
            // Xây dựng URL chuyển hướng với các tham số
            StringBuilder redirectUrl = new StringBuilder(request.getContextPath() + "/truyen");
            boolean hasParam = false;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                redirectUrl.append("?keyword=").append(java.net.URLEncoder.encode(keyword, "UTF-8"));
                hasParam = true;
            }
            
            if (theLoaiParam != null && !theLoaiParam.isEmpty()) {
                redirectUrl.append(hasParam ? "&" : "?").append("theLoai=").append(theLoaiParam);
                hasParam = true;
            }
            
            if (sortBy != null && !sortBy.isEmpty()) {
                redirectUrl.append(hasParam ? "&" : "?").append("sort=").append(sortBy);
                hasParam = true;
            }
            
            if (pageParam != null && !pageParam.isEmpty() && !pageParam.equals("1")) {
                redirectUrl.append(hasParam ? "&" : "?").append("page=").append(pageParam);
            }
            
            response.sendRedirect(redirectUrl.toString());
            return;
        }
         
        // Lấy dữ liệu cơ bản
        List<TheLoai> danhSachTheLoai = theLoaiDAO.layDanhSachTheLoai();  
        List<Truyen> truyenVIP = truyenDAO.layTruyenVIP(6);
        List<Truyen> truyenHot = truyenDAO.layTruyenNoiBat(6);
        List<Truyen> truyenMoiNhat = truyenDAO.layTruyenMoiNhat(6);
        
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession(false);
        NguoiDung currentUser = null;
        if (session != null) {
            currentUser = (NguoiDung) session.getAttribute("user");
        }
        
        // Xử lý gói VIP và thông báo cho người dùng đã đăng nhập
        if (currentUser != null) {
            // Kiểm tra trạng thái VIP hiện tại
            boolean isVIP = taiKhoanVIPDAO.kiemTraVIP(currentUser.getId());
            request.setAttribute("isCurrentUserVIP", isVIP);
            
            // Lấy thông báo (chỉ hiển thị 10 thông báo gần nhất)
            List<ThongBao> danhSachThongBao = thongBaoDAO.layThongBaoTheoNguoiDung(currentUser.getId(), 10);
            int soThongBaoChuaDoc = thongBaoDAO.demThongBaoChuaDoc(currentUser.getId());
            
            request.setAttribute("danhSachThongBao", danhSachThongBao);
            request.setAttribute("soThongBaoChuaDoc", soThongBaoChuaDoc);
            
            // Lấy gói VIP cho dropdown (chỉ hiển thị nếu chưa có VIP)
            if (!isVIP) {
                List<GoiVIP> danhSachGoiVIP = goiVIPDAO.layGoiVIPHoatDong();
                // Lấy tối đa 3 gói VIP cho dropdown
                List<GoiVIP> goiVIPDropdown = danhSachGoiVIP.stream()
                    .limit(3)
                    .collect(java.util.stream.Collectors.toList());
                request.setAttribute("danhSachGoiVIP", goiVIPDropdown);
            }
        } else {
            // Người dùng chưa đăng nhập - hiển thị gói VIP trong section chính
            List<GoiVIP> danhSachGoiVIP = goiVIPDAO.layGoiVIPHoatDong();
            // Lấy tối đa 3 gói VIP
            List<GoiVIP> goiVIPLimited = danhSachGoiVIP.stream()
                .limit(3)
                .collect(java.util.stream.Collectors.toList());
            request.setAttribute("danhSachGoiVIP", goiVIPLimited);
        }
        
        // Truyền danh sách thể loại và truyện vào request
        request.setAttribute("danhSachTheLoai", danhSachTheLoai); 
        request.setAttribute("truyenVIP", truyenVIP);
        request.setAttribute("truyenHot", truyenHot);
        request.setAttribute("truyenMoiNhat", truyenMoiNhat);
        
        // Forward đến trang JSP
        request.getRequestDispatcher("/User/Home.jsp").forward(request, response);
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
        return "Trang chủ với chức năng tìm kiếm, lọc truyện, gói VIP và thông báo";
    }
}