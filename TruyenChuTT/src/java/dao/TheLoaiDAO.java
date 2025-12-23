package dao;

import db.DBConnection;
import model.TheLoai;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TheLoaiDAO {

    // Lấy tất cả thể loại
    public List<TheLoai> layDanhSachTheLoai() {
        List<TheLoai> list = new ArrayList<>();
        String sql = "SELECT * FROM TheLoai ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TheLoai tl = new TheLoai();
                tl.setId(rs.getInt("id"));
                tl.setTenTheLoai(rs.getString("tenTheLoai"));
                tl.setMoTa(rs.getString("moTa"));
                tl.setMauSac(rs.getString("mauSac"));
                tl.setTrangThai(rs.getBoolean("trangThai"));
                list.add(tl);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm theo tên
    public List<TheLoai> timKiemTheLoai(String keyword) {
        List<TheLoai> list = new ArrayList<>();
        String sql = "SELECT * FROM TheLoai WHERE tenTheLoai LIKE ? ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TheLoai tl = new TheLoai();
                    tl.setId(rs.getInt("id"));
                    tl.setTenTheLoai(rs.getString("tenTheLoai"));
                    tl.setMoTa(rs.getString("moTa"));
                    tl.setMauSac(rs.getString("mauSac"));
                    tl.setTrangThai(rs.getBoolean("trangThai"));
                    list.add(tl);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết theo ID
    public TheLoai layThongTinTheLoai(int id) {
        String sql = "SELECT * FROM TheLoai WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TheLoai tl = new TheLoai();
                    tl.setId(rs.getInt("id"));
                    tl.setTenTheLoai(rs.getString("tenTheLoai"));
                    tl.setMoTa(rs.getString("moTa"));
                    tl.setMauSac(rs.getString("mauSac"));
                    tl.setTrangThai(rs.getBoolean("trangThai"));
                    return tl;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tạo mới
    public boolean taoTheLoai(TheLoai tl) {
        String sql = "INSERT INTO TheLoai (TenTheLoai, MoTa, mauSac, TrangThai) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tl.getTenTheLoai());
            ps.setString(2, tl.getMoTa());
            ps.setString(3, tl.getMauSac());
            ps.setBoolean(4, tl.isTrangThai());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa
    public boolean xoaTheLoai(int id) {
        String sql = "DELETE FROM TheLoai WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra tên trùng
    public boolean kiemTraTenTrung(String tenTheLoai) {
        String sql = "SELECT COUNT(*) FROM TheLoai WHERE tenTheLoai = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenTheLoai);
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

    // Kiểm tra thể loại đang được sử dụng
    public boolean kiemTraTheLoaiDangSuDung(int id) {
        String sql = "SELECT COUNT(*) FROM Truyen WHERE theLoaiId = ?";
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