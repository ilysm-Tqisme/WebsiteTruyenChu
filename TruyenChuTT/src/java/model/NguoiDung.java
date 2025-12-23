package model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "nguoi_dung")
public class NguoiDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String email;
    private String matKhau;
    private String hoTen;
    private String soDienThoai;
    private String anhDaiDien;
    private String vaiTro;
    private boolean trangThai;
    private LocalDateTime ngayTao;
    private LocalDateTime ngayCapNhat;
    private String tokenQuenMatKhau;
    private LocalDateTime hetHanToken;
    
    private boolean trangThaiVIP;
    private LocalDateTime ngayDangKyVIP;
    private LocalDateTime ngayHetHanVIP;

    // Constructors
    public NguoiDung() {
        this.vaiTro = "USER";
        this.trangThai = true;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }

    public NguoiDung(String email, String matKhau, String hoTen, String soDienThoai) {
        this();
        this.email = email;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.soDienThoai = soDienThoai;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public String getTokenQuenMatKhau() { return tokenQuenMatKhau; }
    public void setTokenQuenMatKhau(String tokenQuenMatKhau) { this.tokenQuenMatKhau = tokenQuenMatKhau; }

    public LocalDateTime getHetHanToken() { return hetHanToken; }
    public void setHetHanToken(LocalDateTime hetHanToken) { this.hetHanToken = hetHanToken; }

    // Utility methods
    public boolean isAdmin() {
        return "ADMIN".equals(this.vaiTro);
    }
    
    @Override
    public String toString() {
        return "NguoiDung{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", vaiTro='" + vaiTro + '\'' +
                ", trangThai=" + trangThai +
                '}';
    }
    
    public String getNgayTaoFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayTao != null ? ngayTao.format(formatter) : "";
    }
    
    public String getNgayCapNhatFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayCapNhat != null ? ngayCapNhat.format(formatter) : "";
    }

    public boolean isTrangThaiVIP() {
        return trangThaiVIP;
    }

    public void setTrangThaiVIP(boolean trangThaiVIP) {
        this.trangThaiVIP = trangThaiVIP;
    }
    
    
    public LocalDateTime getNgayDangKyVIP() {
        return ngayDangKyVIP;
    }

    public void setNgayDangKyVIP(LocalDateTime ngayDangKyVIP) {
        this.ngayDangKyVIP = ngayDangKyVIP;
    }

    public LocalDateTime getNgayHetHanVIP() {
       return ngayHetHanVIP;
    }

    public void setNgayHetHanVIP(LocalDateTime ngayHetHanVIP) {
        this.ngayHetHanVIP = ngayHetHanVIP;
    }
    
    // Utility methods for VIP
    public String getNgayDangKyVIPFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return ngayDangKyVIP != null ? ngayDangKyVIP.format(formatter) : "";
    }
    
    public String getNgayHetHanVIPFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return ngayHetHanVIP != null ? ngayHetHanVIP.format(formatter) : "";
    }
    
    
}
