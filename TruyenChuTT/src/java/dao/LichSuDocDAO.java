package dao;

import db.DBConnection;
import model.LichSuDoc;
import model.NguoiDung;
import model.Truyen;
import model.Chuong;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class LichSuDocDAO {
    
    // Thêm hoặc cập nhật lịch sử đọc
    public boolean themHoacCapNhatLichSuDoc(LichSuDoc lichSuDoc) {
        String checkSql = "SELECT ID, SoLanDoc FROM LichSuDoc WHERE NguoiDungID = ? AND TruyenID = ? AND ChuongID = ?";
        String insertSql = "INSERT INTO LichSuDoc (NguoiDungID, TruyenID, ChuongID, NgayDoc, SoLanDoc) VALUES (?, ?, ?, ?, ?)";
        String updateSql = "UPDATE LichSuDoc SET NgayDoc = ?, SoLanDoc = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Kiểm tra đã có lịch sử chưa
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, lichSuDoc.getNguoiDung().getId());
                checkStmt.setInt(2, lichSuDoc.getTruyen().getId());
                checkStmt.setInt(3, lichSuDoc.getChuong().getId());
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    // Cập nhật
                    Long id = rs.getLong("ID");
                    int soLanDoc = rs.getInt("SoLanDoc") + 1;
                    
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
                        updateStmt.setInt(2, soLanDoc);
                        updateStmt.setLong(3, id);
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    // Thêm mới
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, lichSuDoc.getNguoiDung().getId());
                        insertStmt.setInt(2, lichSuDoc.getTruyen().getId());
                        insertStmt.setInt(3, lichSuDoc.getChuong().getId());
                        insertStmt.setTimestamp(4, Timestamp.valueOf(lichSuDoc.getNgayDoc()));
                        insertStmt.setInt(5, lichSuDoc.getSoLanDoc());
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm/cập nhật lịch sử đọc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Đếm số truyện đã đọc theo người dùng
    public int demTruyenDaDocTheoNguoiDung(int nguoiDungId) {
        String sql = "SELECT COUNT(DISTINCT TruyenID) FROM LichSuDoc WHERE NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm truyện đã đọc: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy lịch sử đọc gần đây của người dùng
    public List<LichSuDoc> layLichSuDocGanDayTheoNguoiDung(int nguoiDungId, int limit) {
        List<LichSuDoc> danhSach = new ArrayList<>();
        String sql = """
            SELECT ls.*, t.TenTruyen, c.TenChuong, c.SoChuong
            FROM LichSuDoc ls
            JOIN Truyen t ON ls.TruyenID = t.ID
            JOIN Chuong c ON ls.ChuongID = c.ID
            WHERE ls.NguoiDungID = ?
            ORDER BY ls.NgayDoc DESC
            LIMIT ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                LichSuDoc lichSuDoc = mapResultSetToLichSuDoc(rs);
                danhSach.add(lichSuDoc);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy lịch sử đọc gần đây: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy lịch sử đọc theo truyện
    public List<LichSuDoc> layLichSuDocTheoTruyen(int nguoiDungId, int truyenId) {
        List<LichSuDoc> danhSach = new ArrayList<>();
        String sql = """
            SELECT ls.*, t.TenTruyen, c.TenChuong, c.SoChuong
            FROM LichSuDoc ls
            JOIN Truyen t ON ls.TruyenID = t.ID
            JOIN Chuong c ON ls.ChuongID = c.ID
            WHERE ls.NguoiDungID = ? AND ls.TruyenID = ?
            ORDER BY c.SoChuong ASC
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, truyenId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                LichSuDoc lichSuDoc = mapResultSetToLichSuDoc(rs);
                danhSach.add(lichSuDoc);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy lịch sử đọc theo truyện: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Xóa lịch sử đọc
    public boolean xoaLichSuDoc(Long id) {
        String sql = "DELETE FROM LichSuDoc WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, id);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa lịch sử đọc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method
    private LichSuDoc mapResultSetToLichSuDoc(ResultSet rs) throws SQLException {
        LichSuDoc lichSuDoc = new LichSuDoc();
        lichSuDoc.setId(rs.getLong("ID"));
        lichSuDoc.setSoLanDoc(rs.getInt("SoLanDoc"));
        
        Timestamp ngayDoc = rs.getTimestamp("NgayDoc");
        if (ngayDoc != null) {
            lichSuDoc.setNgayDoc(ngayDoc.toLocalDateTime());
        }
        
        // Set NguoiDung
        NguoiDung nguoiDung = new NguoiDung();
        nguoiDung.setId(rs.getInt("NguoiDungID"));
        lichSuDoc.setNguoiDung(nguoiDung);
        
        // Set Truyen
        Truyen truyen = new Truyen();
        truyen.setId(rs.getInt("TruyenID"));
        truyen.setTenTruyen(rs.getString("TenTruyen"));
        lichSuDoc.setTruyen(truyen);
        
        // Set Chuong
        Chuong chuong = new Chuong();
        chuong.setId(rs.getInt("ChuongID"));
        chuong.setTenChuong(rs.getString("TenChuong"));
        chuong.setSoChuong(rs.getInt("SoChuong"));
        lichSuDoc.setChuong(chuong);
        
        return lichSuDoc;
    }
}