/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author USER
 */
import db.DBConnection;
import model.TaiKhoanVIP;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.GoiVIP;
import model.NguoiDung;

public class TaiKhoanVIPDAO {
    
    // Kiểm tra user có phải VIP hiện tại không
    public boolean kiemTraVIP(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM TaiKhoanVIP WHERE NguoiDungID = ? AND TrangThai = 1 AND NgayKetThuc > NOW()";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Lấy thông tin VIP của user
    public TaiKhoanVIP layThongTinVIP(int nguoiDungId) {
        String sql = "SELECT * FROM TaiKhoanVIP WHERE NguoiDungID = ? AND TrangThai = 1 AND NgayKetThuc > NOW() ORDER BY NgayKetThuc DESC LIMIT 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                TaiKhoanVIP vip = new TaiKhoanVIP();
                
                vip.setId(rs.getInt("ID"));
                vip.setNguoiDungID(rs.getInt("NguoiDungID"));
                vip.setLoaiVIP(rs.getString("LoaiVIP"));
                
                vip.setGiaVIP(rs.getBigDecimal("GiaVIP"));
                vip.setTrangThai(rs.getBoolean("TrangThai"));
                
                Timestamp ngayBatDau = rs.getTimestamp("NgayBatDau");
                if (ngayBatDau != null) {
                    vip.setNgayBatDau(ngayBatDau.toLocalDateTime());
                }
                
                Timestamp ngayKetThuc = rs.getTimestamp("NgayKetThuc");
                if (ngayKetThuc != null) {
                    vip.setNgayKetThuc(ngayKetThuc.toLocalDateTime());
                }
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    vip.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                return vip;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy thông tin VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Cấp VIP cho người dùng
    public boolean capVIPChoNguoiDung(int nguoiDungId, LocalDateTime ngayBatDau, LocalDateTime ngayKetThuc, String loaiVIP, java.math.BigDecimal giaVIP) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            System.out.println("DEBUG: Bắt đầu cấp VIP cho user " + nguoiDungId);
            System.out.println("DEBUG: Ngày bắt đầu: " + ngayBatDau);
            System.out.println("DEBUG: Ngày kết thúc: " + ngayKetThuc);
            
            // 1. Vô hiệu hóa tất cả VIP cũ của user trước
            String sqlDisableOld = "UPDATE TaiKhoanVIP SET TrangThai = 0 WHERE NguoiDungID = ? AND TrangThai = 1";
            try (PreparedStatement pstmtDisable = conn.prepareStatement(sqlDisableOld)) {
                pstmtDisable.setInt(1, nguoiDungId);
                int disabledRows = pstmtDisable.executeUpdate();
                System.out.println("DEBUG: Đã vô hiệu hóa " + disabledRows + " VIP cũ");
            }
            
            // 2. Thêm vào bảng TaiKhoanVIP
            String sqlVIP = "INSERT INTO TaiKhoanVIP (NguoiDungID, NgayBatDau, NgayKetThuc, LoaiVIP, GiaVIP, TrangThai) VALUES (?, ?, ?, ?, ?, 1)";
            try (PreparedStatement pstmtVIP = conn.prepareStatement(sqlVIP)) {
                pstmtVIP.setInt(1, nguoiDungId);
                pstmtVIP.setTimestamp(2, Timestamp.valueOf(ngayBatDau));
                pstmtVIP.setTimestamp(3, Timestamp.valueOf(ngayKetThuc));
                pstmtVIP.setString(4, loaiVIP);
                pstmtVIP.setBigDecimal(5, giaVIP);
                int insertedRows = pstmtVIP.executeUpdate();
                System.out.println("DEBUG: Đã thêm " + insertedRows + " bản ghi VIP mới");
            }
            
            // 3. Cập nhật trạng thái VIP trong bảng NguoiDung
            String sqlUser = "UPDATE NguoiDung SET TrangThaiVIP = 1, NgayDangKyVIP = ?, NgayHetHanVIP = ? WHERE ID = ?";
            try (PreparedStatement pstmtUser = conn.prepareStatement(sqlUser)) {
                pstmtUser.setTimestamp(1, Timestamp.valueOf(ngayBatDau));
                pstmtUser.setTimestamp(2, Timestamp.valueOf(ngayKetThuc));
                pstmtUser.setInt(3, nguoiDungId);
                int updatedRows = pstmtUser.executeUpdate();
                System.out.println("DEBUG: Đã cập nhật " + updatedRows + " user với trạng thái VIP");
            }
            
            conn.commit();
            // Lấy thông tin người dùng
        NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
        NguoiDung nd = nguoiDungDAO.layThongTinNguoiDung(nguoiDungId);

        //   / Gửi email xác nhận cấp VIP
        service.EmailSender.sendCapVipEmail(
            nd.getEmail(),
            nd.getHoTen(),
            loaiVIP,
            giaVIP,
            ngayBatDau,
            ngayKetThuc
        );
            System.out.println("DEBUG: Cấp VIP thành công!");
            return true;
            
        } catch (SQLException | ClassNotFoundException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("DEBUG: Đã rollback transaction");
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            System.err.println("Lỗi khi cấp VIP: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }
    
    // Thu hồi VIP của người dùng
    public boolean thuHoiVIP(int nguoiDungId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Xóa tất cả VIP đang hoạt động của user
            String sqlDeleteVIP = "UPDATE TaiKhoanVIP SET TrangThai = 0 WHERE NguoiDungID = ? AND TrangThai = 1";
            try (PreparedStatement pstmtDelete = conn.prepareStatement(sqlDeleteVIP)) {
                pstmtDelete.setInt(1, nguoiDungId);
                pstmtDelete.executeUpdate();
            }
            
            // 2. Cập nhật trạng thái VIP trong bảng NguoiDung
            String sqlUser = "UPDATE NguoiDung SET TrangThaiVIP = 0, NgayDangKyVIP = NULL, NgayHetHanVIP = NULL WHERE ID = ?";
            try (PreparedStatement pstmtUser = conn.prepareStatement(sqlUser)) {
                pstmtUser.setInt(1, nguoiDungId);
                pstmtUser.executeUpdate();
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException | ClassNotFoundException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            System.err.println("Lỗi khi thu hồi VIP: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }
    
    // Cập nhật trạng thái VIP cho NguoiDung
    public boolean capNhatTrangThaiVIPChoNguoiDung(int nguoiDungId, boolean trangThaiVIP) {
        String sql = "UPDATE NguoiDung SET TrangThaiVIP = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, trangThaiVIP);
            pstmt.setInt(2, nguoiDungId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật trạng thái VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Lấy danh sách tài khoản VIP với thông tin người dùng
    public List<Object[]> layDanhSachVIPVoiThongTinNguoiDung(int page, int pageSize) {
        List<Object[]> danhSach = new ArrayList<>();
        String sql = "SELECT v.*, u.HoTen, u.Email, u.SoDienThoai FROM TaiKhoanVIP v " +
                     "JOIN NguoiDung u ON v.NguoiDungID = u.ID " +
                     "WHERE v.TrangThai = 1 " +
                     "ORDER BY v.NgayTao DESC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, (page - 1) * pageSize);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Object[] data = new Object[2];
                
                // TaiKhoanVIP
                TaiKhoanVIP vip = new TaiKhoanVIP();
                vip.setId(rs.getInt("ID"));
                vip.setNguoiDungID(rs.getInt("NguoiDungID"));
                vip.setLoaiVIP(rs.getString("LoaiVIP"));
                vip.setGiaVIP(rs.getBigDecimal("GiaVIP"));
                vip.setTrangThai(rs.getBoolean("TrangThai"));
                
                Timestamp ngayBatDau = rs.getTimestamp("NgayBatDau");
                if (ngayBatDau != null) vip.setNgayBatDau(ngayBatDau.toLocalDateTime());
                
                Timestamp ngayKetThuc = rs.getTimestamp("NgayKetThuc");
                if (ngayKetThuc != null) vip.setNgayKetThuc(ngayKetThuc.toLocalDateTime());
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) vip.setNgayTao(ngayTao.toLocalDateTime());
                
                data[0] = vip;
                
                // Thông tin người dùng
                String[] userInfo = new String[3];
                userInfo[0] = rs.getString("HoTen");
                userInfo[1] = rs.getString("Email"); 
                userInfo[2] = rs.getString("SoDienThoai");
                data[1] = userInfo;
                
                danhSach.add(data);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy danh sách tài khoản VIP
    public List<TaiKhoanVIP> layDanhSachVIP(int page, int pageSize) {
        List<TaiKhoanVIP> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM TaiKhoanVIP ORDER BY NgayTao DESC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, (page - 1) * pageSize);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                TaiKhoanVIP vip = new TaiKhoanVIP();
                vip.setId(rs.getInt("ID"));
                vip.setNguoiDungID(rs.getInt("NguoiDungID"));
                vip.setLoaiVIP(rs.getString("LoaiVIP"));
                vip.setGiaVIP(rs.getBigDecimal("GiaVIP"));
                vip.setTrangThai(rs.getBoolean("TrangThai"));
                
                Timestamp ngayBatDau = rs.getTimestamp("NgayBatDau");
                if (ngayBatDau != null) {
                    vip.setNgayBatDau(ngayBatDau.toLocalDateTime());
                }
                
                Timestamp ngayKetThuc = rs.getTimestamp("NgayKetThuc");
                if (ngayKetThuc != null) {
                    vip.setNgayKetThuc(ngayKetThuc.toLocalDateTime());
                }
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    vip.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                danhSach.add(vip);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Đếm tổng số VIP đang hoạt động
    public int demTongSoVIPHoatDong() {
        String sql = "SELECT COUNT(*) FROM TaiKhoanVIP WHERE TrangThai = 1 AND NgayKetThuc > NOW()";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public List<TaiKhoanVIP> layVipSapHetTrongNgay(int soNgayCanhBao) {
    List<TaiKhoanVIP> danhSach = new ArrayList<>();
    String sql = "SELECT * FROM TaiKhoanVIP WHERE TrangThai = 1 AND NgayKetThuc BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL ? DAY)";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setInt(1, soNgayCanhBao);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            TaiKhoanVIP vip = new TaiKhoanVIP();
            vip.setId(rs.getInt("ID"));
            vip.setNguoiDungID(rs.getInt("NguoiDungID"));
            vip.setLoaiVIP(rs.getString("LoaiVIP"));
            vip.setGiaVIP(rs.getBigDecimal("GiaVIP"));
            vip.setNgayBatDau(rs.getTimestamp("NgayBatDau").toLocalDateTime());
            vip.setNgayKetThuc(rs.getTimestamp("NgayKetThuc").toLocalDateTime());
            danhSach.add(vip);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return danhSach;
}

}