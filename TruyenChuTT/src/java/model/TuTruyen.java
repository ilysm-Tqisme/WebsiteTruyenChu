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
@Table(name = "TuTruyen", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"NguoiDungID", "TruyenID"})
})
public class TuTruyen {
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
    private LocalDateTime ngayLuu = LocalDateTime.now();

    // Constructors
    public TuTruyen() {}

    public TuTruyen(NguoiDung nguoiDung, Truyen truyen) {
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

    public LocalDateTime getNgayLuu() { return ngayLuu; }
    public void setNgayLuu(LocalDateTime ngayLuu) { this.ngayLuu = ngayLuu; }
    
    public String getNgayLuuFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayLuu != null ? ngayLuu.format(formatter) : "";
    }
}