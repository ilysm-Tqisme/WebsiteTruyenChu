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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "ThongKe", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"TruyenID", "NgayThongKe"})
})
public class ThongKe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TruyenID", nullable = false)
    private Truyen truyen;
    
    @Column(name = "NgayThongKe", nullable = false)
    private LocalDate ngayThongKe;
    
    private Integer luotXem = 0;
    
    private Integer luotXemChuong = 0;
    
    private Integer soBinhLuan = 0;
    
    private Integer soDanhGia = 0;

    // Constructors
    public ThongKe() {}

    public ThongKe(Truyen truyen, LocalDate ngayThongKe) {
        this.truyen = truyen;
        this.ngayThongKe = ngayThongKe;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Truyen getTruyen() { return truyen; }
    public void setTruyen(Truyen truyen) { this.truyen = truyen; }

    public LocalDate getNgayThongKe() { return ngayThongKe; }
    public void setNgayThongKe(LocalDate ngayThongKe) { this.ngayThongKe = ngayThongKe; }

    public Integer getLuotXem() { return luotXem; }
    public void setLuotXem(Integer luotXem) { this.luotXem = luotXem; }

    public Integer getLuotXemChuong() { return luotXemChuong; }
    public void setLuotXemChuong(Integer luotXemChuong) { this.luotXemChuong = luotXemChuong; }

    public Integer getSoBinhLuan() { return soBinhLuan; }
    public void setSoBinhLuan(Integer soBinhLuan) { this.soBinhLuan = soBinhLuan; }

    public Integer getSoDanhGia() { return soDanhGia; }
    public void setSoDanhGia(Integer soDanhGia) { this.soDanhGia = soDanhGia; }
    
    public String getNgayThongKeFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayThongKe != null ? ngayThongKe.format(formatter) : "";
    }
}
