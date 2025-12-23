package service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.util.UUID;

public class EmailService {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    
    // ⚠️ QUAN TRỌNG: Cập nhật thông tin email thực của bạn
    private static final String EMAIL_USERNAME = "accsv12ttt@gmail.com"; // Thay bằng email thật
    private static final String EMAIL_PASSWORD = "qeok plky bvkl kwlj"; // Thay bằng App Password
    
    public boolean sendResetPasswordEmail(String toEmail, String resetToken, String userName) {
        System.out.println("🔄 Bắt đầu gửi email...");
        System.out.println("📧 Gửi từ: " + EMAIL_USERNAME);
        System.out.println("📧 Gửi đến: " + toEmail);
        
        try {
            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.debug", "true"); // Bật debug mode
            
            System.out.println("⚙️ Cấu hình SMTP hoàn tất");
            
            // Tạo session với authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    System.out.println("🔐 Đang xác thực với Gmail...");
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Bật debug cho session
            session.setDebug(true);
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Đặt lại mật khẩu - TruyenTT");
            
            String resetLink = "http://localhost:8080/TruyenChuTT/reset-password?token=" + resetToken;
            System.out.println("🔗 Reset link: " + resetLink);
            
            // Tạo nội dung email đơn giản để test
            String htmlContent = "<html><body>" +
                "<h2>Đặt lại mật khẩu - TruyenTT</h2>" +
                "<p>Xin chào " + userName + ",</p>" +
                "<p>Vui lòng click vào link sau để đặt lại mật khẩu:</p>" +
                "<p><a href='" + resetLink + "'>Đặt lại mật khẩu</a></p>" +
                "<p>Link có hiệu lực trong 15 phút.</p>" +
                "<p>Trân trọng,<br>TruyenTT Team</p>" +
                "</body></html>";
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            System.out.println("📝 Nội dung email đã tạo");
            
            // Gửi email
            System.out.println("📤 Đang gửi email...");
            Transport.send(message);
            
            System.out.println("✅ Gửi email thành công!");
            return true;
            
        } catch (MessagingException e) {
            System.err.println("❌ Lỗi khi gửi email:");
            System.err.println("Error Type: " + e.getClass().getSimpleName());
            System.err.println("Error Message: " + e.getMessage());
            
            // In chi tiết lỗi
            if (e instanceof AuthenticationFailedException) {
                System.err.println("🚫 Lỗi xác thực - Kiểm tra email/password");
            } else if (e instanceof SendFailedException) {
                System.err.println("📧 Lỗi gửi email - Kiểm tra địa chỉ email");
            }
            
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("❌ Lỗi không xác định:");
            e.printStackTrace();
            return false;
        }
    }
    
    public String generateResetToken() {
        return UUID.randomUUID().toString();
    }
    
    // Method test cấu hình email
    public boolean testEmailConnection() {
        System.out.println("🧪 Testing email configuration...");
        
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Test kết nối
            Transport transport = session.getTransport("smtp");
            transport.connect(SMTP_HOST, EMAIL_USERNAME, EMAIL_PASSWORD);
            transport.close();
            
            System.out.println("✅ Email connection test successful!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Email connection test failed:");
            e.printStackTrace();
            return false;
        }
    }
}
