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
import java.util.List;

@Entity
@Table(name = "BinhLuan")
public class BinhLuan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungID", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TruyenID", nullable = false)
    private Truyen truyen;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ChuongID")
    private Chuong chuong;
    
    @Column(columnDefinition = "NTEXT", nullable = false)
    private String noiDung;
    
    @Column(columnDefinition = "BIT")
    private Boolean trangThai = true;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayTao = LocalDateTime.now();
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BinhLuanChaID")
    private BinhLuan binhLuanCha;
    
    // Relationships
    @OneToMany(mappedBy = "binhLuanCha", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<BinhLuan> binhLuanCon;

    // Constructors
    public BinhLuan() {}

    public BinhLuan(NguoiDung nguoiDung, Truyen truyen, String noiDung) {
        this.nguoiDung = nguoiDung;
        this.truyen = truyen;
        this.noiDung = noiDung;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public Truyen getTruyen() { return truyen; }
    public void setTruyen(Truyen truyen) { this.truyen = truyen; }

    public Chuong getChuong() { return chuong; }
    public void setChuong(Chuong chuong) { this.chuong = chuong; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public Boolean getTrangThai() { return trangThai; }
    public void setTrangThai(Boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public BinhLuan getBinhLuanCha() { return binhLuanCha; }
    public void setBinhLuanCha(BinhLuan binhLuanCha) { this.binhLuanCha = binhLuanCha; }

    public List<BinhLuan> getBinhLuanCon() { return binhLuanCon; }
    public void setBinhLuanCon(List<BinhLuan> binhLuanCon) { this.binhLuanCon = binhLuanCon; }
    
    public String getNgayTaoFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayTao != null ? ngayTao.format(formatter) : "";
    }
}
