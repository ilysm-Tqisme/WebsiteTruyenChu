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
@Table(name = "LichSuDoc")
public class LichSuDoc {
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
    @JoinColumn(name = "ChuongID", nullable = false)
    private Chuong chuong;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayDoc = LocalDateTime.now();
    
    private Integer soLanDoc = 1;

    // Constructors
    public LichSuDoc() {}

    public LichSuDoc(NguoiDung nguoiDung, Truyen truyen, Chuong chuong) {
        this.nguoiDung = nguoiDung;
        this.truyen = truyen;
        this.chuong = chuong;
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

    public LocalDateTime getNgayDoc() { return ngayDoc; }
    public void setNgayDoc(LocalDateTime ngayDoc) { this.ngayDoc = ngayDoc; }

    public Integer getSoLanDoc() { return soLanDoc; }
    public void setSoLanDoc(Integer soLanDoc) { this.soLanDoc = soLanDoc; }
    
    public String getNgayDocFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayDoc != null ? ngayDoc.format(formatter) : "";
    }
}
