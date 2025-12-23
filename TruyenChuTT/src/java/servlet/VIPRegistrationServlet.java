 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.GoiVIPDAO;
import dao.TaiKhoanVIPDAO;
import dao.ThongBaoDAO;
import dao.NguoiDungDAO;
import dao.YeuCauThanhToanDAO;
import model.GoiVIP;
import model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.TaiKhoanVIP;
import model.YeuCauThanhToan;

/**
 *
 * @author USER
 */
@WebServlet(name="VIPRegistrationServlet", urlPatterns={"/vip/register"})
public class VIPRegistrationServlet extends HttpServlet {

    private final GoiVIPDAO goiVIPDAO = new GoiVIPDAO();
    private final TaiKhoanVIPDAO taiKhoanVIPDAO = new TaiKhoanVIPDAO();
    private final YeuCauThanhToanDAO yeuCauThanhToanDAO = new YeuCauThanhToanDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login?redirect=vip");
        return;
    }

    
    NguoiDung user = (NguoiDung) session.getAttribute("user");
    TaiKhoanVIP vip = taiKhoanVIPDAO.layThongTinVIP(user.getId());
    
    if (taiKhoanVIPDAO.kiemTraVIP(user.getId())) {
        
         NguoiDung vipInfo = nguoiDungDAO.layThongTinNguoiDung(user.getId());
         GoiVIP goiVIP = goiVIPDAO.layGoiVIPTheoID(vip.getId());
         request.setAttribute("error", "Bạn đã là thành viên VIP!");
        
        // Set thuộc tính để hiển thị ở JSP
         request.setAttribute("user", user); // chứa họ tên, email, ...
         request.setAttribute("goiVIP", goiVIP);
         request.setAttribute("vipInfo", vipInfo); // chứa ngày đăng ký, ngày hết hạn
        request.getRequestDispatcher("/User/VIPStatus.jsp").forward(request, response);
        return;
    }

    String packageIdStr = request.getParameter("packageId");
    String action = request.getParameter("action");
    
    if (packageIdStr == null || packageIdStr.isEmpty()) {
        request.setAttribute("goiVIPList", goiVIPDAO.layGoiVIPHoatDong());
        request.getRequestDispatcher("/User/VIPPackages.jsp").forward(request, response);
    } else {
        try {
            int packageId = Integer.parseInt(packageIdStr);
            GoiVIP goiVIP = goiVIPDAO.layGoiVIPTheoID(packageId);
            
            if (goiVIP == null || !goiVIP.isTrangThai()) {
                request.setAttribute("error", "Gói VIP không tồn tại hoặc đã ngừng hoạt động!");
                request.setAttribute("goiVIPList", goiVIPDAO.layGoiVIPHoatDong());
                request.getRequestDispatcher("/User/VIPPackages.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("goiVIP", goiVIP);
            request.setAttribute("user", user);
            
            String transferContent = "VIP " + goiVIP.getTenGoi() + " " + user.getHoTen() + " " + user.getEmail();
            request.setAttribute("transferContent", transferContent);
            
            request.setAttribute("packagePrice", goiVIP.getGia().toString());
            
            if ("detail".equals(action)) {
                boolean hasRequest = yeuCauThanhToanDAO.kiemTraYeuCauDangCho(user.getId(), packageId);
                request.setAttribute("hasExistingRequest", hasRequest);
                
                // Thêm thời gian tạo yêu cầu nếu có
                if (hasRequest) {
                    YeuCauThanhToan yeuCau = yeuCauThanhToanDAO.layYeuCauDangCho(user.getId(), packageId);
                    if (yeuCau != null && yeuCau.getNgayTao() != null) {
                        request.setAttribute("requestTimestamp", yeuCau.getNgayTao().toString());
                    }
                }

                String success = request.getParameter("success");
                if ("true".equals(success)) {
                    request.setAttribute("success", true);
                }
    
                request.getRequestDispatcher("/User/DetailPayment.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/User/VIPPayment.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID gói VIP không hợp lệ!");
            request.setAttribute("goiVIPList", goiVIPDAO.layGoiVIPHoatDong());
            request.getRequestDispatcher("/User/VIPPackages.jsp").forward(request, response);
        }
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        if (taiKhoanVIPDAO.kiemTraVIP(user.getId())) {
            request.setAttribute("error", "Bạn đã là thành viên VIP!");
            request.getRequestDispatcher("/User/VIPStatus.jsp").forward(request, response);
            return;
        }

        try {
            int packageId = Integer.parseInt(request.getParameter("packageId"));
            GoiVIP goiVIP = goiVIPDAO.layGoiVIPTheoID(packageId);
            
            if (goiVIP == null || !goiVIP.isTrangThai()) {
                request.setAttribute("error", "Gói VIP không tồn tại hoặc đã ngừng hoạt động!");
                response.sendRedirect(request.getContextPath() + "/vip/register");
                return;
            }

            if ("createPaymentRequest".equals(request.getParameter("action"))) {
                if (yeuCauThanhToanDAO.kiemTraYeuCauDangCho(user.getId(), packageId)) {
                    request.setAttribute("error", "Bạn đã có yêu cầu thanh toán đang chờ xử lý cho gói này!");
                    request.setAttribute("goiVIP", goiVIP);
                    request.setAttribute("user", user);
                    request.setAttribute("hasExistingRequest", true);
                    request.getRequestDispatcher("/User/DetailPayment.jsp").forward(request, response);
                    return;
                }
                
                String transferId = generateTransferId(user.getId(), packageId);
                String transferContent = "VIP " + goiVIP.getTenGoi() + " " + user.getHoTen() + " " + user.getEmail() + " " + transferId;
                
                YeuCauThanhToan yeuCau = new YeuCauThanhToan(user.getId(), packageId, goiVIP.getGia(), transferContent);
                
                if (yeuCauThanhToanDAO.taoYeuCauThanhToan(yeuCau)) {
                    String redirectUrl = request.getContextPath() + "/vip/register?packageId=" + packageId + "&action=detail&success=true";
                    response.sendRedirect(redirectUrl);
                    return;
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi tạo yêu cầu thanh toán!");
                    request.setAttribute("goiVIP", goiVIP);
                    request.setAttribute("user", user);
                    request.setAttribute("hasExistingRequest", false);
                    request.getRequestDispatcher("/User/DetailPayment.jsp").forward(request, response);
                    return;
                }
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/vip/register");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau!");
            response.sendRedirect(request.getContextPath() + "/vip/register");
        }
    }
    
    private String generateTransferId(int userId, int packageId) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        return "VIP" + userId + packageId + now.format(formatter);
    }
}
