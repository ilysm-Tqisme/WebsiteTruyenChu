/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package checkVIP;

/**
 *
 * @author USER
 */
import dao.NguoiDungDAO;
import dao.TaiKhoanVIPDAO;
import model.NguoiDung;
import model.TaiKhoanVIP;

import java.time.LocalDateTime;
import java.util.List;
import java.util.TimerTask;
import service.EmailSender;

public class VipReminderTask extends TimerTask {
    @Override
    public void run() {
        TaiKhoanVIPDAO vipDAO = new TaiKhoanVIPDAO();
        NguoiDungDAO ndDAO = new NguoiDungDAO();
        List<TaiKhoanVIP> danhSach = vipDAO.layVipSapHetTrongNgay(1); // 1 ngày trước khi hết

        for (TaiKhoanVIP vip : danhSach) {
            NguoiDung nd = ndDAO.layThongTinNguoiDung(vip.getNguoiDungID());
            if (nd != null) {
                EmailSender.sendVipSapHetEmail(
                        nd.getEmail(),
                        nd.getHoTen(),
                        vip.getNgayKetThuc()
                );
            }
        }
    }
}

