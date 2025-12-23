package model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "Chuong")
public class Chuong {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TruyenID", nullable = false)
    private Truyen truyen;

    
    @Column(name = "TenChuong", nullable = false)
    private String tenChuong;
     
    @Lob
    @Column(name = "NoiDung", nullable = false, columnDefinition = "NTEXT")
    private String noiDung;
    
    @Column(name = "SoChuong", nullable = false)
    private int soChuong;
    
    @Column(name = "ChiDanhChoVIP", nullable = false)
    private boolean chiDanhChoVIP;
    
    @Column(name = "LuotXem", nullable = false)
    private int luotXem;
    
    @Column(name = "TrangThai", nullable = false, length = 50)
    private String trangThai;
    
    
    @Column(name = "NgayTao", nullable = false)
    private LocalDateTime ngayTao;

    @Column(name = "NgayCapNhat", nullable = false)
    private LocalDateTime ngayCapNhat;

    @Column(name = "NgayDangLich")
    private LocalDateTime ngayDangLich;

   // Join field
    //@Transient
    //private String tenTruyen;

    public Chuong() {
        this.trangThai = "CONG_KHAI";
        this.chiDanhChoVIP = false;
        this.luotXem = 0;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }

    public Chuong(Truyen truyen, String tenChuong, String noiDung, int soChuong) {
        this();
        this.truyen = truyen;
        this.tenChuong = tenChuong;
        this.noiDung = noiDung;
        this.soChuong = soChuong;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Truyen getTruyen() {
        return truyen;
    }

    public void setTruyen(Truyen truyen) {
        this.truyen = truyen;
    }

   

    public String getTenChuong() { return tenChuong; }
    public void setTenChuong(String tenChuong) { this.tenChuong = tenChuong; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public int getSoChuong() { return soChuong; }
    public void setSoChuong(int soChuong) { this.soChuong = soChuong; }

    public boolean isChiDanhChoVIP() { return chiDanhChoVIP; }
    public void setChiDanhChoVIP(boolean chiDanhChoVIP) { this.chiDanhChoVIP = chiDanhChoVIP; }

    public int getLuotXem() { return luotXem; }
    public void setLuotXem(int luotXem) { this.luotXem = luotXem; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

    public LocalDateTime getNgayDangLich() { return ngayDangLich; }
    public void setNgayDangLich(LocalDateTime ngayDangLich) { this.ngayDangLich = ngayDangLich; }

    @Transient
    public String getTenTruyen() {
        return truyen != null ? truyen.getTenTruyen() : null;
    }
 

    // Utility methods
    public String getNgayTaoFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayTao != null ? ngayTao.format(formatter) : "";
    }

    public String getLuotXemFormatted() {
        return String.format("%,d", luotXem);
    }

    public String getNgayCapNhatFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayCapNhat != null ? ngayCapNhat.format(formatter) : "";
    }

    public String getDangLichFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayDangLich != null ? ngayDangLich.format(formatter) : "";
    }

    public String getTrangThaiText() {
        switch (trangThai) {
            case "CONG_KHAI": return "Công khai";
            case "AN": return "Ẩn";
            case "NHAP": return "Nháp";
            case "LICH_DANG": return "Lịch đăng";
            default: return trangThai;
        }
    }

    @Override
    public String toString() {
        return "Chuong{" +
                "id=" + id +
                ", truyen=" + truyen +
                ", tenChuong='" + tenChuong + '\'' +
                ", soChuong=" + soChuong +
                ", trangThai='" + trangThai + '\'' +
                '}';
    }

}
