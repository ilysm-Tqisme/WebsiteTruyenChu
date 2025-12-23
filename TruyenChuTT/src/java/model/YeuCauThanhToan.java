/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author USER
 */
public class YeuCauThanhToan {
    private int id;
    private int nguoiDungID;
    private int goiVIPID;
    private BigDecimal soTien;
    private String noiDungChuyenKhoan;
    private String trangThai; // PENDING, APPROVED, REJECTED
    private LocalDateTime ngayTao;
    private LocalDateTime ngayXuLy;
    private Integer nguoiXuLy;
    private String ghiChu;
    
    // Constructors
    public YeuCauThanhToan() {}
    
    public YeuCauThanhToan(int nguoiDungID, int goiVIPID, BigDecimal soTien, String noiDungChuyenKhoan) {
        this.nguoiDungID = nguoiDungID;
        this.goiVIPID = goiVIPID;
        this.soTien = soTien;
        this.noiDungChuyenKhoan = noiDungChuyenKhoan;
        this.trangThai = "PENDING";
        this.ngayTao = LocalDateTime.now();
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
    
    public int getGoiVIPID() {
        return goiVIPID;
    }
    
    public void setGoiVIPID(int goiVIPID) {
        this.goiVIPID = goiVIPID;
    }
    
    public BigDecimal getSoTien() {
        return soTien;
    }
    
    public void setSoTien(BigDecimal soTien) {
        this.soTien = soTien;
    }
    
    public String getNoiDungChuyenKhoan() {
        return noiDungChuyenKhoan;
    }
    
    public void setNoiDungChuyenKhoan(String noiDungChuyenKhoan) {
        this.noiDungChuyenKhoan = noiDungChuyenKhoan;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public LocalDateTime getNgayXuLy() {
        return ngayXuLy;
    }
    
    public void setNgayXuLy(LocalDateTime ngayXuLy) {
        this.ngayXuLy = ngayXuLy;
    }
    
    public Integer getNguoiXuLy() {
        return nguoiXuLy;
    }
    
    public void setNguoiXuLy(Integer nguoiXuLy) {
        this.nguoiXuLy = nguoiXuLy;
    }
    
    public String getGhiChu() {
        return ghiChu;
    }
    
    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }
    
    // Helper methods
    public String getSoTienFormatted() {
        if (soTien == null) return "0";
        return String.format("%,.0f", soTien);
    }
    
    public String getNgayTaoFormatted() {
        if (ngayTao == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayTao.format(formatter);
    }
    
    public String getNgayXuLyFormatted() {
        if (ngayXuLy == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayXuLy.format(formatter);
    }
    
    public String getTrangThaiText() {
        switch (trangThai) {
            case "PENDING":
                return "Chờ duyệt";
            case "APPROVED":
                return "Đã duyệt";
            case "REJECTED":
                return "Từ chối";
            default:
                return "Không xác định";
        }
    }
}
