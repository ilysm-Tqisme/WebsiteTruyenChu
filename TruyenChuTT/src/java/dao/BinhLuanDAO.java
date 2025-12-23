package dao;

import db.DBConnection;
import model.BinhLuan;
import model.NguoiDung;
import model.Truyen;
import model.Chuong;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BinhLuanDAO {
    private final ThongBaoDAO thongBaoDAO = new ThongBaoDAO();
    
    // Thêm bình luận mới với tích hợp thông báo
    public boolean themBinhLuan(BinhLuan binhLuan) {
        String sql = "INSERT INTO BinhLuan (NguoiDungID, TruyenID, ChuongID, NoiDung, TrangThai, NgayTao, BinhLuanChaID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, binhLuan.getNguoiDung().getId());
            pstmt.setInt(2, binhLuan.getTruyen().getId());
            
            if (binhLuan.getChuong() != null) {
                pstmt.setInt(3, binhLuan.getChuong().getId());
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            
            pstmt.setString(4, binhLuan.getNoiDung());
            pstmt.setBoolean(5, binhLuan.getTrangThai());
            pstmt.setTimestamp(6, Timestamp.valueOf(binhLuan.getNgayTao()));
            
            if (binhLuan.getBinhLuanCha() != null) {
                pstmt.setLong(7, binhLuan.getBinhLuanCha().getId());
            } else {
                pstmt.setNull(7, Types.BIGINT);
            }
            
            int result = pstmt.executeUpdate();
            
            // Nếu thành công và là trả lời bình luận (có bình luận cha)
            if (result > 0 && binhLuan.getBinhLuanCha() != null) {
                // Lấy ID của bình luận vừa tạo
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    binhLuan.setId(generatedKeys.getLong(1));
                }
                
                // Lấy thông tin bình luận cha để tạo thông báo
                BinhLuan binhLuanCha = layBinhLuanTheoId(binhLuan.getBinhLuanCha().getId());
                if (binhLuanCha != null && binhLuanCha.getNguoiDung().getId() != binhLuan.getNguoiDung().getId()) {
                    // Chỉ tạo thông báo nếu người trả lời khác với người viết bình luận gốc
                    thongBaoDAO.themThongBaoTraLoiBinhLuan(
                        binhLuanCha.getNguoiDung().getId(),
                        binhLuan.getNguoiDung().getHoTen(),
                        binhLuan.getTruyen().getTenTruyen(),
                        binhLuan.getNoiDung()
                    );
                }
            }
            
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm bình luận: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Lấy bình luận theo truyện với sắp xếp
    public List<BinhLuan> layBinhLuanTheoTruyenVoiSapXep(int truyenId, int offset, int limit, String sortOrder) {
        List<BinhLuan> danhSach = new ArrayList<>();
        
        String orderBy = "ORDER BY bl.NgayTao DESC"; // Mặc định mới nhất
        if ("oldest".equals(sortOrder)) {
            orderBy = "ORDER BY bl.NgayTao ASC"; // Cũ nhất
        }
        
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.TruyenID = ? AND bl.TrangThai = 1 AND bl.BinhLuanChaID IS NULL
        """ + " " + orderBy + " LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, truyenId);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BinhLuan binhLuan = mapResultSetToBinhLuan(rs);
                
                // Lấy bình luận con
                List<BinhLuan> binhLuanCon = layBinhLuanCon(binhLuan.getId());
                binhLuan.setBinhLuanCon(binhLuanCon);
                
                danhSach.add(binhLuan);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy bình luận theo truyện: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy bình luận theo truyện
    public List<BinhLuan> layBinhLuanTheoTruyen(int truyenId, int offset, int limit) {
        // Nếu truyenId = 0, lấy tất cả bình luận
        if (truyenId == 0) {
            return layTatCaBinhLuan(offset, limit);
        }
        return layBinhLuanTheoTruyenVoiSapXep(truyenId, offset, limit, "newest");
    }
    
    // Lấy tất cả bình luận cho admin
    public List<BinhLuan> layTatCaBinhLuan(int offset, int limit) {
        List<BinhLuan> danhSach = new ArrayList<>();
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.BinhLuanChaID IS NULL
            ORDER BY bl.NgayTao DESC
            LIMIT ? OFFSET ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BinhLuan binhLuan = mapResultSetToBinhLuan(rs);
                
                // Lấy bình luận con
                List<BinhLuan> binhLuanCon = layBinhLuanCon(binhLuan.getId());
                binhLuan.setBinhLuanCon(binhLuanCon);
                
                danhSach.add(binhLuan);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy tất cả bình luận: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Tìm kiếm bình luận theo từ khóa
    public List<BinhLuan> timKiemBinhLuan(String keyword, int offset, int limit) {
        List<BinhLuan> danhSach = new ArrayList<>();
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.BinhLuanChaID IS NULL
            AND (bl.NoiDung LIKE ? OR nd.HoTen LIKE ? OR t.TenTruyen LIKE ?)
            ORDER BY bl.NgayTao DESC
            LIMIT ? OFFSET ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            pstmt.setString(3, searchKeyword);
            pstmt.setInt(4, limit);
            pstmt.setInt(5, offset);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BinhLuan binhLuan = mapResultSetToBinhLuan(rs);
                
                // Lấy bình luận con
                List<BinhLuan> binhLuanCon = layBinhLuanCon(binhLuan.getId());
                binhLuan.setBinhLuanCon(binhLuanCon);
                
                danhSach.add(binhLuan);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi tìm kiếm bình luận: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Đếm kết quả tìm kiếm
    public int demKetQuaTimKiem(String keyword) {
        String sql = """
            SELECT COUNT(*)
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.BinhLuanChaID IS NULL
            AND (bl.NoiDung LIKE ? OR nd.HoTen LIKE ? OR t.TenTruyen LIKE ?)
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            pstmt.setString(3, searchKeyword);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm kết quả tìm kiếm: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Đếm tổng số bình luận
    public int demTatCaBinhLuan() {
        String sql = "SELECT COUNT(*) FROM BinhLuan WHERE BinhLuanChaID IS NULL";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm tất cả bình luận: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy bình luận con
    public List<BinhLuan> layBinhLuanCon(Long binhLuanChaId) {
        List<BinhLuan> danhSach = new ArrayList<>();
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.BinhLuanChaID = ? AND bl.TrangThai = 1
            ORDER BY bl.NgayTao ASC
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, binhLuanChaId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BinhLuan binhLuan = mapResultSetToBinhLuan(rs);
                danhSach.add(binhLuan);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy bình luận con: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Lấy bình luận theo ID
    public BinhLuan layBinhLuanTheoId(Long binhLuanId) {
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.ID = ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, binhLuanId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToBinhLuan(rs);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy bình luận theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Đếm số bình luận theo truyện
    public int demBinhLuanTheoTruyen(int truyenId) {
        // Nếu truyenId = 0, đếm tất cả bình luận
        if (truyenId == 0) {
            return demTatCaBinhLuan();
        }
        
        String sql = "SELECT COUNT(*) FROM BinhLuan WHERE TruyenID = ? AND TrangThai = 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, truyenId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm bình luận theo truyện: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Đếm số bình luận theo người dùng
    public int demBinhLuanTheoNguoiDung(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM BinhLuan WHERE NguoiDungID = ? AND TrangThai = 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm bình luận: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Lấy bình luận gần đây của người dùng
    public List<BinhLuan> layBinhLuanGanDayTheoNguoiDung(int nguoiDungId, int limit) {
        List<BinhLuan> danhSach = new ArrayList<>();
        String sql = """
            SELECT bl.*, nd.HoTen, nd.AnhDaiDien, nd.TrangThaiVIP, nd.VaiTro, t.TenTruyen
            FROM BinhLuan bl
            JOIN NguoiDung nd ON bl.NguoiDungID = nd.ID
            JOIN Truyen t ON bl.TruyenID = t.ID
            WHERE bl.NguoiDungID = ? AND bl.TrangThai = 1
            ORDER BY bl.NgayTao DESC
            LIMIT ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BinhLuan binhLuan = mapResultSetToBinhLuan(rs);
                danhSach.add(binhLuan);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy bình luận gần đây: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Xóa bình luận với cascade (xóa các bình luận con trước)
    public boolean xoaBinhLuan(Long id) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction
            
            // Xóa tất cả bình luận con trước
            String deleteSql = "DELETE FROM BinhLuan WHERE BinhLuanChaID = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {
                pstmt.setLong(1, id);
                pstmt.executeUpdate();
            }
            
            // Sau đó xóa bình luận cha
            String deleteParentSql = "DELETE FROM BinhLuan WHERE ID = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(deleteParentSql)) {
                pstmt.setLong(1, id);
                int result = pstmt.executeUpdate();
                
                conn.commit(); // Commit transaction
                return result > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa bình luận: " + e.getMessage());
            e.printStackTrace();
            
            // Rollback nếu có lỗi
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    System.err.println("Lỗi khi rollback: " + rollbackEx.getMessage());
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    System.err.println("Lỗi khi đóng kết nối: " + closeEx.getMessage());
                }
            }
        }
    }
    
    // Xóa nhiều bình luận
    public boolean xoaNhieuBinhLuanThucSu(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return false;
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Xóa tất cả bình luận con trước
            for (Long id : ids) {
                String deleteSql = "DELETE FROM BinhLuan WHERE BinhLuanChaID = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {
                    pstmt.setLong(1, id);
                    pstmt.executeUpdate();
                }
            }

            // Tạo dấu ? động cho câu SQL
            String placeholders = String.join(",", java.util.Collections.nCopies(ids.size(), "?"));
            String sql = "DELETE FROM BinhLuan WHERE ID IN (" + placeholders + ")";

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                for (int i = 0; i < ids.size(); i++) {
                    pstmt.setLong(i + 1, ids.get(i));
                }

                int affected = pstmt.executeUpdate();
                conn.commit(); // Commit transaction
                return affected > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa nhiều bình luận: " + e.getMessage());
            e.printStackTrace();
            
            // Rollback nếu có lỗi
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    System.err.println("Lỗi khi rollback: " + rollbackEx.getMessage());
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    System.err.println("Lỗi khi đóng kết nối: " + closeEx.getMessage());
                }
            }
        }
    }
    
    // Cập nhật trạng thái bình luận (ẩn/hiện)
    public boolean capNhatTrangThaiBinhLuan(Long id, boolean trangThai) {
        String sql = "UPDATE BinhLuan SET TrangThai = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, trangThai);
            pstmt.setLong(2, id);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật trạng thái bình luận: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method để map ResultSet thành BinhLuan
    private BinhLuan mapResultSetToBinhLuan(ResultSet rs) throws SQLException {
        BinhLuan binhLuan = new BinhLuan();
        binhLuan.setId(rs.getLong("ID"));
        binhLuan.setNoiDung(rs.getString("NoiDung"));
        binhLuan.setTrangThai(rs.getBoolean("TrangThai"));
        
        Timestamp ngayTao = rs.getTimestamp("NgayTao");
        if (ngayTao != null) {
            binhLuan.setNgayTao(ngayTao.toLocalDateTime());
        }
        
        // Set NguoiDung
        NguoiDung nguoiDung = new NguoiDung();
        nguoiDung.setId(rs.getInt("NguoiDungID"));
        nguoiDung.setHoTen(rs.getString("HoTen"));
        nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
        nguoiDung.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
        nguoiDung.setVaiTro(rs.getString("VaiTro"));
        binhLuan.setNguoiDung(nguoiDung);
        
        // Set Truyen
        Truyen truyen = new Truyen();
        truyen.setId(rs.getInt("TruyenID"));
        truyen.setTenTruyen(rs.getString("TenTruyen"));
        binhLuan.setTruyen(truyen);
        
        return binhLuan;
    }
}