package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class Truyen {
    private int id;
    private String tenTruyen;
    private String moTa;
    private String anhBia;
    private int tacGiaId;
    private int nguoiTaoId;
    private String trangThai;
    private boolean chiDanhChoVIP;
    private boolean noiBat;
    private boolean truyenMoi;
    private int luotXem;
    private double diemDanhGia;
    private int soLuongDanhGia;
    private LocalDateTime ngayTao;
    private LocalDateTime ngayCapNhat;

    // Các thông tin thêm từ liên kết, không có trong bảng Truyen
    private String tacGiaTen;       // JOIN từ bảng TacGia
    private String nguoiTaoTen;     // JOIN từ bảng NguoiDung
    private List<String> theLoaiTenList; // JOIN từ bảng TruyenTheLoai → TheLoai
    private int soLuongChuong;  

    // Constructors
    public Truyen() {
        // ✅ SỬA: Đổi default value phù hợp với database
        this.trangThai = "DANG_TIEN_HANH"; // Thay vì "DANG_VIET"
        this.luotXem = 0;
        this.diemDanhGia = 0.0;
        this.soLuongDanhGia = 0;
        this.ngayTao = LocalDateTime.now();
        this.ngayCapNhat = LocalDateTime.now();
    }

    public Truyen(String tenTruyen, String moTa, int tacGiaId, int nguoiTaoId) {
        this();
        this.tenTruyen = tenTruyen;
        this.moTa = moTa;
        this.tacGiaId = tacGiaId;
        this.nguoiTaoId = nguoiTaoId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenTruyen() {
        return tenTruyen;
    }

    public void setTenTruyen(String tenTruyen) {
        this.tenTruyen = tenTruyen;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public String getAnhBia() {
        return anhBia;
    }

    public void setAnhBia(String anhBia) {
        this.anhBia = anhBia;
    }

    public int getTacGiaId() {
        return tacGiaId;
    }

    public void setTacGiaId(int tacGiaId) {
        this.tacGiaId = tacGiaId;
    }

    public int getNguoiTaoId() {
        return nguoiTaoId;
    }

    public void setNguoiTaoId(int nguoiTaoId) {
        this.nguoiTaoId = nguoiTaoId;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public boolean isChiDanhChoVIP() {
        return chiDanhChoVIP;
    }

    public void setChiDanhChoVIP(boolean chiDanhChoVIP) {
        this.chiDanhChoVIP = chiDanhChoVIP;
    }

    public boolean isNoiBat() {
        return noiBat;
    }

    public void setNoiBat(boolean noiBat) {
        this.noiBat = noiBat;
    }

    public boolean isTruyenMoi() {
        return truyenMoi;
    }

    public void setTruyenMoi(boolean truyenMoi) {
        this.truyenMoi = truyenMoi;
    }

    public int getLuotXem() {
        return luotXem;
    }

    public void setLuotXem(int luotXem) {
        this.luotXem = luotXem;
    }

    public double getDiemDanhGia() {
        return diemDanhGia;
    }

    public void setDiemDanhGia(double diemDanhGia) {
        this.diemDanhGia = diemDanhGia;
    }

    public int getSoLuongDanhGia() {
        return soLuongDanhGia;
    }

    public void setSoLuongDanhGia(int soLuongDanhGia) {
        this.soLuongDanhGia = soLuongDanhGia;
    }

    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }

    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }

    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    public String getTacGiaTen() {
        return tacGiaTen;
    }

    public void setTacGiaTen(String tacGiaTen) {
        this.tacGiaTen = tacGiaTen;
    }

    public String getNguoiTaoTen() {
        return nguoiTaoTen;
    }

    public void setNguoiTaoTen(String nguoiTaoTen) {
        this.nguoiTaoTen = nguoiTaoTen;
    }

    public List<String> getTheLoaiTenList() {
        return theLoaiTenList;
    }

    public void setTheLoaiTenList(List<String> theLoaiTenList) {
        this.theLoaiTenList = theLoaiTenList;
    }

    public int getSoLuongChuong() {
        return soLuongChuong;
    }

    public void setSoLuongChuong(int soLuongChuong) {
        this.soLuongChuong = soLuongChuong;
    }

    // Utility methods
    public String getTrangThaiText() {
        switch (trangThai) {
            case "DANG_TIEN_HANH": return "Đang tiến hành";
            case "HOAN_THANH": return "Hoàn thành";
            case "TAM_DUNG": return "Tạm dừng";
            case "DA_XOA": return "Đã xóa";
            default: return "Không xác định";
        }
    }

    public String getDanhGiaFormatted() {
        return String.format("%.1f", diemDanhGia);
    }

    public String getLuotXemFormatted() {
        return String.format("%,d", luotXem);
}

    public String getNgayTaoFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayTao != null ? ngayTao.format(formatter) : "";
    }
    
    public String getNgayCapNhatFormatted() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return ngayCapNhat != null ? ngayCapNhat.format(formatter) : "";
    }

    @Override
    public String toString() {
        return "Truyen{" +
                "id=" + id +
                ", tenTruyen='" + tenTruyen + '\'' +
                ", tacGia='" + tacGiaId + '\'' +
                ", theLoaiTen='" +  theLoaiTenList + '\'' +
                ", luotXem=" + luotXem +
                ", danhGia=" + diemDanhGia +
                ", trangThai='" + trangThai + '\'' +
                '}';
    }
}