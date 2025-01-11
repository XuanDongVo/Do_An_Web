package service.mail;

import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import entity.User;
import repository.user.UserRepository;

public class MailService {
	private UserRepository userRepository = new UserRepository();

//	static final String from = "ecommerce789789";
//	static final String password = "Ecom123456789";ickj olkg qgvl zcqp
	static final String from = "voxuandong14052004";
	static final String password = "ickjolkgqgvlzcqp";

	// gửi email
	public boolean sendEmail(String to, String subject, String content) {
		// Properties for SMTP connection
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // Enable TLS

		// Authenticator for SMTP
		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		};

		// Create a mail session with authentication
		Session session = Session.getInstance(props, auth);

		try {
			// Create a new email message
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
			msg.setSubject(subject);
			msg.setSentDate(new Date());
			msg.setContent(content, "text/html; charset=UTF-8");

			// Send email
			Transport.send(msg);
			System.out.println("Email sent successfully");
			return true;
		} catch (Exception e) {
			System.out.println("Error sending email: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

	// tạo mã xác thực ngẫu nhiên
	public String generateVerificationCode() {
		return UUID.randomUUID().toString();
	}

	// cập nhật email
	public void updateEmail(String email, User user) {
		if (user == null) {
			throw new RuntimeException("User not found");
		}
		userRepository.changeEmailUser(user, email);
	}

	// xác thực email
	public void sendVerificationEmail(String toEmail, String verificationCode) {
		String verificationLink = "http://localhost:8080/Ecommerce_web/email?action=verify&&to=" + toEmail + "&&code="
				+ verificationCode;
		String subject = "Xác thực email của bạn";
		String content = "Nhấn vào link sau để xác thực tài khoản: <a href=\"" + verificationLink
				+ "\">Xác thực tài khoản</a>";

		// Sử dụng hàm gửi email của bạn để gửi
		sendEmail(toEmail, subject, content);
	}

}
