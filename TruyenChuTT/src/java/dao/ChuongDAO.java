package dao;

import db.DBConnection;
import model.Chuong;
import model.Truyen;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ChuongDAO {

    // Lấy tất cả chương với phân trang
    public List<Chuong> layTatCaChuong(int offset, int limit)  {
        List<Chuong> list = new ArrayList<>();
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            ORDER BY c.NgayTao DESC
            LIMIT ? OFFSET ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chương theo truyện với phân trang
    public List<Chuong> layChuongTheoTruyen(int truyenId, int offset, int limit) {
        List<Chuong> list = new ArrayList<>();
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TruyenID = ?
            ORDER BY c.SoChuong ASC
            LIMIT ? OFFSET ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chương theo ID
    public Chuong layChuongTheoId(int id)  {
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.ID = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToChuong(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm chương mới
    public int themChuong(Chuong chuong) {
        String sql = """
            INSERT INTO Chuong (TruyenID, TenChuong, NoiDung, SoChuong, ChiDanhChoVIP, 
                               TrangThai, NgayTao, NgayCapNhat, NgayDangLich)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, chuong.getTruyen().getId());
            ps.setString(2, chuong.getTenChuong());
            ps.setString(3, chuong.getNoiDung());
            ps.setInt(4, chuong.getSoChuong());
            ps.setBoolean(5, chuong.isChiDanhChoVIP());
            ps.setString(6, chuong.getTrangThai());
            ps.setTimestamp(7, Timestamp.valueOf(chuong.getNgayTao()));
            ps.setTimestamp(8, Timestamp.valueOf(chuong.getNgayCapNhat()));
            
            if (chuong.getNgayDangLich() != null) {
                ps.setTimestamp(9, Timestamp.valueOf(chuong.getNgayDangLich()));
            } else {
                ps.setNull(9, Types.TIMESTAMP);
            }

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Cập nhật chương
    public boolean capNhatChuong(Chuong chuong) {
        String sql = """
            UPDATE Chuong 
            SET TenChuong = ?, NoiDung = ?, SoChuong = ?, ChiDanhChoVIP = ?, 
                TrangThai = ?, NgayCapNhat = NOW(), NgayDangLich = ?
            WHERE ID = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, chuong.getTenChuong());
            ps.setString(2, chuong.getNoiDung());
            ps.setInt(3, chuong.getSoChuong());
            ps.setBoolean(4, chuong.isChiDanhChoVIP());
            ps.setString(5, chuong.getTrangThai());
            
            if (chuong.getNgayDangLich() != null) {
                ps.setTimestamp(6, Timestamp.valueOf(chuong.getNgayDangLich()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }
            
            ps.setInt(7, chuong.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa chương
    public boolean xoaChuong(int id) {
        String sql = "DELETE FROM Chuong WHERE ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa nhiều chương
    public boolean xoaNhieuChuong(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return false;
        
        StringBuilder sql = new StringBuilder("DELETE FROM Chuong WHERE ID IN (");
        for (int i = 0; i < ids.size(); i++) {
            sql.append("?");
            if (i < ids.size() - 1) sql.append(",");
        }
        sql.append(")");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }
            
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật trạng thái nhiều chương
    public boolean capNhatTrangThaiNhieuChuong(List<Integer> ids, String trangThai) {
        if (ids == null || ids.isEmpty()) return false;
        
        StringBuilder sql = new StringBuilder("UPDATE Chuong SET TrangThai = ?, NgayCapNhat = NOW() WHERE ID IN (");
        for (int i = 0; i < ids.size(); i++) {
            sql.append("?");
            if (i < ids.size() - 1) sql.append(",");
        }
        sql.append(")");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            ps.setString(1, trangThai);
            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 2, ids.get(i));
            }
            
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật lượt xem
    public boolean capNhatLuotXem(int id) {
        String sql = "UPDATE Chuong SET LuotXem = LuotXem + 1 WHERE ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra số chương trùng
    public boolean kiemTraSoChuongTrung(int truyenId, int soChuong, int excludeId) {
        String sql = "SELECT COUNT(*) FROM Chuong WHERE TruyenID = ? AND SoChuong = ? AND ID != ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            ps.setInt(2, soChuong);
            ps.setInt(3, excludeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy số chương tiếp theo
    public int laySoChuongTiepTheo(int truyenId) {
        String sql = "SELECT IFNULL(MAX(SoChuong), 0) + 1 FROM Chuong WHERE TruyenID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 1;
    }

    // Đếm số chương theo truyện
    public int demSoChuongTheoTruyen(int truyenId) {
        String sql = "SELECT COUNT(*) FROM Chuong WHERE TruyenID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Đếm tổng số chương
    public int demTongSoChuong() {
        String sql = "SELECT COUNT(*) FROM Chuong";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tìm kiếm chương
    public List<Chuong> timKiemChuong(String keyword, int truyenId, int offset, int limit) {
        List<Chuong> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (c.TenChuong LIKE ? OR c.NoiDung LIKE ?)");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (truyenId > 0) {
            sql.append(" AND c.TruyenID = ?");
            params.add(truyenId);
        }

        sql.append(" ORDER BY c.NgayTao DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lọc chương theo trạng thái
    public List<Chuong> locChuongTheoTrangThai(String trangThai, Boolean vip, int offset, int limit) {
        List<Chuong> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (trangThai != null && !trangThai.trim().isEmpty()) {
            sql.append(" AND c.TrangThai = ?");
            params.add(trangThai);
        }

        if (vip != null) {
            sql.append(" AND c.ChiDanhChoVIP = ?");
            params.add(vip);
        }

        sql.append(" ORDER BY c.NgayTao DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thống kê chương theo truyện
    public Object[] thongKeChuongTheoTruyen(int truyenId) {
        String sql = """
            SELECT 
                COUNT(*) as tongChuong,
                SUM(CASE WHEN TrangThai = 'CONG_KHAI' THEN 1 ELSE 0 END) as congKhai,
                SUM(CASE WHEN TrangThai = 'NHAP' THEN 1 ELSE 0 END) as nhap,
                SUM(CASE WHEN TrangThai = 'LICH_DANG' THEN 1 ELSE 0 END) as lichDang,
                SUM(CASE WHEN ChiDanhChoVIP = 1 THEN 1 ELSE 0 END) as vip,
                SUM(LuotXem) as tongLuotXem
            FROM Chuong 
            WHERE TruyenID = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Object[]{
                        rs.getInt("tongChuong"),
                        rs.getInt("congKhai"),
                        rs.getInt("nhap"),
                        rs.getInt("lichDang"),
                        rs.getInt("vip"),
                        rs.getLong("tongLuotXem")
                    };
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return new Object[]{0, 0, 0, 0, 0, 0L};
    }

    // Lấy chương trước
    public Chuong layChuongTruoc(int truyenId, int soChuong)  {
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TruyenID = ? AND c.SoChuong < ?
            ORDER BY c.SoChuong DESC
            LIMIT 1
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            ps.setInt(2, soChuong);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToChuong(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy chương sau
    public Chuong layChuongSau(int truyenId, int soChuong)  {
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TruyenID = ? AND c.SoChuong > ?
            ORDER BY c.SoChuong ASC
            LIMIT 1
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            ps.setInt(2, soChuong);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToChuong(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy chương theo lịch đăng
    public List<Chuong> layChuongTheoLichDang(LocalDateTime tuNgay, LocalDateTime denNgay)  {
        List<Chuong> list = new ArrayList<>();
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TrangThai = 'LICH_DANG' 
            AND c.NgayDangLich BETWEEN ? AND ?
            ORDER BY c.NgayDangLich ASC
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setTimestamp(1, Timestamp.valueOf(tuNgay));
            ps.setTimestamp(2, Timestamp.valueOf(denNgay));
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy top chương theo lượt xem
    public List<Chuong> layTopChuongTheoLuotXem(int limit)  {
        List<Chuong> list = new ArrayList<>();
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TrangThai = 'CONG_KHAI'
            ORDER BY c.LuotXem DESC
            LIMIT ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chương mới nhất
    public List<Chuong> layChuongMoiNhat(int limit)  {
        List<Chuong> list = new ArrayList<>();
        String sql = """
            SELECT c.*, t.TenTruyen
            FROM Chuong c
            JOIN Truyen t ON c.TruyenID = t.ID
            WHERE c.TrangThai = 'CONG_KHAI'
            ORDER BY c.NgayTao DESC
            LIMIT ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Chuong chuong = mapResultSetToChuong(rs);
                    list.add(chuong);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái chương đã lên lịch
    public boolean capNhatChuongDaLenLich()  {
        String sql = """
            UPDATE Chuong 
            SET TrangThai = 'CONG_KHAI', NgayCapNhat = NOW()
            WHERE TrangThai = 'LICH_DANG' 
            AND NgayDangLich <= NOW()
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method để map ResultSet sang Chuong object
    private Chuong mapResultSetToChuong(ResultSet rs) throws SQLException {
        Chuong chuong = new Chuong();
        chuong.setId(rs.getInt("ID"));
        chuong.setTenChuong(rs.getString("TenChuong"));
        chuong.setNoiDung(rs.getString("NoiDung"));
        chuong.setSoChuong(rs.getInt("SoChuong"));
        chuong.setChiDanhChoVIP(rs.getBoolean("ChiDanhChoVIP"));
        chuong.setLuotXem(rs.getInt("LuotXem"));
        chuong.setTrangThai(rs.getString("TrangThai"));
        
        Timestamp ngayTao = rs.getTimestamp("NgayTao");
        if (ngayTao != null) {
            chuong.setNgayTao(ngayTao.toLocalDateTime());
        }
        
        Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
        if (ngayCapNhat != null) {
            chuong.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
        }
        
        Timestamp ngayDangLich = rs.getTimestamp("NgayDangLich");
        if (ngayDangLich != null) {
            chuong.setNgayDangLich(ngayDangLich.toLocalDateTime());
        }

        // Tạo đối tượng Truyen
        Truyen truyen = new Truyen();
        truyen.setId(rs.getInt("TruyenID"));
        truyen.setTenTruyen(rs.getString("TenTruyen"));
        chuong.setTruyen(truyen);

        return chuong;
    }
}