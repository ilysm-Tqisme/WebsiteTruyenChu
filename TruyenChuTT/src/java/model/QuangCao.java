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
@Table(name = "QuangCao")
public class QuangCao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String tieuDe;
    
    @Column(columnDefinition = "NTEXT")
    private String noiDung;
    
    @Column(length = 500)
    private String anhQuangCao;
    
    @Column(length = 500)
    private String linkQuangCao;
    
    @Enumerated(EnumType.STRING)
    @Column(length = 100)
    private ViTri viTri;
    
    @Column(nullable = false, columnDefinition = "DATETIME")
    private LocalDateTime ngayBatDau;
    
    @Column(nullable = false, columnDefinition = "DATETIME")
    private LocalDateTime ngayKetThuc;
    
    @Column(columnDefinition = "BIT")
    private Boolean trangThai = true;
    
    private Integer thuTu = 0;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayTao = LocalDateTime.now();

    public enum ViTri {
        HEADER, SIDEBAR, FOOTER, GIUA_CHUONG, POPUP
    }

    // Constructors
    public QuangCao() {}

    public QuangCao(String tieuDe, ViTri viTri, LocalDateTime ngayBatDau, LocalDateTime ngayKetThuc) {
        this.tieuDe = tieuDe;
        this.viTri = viTri;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public String getAnhQuangCao() { return anhQuangCao; }
    public void setAnhQuangCao(String anhQuangCao) { this.anhQuangCao = anhQuangCao; }

    public String getLinkQuangCao() { return linkQuangCao; }
    public void setLinkQuangCao(String linkQuangCao) { this.linkQuangCao = linkQuangCao; }

    public ViTri getViTri() { return viTri; }
    public void setViTri(ViTri viTri) { this.viTri = viTri; }

    public LocalDateTime getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(LocalDateTime ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public LocalDateTime getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(LocalDateTime ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }

    public Boolean getTrangThai() { return trangThai; }
    public void setTrangThai(Boolean trangThai) { this.trangThai = trangThai; }

    public Integer getThuTu() { return thuTu; }
    public void setThuTu(Integer thuTu) { this.thuTu = thuTu; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }
    
    public String getNgayBatDauFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayBatDau != null ? ngayBatDau.format(formatter) : "";
    }

    public String getNgayKetThucFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayKetThuc != null ? ngayKetThuc.format(formatter) : "";
    }
}
