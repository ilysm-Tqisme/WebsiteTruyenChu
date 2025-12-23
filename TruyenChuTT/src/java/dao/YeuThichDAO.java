package dao;

import db.DBConnection;
import model.YeuThich;
import model.NguoiDung;
import model.Truyen;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class YeuThichDAO {
    
    // Thêm truyện vào yêu thích
    public boolean themTruyenVaoYeuThich(YeuThich yeuThich) {
        String checkSql = "SELECT COUNT(*) FROM YeuThich WHERE NguoiDungID = ? AND TruyenID = ?";
        String insertSql = "INSERT INTO YeuThich (NguoiDungID, TruyenID, NgayYeuThich) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Kiểm tra đã có chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, yeuThich.getNguoiDung().getId());
                checkStmt.setInt(2, yeuThich.getTruyen().getId());
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Đã tồn tại
                }
            }
            
            // Thêm mới
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, yeuThich.getNguoiDung().getId());
                insertStmt.setInt(2, yeuThich.getTruyen().getId());
                insertStmt.setTimestamp(3, Timestamp.valueOf(yeuThich.getNgayYeuThich()));
                return insertStmt.executeUpdate() > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm truyện vào yêu thích: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa truyện khỏi yêu thích
    public boolean xoaTruyenKhoiYeuThich(int nguoiDungId, int truyenId) {
        String sql = "DELETE FROM YeuThich WHERE NguoiDungID = ? AND TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, truyenId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa truyện khỏi yêu thích: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Kiểm tra truyện đã yêu thích chưa
    public boolean kiemTraTruyenYeuThich(int nguoiDungId, int truyenId) {
        String sql = "SELECT COUNT(*) FROM YeuThich WHERE NguoiDungID = ? AND TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, truyenId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra truyện yêu thích: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Đếm số truyện yêu thích theo người dùng
    public int demTruyenYeuThichTheoNguoiDung(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM YeuThich WHERE NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm truyện yêu thích: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy danh sách truyện yêu thích với phân trang
    public List<YeuThich> layDanhSachTruyenYeuThich(int nguoiDungId, int offset, int limit) {
        List<YeuThich> danhSach = new ArrayList<>();
        String sql = """
            SELECT yt.*, t.TenTruyen, t.AnhBia, tg.TenTacGia, t.LuotXem, t.DiemDanhGia,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM YeuThich yt
            JOIN Truyen t ON yt.TruyenID = t.ID
            LEFT JOIN TacGia tg ON t.TacGiaID = tg.ID
            WHERE yt.NguoiDungID = ?
            ORDER BY yt.NgayYeuThich DESC
            LIMIT ? OFFSET ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                YeuThich yeuThich = mapResultSetToYeuThich(rs);
                danhSach.add(yeuThich);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách truyện yêu thích: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy tất cả truyện yêu thích (không phân trang)
    public List<YeuThich> layTatCaTruyenYeuThich(int nguoiDungId) {
        List<YeuThich> danhSach = new ArrayList<>();
        String sql = """
            SELECT yt.*, t.TenTruyen, t.AnhBia, tg.TenTacGia, t.LuotXem, t.DiemDanhGia,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM YeuThich yt
            JOIN Truyen t ON yt.TruyenID = t.ID
            LEFT JOIN TacGia tg ON t.TacGiaID = tg.ID
            WHERE yt.NguoiDungID = ?
            ORDER BY yt.NgayYeuThich DESC
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                YeuThich yeuThich = mapResultSetToYeuThich(rs);
                danhSach.add(yeuThich);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy tất cả truyện yêu thích: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Helper method
    private YeuThich mapResultSetToYeuThich(ResultSet rs) throws SQLException {
        YeuThich yeuThich = new YeuThich();
        yeuThich.setId(rs.getLong("ID"));
        
        Timestamp ngayYeuThich = rs.getTimestamp("NgayYeuThich");
        if (ngayYeuThich != null) {
            yeuThich.setNgayYeuThich(ngayYeuThich.toLocalDateTime());
        }
        
        // Set NguoiDung
        NguoiDung nguoiDung = new NguoiDung();
        nguoiDung.setId(rs.getInt("NguoiDungID"));
        yeuThich.setNguoiDung(nguoiDung);
        
        // Set Truyen
        Truyen truyen = new Truyen();
        truyen.setId(rs.getInt("TruyenID"));
        truyen.setTenTruyen(rs.getString("TenTruyen"));
        truyen.setAnhBia(rs.getString("AnhBia"));
        truyen.setTacGiaTen(rs.getString("TenTacGia"));
        truyen.setLuotXem(rs.getInt("LuotXem"));
        truyen.setDiemDanhGia(rs.getDouble("DiemDanhGia"));
        if (rs.getObject("soLuongChuong") != null) {
            truyen.setSoLuongChuong(rs.getInt("soLuongChuong"));
        }
        yeuThich.setTruyen(truyen);
        
        return yeuThich;
    }
}

