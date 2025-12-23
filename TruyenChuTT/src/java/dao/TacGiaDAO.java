package dao;

import db.DBConnection;
import model.TacGia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacGiaDAO {

    // Lấy danh sách tất cả tác giả
    public List<TacGia> layDanhSachTacGia() {
        List<TacGia> list = new ArrayList<>();
        String sql = "SELECT * FROM TacGia ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TacGia tg = new TacGia();
                tg.setId(rs.getInt("id"));
                tg.setTenTacGia(rs.getString("tenTacGia"));
                tg.setMoTa(rs.getString("moTa"));
                tg.setAnhDaiDien(rs.getString("anhDaiDien"));
                tg.setNgayTao(rs.getTimestamp("ngayTao").toLocalDateTime());
                list.add(tg);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Tìm kiếm theo tên
    public List<TacGia> timKiemTacGia(String keyword) {
        List<TacGia> list = new ArrayList<>();
        String sql = "SELECT * FROM TacGia WHERE tenTacGia LIKE ? ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TacGia tg = new TacGia();
                    tg.setId(rs.getInt("id"));
                    tg.setTenTacGia(rs.getString("tenTacGia"));
                    tg.setMoTa(rs.getString("moTa"));
                    tg.setAnhDaiDien(rs.getString("anhDaiDien"));
                    tg.setNgayTao(rs.getTimestamp("ngayTao").toLocalDateTime());
                    list.add(tg);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy chi tiết tác giả
    public TacGia layThongTinTacGia(int id) {
        String sql = "SELECT * FROM TacGia WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TacGia tg = new TacGia();
                    tg.setId(rs.getInt("id"));
                    tg.setTenTacGia(rs.getString("tenTacGia"));
                    tg.setMoTa(rs.getString("moTa"));
                    tg.setAnhDaiDien(rs.getString("anhDaiDien"));
                    tg.setNgayTao(rs.getTimestamp("ngayTao").toLocalDateTime());
                    return tg;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tạo mới
    public boolean taoTacGia(TacGia tg) {
        String sql = "INSERT INTO TacGia (tenTacGia, moTa, anhDaiDien, ngayTao) VALUES (?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tg.getTenTacGia());
            ps.setString(2, tg.getMoTa());
            ps.setString(3, tg.getAnhDaiDien());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa
    public boolean xoaTacGia(int id) {
        String sql = "DELETE FROM TacGia WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Dùng để tạo nhanh khi thêm truyện
    public int taoVaLayIdTacGia(TacGia tg) {
        String sql = "INSERT INTO TacGia (tenTacGia, moTa, anhDaiDien, ngayTao) VALUES (?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, tg.getTenTacGia());
            ps.setString(2, tg.getMoTa());
            ps.setString(3, tg.getAnhDaiDien());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
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
    
    public boolean kiemTraTenTrung(String tenTacGia) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM TacGia WHERE tenTacGia = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenTacGia);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public boolean kiemTraTacGiaDangSuDung(int id) {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE tacGiaId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}