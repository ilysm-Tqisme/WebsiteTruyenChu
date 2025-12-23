/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author USER
 */
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "ThongBao")
public class ThongBao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungID", nullable = false)
    private NguoiDung nguoiDung;
    
    @Column(nullable = false)
    private String tieuDe;
    
    @Column(columnDefinition = "NTEXT", nullable = false)
    private String noiDung;
    
    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private LoaiThongBao loaiThongBao;
    
    @Column(columnDefinition = "BIT")
    private Boolean daDoc = false;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayTao = LocalDateTime.now();

    public enum LoaiThongBao {
        CHUONG_MOI, BINH_LUAN, VIP, HE_THONG
    }
    @Column(name = "LinkChuyenHuong", columnDefinition = "LONGTEXT")
    private String linkChuyenHuong;

    public String getLinkChuyenHuong() { return linkChuyenHuong; }
    public void setLinkChuyenHuong(String linkChuyenHuong) { this.linkChuyenHuong = linkChuyenHuong; }


    // Constructors
    public ThongBao() {}

    public ThongBao(NguoiDung nguoiDung, String tieuDe, String noiDung, LoaiThongBao loaiThongBao) {
        this.nguoiDung = nguoiDung;
        this.tieuDe = tieuDe;
        this.noiDung = noiDung;
        this.loaiThongBao = loaiThongBao;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public LoaiThongBao getLoaiThongBao() { return loaiThongBao; }
    public void setLoaiThongBao(LoaiThongBao loaiThongBao) { this.loaiThongBao = loaiThongBao; }

    public Boolean getDaDoc() { return daDoc; }
    public void setDaDoc(Boolean daDoc) { this.daDoc = daDoc; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    public String getNgayTaoFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayTao != null ? ngayTao.format(formatter) : "";
    }
}
