/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author USER
 */
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class TaiKhoanVIP {

    private int id;
    private int nguoiDungID;
    private LocalDateTime ngayBatDau;
    private LocalDateTime ngayKetThuc;
    private String loaiVIP;
    private BigDecimal giaVIP;
    private boolean trangThai;
    private LocalDateTime ngayTao;

    // Constructors
    public TaiKhoanVIP() {}

    public TaiKhoanVIP(int id, int nguoiDungID, LocalDateTime ngayBatDau, LocalDateTime ngayKetThuc,
                       String loaiVIP, BigDecimal giaVIP, boolean trangThai, LocalDateTime ngayTao) {
        this.id = id;
        this.nguoiDungID = nguoiDungID;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
        this.loaiVIP = loaiVIP;
        this.giaVIP = giaVIP;
        this.trangThai = trangThai;
        this.ngayTao = ngayTao;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNguoiDungID() {
        return nguoiDungID;
    }

    public void setNguoiDungID(int nguoiDungID) {
        this.nguoiDungID = nguoiDungID;
    }

    public LocalDateTime getNgayBatDau() {
        return ngayBatDau;
    }

    public void setNgayBatDau(LocalDateTime ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public LocalDateTime getNgayKetThuc() {
        return ngayKetThuc;
    }

    public void setNgayKetThuc(LocalDateTime ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public String getLoaiVIP() {
        return loaiVIP;
    }

    public void setLoaiVIP(String loaiVIP) {
        this.loaiVIP = loaiVIP;
    }

    public BigDecimal getGiaVIP() {
        return giaVIP;
    }

    public void setGiaVIP(BigDecimal giaVIP) {
        this.giaVIP = giaVIP;
    }

    public boolean isTrangThai() {
        return trangThai;
    }

    public void setTrangThai(boolean trangThai) {
        this.trangThai = trangThai;
    }
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }


    // Format DateTime
    public String getNgayTaoFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayTao != null ? ngayTao.format(formatter) : "";
    }

    public String getNgayBatDauFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayBatDau != null ? ngayBatDau.format(formatter) : "";
    }

    public String getNgayKetThucFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayKetThuc != null ? ngayKetThuc.format(formatter) : "";
    }

    // Format giaVIP thành dạng "120.000 ₫"
    public String getGiaVIPFormatted() {
        if (giaVIP == null) return "";
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(',');
        DecimalFormat formatter = new DecimalFormat("#,###", symbols);
        return formatter.format(giaVIP) + " ₫";
    }
}