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

@Entity
@Table(name = "CauHinh")
public class CauHinh {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String tenCauHinh;
    
    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String giaTri;
    
    @Column(columnDefinition = "NTEXT")
    private String moTa;
    
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime ngayCapNhat = LocalDateTime.now();

    // Constructors
    public CauHinh() {}

    public CauHinh(String tenCauHinh, String giaTri) {
        this.tenCauHinh = tenCauHinh;
        this.giaTri = giaTri;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTenCauHinh() { return tenCauHinh; }
    public void setTenCauHinh(String tenCauHinh) { this.tenCauHinh = tenCauHinh; }

    public String getGiaTri() { return giaTri; }
    public void setGiaTri(String giaTri) { this.giaTri = giaTri; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public LocalDateTime getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
