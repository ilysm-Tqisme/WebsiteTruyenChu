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
import model.DanhGia;
import model.NguoiDung;
import model.Truyen;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DanhGiaDAO {
    
    // Thêm hoặc cập nhật đánh giá
    public boolean themHoacCapNhatDanhGia(DanhGia danhGia) {
        String checkSql = "SELECT COUNT(*) FROM DanhGia WHERE NguoiDungID = ? AND TruyenID = ?";
        String insertSql = "INSERT INTO DanhGia (NguoiDungID, TruyenID, DiemSo, NhanXet, NgayDanhGia) VALUES (?, ?, ?, ?, ?)";
        String updateSql = "UPDATE DanhGia SET DiemSo = ?, NhanXet = ?, NgayDanhGia = ? WHERE NguoiDungID = ? AND TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Kiểm tra đã có đánh giá chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, danhGia.getNguoiDung().getId());
                checkStmt.setInt(2, danhGia.getTruyen().getId());
                ResultSet rs = checkStmt.executeQuery();
                
                boolean exists = rs.next() && rs.getInt(1) > 0;
                
                if (exists) {
                    // Cập nhật
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, danhGia.getDiemSo());
                        updateStmt.setString(2, danhGia.getNhanXet());
                        updateStmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                        updateStmt.setInt(4, danhGia.getNguoiDung().getId());
                        updateStmt.setInt(5, danhGia.getTruyen().getId());
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    // Thêm mới
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, danhGia.getNguoiDung().getId());
                        insertStmt.setInt(2, danhGia.getTruyen().getId());
                        insertStmt.setInt(3, danhGia.getDiemSo());
                        insertStmt.setString(4, danhGia.getNhanXet());
                        insertStmt.setTimestamp(5, Timestamp.valueOf(danhGia.getNgayDanhGia()));
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm/cập nhật đánh giá: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Lấy đánh giá theo truyện
    public List<DanhGia> layDanhGiaTheoTruyen(int truyenId, int offset, int limit) {
        List<DanhGia> danhSach = new ArrayList<>();
        String sql = """
            SELECT dg.*, nd.HoTen, nd.AnhDaiDien, t.TenTruyen
            FROM DanhGia dg
            JOIN NguoiDung nd ON dg.NguoiDungID = nd.ID
            JOIN Truyen t ON dg.TruyenID = t.ID
            WHERE dg.TruyenID = ?
            ORDER BY dg.NgayDanhGia DESC
            LIMIT ? OFFSET ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, truyenId);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                DanhGia danhGia = mapResultSetToDanhGia(rs);
                danhSach.add(danhGia);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy đánh giá theo truyện: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Đếm số đánh giá theo người dùng
    public int demDanhGiaTheoNguoiDung(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM DanhGia WHERE NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm đánh giá: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy đánh giá gần đây của người dùng
    public List<DanhGia> layDanhGiaGanDayTheoNguoiDung(int nguoiDungId, int limit) {
        List<DanhGia> danhSach = new ArrayList<>();
        String sql = """
            SELECT dg.*, nd.HoTen, nd.AnhDaiDien, t.TenTruyen
            FROM DanhGia dg
            JOIN NguoiDung nd ON dg.NguoiDungID = nd.ID
            JOIN Truyen t ON dg.TruyenID = t.ID
            WHERE dg.NguoiDungID = ?
            ORDER BY dg.NgayDanhGia DESC
            LIMIT ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                DanhGia danhGia = mapResultSetToDanhGia(rs);
                danhSach.add(danhGia);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy đánh giá gần đây: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Tính điểm trung bình của truyện
    public double tinhDiemTrungBinhTruyen(int truyenId) {
        String sql = "SELECT AVG(DiemSo) FROM DanhGia WHERE TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, truyenId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi tính điểm trung bình: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    // Helper method
    private DanhGia mapResultSetToDanhGia(ResultSet rs) throws SQLException {
        DanhGia danhGia = new DanhGia();
        danhGia.setId(rs.getLong("ID"));
        danhGia.setDiemSo(rs.getInt("DiemSo"));
        danhGia.setNhanXet(rs.getString("NhanXet"));
        
        Timestamp ngayDanhGia = rs.getTimestamp("NgayDanhGia");
        if (ngayDanhGia != null) {
            danhGia.setNgayDanhGia(ngayDanhGia.toLocalDateTime());
        }
        
        // Set NguoiDung
        NguoiDung nguoiDung = new NguoiDung();
        nguoiDung.setId(rs.getInt("NguoiDungID"));
        nguoiDung.setHoTen(rs.getString("HoTen"));
        nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
        danhGia.setNguoiDung(nguoiDung);
        
        // Set Truyen
        Truyen truyen = new Truyen();
        truyen.setId(rs.getInt("TruyenID"));
        truyen.setTenTruyen(rs.getString("TenTruyen"));
        danhGia.setTruyen(truyen);
        
        return danhGia;
    }
}