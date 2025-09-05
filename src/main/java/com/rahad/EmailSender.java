package com.rahad;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {

    public static void sendCode(String toEmail, String code) 
            throws MessagingException, UnsupportedEncodingException {
        
        String fromEmail = "vairahad99@gmail.com";   // your Gmail
        String password = "tlpejfijpbskfyow";        // Gmail App Password

        // SMTP Configuration
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Create Email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail, "Rahad Course Management"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("📧 Email Verification – Course Management System");

        // Professional HTML Email Template
        String htmlContent = "<div style='font-family:Arial, sans-serif; background:#f4f6f9; padding:30px;'>"
                + "<div style='max-width:600px; margin:0 auto; background:#ffffff; border-radius:10px; "
                + "box-shadow:0 4px 12px rgba(0,0,0,0.1); padding:30px;'>"
                + "<h2 style='color:#2563eb; text-align:center;'>Rahad Course Management</h2>"
                + "<p style='font-size:16px; color:#333;'>Hello,</p>"
                + "<p style='font-size:15px; color:#555;'>Thank you for registering at our <strong>Course Management System</strong>. "
                + "To complete your sign-up, please verify your email address using the code below:</p>"
                + "<div style='text-align:center; margin:30px 0;'>"
                + "  <span style='font-size:28px; font-weight:bold; letter-spacing:8px; color:#2563eb; "
                + "  border:2px dashed #2563eb; padding:15px 25px; border-radius:8px; display:inline-block;'>"
                + code + "</span>"
                + "</div>"
                + "<p style='font-size:14px; color:#777;'>This code will expire in <strong>10 minutes</strong>. "
                + "If you did not sign up, please ignore this email.</p>"
                + "<hr style='margin:30px 0; border:none; border-top:1px solid #eee;'>"
                + "<p style='font-size:12px; color:#999; text-align:center;'>"
                + "© " + java.time.Year.now() + " Rahad Course Management. All rights reserved."
                + "</p>"
                + "</div></div>";

        message.setContent(htmlContent, "text/html; charset=utf-8");

        // Send Email
        Transport.send(message);
    }
}
