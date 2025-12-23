package dao;

import db.DBConnection;
import model.NguoiDung;
import util.BCryptUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {
    
    // Đăng ký người dùng mới
    public boolean dangKy(NguoiDung nguoiDung) {
        String sql = "INSERT INTO NguoiDung (Email, MatKhau, HoTen, SoDienThoai, VaiTro, TrangThai, NgayTao, NgayCapNhat) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nguoiDung.getEmail());
            pstmt.setString(2, BCryptUtil.hashPassword(nguoiDung.getMatKhau()));
            pstmt.setString(3, nguoiDung.getHoTen());
            pstmt.setString(4, nguoiDung.getSoDienThoai());
            pstmt.setString(5, nguoiDung.getVaiTro());
            pstmt.setBoolean(6, nguoiDung.isTrangThai());
            pstmt.setTimestamp(7, Timestamp.valueOf(nguoiDung.getNgayTao()));
            pstmt.setTimestamp(8, Timestamp.valueOf(nguoiDung.getNgayCapNhat()));
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đăng ký người dùng: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Đăng nhập
    public NguoiDung dangNhap(String email, String matKhau) {
        String sql = "SELECT * FROM NguoiDung WHERE Email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String hashedPassword = rs.getString("MatKhau");
                
                // Kiểm tra mật khẩu với BCrypt
                if (BCryptUtil.checkPassword(matKhau, hashedPassword)) {
                    NguoiDung nguoiDung = new NguoiDung();
                    nguoiDung.setId(rs.getInt("ID"));
                    nguoiDung.setEmail(rs.getString("Email"));
                    nguoiDung.setMatKhau(hashedPassword);
                    nguoiDung.setHoTen(rs.getString("HoTen"));
                    nguoiDung.setSoDienThoai(rs.getString("SoDienThoai"));
                    nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
                    nguoiDung.setVaiTro(rs.getString("VaiTro"));
                    nguoiDung.setTrangThai(rs.getBoolean("TrangThai"));
                    nguoiDung.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
                    
                    Timestamp ngayTao = rs.getTimestamp("NgayTao");
                    if (ngayTao != null) {
                        nguoiDung.setNgayTao(ngayTao.toLocalDateTime());
                    }
                    
                    Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                    if (ngayCapNhat != null) {
                        nguoiDung.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
                    }
                    
                    Timestamp ngayDangKyVIP = rs.getTimestamp("NgayDangKyVIP");
                    if (ngayDangKyVIP != null) {
                        nguoiDung.setNgayDangKyVIP(ngayDangKyVIP.toLocalDateTime());
                    }
                    
                    Timestamp ngayHetHanVIP = rs.getTimestamp("NgayHetHanVIP");
                    if (ngayHetHanVIP != null) {
                        nguoiDung.setNgayHetHanVIP(ngayHetHanVIP.toLocalDateTime());
                    }
                    
                    return nguoiDung;
                }
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đăng nhập: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Kiểm tra email đã tồn tại
    public boolean kiemTraEmailTonTai(String email) {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE Email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra email: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Kiểm tra sdt
    public boolean kiemTraSoDienThoaiDaTonTai(String soDienThoai, int userId) {
        String sql = "SELECT COUNT(*) FROM nguoidung WHERE sodienthoai = ? AND id != ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, soDienThoai);
            stmt.setInt(2, userId); // Tránh so sánh với chính user hiện tại
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy thông tin người dùng theo ID
    public NguoiDung layThongTinNguoiDung(int id) {
        String sql = "SELECT * FROM NguoiDung WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                NguoiDung nguoiDung = new NguoiDung();
                nguoiDung.setId(rs.getInt("ID"));
                nguoiDung.setEmail(rs.getString("Email"));
                nguoiDung.setMatKhau(rs.getString("MatKhau"));
                nguoiDung.setHoTen(rs.getString("HoTen"));
                nguoiDung.setSoDienThoai(rs.getString("SoDienThoai"));
                nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
                nguoiDung.setVaiTro(rs.getString("VaiTro"));
                nguoiDung.setTrangThai(rs.getBoolean("TrangThai"));
                nguoiDung.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    nguoiDung.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                if (ngayCapNhat != null) {
                    nguoiDung.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
                }
                
                Timestamp ngayDangKyVIP = rs.getTimestamp("NgayDangKyVIP");
                if (ngayDangKyVIP != null) {
                    nguoiDung.setNgayDangKyVIP(ngayDangKyVIP.toLocalDateTime());
                }
                
                Timestamp ngayHetHanVIP = rs.getTimestamp("NgayHetHanVIP");
                if (ngayHetHanVIP != null) {
                    nguoiDung.setNgayHetHanVIP(ngayHetHanVIP.toLocalDateTime());
                }
                
                return nguoiDung;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy thông tin người dùng: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Cập nhật thông tin người dùng
    public boolean capNhatThongTin(NguoiDung nguoiDung) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, SoDienThoai = ?, AnhDaiDien = ?, NgayCapNhat = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nguoiDung.getHoTen());
            pstmt.setString(2, nguoiDung.getSoDienThoai());
            pstmt.setString(3, nguoiDung.getAnhDaiDien());
            pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(5, nguoiDung.getId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật thông tin: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Đổi mật khẩu
    public boolean doiMatKhau(int userId, String matKhauDaHash) {
        String sql = "UPDATE NguoiDung SET MatKhau = ?, NgayCapNhat = ? WHERE ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, matKhauDaHash); // Không mã hóa lại
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(3, userId);

            int result = pstmt.executeUpdate();
            return result > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đổi mật khẩu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy thông tin người dùng theo email
    public NguoiDung layThongTinNguoiDungTheoEmail(String email) {
        String sql = "SELECT * FROM NguoiDung WHERE Email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                NguoiDung nguoiDung = new NguoiDung();
                nguoiDung.setId(rs.getInt("ID"));
                nguoiDung.setEmail(rs.getString("Email"));
                nguoiDung.setMatKhau(rs.getString("MatKhau"));
                nguoiDung.setHoTen(rs.getString("HoTen"));
                nguoiDung.setSoDienThoai(rs.getString("SoDienThoai"));
                nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
                nguoiDung.setVaiTro(rs.getString("VaiTro"));
                nguoiDung.setTrangThai(rs.getBoolean("TrangThai"));
                nguoiDung.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    nguoiDung.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                Timestamp ngayCapNhat = rs.getTimestamp("NgayCapNhat");
                if (ngayCapNhat != null) {
                    nguoiDung.setNgayCapNhat(ngayCapNhat.toLocalDateTime());
                }
                
                Timestamp ngayDangKyVIP = rs.getTimestamp("NgayDangKyVIP");
                if (ngayDangKyVIP != null) {
                    nguoiDung.setNgayDangKyVIP(ngayDangKyVIP.toLocalDateTime());
                }
                
                Timestamp ngayHetHanVIP = rs.getTimestamp("NgayHetHanVIP");
                if (ngayHetHanVIP != null) {
                    nguoiDung.setNgayHetHanVIP(ngayHetHanVIP.toLocalDateTime());
                }
                
                return nguoiDung;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy thông tin người dùng theo email: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    // Lưu token quên mật khẩu
    public boolean luuTokenQuenMatKhau(int userId, String token, LocalDateTime expireTime) {
        String sql = "UPDATE NguoiDung SET TokenQuenMatKhau = ?, HetHanToken = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, token);
            pstmt.setTimestamp(2, Timestamp.valueOf(expireTime));
            pstmt.setInt(3, userId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lưu token quên mật khẩu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra token quên mật khẩu
    public NguoiDung kiemTraTokenQuenMatKhau(String token) {
        String sql = "SELECT * FROM NguoiDung WHERE TokenQuenMatKhau = ? AND HetHanToken > ? AND TrangThai = 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, token);
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                NguoiDung nguoiDung = new NguoiDung();
                nguoiDung.setId(rs.getInt("ID"));
                nguoiDung.setEmail(rs.getString("Email"));
                nguoiDung.setHoTen(rs.getString("HoTen"));
                return nguoiDung;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi kiểm tra token: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    // Đặt lại mật khẩu
    public boolean datLaiMatKhau(int userId, String matKhauMoi, String token) {
        String sql = "UPDATE NguoiDung SET MatKhau = ?, TokenQuenMatKhau = NULL, HetHanToken = NULL, NgayCapNhat = ? WHERE ID = ? AND TokenQuenMatKhau = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, BCryptUtil.hashPassword(matKhauMoi));
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(3, userId);
            pstmt.setString(4, token);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đặt lại mật khẩu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Đếm tổng số người dùng
    public int demTongSoNguoiDung() {
        String sql = "SELECT COUNT(*) FROM NguoiDung";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm người dùng: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }

    // Đếm tài khoản VIP
    public int demTaiKhoanVIP() {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE TrangThaiVIP = 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm VIP: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }

    // Lấy người dùng mới nhất
    public List<NguoiDung> layNguoiDungMoiNhat(int limit) {
        List<NguoiDung> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM NguoiDung ORDER BY NgayTao DESC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                NguoiDung nd = new NguoiDung();
                nd.setId(rs.getInt("ID"));
                nd.setEmail(rs.getString("Email"));
                nd.setHoTen(rs.getString("HoTen"));
                nd.setSoDienThoai(rs.getString("SoDienThoai"));
                nd.setVaiTro(rs.getString("VaiTro"));
                nd.setTrangThai(rs.getBoolean("TrangThai"));
                nd.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));

                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) nd.setNgayTao(ngayTao.toLocalDateTime());

                danhSach.add(nd);
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy người dùng mới nhất: " + e.getMessage());
            e.printStackTrace();
        }

        return danhSach;
    }

    // Lấy danh sách người dùng với phân trang và tìm kiếm
    public List<NguoiDung> layDanhSachNguoiDung(int page, int pageSize, String keyword, String role) {
        List<NguoiDung> danhSach = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM NguoiDung WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (HoTen LIKE ? OR Email LIKE ?) ");
        }

        if (role != null && !role.trim().isEmpty()) {
            sql.append("AND VaiTro = ? ");
        }

        sql.append("ORDER BY NgayTao DESC LIMIT ? OFFSET ?");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKeyword = "%" + keyword.trim() + "%";
                pstmt.setString(paramIndex++, searchKeyword);
                pstmt.setString(paramIndex++, searchKeyword);
            }

            if (role != null && !role.trim().isEmpty()) {
                pstmt.setString(paramIndex++, role);
            }

            pstmt.setInt(paramIndex++, pageSize);                // LIMIT
            pstmt.setInt(paramIndex, (page - 1) * pageSize);     // OFFSET

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                NguoiDung nd = new NguoiDung();
                nd.setId(rs.getInt("ID"));
                nd.setEmail(rs.getString("Email"));
                nd.setHoTen(rs.getString("HoTen"));
                nd.setSoDienThoai(rs.getString("SoDienThoai"));
                nd.setVaiTro(rs.getString("VaiTro"));
                nd.setTrangThai(rs.getBoolean("TrangThai"));
                nd.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));

                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) nd.setNgayTao(ngayTao.toLocalDateTime());

                danhSach.add(nd);
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách người dùng: " + e.getMessage());
            e.printStackTrace();
        }

        return danhSach;
    }

    // Đếm người dùng với điều kiện
    public int demNguoiDung(String keyword, String role) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM NguoiDung WHERE 1=1 ");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (HoTen LIKE ? OR Email LIKE ?) ");
        }
        
        if (role != null && !role.trim().isEmpty()) {
            sql.append("AND VaiTro = ? ");
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKeyword = "%" + keyword.trim() + "%";
                pstmt.setString(paramIndex++, searchKeyword);
                pstmt.setString(paramIndex++, searchKeyword);
            }
            
            if (role != null && !role.trim().isEmpty()) {
                pstmt.setString(paramIndex, role);
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm người dùng: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }

    // Chuyển đổi trạng thái người dùng
    public boolean chuyenDoiTrangThaiNguoiDung(int userId) {
        String sql = "UPDATE NguoiDung SET TrangThai = NOT TrangThai WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi chuyển đổi trạng thái: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa người dùng
    public boolean xoaNguoiDung(int userId) {
        String sql = "DELETE FROM NguoiDung WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa người dùng: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật thông tin người dùng (Admin)
    public boolean capNhatThongTinAdmin(NguoiDung nguoiDung) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, Email = ?, SoDienThoai = ?, VaiTro = ?, NgayCapNhat = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, nguoiDung.getHoTen());
            pstmt.setString(2, nguoiDung.getEmail());
            pstmt.setString(3, nguoiDung.getSoDienThoai());
            pstmt.setString(4, nguoiDung.getVaiTro());
            pstmt.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(6, nguoiDung.getId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật thông tin admin: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách người dùng với phân trang
    public List<NguoiDung> layDanhSachNguoiDungPhanTrang(int page, int pageSize) {
        List<NguoiDung> danhSach = new ArrayList<>();

        if (pageSize <= 0) pageSize = 10;
        if (page <= 0) page = 1;

        String sql = "SELECT * FROM NguoiDung ORDER BY NgayTao DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, pageSize);              // LIMIT
            pstmt.setInt(2, (page - 1) * pageSize); // OFFSET

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                NguoiDung nd = new NguoiDung();
                nd.setId(rs.getInt("ID"));
                nd.setEmail(rs.getString("Email"));
                nd.setHoTen(rs.getString("HoTen"));
                nd.setSoDienThoai(rs.getString("SoDienThoai"));
                nd.setAnhDaiDien(rs.getString("AnhDaiDien"));
                nd.setVaiTro(rs.getString("VaiTro"));
                nd.setTrangThai(rs.getBoolean("TrangThai"));
                nd.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) nd.setNgayTao(ngayTao.toLocalDateTime());
                
                Timestamp ngayDangKyVIP = rs.getTimestamp("NgayDangKyVIP");
                if (ngayDangKyVIP != null) nd.setNgayDangKyVIP(ngayDangKyVIP.toLocalDateTime());
                
                Timestamp ngayHetHanVIP = rs.getTimestamp("NgayHetHanVIP");
                if (ngayHetHanVIP != null) nd.setNgayHetHanVIP(ngayHetHanVIP.toLocalDateTime());
                
                danhSach.add(nd);
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy danh sách người dùng phân trang: " + e.getMessage());
            e.printStackTrace();
        }

        return danhSach;
    }

    // Tìm kiếm người dùng
    public List<NguoiDung> timKiemNguoiDung(String keyword) {
        List<NguoiDung> danhSach = new ArrayList<>();
        String sql = "SELECT * FROM NguoiDung WHERE HoTen LIKE ? OR Email LIKE ? ORDER BY NgayTao DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                NguoiDung nguoiDung = new NguoiDung();
                nguoiDung.setId(rs.getInt("ID"));
                nguoiDung.setEmail(rs.getString("Email"));
                nguoiDung.setHoTen(rs.getString("HoTen"));
                nguoiDung.setSoDienThoai(rs.getString("SoDienThoai"));
                nguoiDung.setAnhDaiDien(rs.getString("AnhDaiDien"));
                nguoiDung.setVaiTro(rs.getString("VaiTro"));
                nguoiDung.setTrangThai(rs.getBoolean("TrangThai"));
                nguoiDung.setTrangThaiVIP(rs.getBoolean("TrangThaiVIP"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    nguoiDung.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                Timestamp ngayDangKyVIP = rs.getTimestamp("NgayDangKyVIP");
                if (ngayDangKyVIP != null) {
                    nguoiDung.setNgayDangKyVIP(ngayDangKyVIP.toLocalDateTime());
                }
                
                Timestamp ngayHetHanVIP = rs.getTimestamp("NgayHetHanVIP");
                if (ngayHetHanVIP != null) {
                    nguoiDung.setNgayHetHanVIP(ngayHetHanVIP.toLocalDateTime());
                }
                
                danhSach.add(nguoiDung);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi tìm kiếm người dùng: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }

    // Cập nhật trạng thái người dùng
    public boolean capNhatTrangThaiNguoiDung(int userId, boolean trangThai) {
        String sql = "UPDATE NguoiDung SET TrangThai = ?, NgayCapNhat = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, trangThai);
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(3, userId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật trạng thái: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Cập nhật ảnh đại diện
    public boolean capNhatAnhDaiDien(int id, String anhDaiDien) {
        String sql = "UPDATE NguoiDung SET AnhDaiDien = ?, NgayCapNhat = ? WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, anhDaiDien);
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(3, id);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi cập nhật ảnh đại diện: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}