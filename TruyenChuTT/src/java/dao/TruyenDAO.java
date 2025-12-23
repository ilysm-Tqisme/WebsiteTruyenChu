package dao;

import db.DBConnection;
import model.Truyen;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Chuong;
import model.TheLoai;

public class TruyenDAO {

    // Lấy danh sách tất cả truyện kèm tác giả, người tạo, thể loại, số chương
    public List<Truyen> layTatCaTruyen() {
        List<Truyen> ds = new ArrayList<>();
        
        // ✅ SỬA: Đổi nd.tenNguoiDung -> nd.HoTen
        String sql = """
            SELECT t.*, 
                   tg.TenTacGia, 
                   nd.HoTen AS nguoiTaoTen, 
                   (
                       SELECT COUNT(*) FROM Chuong c WHERE c.TruyenID = t.ID
                   ) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            ORDER BY t.NgayTao DESC
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Truyen t = new Truyen();
                t.setId(rs.getInt("ID"));
                t.setTenTruyen(rs.getString("TenTruyen"));
                t.setMoTa(rs.getString("MoTa"));
                t.setAnhBia(rs.getString("AnhBia"));
                t.setTrangThai(rs.getString("TrangThai"));
                t.setTacGiaId(rs.getInt("TacGiaID"));
                t.setNguoiTaoId(rs.getInt("NguoiTaoID"));
                t.setChiDanhChoVIP(rs.getBoolean("ChiDanhChoVIP"));
                t.setNoiBat(rs.getBoolean("NoiBat"));
                t.setTruyenMoi(rs.getBoolean("TruyenMoi"));
                t.setLuotXem(rs.getInt("LuotXem"));
                t.setDiemDanhGia(rs.getDouble("DiemDanhGia"));
                t.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
                t.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                t.setNgayCapNhat(rs.getTimestamp("NgayCapNhat").toLocalDateTime());

                t.setTacGiaTen(rs.getString("TenTacGia"));
                t.setNguoiTaoTen(rs.getString("nguoiTaoTen"));
                t.setSoLuongChuong(rs.getInt("soLuongChuong"));

                ds.add(t);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return ds;
    }

    // ✅ THÊM MỚI: Tìm kiếm và lọc truyện với phân trang
    public List<Truyen> timKiemVaLocTruyen(String keyword, Integer theLoaiId, String sortBy, int offset, int limit) {
        List<Truyen> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        
        sql.append("""
            SELECT DISTINCT t.*, 
                   tg.TenTacGia, 
                   nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            """);

        // Join với bảng TruyenTheLoai nếu có lọc theo thể loại
        if (theLoaiId != null) {
            sql.append("JOIN TruyenTheLoai ttl ON t.ID = ttl.TruyenID ");
        }

        sql.append("WHERE t.TrangThai != 'DA_XOA' ");

        // Thêm điều kiện tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (t.TenTruyen LIKE ? OR tg.TenTacGia LIKE ?) ");
        }

        // Thêm điều kiện lọc theo thể loại
        if (theLoaiId != null) {
            sql.append("AND ttl.TheLoaiID = ? ");
        }

        // Thêm sắp xếp
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "ngay_tao":
                    sql.append("ORDER BY t.NgayTao DESC ");
                    break;
                case "luot_xem":
                    sql.append("ORDER BY t.LuotXem DESC ");
                    break;
                case "danh_gia":
                    sql.append("ORDER BY t.DiemDanhGia DESC ");
                    break;
                case "ten_truyen":
                    sql.append("ORDER BY t.TenTruyen ASC ");
                    break;
                default:
                    sql.append("ORDER BY t.NgayTao DESC ");
            }
        } else {
            sql.append("ORDER BY t.NgayTao DESC ");
        }

        sql.append("LIMIT ? OFFSET ?");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            // Set parameters cho tìm kiếm
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            // Set parameter cho thể loại
            if (theLoaiId != null) {
                ps.setInt(paramIndex++, theLoaiId);
            }

            // Set parameters cho phân trang
            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    // Lấy danh sách thể loại
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ THÊM MỚI: Đếm tổng số truyện theo điều kiện tìm kiếm và lọc
    public int demTongSoTruyenTheoLoc(String keyword, Integer theLoaiId) {
        StringBuilder sql = new StringBuilder();
        
        sql.append("SELECT COUNT(DISTINCT t.ID) FROM Truyen t ");
        sql.append("JOIN TacGia tg ON t.TacGiaID = tg.ID ");
        
        if (theLoaiId != null) {
            sql.append("JOIN TruyenTheLoai ttl ON t.ID = ttl.TruyenID ");
        }
        
        sql.append("WHERE t.TrangThai != 'DA_XOA' ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (t.TenTruyen LIKE ? OR tg.TenTacGia LIKE ?) ");
        }

        if (theLoaiId != null) {
            sql.append("AND ttl.TheLoaiID = ? ");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            if (theLoaiId != null) {
                ps.setInt(paramIndex, theLoaiId);
            }

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

    // Kiểm tra tên truyện trùng
    public boolean kiemTraTrungTen(String tenTruyen) {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE TenTruyen = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenTruyen);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm truyện mới (trả về ID)
    public int themTruyen(Truyen t) {
        // ✅ DEBUG: In ra giá trị TrangThai trước khi insert
        System.out.println("DEBUG - TrangThai value: '" + t.getTrangThai() + "'");
        
        String sql = """
            INSERT INTO Truyen (TenTruyen, MoTa, AnhBia, TacGiaID, NguoiTaoID, TrangThai, ChiDanhChoVIP, NoiBat, TruyenMoi, NgayTao, NgayCapNhat)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, t.getTenTruyen());
            ps.setString(2, t.getMoTa());
            ps.setString(3, t.getAnhBia());
            ps.setInt(4, t.getTacGiaId());
            ps.setInt(5, t.getNguoiTaoId());
            ps.setString(6, t.getTrangThai());
            ps.setBoolean(7, t.isChiDanhChoVIP());
            ps.setBoolean(8, t.isNoiBat());
            ps.setBoolean(9, t.isTruyenMoi());
            ps.setTimestamp(10, Timestamp.valueOf(t.getNgayTao()));
            ps.setTimestamp(11, Timestamp.valueOf(t.getNgayCapNhat()));

            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("ERROR in themTruyen - TrangThai: '" + t.getTrangThai() + "'");
            e.printStackTrace();
        }
        return -1;
    }

    // Gán thể loại cho truyện (nhiều thể loại)
    public boolean ganTheLoai(int truyenId, List<Integer> theLoaiIds) {
        String sql = "INSERT INTO TruyenTheLoai (TruyenID, TheLoaiID) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int tlId : theLoaiIds) {
                ps.setInt(1, truyenId);
                ps.setInt(2, tlId);
                ps.addBatch();
            }

            int[] result = ps.executeBatch();
            return result.length == theLoaiIds.size();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa truyện và dữ liệu liên quan
    public boolean xoaTruyen(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            String[] xoaBang = {
                "DELETE FROM TruyenTheLoai WHERE TruyenID = ?",
                "DELETE FROM Chuong WHERE TruyenID = ?",
                "DELETE FROM DanhGia WHERE TruyenID = ?",
                "DELETE FROM BinhLuan WHERE TruyenID = ?",
                "DELETE FROM LichSuDoc WHERE TruyenID = ?",
                "DELETE FROM Truyen WHERE ID = ?"
            };

            for (String sql : xoaBang) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy chi tiết truyện
    public Truyen layTruyenTheoId(int id) {
        // ✅ SỬA: Đổi nd.tenNguoiDung -> nd.HoTen
        String sql = """
            SELECT t.*, 
                   tg.TenTacGia, 
                   nd.HoTen AS nguoiTaoTen
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.ID = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Truyen t = new Truyen();
                    t.setId(rs.getInt("ID"));
                    t.setTenTruyen(rs.getString("TenTruyen"));
                    t.setMoTa(rs.getString("MoTa"));
                    t.setAnhBia(rs.getString("AnhBia"));
                    t.setTacGiaId(rs.getInt("TacGiaID"));
                    t.setNguoiTaoId(rs.getInt("NguoiTaoID"));
                    t.setTrangThai(rs.getString("TrangThai"));
                    t.setChiDanhChoVIP(rs.getBoolean("ChiDanhChoVIP"));
                    t.setNoiBat(rs.getBoolean("NoiBat"));
                    t.setTruyenMoi(rs.getBoolean("TruyenMoi"));
                    t.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                    t.setNgayCapNhat(rs.getTimestamp("NgayCapNhat").toLocalDateTime());
                    t.setTacGiaTen(rs.getString("TenTacGia"));
                    t.setNguoiTaoTen(rs.getString("nguoiTaoTen"));
                    return t;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Lọc truyện theo thể loại, trạng thái, VIP...
    public List<Truyen> locTruyen(Integer theLoaiId, String trangThai, Boolean chiDanhChoVIP) {
        List<Truyen> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen, ")
           .append("(SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong ")
           .append("FROM Truyen t ")
           .append("JOIN TacGia tg ON t.TacGiaID = tg.ID ")
           .append("JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID ")
           .append("WHERE 1=1 ");

        if (trangThai != null && !trangThai.isEmpty()) {
            sql.append(" AND t.TrangThai = ?");
        }
        if (theLoaiId != null) {
            sql.append(" AND EXISTS (SELECT 1 FROM TruyenTheLoai tl WHERE tl.TruyenID = t.ID AND tl.TheLoaiID = ?)");
        }
        if (chiDanhChoVIP != null) {
            sql.append(" AND t.ChiDanhChoVIP = ?");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (trangThai != null && !trangThai.isEmpty()) {
                ps.setString(index++, trangThai);
            }
            if (theLoaiId != null) {
                ps.setInt(index++, theLoaiId);
            }
            if (chiDanhChoVIP != null) {
                ps.setBoolean(index++, chiDanhChoVIP);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm nâng cao và phân trang
    public List<Truyen> timKiemTruyenNangCao(String keyword, int offset, int limit) {
        List<Truyen> list = new ArrayList<>();
        String sql = "SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen, " +
                     "(SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong " +
                     "FROM Truyen t " +
                     "JOIN TacGia tg ON t.TacGiaID = tg.ID " +
                     "JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID " +
                     "WHERE t.TenTruyen LIKE ? " +
                     "ORDER BY t.NgayTao DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean capNhatTruyen(Truyen t) {
        String sql = "UPDATE Truyen SET TenTruyen = ?, MoTa = ?, AnhBia = ?, TacGiaID = ?, " +
                     "TrangThai = ?, ChiDanhChoVIP = ?, NoiBat = ?, TruyenMoi = ?, NgayCapNhat = NOW() " +
                     "WHERE ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getTenTruyen());
            ps.setString(2, t.getMoTa());
            ps.setString(3, t.getAnhBia());
            ps.setInt(4, t.getTacGiaId());
            ps.setString(5, t.getTrangThai());
            ps.setBoolean(6, t.isChiDanhChoVIP());
            ps.setBoolean(7, t.isNoiBat());
            ps.setBoolean(8, t.isTruyenMoi());
            ps.setInt(9, t.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách ID thể loại của truyện
    public List<Integer> layTheLoaiIdsCuaTruyen(int truyenId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT TheLoaiID FROM TruyenTheLoai WHERE TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("TheLoaiID"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách tên thể loại của truyện
    public List<String> layTheLoaiNamesCuaTruyen(int truyenId) {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT tl.TenTheLoai 
            FROM TruyenTheLoai ttl 
            JOIN TheLoai tl ON ttl.TheLoaiID = tl.ID 
            WHERE ttl.TruyenID = ?
        """;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("TenTheLoai"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm số lượng chương của truyện
    public int demSoLuongChuong(int truyenId) {
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

    // Xóa tất cả thể loại của truyện
    public boolean xoaTatCaTheLoaiCuaTruyen(int truyenId) {
        String sql = "DELETE FROM TruyenTheLoai WHERE TruyenID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật lượt xem
    public boolean capNhatLuotXem(int truyenId) {
        String sql = "UPDATE Truyen SET LuotXem = LuotXem + 1, NgayCapNhat = NOW() WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, truyenId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật điểm đánh giá
    public boolean capNhatDiemDanhGia(int truyenId, double diemMoi, int soLuongDanhGiaMoi) {
        String sql = "UPDATE Truyen SET DiemDanhGia = ?, SoLuongDanhGia = ?, NgayCapNhat = NOW() WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, diemMoi);
            ps.setInt(2, soLuongDanhGiaMoi);
            ps.setInt(3, truyenId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy top truyện theo tiêu chí
    public List<Truyen> layTopTruyen(String tieuChi, int limit) {
        List<Truyen> list = new ArrayList<>();
        String orderBy = "";
        
        switch (tieuChi) {
            case "luotXem":
                orderBy = "ORDER BY t.LuotXem DESC";
                break;
            case "danhGia":
                orderBy = "ORDER BY t.DiemDanhGia DESC";
                break;
            case "moi":
                orderBy = "ORDER BY t.NgayTao DESC";
                break;
            case "capNhat":
                orderBy = "ORDER BY t.NgayCapNhat DESC";
                break;
            default:
                orderBy = "ORDER BY t.NgayTao DESC";
        }
        
        String sql = """
            SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.TrangThai != 'DA_XOA'
        """ + " " + orderBy + " LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    list.add(t);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method để map ResultSet sang Truyen object
    private void mapResultSetToTruyen(ResultSet rs, Truyen t) throws SQLException {
        t.setId(rs.getInt("ID"));
        t.setTenTruyen(rs.getString("TenTruyen"));
        t.setMoTa(rs.getString("MoTa"));
        t.setAnhBia(rs.getString("AnhBia"));
        t.setTrangThai(rs.getString("TrangThai"));
        t.setTacGiaId(rs.getInt("TacGiaID"));
        t.setNguoiTaoId(rs.getInt("NguoiTaoID"));
        t.setChiDanhChoVIP(rs.getBoolean("ChiDanhChoVIP"));
        t.setNoiBat(rs.getBoolean("NoiBat"));
        t.setTruyenMoi(rs.getBoolean("TruyenMoi"));
        t.setLuotXem(rs.getInt("LuotXem"));
        t.setDiemDanhGia(rs.getDouble("DiemDanhGia"));
        t.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));
        t.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
        t.setNgayCapNhat(rs.getTimestamp("NgayCapNhat").toLocalDateTime());
        t.setTacGiaTen(rs.getString("TenTacGia"));
        t.setNguoiTaoTen(rs.getString("nguoiTaoTen"));
        t.setSoLuongChuong(rs.getInt("soLuongChuong"));
    }
    
    public List<Truyen> getTruyen() {
    List<Truyen> list = new ArrayList<>();
    String sql = """
        SELECT t.*, 
               tg.TenTacGia, 
               nd.HoTen AS nguoiTaoTen, 
               (
                   SELECT COUNT(*) FROM Chuong c WHERE c.TruyenID = t.ID
               ) AS soLuongChuong
        FROM Truyen t
        JOIN TacGia tg ON t.TacGiaID = tg.ID
        JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
        ORDER BY t.NgayTao DESC
    """;

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Truyen t = new Truyen();
            t.setId(rs.getInt("ID"));
            t.setTenTruyen(rs.getString("TenTruyen"));
            t.setMoTa(rs.getString("MoTa"));
            t.setAnhBia(rs.getString("AnhBia"));
            t.setTacGiaId(rs.getInt("TacGiaID"));
            t.setTacGiaTen(rs.getString("TenTacGia"));
            t.setNguoiTaoId(rs.getInt("NguoiTaoID"));
            t.setNguoiTaoTen(rs.getString("nguoiTaoTen"));
            t.setTrangThai(rs.getString("TrangThai"));
            t.setChiDanhChoVIP(rs.getBoolean("ChiDanhChoVIP"));
            t.setNoiBat(rs.getBoolean("NoiBat"));
            t.setTruyenMoi(rs.getBoolean("TruyenMoi"));
            t.setLuotXem(rs.getInt("LuotXem"));
            t.setDiemDanhGia(rs.getDouble("DiemDanhGia"));
            t.setSoLuongDanhGia(rs.getInt("SoLuongDanhGia"));

            Timestamp ngayTao = rs.getTimestamp("NgayTao");
            Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
            if (ngayTao != null) t.setNgayTao(ngayTao.toLocalDateTime());
            if (ngayCapNhat != null) t.setNgayCapNhat(ngayCapNhat.toLocalDateTime());

            t.setSoLuongChuong(rs.getInt("soLuongChuong"));

            // ✅ Gọi thêm để lấy danh sách thể loại của truyện
            List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
            t.setTheLoaiTenList(theLoaiTenList);

            list.add(t);
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    return list;
}

    public List<Truyen> layTruyenNoiBat(int limit) {
    List<Truyen> list = new ArrayList<>();
    String sql = """
        SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
               (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
        FROM Truyen t
        JOIN TacGia tg ON t.TacGiaID = tg.ID
        JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
        WHERE t.TrangThai != 'DA_XOA' AND t.NoiBat = 1
        ORDER BY t.LuotXem DESC
        LIMIT ?
    """;

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, limit);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Truyen t = new Truyen();
                mapResultSetToTruyen(rs, t);
                // Lấy danh sách thể loại
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public List<Truyen> layTruyenMoiNhat(int limit) {
    List<Truyen> list = new ArrayList<>();
    String sql = """
        SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
               (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
        FROM Truyen t
        JOIN TacGia tg ON t.TacGiaID = tg.ID
        JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
        WHERE t.TrangThai != 'DA_XOA'
        ORDER BY t.NgayTao DESC
        LIMIT ?
    """;

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, limit);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Truyen t = new Truyen();
                mapResultSetToTruyen(rs, t);
                // Lấy danh sách thể loại
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    // Lấy truyện VIP
    public List<Truyen> layTruyenVIP(int limit) {
        List<Truyen> list = new ArrayList<>();
        String sql = """
            SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.TrangThai != 'DA_XOA' AND t.ChiDanhChoVIP = 1
            ORDER BY t.LuotXem DESC
            LIMIT ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    // Lấy danh sách thể loại
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
     // Lấy tất cả truyện VIP với phân trang
    public List<Truyen> layTatCaTruyenVIP(int offset, int limit) {
        List<Truyen> list = new ArrayList<>();
        String sql = """
            SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.TrangThai != 'DA_XOA' AND t.ChiDanhChoVIP = 1
            ORDER BY t.LuotXem DESC
            LIMIT ? OFFSET ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                   Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy tất cả truyện hot với phân trang
    public List<Truyen> layTatCaTruyenHot(int offset, int limit) {
        List<Truyen> list = new ArrayList<>();
        String sql = """
            SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.TrangThai != 'DA_XOA' AND t.NoiBat = 1
            ORDER BY t.LuotXem DESC
            LIMIT ? OFFSET ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy tất cả truyện mới với phân trang
    public List<Truyen> layTatCaTruyenMoi(int offset, int limit) {
        List<Truyen> list = new ArrayList<>();
        String sql = """
            SELECT t.*, tg.TenTacGia, nd.HoTen AS nguoiTaoTen,
                   (SELECT COUNT(*) FROM Chuong WHERE TruyenID = t.ID) AS soLuongChuong
            FROM Truyen t
            JOIN TacGia tg ON t.TacGiaID = tg.ID
            JOIN NguoiDung nd ON t.NguoiTaoID = nd.ID
            WHERE t.TrangThai != 'DA_XOA'
            ORDER BY t.NgayTao DESC
            LIMIT ? OFFSET ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Truyen t = new Truyen();
                    mapResultSetToTruyen(rs, t);
                    List<String> theLoaiTenList = layTheLoaiNamesCuaTruyen(t.getId());
                    t.setTheLoaiTenList(theLoaiTenList);
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số truyện VIP
    public int demTongSoTruyenVIP() {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE TrangThai != 'DA_XOA' AND ChiDanhChoVIP = 1";
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

    // Đếm tổng số truyện hot
    public int demTongSoTruyenHot() {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE TrangThai != 'DA_XOA' AND NoiBat = 1";
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

    // Đếm tổng số truyện mới
    public int demTongSoTruyenMoi() {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE TrangThai != 'DA_XOA'";
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
    
}