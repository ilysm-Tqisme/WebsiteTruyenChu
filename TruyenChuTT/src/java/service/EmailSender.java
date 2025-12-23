/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

/**
 *
 * @author USER
 */
public class EmailSender {
     public static void sendCapVipEmail(String toEmail, String hoTen, String loaiVIP, BigDecimal giaVIP,
                                       java.time.LocalDateTime ngayBatDau, java.time.LocalDateTime ngayKetThuc) {
        final String fromEmail = "accsv12ttt@gmail.com"; // ✏️ Thay bằng email thật
        final String password = "rmga ihxh veua crou";    // ✏️ Mật khẩu ứng dụng

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "Truyện Chữ VIP"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("🎉 Chúc mừng! Bạn đã được cấp quyền VIP");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            String htmlContent = "<h2>Xin chúc mừng " + hoTen + "!</h2>"
                    + "<p>Bạn đã được <strong>cấp quyền VIP</strong> trên hệ thống Truyện Chữ.</p>"
                    + "<ul>"
                    + "<li><strong>Gói VIP:</strong> " + loaiVIP + "</li>"
                    + "<li><strong>Giá:</strong> " + giaVIP + " VND</li>"
                    + "<li><strong>Thời gian hiệu lực:</strong> từ <strong>" + ngayBatDau.format(formatter) + "</strong> đến <strong>" + ngayKetThuc.format(formatter) + "</strong></li>"
                    + "</ul>"
                    + "<p>Chúc bạn đọc truyện vui vẻ!</p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("📧 Email cấp VIP đã gửi tới: " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendVipSapHetEmail(String toEmail, String hoTen, LocalDateTime ngayHetHan) {
    final String fromEmail = "accsv12ttt@gmail.com";
    final String password = "iqkb llrn svrg yvkl";

    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    Session session = Session.getInstance(props, new Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(fromEmail, password);
        }
    });

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail, "Truyện Chữ VIP"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("🔔 Gói VIP của bạn sắp hết hạn");

        String content = "<h2>Xin chào " + hoTen + "!</h2>"
                + "<p>Gói VIP của bạn sẽ <strong>hết hạn vào ngày: </strong><strong style='color:red;'>"
                + ngayHetHan.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) + "</strong></p>"
                + "<p>Hãy gia hạn để tiếp tục trải nghiệm các đặc quyền VIP!</p>";

        message.setContent(content, "text/html; charset=utf-8");
        Transport.send(message);
        System.out.println("📩 Đã gửi cảnh báo hết VIP tới: " + toEmail);

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
