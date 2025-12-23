package dao;

import db.DBConnection;
import model.TuTruyen;
import model.NguoiDung;
import model.Truyen;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TuTruyenDAO {
    
    // Thêm truyện vào tủ
    public boolean themTruyenVaoTu(TuTruyen tuTruyen) {
        String checkSql = "SELECT COUNT(*) FROM TuTruyen WHERE NguoiDungID = ? AND TruyenID = ?";
        String insertSql = "INSERT INTO TuTruyen (NguoiDungID, TruyenID, NgayLuu) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Kiểm tra đã có chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, tuTruyen.getNguoiDung().getId());
                checkStmt.setInt(2, tuTruyen.getTruyen().getId());
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Đã tồn tại
                }
            }
            
            // Thêm mới
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, tuTruyen.getNguoiDung().getId());
                insertStmt.setInt(2, tuTruyen.getTruyen().getId());
                insertStmt.setTimestamp(3, Timestamp.valueOf(tuTruyen.getNgayLuu()));
                return insertStmt.executeUpdate() > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm truyện vào tủ: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Xóa truyện khỏi tủ
    public boolean xoaTruyenKhoiTu(int nguoiDungId, int truyenId) {
        String sql = "DELETE FROM TuTruyen WHERE NguoiDungID = ? AND TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, truyenId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa truyện khỏi tủ: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Kiểm tra truyện đã có trong tủ chưa
    public boolean kiemTraTruyenTrongTu(int nguoiDungId, int truyenId) {
        String sql = "SELECT COUNT(*) FROM TuTruyen WHERE NguoiDungID = ? AND TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, truyenId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra truyện trong tủ: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Đếm số truyện trong tủ theo người dùng
    public int demTruyenTrongTuTheoNguoiDung(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM TuTruyen WHERE NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm truyện trong tủ: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy danh sách truyện trong tủ
    public List<TuTruyen> layDanhSachTruyenTrongTu(int nguoiDungId, int offset, int limit) {
        List<TuTruyen> danhSach = new ArrayList<>();
        String sql = """
            SELECT tt.*, t.TenTruyen, t.AnhBia, tg.TenTacGia, t.LuotXem, t.DiemDanhGia,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM TuTruyen tt
            JOIN Truyen t ON tt.TruyenID = t.ID
            LEFT JOIN TacGia tg ON t.TacGiaID = tg.ID
            WHERE tt.NguoiDungID = ?
            ORDER BY tt.NgayLuu DESC
            LIMIT ? OFFSET ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                TuTruyen tuTruyen = mapResultSetToTuTruyen(rs);
                danhSach.add(tuTruyen);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách truyện trong tủ: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Helper method
    private TuTruyen mapResultSetToTuTruyen(ResultSet rs) throws SQLException {
        TuTruyen tuTruyen = new TuTruyen();
        tuTruyen.setId(rs.getLong("ID"));
        
        Timestamp ngayLuu = rs.getTimestamp("NgayLuu");
        if (ngayLuu != null) {
            tuTruyen.setNgayLuu(ngayLuu.toLocalDateTime());
        }
        
        // Set NguoiDung
        NguoiDung nguoiDung = new NguoiDung();
        nguoiDung.setId(rs.getInt("NguoiDungID"));
        tuTruyen.setNguoiDung(nguoiDung);
        
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
        tuTruyen.setTruyen(truyen);
        
        return tuTruyen;
    }
}