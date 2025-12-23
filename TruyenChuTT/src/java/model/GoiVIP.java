/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author USER
 */
public class GoiVIP {
    private int id;
    private String tenGoi;
    private String moTa;
    private int soThang;
    private BigDecimal gia;
    private BigDecimal giaGoc;
    private int phanTramGiamGia;
    private String mauSac;
    private String icon;
    private boolean trangThai;
    private int thuTu;
    private boolean noiBat;
    
    // Constructors
    public GoiVIP() {}
    
    public GoiVIP(String tenGoi, String moTa, int soThang, BigDecimal gia) {
        this.tenGoi = tenGoi;
        this.moTa = moTa;
        this.soThang = soThang;
        this.gia = gia;
        this.trangThai = true;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTenGoi() {
        return tenGoi;
    }
    
    public void setTenGoi(String tenGoi) {
        this.tenGoi = tenGoi;
    }
    
    public String getMoTa() {
        return moTa;
    }
    
    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
    public int getSoThang() {
        return soThang;
    }
    
    public void setSoThang(int soThang) {
        this.soThang = soThang;
    }
    
    public BigDecimal getGia() {
        return gia;
    }
    
    public void setGia(BigDecimal gia) {
        this.gia = gia;
    }
    
    public BigDecimal getGiaGoc() {
        return giaGoc;
    }
    
    public void setGiaGoc(BigDecimal giaGoc) {
        this.giaGoc = giaGoc;
    }
    
    public int getPhanTramGiamGia() {
        return phanTramGiamGia;
    }
    
    public void setPhanTramGiamGia(int phanTramGiamGia) {
        this.phanTramGiamGia = phanTramGiamGia;
    }
    
    public String getMauSac() {
        return mauSac;
    }
    
    public void setMauSac(String mauSac) {
        this.mauSac = mauSac;
    }
    
    public String getIcon() {
        return icon;
    }
    
    public void setIcon(String icon) {
        this.icon = icon;
    }
    
    public boolean isTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(boolean trangThai) {
        this.trangThai = trangThai;
    }
    
    public int getThuTu() {
        return thuTu;
    }
    
    public void setThuTu(int thuTu) {
        this.thuTu = thuTu;
    }
    
    public boolean isNoiBat() {
        return noiBat;
    }
    
    public void setNoiBat(boolean noiBat) {
        this.noiBat = noiBat;
    }
    
    // Helper methods
    public String getGiaFormatted() {
        if (gia == null) return "0";
        return String.format("%,.0f", gia);
    }
    
    public String getGiaGocFormatted() {
        if (giaGoc == null) return "";
        return String.format("%,.0f", giaGoc);
    }
    
    public boolean hasDiscount() {
        return giaGoc != null && giaGoc.compareTo(gia) > 0;
    }
    
    public String getDisplayName() {
        return tenGoi + " (" + soThang + " tháng)";
    }
}
