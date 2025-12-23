package dao;

import db.DBConnection;
import model.GoiVIP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GoiVIPDAO {
    
    // Lấy tất cả gói VIP
    public List<GoiVIP> layTatCaGoiVIP() {
        List<GoiVIP> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM GoiVIP ORDER BY ThuTu, NgayTao DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                GoiVIP goi = new GoiVIP();
                goi.setId(rs.getInt("ID"));
                goi.setTenGoi(rs.getString("TenGoi"));
                goi.setMoTa(rs.getString("MoTa"));
                goi.setSoThang(rs.getInt("SoThang"));
                goi.setGia(rs.getBigDecimal("Gia"));
                goi.setGiaGoc(rs.getBigDecimal("GiaGoc"));
                goi.setPhanTramGiamGia(rs.getInt("PhanTramGiamGia"));
                goi.setMauSac(rs.getString("MauSac"));
                goi.setIcon(rs.getString("Icon"));
                goi.setTrangThai(rs.getBoolean("TrangThai"));
                goi.setThuTu(rs.getInt("ThuTu"));
                goi.setNoiBat(rs.getBoolean("NoiBat"));
                
                danhSach.add(goi);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách gói VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy gói VIP đang hoạt động
    public List<GoiVIP> layGoiVIPHoatDong() {
        List<GoiVIP> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM GoiVIP WHERE TrangThai = 1 ORDER BY ThuTu, NgayTao DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                GoiVIP goi = new GoiVIP();
                goi.setId(rs.getInt("ID"));
                goi.setTenGoi(rs.getString("TenGoi"));
                goi.setMoTa(rs.getString("MoTa"));
                goi.setSoThang(rs.getInt("SoThang"));
                goi.setGia(rs.getBigDecimal("Gia"));
                goi.setGiaGoc(rs.getBigDecimal("GiaGoc"));
                goi.setPhanTramGiamGia(rs.getInt("PhanTramGiamGia"));
                goi.setMauSac(rs.getString("MauSac"));
                goi.setIcon(rs.getString("Icon"));
                goi.setTrangThai(rs.getBoolean("TrangThai"));
                goi.setThuTu(rs.getInt("ThuTu"));
                goi.setNoiBat(rs.getBoolean("NoiBat"));
                
                danhSach.add(goi);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy gói VIP hoạt động: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy thông tin gói VIP theo ID
    public GoiVIP layGoiVIPTheoID(int id) {
        String sql = "SELECT * FROM GoiVIP WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                GoiVIP goi = new GoiVIP();
                goi.setId(rs.getInt("ID"));
                goi.setTenGoi(rs.getString("TenGoi"));
                goi.setMoTa(rs.getString("MoTa"));
                goi.setSoThang(rs.getInt("SoThang"));
                goi.setGia(rs.getBigDecimal("Gia"));
                goi.setGiaGoc(rs.getBigDecimal("GiaGoc"));
                goi.setPhanTramGiamGia(rs.getInt("PhanTramGiamGia"));
                goi.setMauSac(rs.getString("MauSac"));
                goi.setIcon(rs.getString("Icon"));
                goi.setTrangThai(rs.getBoolean("TrangThai"));
                goi.setThuTu(rs.getInt("ThuTu"));
                goi.setNoiBat(rs.getBoolean("NoiBat"));
                
                return goi;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy gói VIP theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Thêm gói VIP mới
    public boolean themGoiVIP(GoiVIP goi) {
        String sql = "INSERT INTO GoiVIP (TenGoi, MoTa, SoThang, Gia, GiaGoc, PhanTramGiamGia, MauSac, Icon, TrangThai, ThuTu, NoiBat) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, goi.getTenGoi());
            pstmt.setString(2, goi.getMoTa());
            pstmt.setInt(3, goi.getSoThang());
            pstmt.setBigDecimal(4, goi.getGia());
            pstmt.setBigDecimal(5, goi.getGiaGoc());
            pstmt.setInt(6, goi.getPhanTramGiamGia());
            pstmt.setString(7, goi.getMauSac());
            pstmt.setString(8, goi.getIcon());
            pstmt.setBoolean(9, goi.isTrangThai());
            pstmt.setInt(10, goi.getThuTu());
            pstmt.setBoolean(11, goi.isNoiBat());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm gói VIP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Cập nhật gói VIP
    public boolean capNhatGoiVIP(GoiVIP goi) {
        String sql = "UPDATE GoiVIP SET TenGoi = ?, MoTa = ?, SoThang = ?, Gia = ?, GiaGoc = ?, PhanTramGiamGia = ?, MauSac = ?, Icon = ?, TrangThai = ?, ThuTu = ?, NoiBat = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, goi.getTenGoi());
            pstmt.setString(2, goi.getMoTa());
            pstmt.setInt(3, goi.getSoThang());
            pstmt.setBigDecimal(4, goi.getGia());
            pstmt.setBigDecimal(5, goi.getGiaGoc());
            pstmt.setInt(6, goi.getPhanTramGiamGia());
            pstmt.setString(7, goi.getMauSac());
            pstmt.setString(8, goi.getIcon());
            pstmt.setBoolean(9, goi.isTrangThai());
            pstmt.setInt(10, goi.getThuTu());
            pstmt.setBoolean(11, goi.isNoiBat());
            pstmt.setInt(12, goi.getId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật gói VIP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa gói VIP
    public boolean xoaGoiVIP(int id) {
        String sql = "DELETE FROM GoiVIP WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa gói VIP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Kiểm tra tên gói đã tồn tại
    public boolean kiemTraTenGoiTonTai(String tenGoi, int excludeId) {
        String sql = "SELECT COUNT(*) FROM GoiVIP WHERE TenGoi = ? AND ID != ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, tenGoi);
            pstmt.setInt(2, excludeId);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra tên gói: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Đếm tổng số gói VIP
    public int demTongSoGoiVIP() {
        String sql = "SELECT COUNT(*) FROM GoiVIP";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm gói VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
}