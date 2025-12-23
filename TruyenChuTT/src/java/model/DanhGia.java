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
@Table(name = "DanhGia", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"NguoiDungID", "TruyenID"})
})
public class DanhGia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungID", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TruyenID", nullable = false)
    private Truyen truyen;
    
    @Column(nullable = false)
    private Integer diemSo;
    
    @Column(columnDefinition = "NTEXT")
    private String nhanXet;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayDanhGia = LocalDateTime.now();

    // Constructors
    public DanhGia() {}

    public DanhGia(NguoiDung nguoiDung, Truyen truyen, Integer diemSo) {
        this.nguoiDung = nguoiDung;
        this.truyen = truyen;
        this.diemSo = diemSo;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public Truyen getTruyen() { return truyen; }
    public void setTruyen(Truyen truyen) { this.truyen = truyen; }

    public Integer getDiemSo() { return diemSo; }
    public void setDiemSo(Integer diemSo) { this.diemSo = diemSo; }

    public String getNhanXet() { return nhanXet; }
    public void setNhanXet(String nhanXet) { this.nhanXet = nhanXet; }

    public LocalDateTime getNgayDanhGia() { return ngayDanhGia; }
    public void setNgayDanhGia(LocalDateTime ngayDanhGia) { this.ngayDanhGia = ngayDanhGia; }
   

    public String getNgayDanhGiatFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayDanhGia != null ? ngayDanhGia.format(formatter) : "";
    }    
}
