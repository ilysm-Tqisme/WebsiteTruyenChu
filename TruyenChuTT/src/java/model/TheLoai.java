package model;

import java.time.LocalDateTime;

public class TheLoai {
    private int id;
    private String tenTheLoai;
    private String moTa;
    private String mauSac; // Màu sắc hiển thị
    private boolean trangThai;
    private LocalDateTime ngayTao;
    private int soLuongTruyen;

    // Constructors
    public TheLoai() {
        this.trangThai = true;
        this.ngayTao = LocalDateTime.now();
        this.soLuongTruyen = 0;
    }

    public TheLoai(String tenTheLoai, String moTa) {
        this();
        this.tenTheLoai = tenTheLoai;
        this.moTa = moTa;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenTheLoai() { return tenTheLoai; }
    public void setTenTheLoai(String tenTheLoai) { this.tenTheLoai = tenTheLoai; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getMauSac() { return mauSac; }
    public void setMauSac(String mauSac) { this.mauSac = mauSac; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public int getSoLuongTruyen() { return soLuongTruyen; }
    public void setSoLuongTruyen(int soLuongTruyen) { this.soLuongTruyen = soLuongTruyen; }

    @Override
    public String toString() {
        return "TheLoai{" +
                "id=" + id +
                ", tenTheLoai='" + tenTheLoai + '\'' +
                ", soLuongTruyen=" + soLuongTruyen +
                '}';
    }
}
