/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBConnection;
import model.YeuCauThanhToan;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author USER
 */
public class YeuCauThanhToanDAO {
    // Tạo yêu cầu thanh toán mới
    public boolean taoYeuCauThanhToan(YeuCauThanhToan yeuCau) {
        String sql = "INSERT INTO YeuCauThanhToan (NguoiDungID, GoiVIPID, SoTien, NoiDungChuyenKhoan, TrangThai) VALUES (?, ?, ?, ?, 'PENDING')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, yeuCau.getNguoiDungID());
            pstmt.setInt(2, yeuCau.getGoiVIPID());
            pstmt.setBigDecimal(3, yeuCau.getSoTien());
            pstmt.setString(4, yeuCau.getNoiDungChuyenKhoan());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi tạo yêu cầu thanh toán: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Kiểm tra xem user có yêu cầu thanh toán đang pending không
    public boolean kiemTraYeuCauDangCho(int nguoiDungID, int goiVIPID) {
        String sql = "SELECT COUNT(*) FROM YeuCauThanhToan WHERE NguoiDungID = ? AND GoiVIPID = ? AND TrangThai = 'PENDING'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungID);
            pstmt.setInt(2, goiVIPID);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra yêu cầu: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Lấy yêu cầu thanh toán theo ID
    public YeuCauThanhToan layYeuCauTheoID(int id) {
        String sql = "SELECT * FROM YeuCauThanhToan WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                YeuCauThanhToan yeuCau = new YeuCauThanhToan();
                yeuCau.setId(rs.getInt("ID"));
                yeuCau.setNguoiDungID(rs.getInt("NguoiDungID"));
                yeuCau.setGoiVIPID(rs.getInt("GoiVIPID"));
                yeuCau.setSoTien(rs.getBigDecimal("SoTien"));
                yeuCau.setNoiDungChuyenKhoan(rs.getString("NoiDungChuyenKhoan"));
                yeuCau.setTrangThai(rs.getString("TrangThai"));
                yeuCau.setGhiChu(rs.getString("GhiChu"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    yeuCau.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                Timestamp ngayXuLy = rs.getTimestamp("NgayXuLy");
                if (ngayXuLy != null) {
                    yeuCau.setNgayXuLy(ngayXuLy.toLocalDateTime());
                }
                
                yeuCau.setNguoiXuLy((Integer) rs.getObject("NguoiXuLy"));
                
                return yeuCau;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy yêu cầu: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Lấy danh sách yêu cầu thanh toán đang chờ duyệt
    public List<YeuCauThanhToan> layDanhSachYeuCauChoXuLy() {
        List<YeuCauThanhToan> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM YeuCauThanhToan WHERE TrangThai = 'PENDING' ORDER BY NgayTao DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                YeuCauThanhToan yeuCau = new YeuCauThanhToan();
                yeuCau.setId(rs.getInt("ID"));
                yeuCau.setNguoiDungID(rs.getInt("NguoiDungID"));
                yeuCau.setGoiVIPID(rs.getInt("GoiVIPID"));
                yeuCau.setSoTien(rs.getBigDecimal("SoTien"));
                yeuCau.setNoiDungChuyenKhoan(rs.getString("NoiDungChuyenKhoan"));
                yeuCau.setTrangThai(rs.getString("TrangThai"));
                yeuCau.setGhiChu(rs.getString("GhiChu"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    yeuCau.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                danhSach.add(yeuCau);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách yêu cầu: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Duyệt yêu cầu thanh toán
    public boolean duyetYeuCau(int yeuCauID, int nguoiXuLy, String ghiChu) {
        String sql = "UPDATE YeuCauThanhToan SET TrangThai = 'APPROVED', NgayXuLy = NOW(), NguoiXuLy = ?, GhiChu = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiXuLy);
            pstmt.setString(2, ghiChu);
            pstmt.setInt(3, yeuCauID);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi duyệt yêu cầu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Từ chối yêu cầu thanh toán
    public boolean tuChoiYeuCau(int yeuCauID, int nguoiXuLy, String ghiChu) {
        String sql = "UPDATE YeuCauThanhToan SET TrangThai = 'REJECTED', NgayXuLy = NOW(), NguoiXuLy = ?, GhiChu = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiXuLy);
            pstmt.setString(2, ghiChu);
            pstmt.setInt(3, yeuCauID);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi từ chối yêu cầu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    // Lấy yêu cầu thanh toán đang chờ xử lý theo user và package
public YeuCauThanhToan layYeuCauDangCho(int nguoiDungID, int goiVIPID) {
    String sql = "SELECT * FROM YeuCauThanhToan WHERE NguoiDungID = ? AND GoiVIPID = ? AND TrangThai = 'PENDING'";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setInt(1, nguoiDungID);
        pstmt.setInt(2, goiVIPID);
        
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            YeuCauThanhToan yeuCau = new YeuCauThanhToan();
            yeuCau.setId(rs.getInt("ID"));
            yeuCau.setNguoiDungID(rs.getInt("NguoiDungID"));
            yeuCau.setGoiVIPID(rs.getInt("GoiVIPID"));
            yeuCau.setSoTien(rs.getBigDecimal("SoTien"));
            yeuCau.setNoiDungChuyenKhoan(rs.getString("NoiDungChuyenKhoan"));
            yeuCau.setTrangThai(rs.getString("TrangThai"));
            yeuCau.setGhiChu(rs.getString("GhiChu"));
            
            Timestamp ngayTao = rs.getTimestamp("NgayTao");
            if (ngayTao != null) {
                yeuCau.setNgayTao(ngayTao.toLocalDateTime());
            }
            
            Timestamp ngayXuLy = rs.getTimestamp("NgayXuLy");
            if (ngayXuLy != null) {
                yeuCau.setNgayXuLy(ngayXuLy.toLocalDateTime());
            }
            
            yeuCau.setNguoiXuLy((Integer) rs.getObject("NguoiXuLy"));
            
            return yeuCau;
        }
        
    } catch (SQLException | ClassNotFoundException e) {
        System.err.println("Lỗi khi lấy yêu cầu đang chờ: " + e.getMessage());
        e.printStackTrace();
    }
    
    return null;
}
   private YeuCauThanhToan mapResultSetToYeuCau(ResultSet rs) throws SQLException {
    YeuCauThanhToan yeuCau = new YeuCauThanhToan();
    yeuCau.setId(rs.getInt("ID"));
    yeuCau.setNguoiDungID(rs.getInt("NguoiDungID"));
    yeuCau.setGoiVIPID(rs.getInt("GoiVIPID"));
    yeuCau.setSoTien(rs.getBigDecimal("SoTien"));
    yeuCau.setNoiDungChuyenKhoan(rs.getString("NoiDungChuyenKhoan"));
    yeuCau.setTrangThai(rs.getString("TrangThai"));
    yeuCau.setGhiChu(rs.getString("GhiChu"));

    Timestamp ngayTao = rs.getTimestamp("NgayTao");
    if (ngayTao != null) {
        yeuCau.setNgayTao(ngayTao.toLocalDateTime());
    }

    Timestamp ngayXuLy = rs.getTimestamp("NgayXuLy");
    if (ngayXuLy != null) {
        yeuCau.setNgayXuLy(ngayXuLy.toLocalDateTime());
    }

    yeuCau.setNguoiXuLy((Integer) rs.getObject("NguoiXuLy"));
    return yeuCau;
}

   public boolean xoaYeuCau(int id) {
    String sql = "DELETE FROM YeuCauThanhToan WHERE ID = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setInt(1, id);
        return pstmt.executeUpdate() > 0;

    } catch (SQLException | ClassNotFoundException e) {
        System.err.println("Lỗi khi xóa yêu cầu: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}
}
