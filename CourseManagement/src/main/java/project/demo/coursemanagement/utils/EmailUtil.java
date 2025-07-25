package project.demo.coursemanagement.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Simple utility class for sending emails
 */
public class EmailUtil {

    private static final Logger LOGGER = Logger.getLogger(EmailUtil.class.getName());

    // SMTP server configuration
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_AUTH = "true";
    private static final String SMTP_STARTTLS = "true";

    // Sender email credentials
    private static final String SENDER_EMAIL = "quanhthe181258@fpt.edu.vn";
    private static final String SENDER_PASSWORD = "dtaoyseilmrsxzhc";

    /**
     * Sends an email with the specified parameters
     *
     * @param recipient The recipient's email address
     * @param subject The email subject
     * @param content The email content (HTML supported)
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendEmail(String recipient, String subject, String content) {
        // Input validation
        if (recipient == null || recipient.trim().isEmpty()) {
            LOGGER.warning("Recipient email is required");
            return false;
        }

        if (subject == null || subject.trim().isEmpty()) {
            LOGGER.warning("Email subject is required");
            return false;
        }

        if (content == null || content.trim().isEmpty()) {
            LOGGER.warning("Email content is required");
            return false;
        }

        LOGGER.info("Attempting to send email to: " + recipient);

        // Set mail properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", SMTP_AUTH);
        properties.put("mail.smtp.starttls.enable", SMTP_STARTTLS);
        properties.put("mail.smtp.ssl.trust", SMTP_HOST);
        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");

        try {
            // Create session with authenticator
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Course Management System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");
            message.setSentDate(new java.util.Date());

            // Send message
            Transport.send(message);

            LOGGER.info("Email sent successfully to: " + recipient);
            return true;

        } catch (AuthenticationFailedException e) {
            LOGGER.log(Level.SEVERE, "Email authentication failed - check credentials", e);
            return false;

        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send email: " + e.getMessage(), e);
            return false;

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error sending email: " + e.getMessage(), e);
            return false;
        }
    }

    /**
     * Sends a password reset email with a reset link
     *
     * @param recipient The recipient's email address
     * @param resetToken The password reset token (not used in email content, just for logging)
     * @param resetLink The password reset link
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendPasswordResetEmail(String recipient, String resetToken, String resetLink) {
        String subject = "Yêu Cầu Đặt Lại Mật Khẩu - Hệ Thống Quản Lý Khóa Học";

        String content =
                "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; background: #f8f9fa; padding: 20px;'>" +
                        "<div style='background: white; border-radius: 10px; padding: 30px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);'>" +
                        "<div style='text-align: center; margin-bottom: 30px;'>" +
                        "<h2 style='color: #4facfe; margin: 0;'>Hệ Thống Quản Lý Khóa Học</h2>" +
                        "</div>" +
                        "<h3 style='color: #333; margin-bottom: 20px;'>Yêu Cầu Đặt Lại Mật Khẩu</h3>" +
                        "<p style='color: #666; line-height: 1.6; margin-bottom: 25px;'>" +
                        "Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu của bạn. Nhấp vào nút bên dưới để tạo mật khẩu mới:" +
                        "</p>" +
                        "<div style='text-align: center; margin: 30px 0;'>" +
                        "<a href='" + resetLink + "' style='" +
                        "display: inline-block; " +
                        "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); " +
                        "color: white; " +
                        "padding: 15px 30px; " +
                        "text-decoration: none; " +
                        "border-radius: 25px; " +
                        "font-weight: 600; " +
                        "box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);" +
                        "'>Đặt Lại Mật Khẩu</a>" +
                        "</div>" +
                        "<p style='color: #666; line-height: 1.6; font-size: 14px;'>" +
                        "Hoặc sao chép và dán URL này vào trình duyệt của bạn:" +
                        "</p>" +
                        "<p style='background: #f8f9fa; padding: 10px; border-radius: 5px; word-break: break-all; font-size: 14px;'>" +
                        resetLink +
                        "</p>" +
                        "<div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee;'>" +
                        "<p style='color: #999; font-size: 14px; margin-bottom: 5px;'>" +
                        "⏰ Liên kết này sẽ hết hạn sau 30 phút." +
                        "</p>" +
                        "<p style='color: #999; font-size: 14px; margin-bottom: 20px;'>" +
                        "🔐 Nếu bạn không yêu cầu đặt lại mật khẩu, bạn có thể bỏ qua email này." +
                        "</p>" +
                        "<p style='color: #333; margin-bottom: 5px;'>Xin cảm ơn,</p>" +
                        "<p style='color: #4facfe; font-weight: 600; margin: 0;'>Đội Ngũ Hệ Thống Quản Lý Khóa Học</p>" +
                        "</div>" +
                        "</div>" +
                        "</div>";

        boolean result = sendEmail(recipient, subject, content);

        if (result) {
            LOGGER.info("Password reset email sent to: " + recipient);
        } else {
            LOGGER.warning("Failed to send password reset email to: " + recipient);
        }

        return result;
    }

    /**
     * Test email configuration
     */
    public static boolean testConfiguration() {
        LOGGER.info("Testing email configuration...");

        return sendEmail(
                SENDER_EMAIL,
                "Email Configuration Test",
                "<h2>✅ Email Configuration Test</h2>" +
                        "<p>If you receive this email, your email configuration is working correctly!</p>" +
                        "<p>Sent at: " + new java.util.Date() + "</p>"
        );
    }
}