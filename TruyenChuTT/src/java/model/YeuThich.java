/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "YeuThich", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"NguoiDungID", "TruyenID"})
})
public class YeuThich {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungID", nullable = false)
    private NguoiDung nguoiDung;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TruyenID", nullable = false)
    private Truyen truyen;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayYeuThich = LocalDateTime.now();

    // Constructors
    public YeuThich() {}

    public YeuThich(NguoiDung nguoiDung, Truyen truyen) {
        this.nguoiDung = nguoiDung;
        this.truyen = truyen;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public NguoiDung getNguoiDung() { return nguoiDung; }
    public void setNguoiDung(NguoiDung nguoiDung) { this.nguoiDung = nguoiDung; }

    public Truyen getTruyen() { return truyen; }
    public void setTruyen(Truyen truyen) { this.truyen = truyen; }

    public LocalDateTime getNgayYeuThich() { return ngayYeuThich; }
    public void setNgayYeuThich(LocalDateTime ngayYeuThich) { this.ngayYeuThich = ngayYeuThich; }
    
    public String getNgayYeuThichFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayYeuThich != null ? ngayYeuThich.format(formatter) : "";
    }
}
