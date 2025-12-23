package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TacGia {
    private int id;
    private String tenTacGia;
    private String moTa;
    private String anhDaiDien;
    private LocalDateTime ngayTao;

    // Thêm từ liên kết
    private int soLuongTruyen;

    public TacGia() {
        this.ngayTao = LocalDateTime.now();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenTacGia() { return tenTacGia; }
    public void setTenTacGia(String tenTacGia) { this.tenTacGia = tenTacGia; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public int getSoLuongTruyen() { return soLuongTruyen; }
    public void setSoLuongTruyen(int soLuongTruyen) { this.soLuongTruyen = soLuongTruyen; }
    
    public String getNgayTaoFormatted() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    return ngayTao != null ? ngayTao.format(formatter) : "";
    }
}
