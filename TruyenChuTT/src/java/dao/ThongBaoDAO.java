package dao;

import db.DBConnection;
import model.ThongBao;
import model.NguoiDung;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ThongBaoDAO {
    
    // Lấy danh sách thông báo của người dùng
    public List<ThongBao> layThongBaoTheoNguoiDung(int nguoiDungId, int limit) {
        List<ThongBao> danhSach = new ArrayList<>();
        String sql = "SELECT tb.*, nd.HoTen, nd.Email FROM ThongBao tb " +
                     "JOIN NguoiDung nd ON tb.NguoiDungID = nd.ID " +
                     "WHERE tb.NguoiDungID = ? ORDER BY tb.NgayTao DESC LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setInt(2, limit);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ThongBao tb = new ThongBao();
                tb.setId(rs.getLong("ID"));
                
                // Tạo đối tượng NguoiDung để set vào ThongBao
                NguoiDung nguoiDung = new NguoiDung();
                nguoiDung.setId(rs.getInt("NguoiDungID"));
                nguoiDung.setHoTen(rs.getString("HoTen"));
                nguoiDung.setEmail(rs.getString("Email"));
                tb.setNguoiDung(nguoiDung);
                
                tb.setTieuDe(rs.getString("TieuDe"));
                tb.setNoiDung(rs.getString("NoiDung"));
                tb.setLoaiThongBao(ThongBao.LoaiThongBao.valueOf(rs.getString("LoaiThongBao")));
                tb.setDaDoc(rs.getBoolean("DaDoc"));
                
                Timestamp ngayTao = rs.getTimestamp("NgayTao");
                if (ngayTao != null) {
                    tb.setNgayTao(ngayTao.toLocalDateTime());
                }
                
                // Set LinkChuyenHuong nếu có
                tb.setLinkChuyenHuong(rs.getString("LinkChuyenHuong"));
                
                danhSach.add(tb);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi lấy thông báo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return danhSach;
    }
    
    // Đếm thông báo chưa đọc
    public int demThongBaoChuaDoc(int nguoiDungId) {
        String sql = "SELECT COUNT(*) FROM ThongBao WHERE NguoiDungID = ? AND DaDoc = FALSE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đếm thông báo chưa đọc: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Đánh dấu thông báo đã đọc với kiểm tra quyền sở hữu
    public boolean danhDauDaDoc(long thongBaoId, int nguoiDungId) {
        String sql = "UPDATE ThongBao SET DaDoc = TRUE WHERE ID = ? AND NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, thongBaoId);
            pstmt.setInt(2, nguoiDungId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đánh dấu đã đọc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Đánh dấu thông báo đã đọc (method cũ cho tương thích)
    public boolean danhDauDaDoc(long thongBaoId) {
        String sql = "UPDATE ThongBao SET DaDoc = TRUE WHERE ID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, thongBaoId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đánh dấu đã đọc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Đánh dấu tất cả thông báo đã đọc
    public boolean danhDauTatCaDaDoc(int nguoiDungId) {
        String sql = "UPDATE ThongBao SET DaDoc = TRUE WHERE NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi đánh dấu tất cả đã đọc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Thêm thông báo mới
    public boolean themThongBao(int nguoiDungId, String tieuDe, String noiDung, ThongBao.LoaiThongBao loai) {
        return themThongBao(nguoiDungId, tieuDe, noiDung, loai, null);
    }
    
    // Thêm thông báo mới với link chuyển hướng
    public boolean themThongBao(int nguoiDungId, String tieuDe, String noiDung, ThongBao.LoaiThongBao loai, String linkChuyenHuong) {
        String sql = "INSERT INTO ThongBao (NguoiDungID, TieuDe, NoiDung, LoaiThongBao, DaDoc, NgayTao, LinkChuyenHuong) VALUES (?, ?, ?, ?, FALSE, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, nguoiDungId);
            pstmt.setString(2, tieuDe);
            pstmt.setString(3, noiDung);
            pstmt.setString(4, loai.name());
            pstmt.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setString(6, linkChuyenHuong);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi thêm thông báo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Thêm thông báo VIP
    public boolean themThongBaoVIP(int nguoiDungId, String tenGoi, LocalDateTime ngayHetHan) {
        String tieuDe = "🎉 Chúc mừng! Bạn đã được nâng cấp " + tenGoi + "!";
        String noiDung = String.format(
            "Chúc mừng bạn đã được nâng cấp tài khoản %s! Thời hạn VIP của bạn đến ngày %s. Hãy tận hưởng tất cả các tính năng cao cấp!",
            tenGoi,
            ngayHetHan.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))
        );
        
        return themThongBao(nguoiDungId, tieuDe, noiDung, ThongBao.LoaiThongBao.VIP, "/profile/vip");
    }
    
    // Thêm thông báo trả lời bình luận
    public boolean themThongBaoTraLoiBinhLuan(int nguoiNhanId, String tenNguoiTraLoi, String tenTruyen, String noiDungBinhLuan) {
        String tieuDe = "💬 " + tenNguoiTraLoi + " đã trả lời bình luận của bạn";
        String noiDung = String.format(
            "%s đã trả lời bình luận của bạn trong truyện \"%s\":\n\"%s\"",
            tenNguoiTraLoi,
            tenTruyen,
            noiDungBinhLuan.length() > 100 ? noiDungBinhLuan.substring(0, 100) + "..." : noiDungBinhLuan
        );
        
        return themThongBao(nguoiNhanId, tieuDe, noiDung, ThongBao.LoaiThongBao.BINH_LUAN, "/comments?truyenId=" + tenTruyen);
    }
    
    // Thêm thông báo chương mới
    public boolean themThongBaoChuongMoi(int nguoiDungId, String tenTruyen, String tenChuong) {
        String tieuDe = "📚 Truyện \"" + tenTruyen + "\" có chương mới";
        String noiDung = String.format(
            "Chương mới \"%s\" đã được cập nhật. Hãy đọc ngay để không bỏ lỡ những tình tiết hấp dẫn!",
            tenChuong
        );
        
        return themThongBao(nguoiDungId, tieuDe, noiDung, ThongBao.LoaiThongBao.CHUONG_MOI, "/story/" + tenTruyen);
    }
    
    // Thêm thông báo hệ thống
    public boolean themThongBaoHeThong(int nguoiDungId, String tieuDe, String noiDung) {
        return themThongBao(nguoiDungId, tieuDe, noiDung, ThongBao.LoaiThongBao.HE_THONG);
    }
    
    // Xóa thông báo
    public boolean xoaThongBao(long thongBaoId, int nguoiDungId) {
        String sql = "DELETE FROM ThongBao WHERE ID = ? AND NguoiDungID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, thongBaoId);
            pstmt.setInt(2, nguoiDungId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi khi xóa thông báo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}