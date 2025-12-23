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
import java.util.Properties;

/**
 *
 * @author USER
 */
public class EmailUtil {
    private static final String FROM_EMAIL = "accsv12ttt@gmail.com";
    private static final String PASSWORD = "vrmn ufmx nvwf jhcb";

    private static Session createSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    public static void sendEmail(String toEmail, String subject, String content) {
        try {
            Session session = createSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Truyện Chữ VIP"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(content); // Text email

            Transport.send(message);
            System.out.println("📨 Đã gửi email đến: " + toEmail);
        } catch (Exception e) {
            System.err.println("❌ Gửi email thất bại: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void sendHtmlEmail(String toEmail, String subject, String htmlContent) {
        try {
            Session session = createSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Truyện Chữ VIP"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("📨 Đã gửi HTML email đến: " + toEmail);
        } catch (Exception e) {
            System.err.println("❌ Gửi HTML email thất bại: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
